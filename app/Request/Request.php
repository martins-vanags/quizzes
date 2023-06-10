<?php

namespace App\Request;

class Request
{
    public array $request = [];

    public function __construct()
    {
        if (!empty(file_get_contents("php://input"))) {
            $this->request = json_decode(file_get_contents("php://input"), true);
        } else {
            $this->request = $_GET;
        }
    }

    public function get(string $key): string|int|array|null
    {
        if (array_key_exists($key, $this->request)) {
            return $this->request[$key];
        }

        return null;
    }

    public function getErrors(): Request
    {
        return $this;
    }
}