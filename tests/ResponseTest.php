<?php

namespace Tests;

use App\Response\Response;
use PHPUnit\Framework\TestCase;

class ResponseTest extends TestCase
{
    use Bootstrap;

    public function __construct(string $name)
    {
        $this->bootstrap();

        parent::__construct($name);
    }

    public function test_it_can_get_values_from_response()
    {
        $response = new Response();
        $response->json(['foo' => 'bar']);

        $values = $response->getValues();

        $this->assertIsArray($values);
        $this->assertEquals(['foo' => 'bar'], $values);
    }

    public function test_it_can_retrieve_status_code_from_response()
    {
        $response = new Response();

        $response->json(['foo']);

        $status = $response->getStatus();

        $this->assertIsInt($status);
        $this->assertEquals(200, $status);
    }
}