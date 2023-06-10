Created using php 8.2.5

Installation:
* composer install
* touch .env
* copy over .env.example contents
* fill in your credentials
* leave `DB_CONNECTION=pdo_mysql` as is
* open db.sql and copy over the db schema and import dummy data
* php -S localhost:8000
* http://localhost:8000/ and try it out


Added two simple tests, because they were not required but at least the testing suite is working.



Demo: https://i.imgur.com/Iz6odf2.gif
