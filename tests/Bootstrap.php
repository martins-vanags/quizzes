<?php

namespace Tests;

use Dotenv\Dotenv;

trait Bootstrap
{
    /**
     * Loads .env.testing variables
     */
    public function bootstrap(): void
    {
        if (file_exists(dirname(__DIR__) . '/.env.testing')) {
            (Dotenv::createImmutable(dirname(__DIR__), '.env.testing'))->load();
        }
    }
}