-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 18, 2024 at 11:18 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_eventer`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_bookings`
--

CREATE TABLE `tbl_bookings` (
  `id` int(11) NOT NULL,
  `names` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `country` varchar(255) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `checkin` datetime NOT NULL,
  `checkout` datetime NOT NULL,
  `booked` enum('YES','NO') NOT NULL DEFAULT 'NO',
  `guest_approved` enum('YES','NO') NOT NULL DEFAULT 'NO',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_bookings`
--

INSERT INTO `tbl_bookings` (`id`, `names`, `email`, `phone`, `country`, `hotel_id`, `checkin`, `checkout`, `booked`, `guest_approved`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'Ahishakiye Anacley', 'a.anaclet920@gmail.com', '+250784354460', 'Rwanda', 1, '2023-12-21 11:09:00', '2023-12-23 11:09:00', 'YES', 'NO', '2023-12-27 09:09:36', '2023-12-28 08:39:42', NULL),
(3, 'John Doe', 'a.anaclet921@gmail.com', '+250784354461', 'Rwanda', 1, '2023-12-21 11:09:00', '2023-12-23 11:09:00', 'YES', 'NO', '2023-12-27 09:09:36', '2023-12-28 08:39:42', NULL),
(4, 'Ahishakiye Anaclet', 'a.anaclet920@gmail.com', '+250 784 354 4460', 'Rwanda', 1, '2023-12-29 09:03:00', '2023-12-23 09:03:00', 'YES', 'NO', '2023-12-29 07:04:06', '2023-12-29 07:04:38', NULL),
(5, 'Ahishakiye Anaclet', 'a.anaclet920@gmail.com', '+(250) 784 354 4460', 'Rwanda', 1, '2024-01-26 10:23:00', '2024-02-02 10:23:00', 'YES', 'NO', '2024-01-18 08:23:10', '2024-01-18 10:01:09', NULL),
(6, 'Ahishakiye Anaclet', 'a.anaclet920@gmail.com', '+(250) 784 354 4460', 'Rwanda', 1, '2024-01-20 12:08:00', '2024-01-28 12:08:00', 'NO', 'NO', '2024-01-18 10:08:47', '2024-01-18 10:08:47', NULL),
(7, 'Ahishakiye Anaclet', 'a.anaclet920@gmail.com', '+(250) 784 354 4460', 'Rwanda', 1, '2024-01-20 12:08:00', '2024-01-28 12:08:00', 'NO', 'NO', '2024-01-18 10:09:19', '2024-01-18 10:09:19', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_categories`
--

CREATE TABLE `tbl_categories` (
  `id` int(11) NOT NULL,
  `category` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_categories`
--

INSERT INTO `tbl_categories` (`id`, `category`, `created_at`, `updated_at`, `deleted_at`) VALUES
(3, 'Globus member', '2023-12-27 10:08:48', '2023-12-27 11:01:41', NULL),
(5, 'RADIANT Employees', '2023-12-28 04:06:42', '2023-12-28 04:06:42', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_configs`
--

CREATE TABLE `tbl_configs` (
  `id` int(11) NOT NULL,
  `config_key` varchar(100) NOT NULL,
  `value` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_configs`
--

INSERT INTO `tbl_configs` (`id`, `config_key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'event_time', '10:30', '2023-12-19 08:04:34', '2023-12-19 08:05:05'),
(2, 'event_date', '2023-12-25', '2023-12-19 08:04:34', '2023-12-19 08:04:34'),
(3, 'footer_copyright_text', ' <p>&copy; <script>document.write(new Date().getFullYear())</script> RADIANT Insurance Company ltd. All Rights Reserved.<br/></p>\n      ', '2023-12-19 08:04:34', '2024-01-18 05:55:21'),
(4, 'system_name', 'RADIANT - Events', '2023-12-19 08:04:34', '2023-12-27 06:05:16'),
(5, 'contact_phone', '+(250) 784 354 460', '2023-12-19 08:04:34', '2023-12-27 06:05:16'),
(6, 'contact_email', 'aahishakiye@radiantyacu.rw', '2023-12-19 08:04:34', '2023-12-27 06:05:16'),
(7, 'contact_location', 'Kn 2 AV CHIC Building', '2023-12-19 08:04:34', '2023-12-27 06:05:16');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_guests`
--

CREATE TABLE `tbl_guests` (
  `id` int(11) NOT NULL,
  `names` varchar(255) NOT NULL,
  `position` varchar(512) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_guests`
--

INSERT INTO `tbl_guests` (`id`, `names`, `position`, `email`, `phone`, `country`, `category_id`, `created_at`, `updated_at`) VALUES
(63, 'John Doe', NULL, 'doe@john.com', '250784354462', 'Rwanda', 3, '2023-12-28 03:37:42', '2023-12-28 03:37:42'),
(64, 'John Doe', NULL, 'doe1@john.com', '250784354463', 'Rwanda', 3, '2023-12-28 03:37:42', '2023-12-28 03:37:42'),
(65, 'John Doe', NULL, 'doe2@john.com', '250784354464', 'Rwanda', 3, '2023-12-28 03:37:42', '2023-12-28 03:37:42'),
(66, 'John Doe', NULL, 'doe5@john.com', '250784354465', 'Rwanda', 3, '2023-12-28 03:37:42', '2023-12-28 03:37:42'),
(67, 'John Doe', NULL, 'doe6@john.com', '250784354466', 'Rwanda', 3, '2023-12-28 03:37:42', '2023-12-28 03:37:42'),
(68, 'John Doe', NULL, 'doe9@john.com', '250784354467', 'Rwanda', 3, '2023-12-28 03:37:42', '2023-12-28 03:37:42'),
(69, 'John Doe', NULL, 'doe8@john.com', '250784354468', 'Rwanda', 3, '2023-12-28 03:37:42', '2023-12-28 03:37:42'),
(70, 'John Doe', NULL, 'doe@john.com', '250784354469', 'Rwanda', 3, '2023-12-28 03:37:42', '2023-12-28 03:37:42'),
(71, 'John Doe', NULL, 'doe@john.com2', '25078435447', 'Rwanda', 5, '2023-12-28 04:13:41', '2023-12-28 04:13:41'),
(72, 'John Doe', NULL, '[object Object]', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(73, 'John Doe', NULL, 'doe@john.com3', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(74, 'John Doe', NULL, 'doe@john.com4', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(75, 'John Doe', NULL, 'doe@john.com5', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(76, 'John Doe', NULL, 'doe@john.com6', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(77, 'John Doe', NULL, 'doe@john.com7', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(78, 'John Doe', NULL, 'doe@john.com8', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(79, 'John Doe', NULL, 'doe@john.com9', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(80, 'John Doe', NULL, 'doe@john.com10', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(81, 'John Doe', NULL, 'doe@john.com11', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(82, 'John Doe', NULL, 'doe@john.com12', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(83, 'John Doe', NULL, 'doe@john.com13', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(84, 'John Doe', NULL, 'doe@john.com14', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(85, 'John Doe', NULL, 'doe@john.com15', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(86, 'John Doe', NULL, 'doe@john.com16', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(87, 'John Doe', NULL, 'doe@john.com17', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(88, 'John Doe', NULL, 'doe@john.com18', '250784354463', 'Rwanda', 5, '2023-12-28 04:16:13', '2023-12-28 04:16:13'),
(89, 'Ahishakiye Anaclet', NULL, 'a.anaclet920@gmail.com', '+(250) 784 354 4460', 'Rwanda', 0, '2024-01-18 10:09:19', '2024-01-18 10:09:19');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_hotels`
--

CREATE TABLE `tbl_hotels` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `listing` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_hotels`
--

INSERT INTO `tbl_hotels` (`id`, `name`, `address`, `listing`, `created_at`, `updated_at`) VALUES
(1, 'Marriott Hotel', 'KN 3 Ave, Kigali', 1, '2023-12-19 09:30:07', '2023-12-19 09:30:07'),
(2, 'Kigali Serena Hotel', 'KN 3 Ave, Kigali', 1, '2023-12-19 09:30:07', '2023-12-19 09:30:07');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_smses`
--

CREATE TABLE `tbl_smses` (
  `id` int(11) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `sms` varchar(512) NOT NULL,
  `status` varchar(128) NOT NULL,
  `guest_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id` int(11) NOT NULL,
  `names` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` text NOT NULL,
  `active` enum('Y','N') NOT NULL DEFAULT 'Y',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`id`, `names`, `email`, `password`, `active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'John Doe', 'john@example.com', '$2a$10$im0bWe9usIwouC1ogLRr4utBv5xdi617MCP/Yfb40zYO.h43Cf.qW', 'Y', '2023-12-20 12:06:32', '2023-12-20 12:06:32', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_bookings`
--
ALTER TABLE `tbl_bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_categories`
--
ALTER TABLE `tbl_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_configs`
--
ALTER TABLE `tbl_configs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_guests`
--
ALTER TABLE `tbl_guests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_hotels`
--
ALTER TABLE `tbl_hotels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_smses`
--
ALTER TABLE `tbl_smses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_bookings`
--
ALTER TABLE `tbl_bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_categories`
--
ALTER TABLE `tbl_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_configs`
--
ALTER TABLE `tbl_configs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_guests`
--
ALTER TABLE `tbl_guests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `tbl_hotels`
--
ALTER TABLE `tbl_hotels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_smses`
--
ALTER TABLE `tbl_smses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
