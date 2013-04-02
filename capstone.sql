-- phpMyAdmin SQL Dump
-- version 3.5.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 02, 2013 at 04:42 AM
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
(170, 0),
(170, 15),
(170, 17),
(172, 0),
(172, 15),
(173, 0),
(174, 0),
(175, 16),
(176, 17),
(177, 0),
(178, 0),
(179, 0),
(180, 0),
(181, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `fall_status`
--

INSERT INTO `fall_status` (`id`, `monitored_status_id`, `x_cord`, `y_cord`, `z_cord`, `fallen`) VALUES
(1, 9, 343, 54, 57, NULL),
(2, 9, 875, 457, 23, NULL),
(3, 9, 487, 34, 21, NULL),
(4, 10, 343, 54, 57, NULL),
(5, 10, 875, 457, 23, NULL),
(6, 10, 487, 34, 21, NULL),
(7, 11, 343, 54, 57, NULL),
(8, 11, 875, 457, 23, NULL),
(9, 11, 487, 34, 21, NULL),
(10, 12, 343, 54, 57, NULL),
(11, 12, 875, 457, 23, NULL),
(12, 12, 487, 34, 21, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `heart_rates`
--

CREATE TABLE IF NOT EXISTS `heart_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monitored_status_id` int(11) NOT NULL,
  `pulse` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `heart_rates`
--

INSERT INTO `heart_rates` (`id`, `monitored_status_id`, `pulse`) VALUES
(1, 9, 101),
(2, 9, 85),
(3, 9, 135),
(4, 10, 101),
(5, 10, 85),
(6, 10, 135),
(7, 11, 101),
(8, 11, 85),
(9, 11, 135),
(10, 12, 101),
(11, 12, 85),
(12, 12, 135);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `monitored_status`
--

INSERT INTO `monitored_status` (`id`, `patient_id`, `blood_pressure_h`, `blood_pressure_l`, `battery_life`, `status_message`, `last_updated`) VALUES
(9, 172, 220, 100, 857, 'URGENT', '2013-03-24 00:16:47'),
(10, 172, 220, 100, 857, 'URGENT', '2013-03-24 00:18:10'),
(11, 172, 220, 100, 857, 'URGENT', '2013-03-28 14:15:48'),
(12, 172, 220, 100, 857, 'URGENT', '2013-03-31 20:28:38');

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

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
(13, 166, 16, 'hi', '2013-03-23 16:48:08', NULL),
(14, 168, 0, 'jing is a good guy.', '2013-03-27 14:29:00', NULL),
(15, 168, 0, 'hello', '2013-03-28 14:12:34', NULL),
(16, 173, 0, 'something', '2013-03-31 22:36:47', NULL),
(17, 173, 0, 'new', '2013-03-31 23:05:52', NULL),
(18, 173, 0, 'someathing', '2013-04-01 00:31:04', NULL),
(19, 172, 0, 'hello world!', '2013-04-01 15:35:40', NULL),
(20, 172, 0, 'uh oh~', '2013-04-01 15:40:04', NULL),
(21, 170, 17, 'asdf', '2013-04-01 15:54:51', NULL),
(22, 170, 17, 'new', '2013-04-01 15:59:05', NULL),
(23, 176, 17, 'com''on', '2013-04-01 16:00:33', NULL),
(24, 176, 17, 'hello~', '2013-04-01 16:02:32', NULL),
(25, 176, 17, 'try again!', '2013-04-01 16:02:55', NULL),
(26, 176, 17, 'hellow again', '2013-04-01 16:03:16', NULL),
(27, 170, 0, 'this is my message', '2013-04-02 07:33:14', NULL),
(28, 170, 15, 'let me talk too', '2013-04-02 07:33:52', NULL),
(29, 170, 15, 'hello patient', '2013-04-02 07:40:44', NULL),
(30, 170, 15, 'hey it''s me again~', '2013-04-02 07:42:04', NULL),
(31, 170, 0, 'holly cow', '2013-04-02 07:42:28', NULL);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=182 ;

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
(180, 'test', 'test', 'Female', 21, '234523452345', '234 ast st', '/assets/avatars/dp2.jpg', 'asdfasdf', '2013-04-02', NULL, 'Healthy', NULL, NULL, NULL, NULL, '2013-04-02 07:28:43'),
(175, 'Cat', 'Tom', 'Male', 23, '1234329876', '67 uit st', '/assets/avatars/dp1.jpg', 'holololol', '2013-02-21', NULL, 'Passed away', NULL, NULL, NULL, NULL, '2013-02-21 20:18:17'),
(179, 'nimei', 'nimei', 'Female', 14, '(132) 243-2345', '2452 stas st', '/assets/avatars/dp1.jpg', 'na', '2013-03-31', NULL, 'Healthy', NULL, NULL, NULL, NULL, '2013-03-31 21:30:41'),
(181, 'patient', 'new', 'Male', 42, 'afsgafg', 'asfgadfgdafg', '/assets/avatars/dp9.jpg', 'asfgafg', '2013-04-02', NULL, 'Healthy', NULL, NULL, NULL, NULL, '2013-04-02 08:29:25');

-- --------------------------------------------------------

--
-- Table structure for table `pills`
--

CREATE TABLE IF NOT EXISTS `pills` (
  `name` varchar(255) NOT NULL,
  `function` varchar(255) NOT NULL,
  `side_effect` varchar(255) NOT NULL,
  `info` text,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pills`
--

INSERT INTO `pills` (`name`, `function`, `side_effect`, `info`) VALUES
('Asprin', 'nonsteroidal anti-inflammatory drugs', 'dizzy', 'Aspirin''s ability to suppress the production of prostaglandins and thromboxanes is due to its irreversible inactivation of the cyclooxygenase (PTGS) enzyme required for prostaglandin and thromboxane synthesis. Aspirin acts as an acetylating agent where an acetyl group is covalently attached to a serine residue in the active site of the PTGS enzyme. This makes aspirin different from other NSAIDs (such as diclofenac and ibuprofen), which are reversible inhibitors.'),
('Tylenol', 'reducing fever, and relieving the symptoms of allergies, cold, cough, and flu', 'sleepy', 'Like the words "acetaminophen" and "paracetamol", the brand name is derived from the chemical name for the compound, N-acetyl-para-aminophenol (APAP).[1] The brand is owned by McNeil Consumer Healthcare, a subsidiary of Johnson & Johnson.');

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions`
--

CREATE TABLE IF NOT EXISTS `prescriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `pill_name` varchar(255) NOT NULL,
  `direction` text NOT NULL,
  `servings_per_day` int(11) NOT NULL,
  `quantities_per_serving` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `prescriptions`
--

INSERT INTO `prescriptions` (`id`, `patient_id`, `doctor_id`, `pill_name`, `direction`, `servings_per_day`, `quantities_per_serving`, `start_date`, `end_date`) VALUES
(2, 170, 15, 'Asprin', 'Three times a day, with water, after meal.', 3, 1, '2013-03-01', '2013-05-11'),
(3, 170, 17, 'Tylenol', 'One time a day, with water, before dinner.', 1, 1, '2013-03-14', '2013-10-17'),
(9, 172, 15, 'Tylenol', 'be careful', 1, 2, '2013-04-02', '2013-04-17');

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
  `avatar` varchar(255) NOT NULL,
  `usertype` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `password_salt` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cellphone` (`phone`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `last_name`, `first_name`, `address`, `phone`, `avatar`, `usertype`, `email`, `password_hash`, `password_salt`) VALUES
(0, 'Lu', 'Charles', '18 Hollywood St N, Hamilton, ON', '(905) 320-2158', '/assets/avatars/dp0.jpg', 'Guardian', 'chao.cn@hotmail.com', '$2a$10$DRDsimr3ZSQKvL2qH7wEd.5no106Jpc0XGipqfu0a83c0hhqS7/Vm', '$2a$10$DRDsimr3ZSQKvL2qH7wEd.'),
(2, 'Guo', 'Jing', '312 Osler Crt, Hamilton ON', '(647) 111-1111', '/assets/avatars/dp1.jpg', 'Care taker', 'guoj@hotmail.com', '$2a$10$bY29BqeuLn7G7SGJgUr2OOQjBzkhvM5O0B9Pig0Kt8yT.Ue2.ZbNG', '$2a$10$bY29BqeuLn7G7SGJgUr2OO'),
(15, 'Combo', 'Whopper', '1540 main st w, Hamilton ON', '(289) 993-1231', '/assets/avatars/dp2.jpg', 'Doctor', 'whopper@combo.com', '$2a$10$DRDsimr3ZSQKvL2qH7wEd.5no106Jpc0XGipqfu0a83c0hhqS7/Vm', '$2a$10$DRDsimr3ZSQKvL2qH7wEd.'),
(16, 'Hellie', 'Josh', '123 main st', '1234567898', '/assets/avatars/dp3.jpg', 'Doctor', 'Josh@mcmaster.ca', '$2a$10$yp1MjaPaQE2kUXCawwJx.eKXjp0VAywlZLzcGkmwlQe4OK1rJfkI.', '$2a$10$yp1MjaPaQE2kUXCawwJx.e'),
(17, 'Wang', 'Mike', '120 king st', '7679875642', '/assets/avatars/dp4.jpg', 'Guardian', 'mike@126.com', '$2a$10$1PRoocQY9dHS32Efgq14iOo7.S8cA1h1sfOuUaHtfjsJewO8aKouG', '$2a$10$1PRoocQY9dHS32Efgq14iO'),
(18, 'Lu', 'Charles', '18 Hollywood St N, Hamilton, ON', '9055124980', '/assets/avatars/dp8.jpg', 'Care taker', 'chaolu.dev@icloud.com', '$2a$10$rCy13f3a.qiJJIK./se0sewmRZRZ8AAOr76TGkH3UWTr2jTuwSpnK', '$2a$10$rCy13f3a.qiJJIK./se0se');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
