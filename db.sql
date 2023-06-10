/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `answer_options` (
                                  `id` int(11) NOT NULL AUTO_INCREMENT,
                                  `question_id` int(11) NOT NULL,
                                  `option_text` text NOT NULL,
                                  `is_correct` tinyint(1) NOT NULL DEFAULT '0',
                                  PRIMARY KEY (`id`),
                                  KEY `question_id` (`question_id`),
                                  CONSTRAINT `answer_options_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

CREATE TABLE `completes` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `username` varchar(255) NOT NULL,
                             `quiz_id` int(11) NOT NULL,
                             PRIMARY KEY (`id`),
                             KEY `quiz_id` (`quiz_id`),
                             CONSTRAINT `completes_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;

CREATE TABLE `questions` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `quiz_id` int(11) NOT NULL,
                             `question_text` text NOT NULL,
                             PRIMARY KEY (`id`),
                             KEY `quiz_id` (`quiz_id`),
                             CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

CREATE TABLE `quizzes` (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `name` varchar(255) NOT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

INSERT INTO `answer_options` (`id`, `question_id`, `option_text`, `is_correct`) VALUES
    (1, 1, 'George Washington', 1);
INSERT INTO `answer_options` (`id`, `question_id`, `option_text`, `is_correct`) VALUES
    (2, 1, 'Thomas Jefferson', 0);
INSERT INTO `answer_options` (`id`, `question_id`, `option_text`, `is_correct`) VALUES
    (3, 1, 'Abraham Lincoln', 0);
INSERT INTO `answer_options` (`id`, `question_id`, `option_text`, `is_correct`) VALUES
                                                                                    (4, 2, '1945', 1),
                                                                                    (5, 2, '1939', 0),
                                                                                    (6, 2, '1941', 0),
                                                                                    (7, 3, 'Paris', 1),
                                                                                    (8, 3, 'Madrid', 0),
                                                                                    (9, 3, 'Rome', 0),
                                                                                    (10, 4, 'Asia', 1),
                                                                                    (11, 4, 'Europe', 0),
                                                                                    (12, 4, 'Africa', 0),
                                                                                    (13, 5, 'Au', 1),
                                                                                    (14, 5, 'Ag', 0),
                                                                                    (15, 5, 'Cu', 0),
                                                                                    (16, 6, 'Mars', 1),
                                                                                    (17, 6, 'Venus', 0),
                                                                                    (18, 6, 'Jupiter', 0),
                                                                                    (19, 7, 'France', 1),
                                                                                    (20, 7, 'Germany', 0),
                                                                                    (21, 7, 'Brazil', 0),
                                                                                    (22, 8, 'Barry Bonds', 1),
                                                                                    (23, 8, 'Babe Ruth', 0),
                                                                                    (24, 8, 'Hank Aaron', 0),
                                                                                    (25, 9, 'Elon Musk', 1),
                                                                                    (26, 9, 'Jeff Bezos', 0),
                                                                                    (27, 9, 'Mark Zuckerberg', 0),
                                                                                    (28, 10, 'HyperText Markup Language', 1),
                                                                                    (29, 10, 'Home Tool for Modern Living', 0),
                                                                                    (30, 10, 'High Tech Machine Learning', 0),
                                                                                    (31, 11, 'Bar', 1),
                                                                                    (32, 11, 'Boo', 0),
                                                                                    (33, 11, 'zzz', 0);



INSERT INTO `questions` (`id`, `quiz_id`, `question_text`) VALUES
    (1, 1, 'Who was the first president of the United States?');
INSERT INTO `questions` (`id`, `quiz_id`, `question_text`) VALUES
    (2, 1, 'In which year did World War II end?');
INSERT INTO `questions` (`id`, `quiz_id`, `question_text`) VALUES
    (3, 2, 'What is the capital of France?');
INSERT INTO `questions` (`id`, `quiz_id`, `question_text`) VALUES
                                                               (4, 2, 'Which is the largest continent by land area?'),
                                                               (5, 3, 'What is the chemical symbol for gold?'),
                                                               (6, 3, 'Which planet is known as the \"Red Planet\"?'),
                                                               (7, 4, 'Which country won the FIFA World Cup in 2018?'),
                                                               (8, 4, 'Who holds the record for the most home runs in Major League Baseball?'),
                                                               (9, 5, 'Who is the CEO of Tesla?'),
                                                               (10, 5, 'What does HTML stand for?'),
                                                               (11, 5, 'Foo');

INSERT INTO `quizzes` (`id`, `name`) VALUES
    (1, 'History Quiz');
INSERT INTO `quizzes` (`id`, `name`) VALUES
    (2, 'Geography Quiz');
INSERT INTO `quizzes` (`id`, `name`) VALUES
    (3, 'Science Quiz');
INSERT INTO `quizzes` (`id`, `name`) VALUES
                                         (4, 'Sports Quiz'),
                                         (5, 'Technology Quiz');




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;