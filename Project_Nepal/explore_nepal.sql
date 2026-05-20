-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2026 at 03:03 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `explore_nepal`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `destination_id` int(10) UNSIGNED NOT NULL,
  `booking_ref` varchar(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Pending',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `destination_id`, `booking_ref`, `amount`, `status`, `created_at`) VALUES
(1, 3, 11, 'ENP-6ADD1611', 0.01, 'Completed', '2026-05-20 00:33:45'),
(2, 3, 11, 'ENP-4F1062F6', 1000000.00, 'Cancelled', '2026-05-20 15:07:20'),
(3, 3, 11, 'ENP-7E752C67', 1000000.00, 'Confirmed', '2026-05-20 18:45:50');

-- --------------------------------------------------------

--
-- Table structure for table `destinations`
--

CREATE TABLE `destinations` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(150) NOT NULL,
  `region` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  `difficulty` varchar(20) NOT NULL,
  `duration` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `image_url` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `destinations`
--

INSERT INTO `destinations` (`id`, `name`, `description`, `location`, `region`, `category`, `difficulty`, `duration`, `price`, `image_url`, `created_at`, `updated_at`) VALUES
(1, 'Everest Base Camp', 'Mount Everest is regarded not simply as a peak, but as a profound theater of silence, scale, and human wonder. Rising through the Himalayan ether with almost mythic grandeur, Everest humbles even the most seasoned traveler, offering moments of startling beauty beneath an unforgiving sky. Our expeditions are designed to immerse guests in the raw poetry of Nepal’s highlands, where every step feels both insignificant and extraordinary.', 'Solukhumbu, Koshi', 'Himalayan', 'Trekking', 'Hard', '14 days', 42000.00, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.startlap.hu%2Futazas%2Fuploads%2Fsites%2F3%2F2024%2F07%2Feverest-scaled.jpg&f=1&nofb=1&ipt=105db2a516c3627cacca40acefa755faf5233f4f0294600a8f7e5c414963b602', '2026-05-19 21:50:33', '2026-05-19 22:01:37'),
(2, 'Annapurna Circuit Trek', 'Annapurna Base Camp is experienced as a passage into the heart of the Himalayas, a sanctuary of towering ice walls, whispering forests, and rare stillness. Encircled by colossal peaks draped in snow and shadow, the journey unfolds with a quiet, almost cinematic beauty that lingers long after the descent. More than a trek, it is an encounter with Nepal in its most sublime and elemental form.', 'Gandaki Province', 'Himalayan', 'Trekking', 'Moderate', '15 days', 1500.00, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.ESLK4m9yc9JtjXjDiaHkIwHaEK%3Fpid%3DApi&f=1&ipt=da55c51d67e626bc33a620964f9f48d408538a4096aeec4b6fa6627cf04d62c6&ipo=images', '2026-05-19 21:50:33', '2026-05-19 22:05:33'),
(3, 'Langtang Valley Trek', 'Langtang Valley is cherished for its quiet grandeur, A Himalayan landscape where emerald forests, glacial rivers, and ancient mountain villages exist in remarkable harmony. Framed by dramatic snowbound peaks and touched by a deeply enduring culture, Langtang offers a gentler, more intimate encounter with the Himalayas. It is a journey defined not by spectacle alone, but by serenity, authenticity, and the lingering poetry of the mountains.', 'Rasuwa, Bagmati', 'Himalayan', 'Trekking', 'Moderate', '10 days', 650.00, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%2Fid%2FOIP.zN74Uucwjk30jJN-TMZUWQHaFj%3Fpid%3DApi&f=1&ipt=096feb83607315aafb43f06b2a33141336d5c34917e423fa4c20b19c498ef5ec&ipo=images', '2026-05-19 21:50:33', '2026-05-19 22:06:21'),
(4, 'Kathmandu Durbar Square', 'Kathmandu Durbar Square is admired as a living chronicle of Nepal’s regal past — an intricate tapestry of palaces, courtyards, and sacred temples shaped by centuries of artistry and devotion. Amid the scent of incense and the quiet resonance of temple bells, the square reveals a rare convergence of history, spirituality, and urban vitality. It remains one of Kathmandu’s most evocative cultural treasures, timeless in both atmosphere and significance.', 'Kathmandu, Bagmati', 'Hilly', 'Cultural', 'Easy', '1 days', 25.00, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fthf.bing.com%2Fth%2Fid%2FOIP.6VTLAAbD9-gG84YKwQPDbQHaEK%3Fr%3D0%26cb%3Dthfc1falcon%26pid%3DApi&f=1&ipt=9482cb69f94b6854f5c7bb5b23c3cd94403bc7822590f015d48fc8c48efaf9e7&ipo=images', '2026-05-19 21:50:33', '2026-05-19 22:07:28'),
(5, 'Chitwan Safari', 'Chitwan National Park is revered as a sanctuary of extraordinary biodiversity and untamed elegance. From dense sal forests to mist-laden grasslands alive with rare wildlife, the park offers an immersive encounter with Nepal’s subtropical wilderness in its most majestic form. Here, nature unfolds with quiet grandeur — primal, cinematic, and profoundly unforgettable.[Sassy Ahh Rhino]', 'Chitwan, Bagmati', 'Terai', 'Wildlife', 'Easy', '3 days', 280.00, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fres.klook.com%2Fimages%2Ffl_lossy.progressive%2Cq_65%2Fc_fill%2Cw_960%2Ch_640%2Fw_59%2Cx_11%2Cy_11%2Cg_south_west%2Cl_Klook_water_br_trans_yhcmh3%2Factivities%2Ffrl3yd9qlbyqtf8abq8u%2FChitwanNationalParkTour2Nights3DaysJungleSafariPackage.jpg&f=1&nofb=1&ipt=4d64acafcc114e89bd30f8f7f0c15b5b740ad10e4757585c98d813513fdd157f', '2026-05-19 21:50:33', '2026-05-19 22:10:14'),
(6, 'Pokhara Lakeside', 'Pokhara is embraced as a city of tranquil beauty, where serene lakes mirror the grandeur of the Annapurna range beneath ever-changing Himalayan light. Framed by verdant hills and a gentle, almost dreamlike atmosphere, Pokhara offers a rare harmony between adventure and repose. It is a destination where Nepal reveals its softer elegance, contemplative, luminous, and effortlessly enchanting.', 'Kaski, Gandaki', 'Hilly', 'Scenic', 'Easy', '3 days', 150.00, 'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Ftravel80.com%2Fwp-content%2Fuploads%2F2025%2F06%2F2025-08-15-016-pokhara-nightlife-guide.png&f=1&nofb=1&ipt=5c18966c17c0d5020e699327ca6f29bd1cdd38b432d2b67f13d78135767c2222', '2026-05-19 21:50:33', '2026-05-19 22:12:47'),
(8, 'Lumbini', 'Lumbini is revered as a sanctuary of profound stillness and spiritual significance — the sacred birthplace of Gautama Buddha and one of the world’s most contemplative pilgrimage destinations. Amid monastic gardens, ancient ruins, and the soft cadence of prayer, the atmosphere carries a rare sense of serenity that feels almost detached from time itself. Lumbini offers not merely a visit, but a deeply reflective encounter with peace, history, and the enduring philosophy of enlightenmen', 'Rupandehi, Lumbini', 'Terai', 'Religious', 'Easy', '2 days', 120.00, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2F64.media.tumblr.com%2F88edf4c03c6fa284d41317b01affbe09%2Fdbbd6b6d2e63f06b-a8%2Fs640x960%2Fc99aa50b88e6ab5c11130ffcae64ad5624ce2989.jpg&f=1&nofb=1&ipt=efb0bc33e834768cf4120d6ec6bb552cfbec8013b9fe554520214fe2bc5e565d', '2026-05-19 21:50:33', '2026-05-19 22:47:21'),
(9, 'Rara Lake', 'Rara Lake is regarded as one of the Himalayas’ most ethereal sanctuaries — a vast sapphire expanse hidden among pine-clad hills and untouched wilderness. Wrapped in an almost dreamlike stillness, the lake reflects the changing moods of the mountains with breathtaking clarity, offering a rare sense of isolation and serenity far removed from the modern world', 'Gorkha, Gandaki', 'Himalayan', 'Trekking', 'Moderate', '4 days', 750.00, 'https://images.unsplash.com/photo-1631873505000-c9e468448040?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-05-19 21:50:33', '2026-05-19 22:33:35'),
(10, 'Upper Mustang', 'Upper Mustang is admired as a lost Himalayan kingdom suspended between myth and wilderness. Defined by vast ochre cliffs, ancient cave monasteries, and windswept desert valleys sculpted by time itself, the region possesses a stark and almost extraterrestrial beauty unlike anywhere else in Nepal. Upper Mustang offers an expedition into the enigmatic, remote, culturally profound, and hauntingly magnificent.', 'Mustang, Gandaki', 'Himalayan', 'Adventure', 'Hard', '14 days', 1800.00, 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-05-19 21:50:33', '2026-05-19 22:46:27'),
(11, 'Phantom Island', 'Among the volcanic shores and opalescent tides of Phantom Island resides a mythical being of extraordinary peculiarity, distinguished by its floral Hawaiian shirts, obsidian sunglasses, and the near-ceremonial carrying of both a surfboard-shaped guitar in tandem. Frequently observed wandering the coastline at dusk, the creature performs impossibly melodic compositions with such transcendent finesse that local accounts insist the ocean itself yields before the music, splitting into vast aqueous chasms reminiscent of ancient scripture. Whether deity, anomaly, or merely the island’s most eccentric inhabitant remains a matter of considerable academic dispute', 'Unknown', 'Terai', 'Scenic', 'Hard', '365 days', 1000000.00, 'https://i1.sndcdn.com/artworks-zRdBjzmFD8UdQ5g2-ebFEIw-t1080x1080.jpg', '2026-05-19 22:24:15', '2026-05-20 00:34:33');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'ADMIN'),
(2, 'USER');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone` char(10) NOT NULL,
  `role_id` tinyint(3) UNSIGNED NOT NULL DEFAULT 2,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password_hash`, `phone`, `role_id`, `created_at`) VALUES
(1, 'Site Admin', 'admin@explorenepal.com', '$2a$12$gLIwCeiIODAvvzgJihZ9ROnQX//n.Y.tSfqhBWVJ7j7VBHqz37EjO', '9800000000', 1, '2026-05-19 21:50:33'),
(3, 'Amba Singh\'s brother', 'yuytrffghujyt@gmail.com', '$2a$12$S85xWkTpoevFe6XyZAIW8OMV7leO0//y9zN/7IJDUOIrp3MS2MSQ.', '9653467457', 2, '2026-05-19 23:42:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `booking_ref` (`booking_ref`),
  ADD KEY `fk_booking_user` (`user_id`),
  ADD KEY `fk_booking_dest` (`destination_id`);

--
-- Indexes for table `destinations`
--
ALTER TABLE `destinations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_users_role` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `destinations`
--
ALTER TABLE `destinations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `fk_booking_dest` FOREIGN KEY (`destination_id`) REFERENCES `destinations` (`id`),
  ADD CONSTRAINT `fk_booking_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
