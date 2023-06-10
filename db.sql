CREATE TABLE `answer_options` (
                                  `id` int(11) NOT NULL AUTO_INCREMENT,
                                  `question_id` int(11) NOT NULL,
                                  `option_text` text NOT NULL,
                                  `is_correct` tinyint(1) NOT NULL DEFAULT '0',
                                  PRIMARY KEY (`id`),
                                  KEY `question_id` (`question_id`),
                                  CONSTRAINT `answer_options_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

CREATE TABLE `questions` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `quiz_id` int(11) NOT NULL,
                             `question_text` text NOT NULL,
                             PRIMARY KEY (`id`),
                             KEY `quiz_id` (`quiz_id`),
                             CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE `quizzes` (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `name` varchar(255) NOT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `user_answers` (
                                `id` int(11) NOT NULL AUTO_INCREMENT,
                                `username` varchar(255) NOT NULL,
                                `quiz_id` int(11) NOT NULL,
                                `question_id` int(11) NOT NULL,
                                `option_id` int(11) NOT NULL,
                                PRIMARY KEY (`id`),
                                KEY `quiz_id` (`quiz_id`),
                                KEY `question_id` (`question_id`),
                                KEY `option_id` (`option_id`),
                                CONSTRAINT `user_answers_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`),
                                CONSTRAINT `user_answers_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`),
                                CONSTRAINT `user_answers_ibfk_3` FOREIGN KEY (`option_id`) REFERENCES `answer_options` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

CREATE TABLE `completes` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `username` varchar(255) NOT NULL,
                             `quiz_id` int(11) NOT NULL,
                             PRIMARY KEY (`id`),
                             KEY `quiz_id` (`quiz_id`),
                             CONSTRAINT `completes_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;




-- Quiz 1
INSERT INTO quizzes (name) VALUES ('History Quiz');

INSERT INTO questions (quiz_id, question_text) VALUES
                                                   (1, 'Who was the first president of the United States?'),
                                                   (1, 'In which year did World War II end?');

INSERT INTO answer_options (question_id, option_text, is_correct) VALUES
                                                                      (1, 'George Washington', 1),
                                                                      (1, 'Thomas Jefferson', 0),
                                                                      (1, 'Abraham Lincoln', 0),
                                                                      (2, '1945', 1),
                                                                      (2, '1939', 0),
                                                                      (2, '1941', 0);

-- Quiz 2
INSERT INTO quizzes (name) VALUES ('Geography Quiz');

INSERT INTO questions (quiz_id, question_text) VALUES
                                                   (2, 'What is the capital of France?'),
                                                   (2, 'Which is the largest continent by land area?');

INSERT INTO answer_options (question_id, option_text, is_correct) VALUES
                                                                      (3, 'Paris', 1),
                                                                      (3, 'Madrid', 0),
                                                                      (3, 'Rome', 0),
                                                                      (4, 'Asia', 1),
                                                                      (4, 'Europe', 0),
                                                                      (4, 'Africa', 0);

-- Quiz 3
INSERT INTO quizzes (name) VALUES ('Science Quiz');

INSERT INTO questions (quiz_id, question_text) VALUES
                                                   (3, 'What is the chemical symbol for gold?'),
                                                   (3, 'Which planet is known as the "Red Planet"?');

INSERT INTO answer_options (question_id, option_text, is_correct) VALUES
                                                                      (5, 'Au', 1),
                                                                      (5, 'Ag', 0),
                                                                      (5, 'Cu', 0),
                                                                      (6, 'Mars', 1),
                                                                      (6, 'Venus', 0),
                                                                      (6, 'Jupiter', 0);

-- Quiz 4
INSERT INTO quizzes (name) VALUES ('Sports Quiz');

INSERT INTO questions (quiz_id, question_text) VALUES
                                                   (4, 'Which country won the FIFA World Cup in 2018?'),
                                                   (4, 'Who holds the record for the most home runs in Major League Baseball?');

INSERT INTO answer_options (question_id, option_text, is_correct) VALUES
                                                                      (7, 'France', 1),
                                                                      (7, 'Germany', 0),
                                                                      (7, 'Brazil', 0),
                                                                      (8, 'Barry Bonds', 1),
                                                                      (8, 'Babe Ruth', 0),
                                                                      (8, 'Hank Aaron', 0);

-- Quiz 5
INSERT INTO quizzes (name) VALUES ('Technology Quiz');

INSERT INTO questions (quiz_id, question_text) VALUES
                                                   (5, 'Who is the CEO of Tesla?'),
                                                   (5, 'What does HTML stand for?'),
                                                   (5, 'Foo');

INSERT INTO answer_options (question_id, option_text, is_correct) VALUES
                                                                      (9, 'Elon Musk', 1),
                                                                      (9, 'Jeff Bezos', 0),
                                                                      (9, 'Mark Zuckerberg', 0),
                                                                      (10, 'HyperText Markup Language', 1),
                                                                      (10, 'Home Tool for Modern Living', 0),
                                                                      (10, 'High Tech Machine Learning', 0),
                                                                      (11, 'Bar', 1),
                                                                      (11, 'Boo', 0),
                                                                      (11, 'zzz', 0);