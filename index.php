<?php

use Bramus\Router\Router;

require __DIR__ . '/vendor/autoload.php';

set_exception_handler(function ($exception) {
    return response()->json([
        'error' => $exception->getMessage(),
    ], wrap: false, status: 500);
});

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__)->load();

$router = new Router();



$router->run();