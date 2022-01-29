-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: localhost    Database: permission
-- ------------------------------------------------------
-- Server version	8.0.27-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Quản trị hệ thống','Quyền cao nhất'),(2,'Dashboard Projects','Truy cập xem được Dashboard Projects'),(3,'Dashboard User','Truy cập xem được Dashboard User'),(4,'Dashboard Task','Truy cập xem được Dashboard Task');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_users`
--

DROP TABLE IF EXISTS `roles_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_users` (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_users`
--

LOCK TABLES `roles_users` WRITE;
/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;
INSERT INTO `roles_users` VALUES (1,1),(2,3),(3,3),(1,2),(1,4),(1,3),(4,3),(4,4),(3,2),(3,4),(4,2),(5,2),(5,3),(5,4),(6,4),(6,2),(6,3),(7,2),(7,4),(7,3),(8,3),(8,1),(8,2),(9,2),(9,4),(9,3),(10,4),(10,3),(10,2),(10,1);
/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` datetime(3) NOT NULL,
  `active` tinyint NOT NULL,
  `change_pwd` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$pbkdf2-sha512$25000$y9l7LwVgTEkphdD6v/d.zw$DM/eFkWD5WFg560IpG7jgETRFF6E8hLlk9VoTkgVH4vAXHZXnqAsuYGJ6YGcv1izg/GMpUGt2LLXESC4kq/KgA','Administrator ','2021-01-28 06:16:37.000',1,0),(2,'tongttq','$pbkdf2-sha512$25000$CmHsfQ9hDMEYo/Q.pxRiLA$JpNEMqwj9KAfbm7xZUwtHiwaPH7YZICMTBciuKyyf5dAo/nBCIDjXYANn6P3ytxt9XjFM05IOqr5yqgMrHBVlw','Trần Thiên Quốc Tổng','2021-01-19 12:05:47.000',1,0),(3,'suylq','$pbkdf2-sha512$25000$co7RWivl/H.PkbIWwtj7Pw$YoOoxMl2Syf7sPo9e8wr/N47ROHmhOwtI6veMm8.6/9qReT2gEK.H/Kj13.tCnCxNong2m1XBwN0edgW3mMdbA','Lê Quốc Sũy','2021-05-19 16:47:21.000',1,0),(4,'khoatv','$pbkdf2-sha512$25000$jFEqxRgjBMD4vzdmbC2FUA$0YR/2NNHZo6xMCksJcDKZgWT0ejbRXASORacX/rp1yceuG18jZsXfBRhPbzynG1P6ocKBF47qAnLaLO1XXJyZQ','Trần Viết Khoa','2021-05-19 17:26:37.000',1,0),(5,'huelt','$pbkdf2-sha512$25000$YMx5D6H0/v.f834PofT.Hw$MaLeLzeaQM2P7stNwTA4XI/TMGHN8ZDgevKImS5nuBZvhzQcZYFc56efSmIG.U1VkF7Yxd5fltL5bDMEffOBDg','Lê Thị Huệ','2021-05-24 16:08:23.000',1,0),(6,'thamltt','$pbkdf2-sha512$25000$mpPyPsc4hxDivBfivPd.rw$8zOJpX1ehDD1FDJjsm0/tPVBAoOcxsUH7.ap8xYyIDzZ9MezkguseYpPR4.nyYVbSdzEGCt5bTWtxa0yriVndw','Lê Thị Thu Thẩm','2021-05-24 16:08:50.000',1,0),(7,'khanhtq','$pbkdf2-sha512$25000$eQ9BaG2t1fq/9/5/j7F2Lg$AsF8PxWcuvLu9Mq10D4k94eO0U3S/kOVAaUiTlZ6yr6w0lcryiHlEkVwyVFcvT92F4Dc6FGEcSdBQn8y2FvDww','Trần Quốc Khánh','2021-05-25 14:48:35.000',1,0),(8,'thend','$pbkdf2-sha512$25000$ulcK4TwnJCSkdC5lrPUeIw$h8zTRjhlWYIOGcFAKQBDQXypOqFfuK2HmI20gR7PP3/YvVrVzdVIMJo.CglHiyQOZCiJwpEXjiV2Ylvgk4R6cg','Nguyễn Đình Thể','2021-05-25 14:49:02.000',1,0),(9,'vanna','$pbkdf2-sha512$25000$.h.DEOLcu/de650TQqi1Fg$Cp9anx.c0wdgEtqnupmyqrn.qB7YHxgVf.XiQt/NfalShoAWt3wAGi6KM8M9BtZwCzf4D74VhOrYhNwGbzqtmg','Nguyễn Anh Văn','2021-05-25 14:49:28.000',1,0),(10,'ducth','$pbkdf2-sha512$25000$4nyvlfJe613LOad0DqFUig$Opvq23FrwW0Vk4HpctgToTmriRdjd6jOi62ns34ghFYHP3taa8TLocp1XzHp1BjTd6oJCvbWyK1EOFTbsIRL0w','Trần Hữu Đức','2021-05-25 14:50:04.000',1,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-29 13:37:37
