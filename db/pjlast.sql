-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: project
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` char(200) NOT NULL,
  `description` text NOT NULL,
  `create_by_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
INSERT INTO `blogs` VALUES (80,'sdfdsfsd','dsfdsfdsf',NULL),(81,'ขายเหยื่อ','ขาย 200 8000 cash',NULL),(82,'hrthrth','grgrf',NULL),(83,'asdsad','asdasdas',NULL),(84,'asdfasf','dsfds',NULL),(85,'ewf','ethgert',NULL),(86,'dsf','werew',NULL),(89,'test','sdfdsf',NULL),(92,'wefwefew','wfewef',1),(94,'trghrt','efrgert',5);
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chats` (
  `chat_id` int NOT NULL AUTO_INCREMENT,
  `chat_by_id` int NOT NULL,
  `chat_to_id` int NOT NULL,
  `chat_status` varchar(50) DEFAULT NULL,
  `form_blog_id` int DEFAULT NULL,
  PRIMARY KEY (`chat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `comment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `blog_id` int DEFAULT NULL,
  `content` varchar(50) NOT NULL,
  `comment_date` varchar(50) DEFAULT NULL,
  `comment_by_id` int DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  UNIQUE KEY `comment_id_UNIQUE` (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (4,1,'sdfdsfsd','2023-05-16 18:51:56',NULL,NULL),(5,80,'wefwef','2023-05-17 16:13:54',NULL,NULL),(6,80,'dfgdfg','2023-05-17 16:15:48',NULL,NULL),(7,80,'dfgdfg','2023-05-17 16:17:09',NULL,NULL),(8,80,'dfgdfg','2023-05-17 16:17:29',NULL,NULL),(9,80,'ergtergt','2023-05-17 16:18:01',NULL,NULL),(10,80,'ergtergt','2023-05-17 16:18:09',NULL,NULL),(11,80,'ergtergt','2023-05-17 16:18:09',NULL,NULL),(12,80,'ergtergt','2023-05-17 16:18:09',NULL,NULL),(13,80,'ergtergt','2023-05-17 16:18:09',NULL,NULL),(14,80,'ergtergt','2023-05-17 16:18:28',NULL,NULL),(15,80,'ergtergt','2023-05-17 16:18:46',NULL,NULL),(16,80,'ergtergt','2023-05-17 16:18:48',NULL,NULL),(17,80,'sdfdsf','2023-05-17 16:18:59',NULL,NULL),(18,80,'fdhfdeghdfhdfh','2023-05-17 16:19:39',NULL,NULL),(19,80,'dfgdfg','2023-05-17 16:20:25',NULL,NULL),(20,80,'eeee','2023-05-17 16:20:56',NULL,NULL),(21,80,'12121','2023-05-17 16:21:55',NULL,NULL),(22,80,'eee','2023-05-17 16:23:22',NULL,NULL),(23,80,'sdfdsf','2023-05-17 16:24:31',NULL,NULL),(24,81,'สนใจครับ','2023-05-17 16:34:30',NULL,NULL),(25,81,'สนใจครับ','2023-05-17 16:34:33',NULL,NULL),(26,80,'df','2023-05-17 16:34:48',NULL,NULL),(27,81,'8000qwe','2023-05-18 14:39:39',NULL,NULL),(28,81,'dffdf','2023-05-18 14:39:41',NULL,NULL),(29,81,'asda','2023-05-20 18:18:13',NULL,NULL),(30,81,'aaaa','2023-05-20 18:18:20',NULL,NULL),(31,82,'wer','2023-05-20 18:23:35',NULL,NULL),(32,81,'fefeesdfdsfdsfdsfdsfdsfsdfds','2023-05-20 18:36:05',9,'\\uploads\\user_image-1684577439569.png'),(33,81,'qweqw','2023-05-20 18:38:51',9,'\\uploads\\user_image-1684577439569.png'),(34,92,'fdfdhr','2023-05-21 03:10:28',9,'\\uploads\\user_image-1684577439569.png'),(35,92,'regerg','2023-05-21 03:10:31',9,'\\uploads\\user_image-1684577439569.png'),(36,92,'aaaaaaaaa','2023-05-21 03:10:36',9,'\\uploads\\user_image-1684577439569.png'),(37,93,'asda','2023-05-21 16:07:20',9,'\\uploads\\user_image-1684577439569.png'),(38,93,'sssssss','2023-05-21 16:07:23',9,'\\uploads\\user_image-1684577439569.png'),(39,93,'faedsgfer','2023-05-21 16:07:25',9,'\\uploads\\user_image-1684577439569.png'),(40,93,'gertghrt','2023-05-21 16:07:28',9,'\\uploads\\user_image-1684577439569.png'),(41,95,'1212122112','2023-05-22 04:31:35',9,'\\uploads\\user_image-1684577439569.png'),(42,96,'123123','2023-05-22 04:39:16',9,'\\uploads\\user_image-1684577439569.png');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `item_name` varchar(200) DEFAULT NULL,
  `item_desc` varchar(200) DEFAULT NULL,
  `item_image` varchar(200) DEFAULT NULL,
  `own_by_id` int DEFAULT NULL,
  `status` varchar(200) DEFAULT NULL,
  `blog_id` int NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (10,'aaaaaaaaaaaaa','ssssssssssssssssssss','\\uploads\\item_image-1684313132819.png',NULL,'On Going',80),(11,'เหยื่อจักรพรรดิ','เหยื่อ cash 100 ตัว 4900 cash','\\uploads\\item_image-1684316047736.jpg',NULL,'On Going',81),(12,'hrthrt','hrfhrt','\\uploads\\item_image-1684569901150.png',NULL,'On Going',82),(13,'sdaasdasd','sadasdasd','\\uploads\\item_image-1684582771104.png',NULL,'On Going',83),(14,'fsaasf','asfsaf','\\uploads\\item_image-1684582802856.png',NULL,'On Going',84),(15,'wefew','wefew','\\uploads\\item_image-1684599688930.png',NULL,'On Going',85),(16,'sdfsdf','sdds','\\uploads\\item_image-1684599719094.png',NULL,'On Going',86),(17,'tets','stetes','\\uploads\\item_image-1684613176427.png',NULL,'On Going',89),(18,'fewfwefwe','fewfewf','\\uploads\\item_image-1684613384119.png',1,'On Going',92),(19,'testestset','setestsetwest','\\uploads\\item_image-1684660022115.png',9,'sold',93),(20,'trhrth','trhrth','\\uploads\\item_image-1684686092313.png',5,'On Going',94),(21,'1dfsdsfs','dfdvgfdgv','\\uploads\\item_image-1684704679473.png',9,'Sold',95),(22,'dfgdfgdf','gdfgdf','\\uploads\\item_image-1684705116501.png',9,'Sold',96);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `message_id` int NOT NULL AUTO_INCREMENT,
  `message` varchar(200) NOT NULL,
  `m_by_id` int DEFAULT NULL,
  `m_image` varchar(200) DEFAULT NULL,
  `m_timestamp` date DEFAULT NULL,
  `chat_id` int NOT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'hi',10,'\\uploads\\user_image-1684659865157.png','2023-05-21',18),(2,'erew',10,'\\uploads\\user_image-1684659865157.png','2023-05-22',18),(3,'',10,'\\uploads\\user_image-1684659865157.png','2023-05-22',18),(4,'asdasd',10,'\\uploads\\user_image-1684659865157.png','2023-05-22',18),(8,'12312',9,'\\uploads\\user_image-1684577439569.png','2023-05-22',18),(9,'asdas',9,'\\uploads\\user_image-1684577439569.png','2023-05-22',18),(10,'qwe',10,'\\uploads\\user_image-1684659865157.png','2023-05-22',18),(11,'123213',10,'\\uploads\\user_image-1684659865157.png','2023-05-22',24),(12,'wfvwerfv',9,'\\uploads\\user_image-1684577439569.png','2023-05-22',24),(13,'1231232',10,'\\uploads\\user_image-1684659865157.png','2023-05-22',25),(14,'egfewr',9,'\\uploads\\user_image-1684577439569.png','2023-05-22',25);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,1,'KJ6=uRvth6lfE$j0P-WEzDxhn7rnPx@Jc#XY!&Pjt@Mq^KHQnybN9tHyt6Nmq@TGCFj4xP/3J4-HX9XvCyZEF1sL53vj2GCBA2mI'),(2,3,'SN25^K6W=hQ!Tt3TbGHg48Bb/rSHtp7-w#u#sVypV#GpBGgQ@^9A#Jcu47IwBa/Wr5^PY6Ofs37pFVQQ8TNWJHUWIrJpeXJTiYV!'),(3,5,'1zOHxQ2qO1Dh8f3QNsXuj4ids!iSz-vK^baaUDw8eg86h^f3tu188zaJ0wAXw^NLJsryByq7g1Fia5Y7qnaM77Ue&W*l&0IN^qr9'),(4,6,'J@7wtlYn9!R&oMo@g@mF1@4bIErkQUtklInQ/iP*f@AqCNzenU/3EISe$r4=Fd=/x@OfoG7PcOsF/tj*QZz@!KzYgc/a6W7e3dyi'),(5,9,'TvVvKZ6Ks-6fh!0$516IN44w*L=V52#vGzwjYoyQyaRh=xOZ0cRz!dD*xaoxCofNMzvM34UthSzQkm!snVjOk=GQabkEeH/nDUt!'),(6,10,'Dta!j3u7r5/iQuigg*/7#O3p02TL7=jB3XVBKrE=1ACOh-dw#79ntS6/FeTZrUxLrTw/A8F/=qWfRV*e9mqQb$CbipShM$Xpalos');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(200) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(200) NOT NULL,
  `last_name` varchar(200) NOT NULL,
  `picture` varchar(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `phone` int DEFAULT NULL,
  `role` varchar(200) DEFAULT NULL,
  `join_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (3,'user1','$2b$05$NfR8znZOUtY2Wozy7ll1WOVADnZAiOotxTwvs2Pseu1EtReYENim2','sddddd','dasdasdas','\\uploads\\user_image-1684409475160.png','aaaaaaa@gmail.com',123456789,'user','2023-05-18 11:31:15'),(4,'testttt','$2b$05$xaGdf2L4lntvKTqV7qT6tObjQ8mm.xtKbGFPF40hqryJzRGNigoN2','test','test',NULL,'test@gmail.com',123456778,'user','2023-05-20 08:16:18'),(5,'testt','$2b$05$WhRv1.hDQph2ru..zGFd/ueKnXRbdrgTYtPopu5kfv7BB7AWG/pZ2','popo','edsfgsw',NULL,'test@gmaiuk.com',123456789,'user','2023-05-20 08:18:36'),(6,'testtttt','$2b$05$ddlKDCY.t0R8rM09YHVqOeZ.1L3Gh0PcDemn9o3w8L6M79GJxwSiy','sddddd','dasdasdas','\\uploads\\user_image-1684571705750.png','aaaaaaa@gmail.com',123456789,'user','2023-05-20 08:35:05'),(7,'testttttf2','$2b$05$1BzEyUQQ9uAF6SglcMczquocR6M08/8l2xwbT94WXjC5bSOAoqUnK','sddddd','dasdasdas','\\uploads\\user_image-1684573872961.png','aaaaaaa@gmail.com',123456789,'user','2023-05-20 09:11:13'),(8,'df122','$2b$05$sDLZZAH02zu.wFuxEKZIdu0SzXmtA5zmDLpgweSKsvqUNMV1nX94.','dgr','regr','\\uploads\\user_image-1684575826091.png','dfghh@gmail.com',123476788,'user','2023-05-20 09:43:46'),(9,'pongtest','$2b$05$slefPXMdlnKytLfyoNkbz.XC7jboNlHfoXNFdOqAyyCGBP//1kDHy','p','p','\\uploads\\user_image-1684577439569.png','p@gmail.com',123457894,'user','2023-05-20 10:10:39'),(10,'Admin','$2b$05$Q/kdV.FfcC2SlDlpZNxQAejNdtclbSAlzTn47L.HPrNp8X.AO49ou','Admin','Admin','\\uploads\\user_image-1684659865157.png','Admin@gmail.com',999999999,'admin','2023-05-21 09:04:25');
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

-- Dump completed on 2023-05-22  4:41:52
