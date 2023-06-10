<?php

namespace App\Controllers;

use App\Connection\DB;
use App\Exceptions\InternalException;
use App\Exceptions\QuizDoesNotExistException;
use App\Exceptions\UnableToSaveUserAnswersException;
use App\Response\Response;
use App\Validator\Validator;
use Exception;

class UserQuizAnswerController
{
    /**
     * @throws QuizDoesNotExistException
     * @throws InternalException
     */
    public function show(int $quizId): Response
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
            $userAnswers = DB::getConnection()
                ->prepare("
                  SELECT correct_answers, total_questions
                    FROM (
                        SELECT COUNT(*) AS correct_answers
                        FROM user_answers ua
                        JOIN answer_options ao ON ua.option_id = ao.id
                        WHERE ua.username = :username
                          AND ua.quiz_id = :quiz_id
                          AND ao.is_correct = 1
                    ) AS correct_count
                    CROSS JOIN (
                        SELECT COUNT(*) AS total_questions
                        FROM questions
                        WHERE quiz_id = :quiz_id
                    ) AS question_count;");
            $userAnswers->bindValue('quiz_id', $quizId);
            $userAnswers->bindValue('username', request()->get('username'));
            $userAnswers = $userAnswers->executeQuery()->fetchAllAssociative();
        } catch (Exception) {
            throw new InternalException('Failed to fetch query');
        }

        return response()->json([
            'answers' => $userAnswers,
        ]);
    }

    /**
     * @throws QuizDoesNotExistException
     * @throws UnableToSaveUserAnswersException
     * @throws InternalException
     */
    public function store(int $quizId): Response
    {
        $validator = Validator::make()->validate([
            'username' => ['required'],
            'option_id' => ['required', 'int'],
            'question_id' => ['required', 'int']
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
            DB::getQueryBuilder()
                ->insert('user_answers')
                ->values([
                    'username' => ':username',
                    'quiz_id' => ':id',
                    'question_id' => ':question_id',
                    'option_id' => ':option_id',
                ])
                ->setParameters([
                    'username' => request()->get('username'),
                    'id' => $quizId,
                    'question_id' => request()->get('question_id'),
                    'option_id' => request()->get('option_id'),
                ])->executeQuery();
        } catch (Exception) {
            throw new UnableToSaveUserAnswersException('Unable to save user answers for user: ' . request()->get('username'));
        }

        return response()->json([
            'success' => 'true'
        ]);
    }
}