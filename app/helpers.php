<?php
use App\Request\Request;
use App\Response\Response;

if (!function_exists('env')) {
    function env(string $key, string $default = null)
    {
        if (array_key_exists($key, $_ENV)) {
            return $_ENV[$key];
        }

        return $default;
    }
}

if (!function_exists('response')) {
    function response(): Response
    {
        return (new Response());
    }
}

if (!function_exists('request')) {
    function request(): Request
    {
        return (new Request());
    }
}
