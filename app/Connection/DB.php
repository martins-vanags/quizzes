<?php

namespace App\Connection;

use App\Exceptions\ConnectionFailedException;
use Doctrine\DBAL\Connection;
use Doctrine\DBAL\DriverManager;
use Doctrine\DBAL\Exception;
use Doctrine\DBAL\Query\QueryBuilder;

class DB
{
    private static ?Connection $driverManager = null;

    private function __construct()
    {
        // Prevent direct instantiation
    }

    /**
     * @return Connection
     * @throws ConnectionFailedException
     */
    public static function getConnection(): Connection
    {
        if (is_null(self::$driverManager)) {
            try {
                return self::$driverManager = DriverManager::getConnection([
                    'dbname' => env('DB_DATABASE'),
                    'user' => env('DB_USERNAME'),
                    'password' => env('DB_PASSWORD'),
                    'host' => env('DB_HOST'),
                    'port' => env('DB_PORT'),
                    'driver' => env('DB_CONNECTION'),
                ]);
            } catch (Exception $e) {
                throw new ConnectionFailedException($e->getMessage());
            }
        }

        return self::$driverManager;
    }
    
    /**
     * @return QueryBuilder
     * @throws ConnectionFailedException
     */
    public static function getQueryBuilder(): QueryBuilder
    {
        return self::getConnection()->createQueryBuilder();
    }

    public static function forgetInstance(): void
    {
        self::$driverManager = null;
    }
}