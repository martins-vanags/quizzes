<?php

namespace App\Controllers;

use App\Connection\DB;
use App\Exceptions\InternalException;
use App\Exceptions\QuizDoesNotExistException;
use App\Exceptions\QuizNotCompletedException;
use App\Exceptions\UnableToCompleteQuizException;
use App\Response\Response;
use App\Validator\Validator;
use Exception;

class QuizCompleteController
{
    /**
     * Called if all questions for quiz are answered, and we mark it as done
     * @throws QuizDoesNotExistException
     * @throws UnableToCompleteQuizException
     * @throws QuizNotCompletedException
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
            $answeredQuestions = DB::getQueryBuilder()
                ->select('COUNT(*)')
                ->from('user_answers')
                ->where('username = :username')
                ->andWhere('quiz_id = :quiz_id')
                ->getSQL();

            $totalQuestions = DB::getQueryBuilder()
                ->select('COUNT(*)')
                ->from('questions')
                ->where('quiz_id = :quiz_id')
                ->getSQL();

            $quizResults = DB::getQueryBuilder()
                ->select(
                    '(' . $answeredQuestions . ') AS answered_questions',
                    '(' . $totalQuestions . ') AS total_questions'
                )
                ->setParameter('username', request()->get('username'))
                ->setParameter('quiz_id', $quizId)
                ->fetchAssociative();
        } catch (Exception) {
            throw new InternalException('Failed to fetch query');
        }

        if ($quizResults['answered_questions'] != $quizResults['total_questions']) {
            throw new QuizNotCompletedException('Quiz is not completed');
        }

        try {
            DB::getQueryBuilder()
                ->insert('completes')
                ->values([
                    'username' => ':username',
                    'quiz_id' => ':quiz_id',
                ])
                ->setParameters([
                    'username' => request()->get('username'),
                    'quiz_id' => $quizId,
                ])
                ->executeQuery();
        } catch (Exception) {
            throw new UnableToCompleteQuizException('Unable to complete the quiz for user: ' . request()->get('username'));
        }

        return response()->json([
            'success' => 'true'
        ]);
    }
}