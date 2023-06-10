<?php
use Bramus\Router\Router;

require __DIR__ . '/vendor/autoload.php';

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__)->load();

$router = new Router();



$router->run();