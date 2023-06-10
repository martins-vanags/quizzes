<?php

namespace App\Controllers;

use App\Connection\DB;
use App\Exceptions\InternalException;
use App\Exceptions\QuizDoesNotExistException;
use App\Response\Response;
use App\Validator\Validator;
use Exception;

class QuizStartController
{
    /**
     * @param int $quizId
     * @return Response
     * @throws QuizDoesNotExistException
     * @throws InternalException
     */
    public function store(int $quizId): Response
    {
        $validator = Validator::make()->validate([
            'username' => ['required'],
        ], request());

        if (!$validator->passed()) {
            return response()->json([
                'errors' => $validator->getErrors(),
            ], wrap: false, status: 500);
        }

        try {
            $subQuery = DB::getQueryBuilder()
                ->select('1')
                ->from('quizzes')
                ->where('id = :id');

            $quizExists = DB::getQueryBuilder()
                ->select('EXISTS (' . $subQuery->getSQL() . ')')
                ->setParameter('id', $quizId)
                ->fetchOne();
        } catch (Exception) {
            throw new InternalException('Failed to fetch query');
        }

        if ($quizExists != 1) {
            throw new QuizDoesNotExistException('Quiz does not exist');
        }

        try {
            $quizQuestionsAndAnswerOptions = DB::getQueryBuilder()
                ->select('qz.id as quiz_id, q.id AS question_id', 'q.question_text', 'a.id AS option_id', 'a.option_text')
                ->from('quizzes', 'qz')
                ->join('qz', 'questions', 'q', 'qz.id = q.quiz_id')
                ->join('q', 'answer_options', 'a', 'q.id = a.question_id')
                ->where('qz.id = :id')
                ->setParameter('id', $quizId)
                ->fetchAllAssociative();
        } catch (Exception) {
            throw new InternalException('Failed to fetch query');
        }

        $transformedResults = array_reduce($quizQuestionsAndAnswerOptions, function ($transformed, $question) {
            $questionText = $question['question_text'];

            if (!isset($transformed[$questionText])) {
                $transformed[$questionText] = [];
            }

            $transformed[$questionText][] = [
                'question_id' => $question['question_id'],
                'option_id' => $question['option_id'],
                'option_text' => $question['option_text'],
            ];

            return $transformed;
        }, []);

        return response()->json($transformedResults);
    }
}