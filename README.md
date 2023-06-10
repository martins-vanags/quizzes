Created using php 8.2.5

Database schema created using mysql 5.7.33

Requirements:

* php >8.0
* mysql 5.7.X

Installation:

* composer install
* touch .env
* copy over .env.example contents
* fill in your credentials
* leave `DB_CONNECTION=pdo_mysql` as is
* import db.sql (it contains the schema and dummy data)
* php -S localhost:8000
* open http://localhost:8000/ and try it out

Added two simple tests, because they were not required but at least the testing suite is working.

Demo: https://i.imgur.com/Iz6odf2.gif
