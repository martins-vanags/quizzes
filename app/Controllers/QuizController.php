<?php

namespace App\Controllers;

use App\Connection\DB;
use App\Exceptions\InternalException;
use App\Response\Response;
use Exception;

class QuizController
{
    /**
     * Fetch all quizzes
     * @return Response
     * @throws InternalException
     */
    public function index(): Response
    {
        try {
            $quizzes = DB::getQueryBuilder()
                ->select('id, name')
                ->from('quizzes')
                ->fetchAllAssociative();
        } catch (Exception) {
            throw new InternalException('Failed to fetch query');
        }

        return response()->json([
            'quizzes' => $quizzes,
        ]);
    }
}