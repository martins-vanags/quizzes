<?php

namespace Tests;

use App\Connection\DB;
use App\Exceptions\ConnectionFailedException;
use Doctrine\DBAL\Query\QueryBuilder;
use PHPUnit\Framework\TestCase;

class DBTest extends TestCase
{
    use Bootstrap;

    public function __construct(string $name)
    {
        $this->bootstrap();

        parent::__construct($name);
    }

    /**
     * @covers \App\Connection\DB::getConnection
     * @throws ConnectionFailedException
     */
    public function test_database_class_is_working_as_singleton()
    {
        $this->assertSame(DB::getConnection(), DB::getConnection());
    }

    /**
     * @covers \App\Connection\DB::getQueryBuilder
     * @throws ConnectionFailedException
     */
    public function test_database_get_query_builder_returns_query_builder_instance()
    {
        $this->assertInstanceOf(QueryBuilder::class, DB::getQueryBuilder());
    }

    /**
     * @covers \App\Connection\DB::getConnection
     * @throws ConnectionFailedException
     */
    public function test_on_failed_database_connection_it_throws_exception()
    {
        DB::forgetInstance();

        $_ENV['DB_CONNECTION'] = 'FAKE';

        $this->expectException(ConnectionFailedException::class);

        DB::getConnection();
    }
}