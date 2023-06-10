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