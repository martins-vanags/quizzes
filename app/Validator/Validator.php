<?php

namespace App\Validator;

use App\Request\Request;

class Validator
{
    public array $errors = [];

    public static function make(): self
    {
        return new self;
    }

    public function validate(array $values, Request $request): Validator
    {
        foreach ($values as $value => $rules) {
            foreach ($rules as $rule) {
                if ($rule === 'required') {
                    if (!is_null($request->get($value)) && !empty(trim($request->get($value)))) {
                        continue;
                    }
                    $this->errors[$value][] = $value . ' is required';
                    continue;
                }

                if ($rule === 'int') {
                    if (is_int(intval($request->get($value)))) {
                        continue;
                    }
                    $this->errors[$value][] = $value . ' must be the type of integer';
                    continue;
                }
            }

        }

        return $this;
    }

    public function passed(): bool
    {
        return empty($this->errors);
    }

    public function getErrors(): array
    {
        return $this->errors;
    }
}