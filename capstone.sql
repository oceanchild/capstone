-- phpMyAdmin SQL Dump
-- version 3.5.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 23, 2013 at 05:01 PM
-- Server version: 5.5.29
-- PHP Version: 5.3.15

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `capstone`
--

-- --------------------------------------------------------

--
-- Table structure for table `associations`
--

CREATE TABLE IF NOT EXISTS `associations` (
  `patient_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  UNIQUE KEY `association_id` (`patient_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `associations`
--

INSERT INTO `associations` (`patient_id`, `user_id`) VALUES
(114, 2),
(115, 2),
(166, 16),
(168, 0),
(170, 17),
(172, 0),
(173, 0),
(174, 0),
(175, 16),
(176, 17);

-- --------------------------------------------------------

--
-- Table structure for table `dispensers`
--

CREATE TABLE IF NOT EXISTS `dispensers` (
  `id` char(16) NOT NULL,
  `hash_code` varchar(255) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `date_registered` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fall_status`
--

CREATE TABLE IF NOT EXISTS `fall_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monitored_status_id` int(11) NOT NULL,
  `x_cord` float NOT NULL,
  `y_cord` float NOT NULL,
  `z_cord` float NOT NULL,
  `fallen` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `heart_rates`
--

CREATE TABLE IF NOT EXISTS `heart_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monitored_status_id` int(11) NOT NULL,
  `pulse` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `missed_instances`
--

CREATE TABLE IF NOT EXISTS `missed_instances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prescription_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `missed_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `video_url` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `monitored_status`
--

CREATE TABLE IF NOT EXISTS `monitored_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `blood_pressure_h` int(11) DEFAULT NULL,
  `blood_pressure_l` int(11) DEFAULT NULL,
  `battery_life` int(11) NOT NULL,
  `status_message` varchar(255) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE IF NOT EXISTS `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reply_to_note` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `patient_id`, `author_id`, `content`, `date_created`, `reply_to_note`) VALUES
(6, 175, 16, 'He is alrite so far', '2013-03-22 23:40:04', NULL),
(7, 175, 16, 'He is experiencing some headache.', '2013-03-22 23:41:05', NULL),
(8, 175, 2, 'This patient''s heart rate is normal.', '2013-03-23 02:57:13', NULL),
(9, 166, 15, 'Blood pressure is abnormal. Need on site check.', '2013-03-23 03:07:17', NULL),
(10, 166, 16, 'He is getting better.', '2013-03-23 15:59:52', NULL),
(11, 170, 17, 'Some one help this poor guy please.', '2013-03-23 16:17:33', NULL),
(12, 175, 16, 'Hello', '2013-03-23 16:47:57', NULL),
(13, 166, 16, 'hi', '2013-03-23 16:48:08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE IF NOT EXISTS `patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_name` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `age` int(11) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `symptoms` text NOT NULL,
  `date_registered` date NOT NULL,
  `date_terminated` date DEFAULT NULL,
  `health_status` varchar(255) NOT NULL DEFAULT 'healthy',
  `last_fall_date` datetime DEFAULT NULL,
  `heart_rate` float DEFAULT NULL,
  `blood_pressure_h` float DEFAULT NULL,
  `blood_pressure_l` float DEFAULT NULL,
  `last_status_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=177 ;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `last_name`, `first_name`, `gender`, `age`, `phone`, `address`, `avatar`, `symptoms`, `date_registered`, `date_terminated`, `health_status`, `last_fall_date`, `heart_rate`, `blood_pressure_h`, `blood_pressure_l`, `last_status_update`) VALUES
(172, 'Luther', 'Luke', 'Male', 25, '(388) 321-1234', '1342 Smallville Ave', '/assets/avatars/dp4.jpg', 'WISLDFDK', '2013-02-18', NULL, 'Ill', NULL, NULL, NULL, NULL, '2013-02-18 16:15:37'),
(173, 'Luther', 'Charles', 'Male', 24, '(905) 321-1444', '18 Hollywood St N', '/assets/avatars/dp2.jpg', 'well', '2013-02-20', NULL, 'Healthy', NULL, NULL, NULL, NULL, '2013-02-20 03:17:53'),
(170, 'Newtron', 'Jimmy', 'Male', 19, '(905) 321-9999', '312 main st west hamilton on', '/assets/avatars/dp1.jpg', 'science', '2013-02-18', NULL, 'Healthy', NULL, NULL, NULL, NULL, '2013-02-18 16:06:51'),
(176, 'Amell', 'Stephen ', 'Male', 38, '6478985678', '59 Lorge Ave', '/assets/avatars/dp2.jpg', 'Need constant care ', '2013-03-23', NULL, 'Ill', NULL, NULL, NULL, NULL, '2013-03-23 16:08:23'),
(115, 'Whoever', 'Justine', 'Male', 32, '(234) 012-1231', '34 stisks st', '/assets/avatars/dp1.jpg', 'baaaasdsaskldjfaklsla', '2013-02-16', NULL, 'Healthy', NULL, NULL, NULL, NULL, '2013-02-16 14:30:35'),
(114, 'Xiao', 'Xiaofang', 'Female', 26, '(905) 321-1344', '302-1 Osler Court', '/assets/avatars/dp8.jpg', 'nothing', '2013-02-16', NULL, 'Healthy', NULL, NULL, NULL, NULL, '2013-02-16 14:28:48'),
(166, 'Blunt', 'James', 'Male', 34, '(905) 320-2155', '19 Hollywood St N, Hamilton, Canada', '/assets/avatars/dp2.jpg', 'You''re beautiful~~', '2013-02-18', NULL, 'Healthy', NULL, NULL, NULL, NULL, '2013-02-18 03:44:51'),
(174, 'Jefferson', 'Tomson', 'Male', 45, '(905) 342-1234', '312 main st west hamilton on', '/assets/avatars/dp10.jpg', 'asfgasfgafsg', '2013-02-20', NULL, 'Ill', NULL, NULL, NULL, NULL, '2013-02-20 04:37:58'),
(168, 'Stark', 'Jenny', 'Female', 23, '(905) 333-1423', '312 main st west hamilton on', '/assets/avatars/dp5.jpg', 'nothing really', '2013-02-18', NULL, 'Healthy', NULL, NULL, NULL, NULL, '2013-02-18 04:17:01'),
(175, 'Cat', 'Tom', 'Male', 23, '1234329876', '67 uit st', '/assets/avatars/dp1.jpg', 'holololol', '2013-02-21', NULL, 'Passed away', NULL, NULL, NULL, NULL, '2013-02-21 20:18:17');

-- --------------------------------------------------------

--
-- Table structure for table `pills`
--

CREATE TABLE IF NOT EXISTS `pills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `function` varchar(255) NOT NULL,
  `side_effect` varchar(255) NOT NULL,
  `info` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `pills`
--

INSERT INTO `pills` (`id`, `name`, `function`, `side_effect`, `info`) VALUES
(1, 'Asprin', 'nonsteroidal anti-inflammatory drugs', 'dizzy', 'Aspirin''s ability to suppress the production of prostaglandins and thromboxanes is due to its irreversible inactivation of the cyclooxygenase (PTGS) enzyme required for prostaglandin and thromboxane synthesis. Aspirin acts as an acetylating agent where an acetyl group is covalently attached to a serine residue in the active site of the PTGS enzyme. This makes aspirin different from other NSAIDs (such as diclofenac and ibuprofen), which are reversible inhibitors.'),
(2, 'Tylenol', 'reducing fever, and relieving the symptoms of allergies, cold, cough, and flu', 'sleepy', 'Like the words "acetaminophen" and "paracetamol", the brand name is derived from the chemical name for the compound, N-acetyl-para-aminophenol (APAP).[1] The brand is owned by McNeil Consumer Healthcare, a subsidiary of Johnson & Johnson.');

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions`
--

CREATE TABLE IF NOT EXISTS `prescriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `pill_id` int(11) NOT NULL,
  `direction` text NOT NULL,
  `servings_per_day` int(11) NOT NULL,
  `quantities_per_serving` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `prescriptions`
--

INSERT INTO `prescriptions` (`id`, `patient_id`, `doctor_id`, `pill_id`, `direction`, `servings_per_day`, `quantities_per_serving`, `start_date`, `end_date`) VALUES
(2, 170, 15, 1, 'Three times a day, with water, after meal.', 3, 1, '2013-03-01', '2013-05-11'),
(3, 170, 17, 2, 'One time a day, with water, before dinner.', 1, 1, '2013-03-14', '2013-10-17');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_name` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `usertype` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `password_salt` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cellphone` (`phone`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `last_name`, `first_name`, `address`, `phone`, `usertype`, `email`, `password_hash`, `password_salt`) VALUES
(0, 'Lu', 'Chao', '18 Hollywood St N, Hamilton, ON', '(905) 320-2158', 'Guardian', 'chao.cn@hotmail.com', '$2a$10$DRDsimr3ZSQKvL2qH7wEd.5no106Jpc0XGipqfu0a83c0hhqS7/Vm', '$2a$10$DRDsimr3ZSQKvL2qH7wEd.'),
(2, 'Guo', 'Jing', '312 Osler Crt, Hamilton ON', '(647) 111-1111', 'Care taker', 'guoj@hotmail.com', '$2a$10$bY29BqeuLn7G7SGJgUr2OOQjBzkhvM5O0B9Pig0Kt8yT.Ue2.ZbNG', '$2a$10$bY29BqeuLn7G7SGJgUr2OO'),
(15, 'Combo', 'Whopper', '1540 main st w, Hamilton ON', '(289) 993-1231', 'Doctor', 'whopper@combo.com', '$2a$10$6FMzbfkbnfafXe7GfWRJWOO02m8Eq4b31b06YtVx.kC4gTZdi.WEu', '$2a$10$6FMzbfkbnfafXe7GfWRJWO'),
(16, 'Hellie', 'Josh', '123 main st', '1234567898', 'Doctor', 'Josh@mcmaster.ca', '$2a$10$yp1MjaPaQE2kUXCawwJx.eKXjp0VAywlZLzcGkmwlQe4OK1rJfkI.', '$2a$10$yp1MjaPaQE2kUXCawwJx.e'),
(17, 'Wang', 'Mike', '120 king st', '7679875642', 'Guardian', 'mike@126.com', '$2a$10$1PRoocQY9dHS32Efgq14iOo7.S8cA1h1sfOuUaHtfjsJewO8aKouG', '$2a$10$1PRoocQY9dHS32Efgq14iO');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
