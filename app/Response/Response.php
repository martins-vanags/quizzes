<?php

namespace App\Response;

class Response
{
    public array $values;
    public bool $wrap;
    public int $status;
    public string $header = 'Content-Type: application/json';

    public function getValues(): array
    {
        return $this->values;
    }

    public function getStatus(): int
    {
        return $this->status;
    }

    public function getHeaders(): string
    {
        return $this->header;
    }

    public function json(array $values = [], bool $wrap = true, int $status = 200): Response
    {
        $this->values = $values;
        $this->wrap = $wrap;
        $this->status = $status;

        $this->send();

        return $this;
    }

    public function send(): Response
    {
        $this->setHeaders()->sendContent();

        if (\function_exists('fastcgi_finish_request')) {
            fastcgi_finish_request();
        } elseif (!\in_array(\PHP_SAPI, ['cli', 'phpdbg'], true)) {
            $this->cleanOutputBuffers(0, true);
        }

        return $this;
    }

    public function sendContent(): Response
    {
        echo $this->wrap
            ? json_encode(['data' => $this->values])
            : json_encode($this->values);

        return $this;
    }

    public function setHeaders(): Response
    {
        header_remove();

        header($this->header, true, $this->status);

        return $this;
    }

    public function cleanOutputBuffers(int $targetLevel = 0, bool $flush = true): void
    {
        $status = ob_get_status(true);
        $level = \count($status);
        $flags = \PHP_OUTPUT_HANDLER_REMOVABLE | ($flush ? \PHP_OUTPUT_HANDLER_FLUSHABLE : \PHP_OUTPUT_HANDLER_CLEANABLE);

        while ($level-- > $targetLevel && ($s = $status[$level]) && (!isset($s['del']) ? !isset($s['flags']) || ($s['flags'] & $flags) === $flags : $s['del'])) {
            if ($flush) {
                ob_end_flush();
            } else {
                ob_end_clean();
            }
        }
    }
}