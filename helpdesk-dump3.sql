-- MySQL dump 10.13  Distrib 8.2.0, for macos13.5 (x86_64)
--
-- Host: localhost    Database: helpdesk4
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `Groups`
--

DROP TABLE IF EXISTS `Groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Groups`
--

LOCK TABLES `Groups` WRITE;
/*!40000 ALTER TABLE `Groups` DISABLE KEYS */;
INSERT INTO `Groups` VALUES (1,'micro-informatica'),(2,'macro-informatica');
/*!40000 ALTER TABLE `Groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ticket_id` int DEFAULT NULL,
  `message` text COLLATE utf8mb4_general_ci,
  `sender_type` enum('user','admin') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `sender_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3307 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (3305,114,'Este ticket foi aceite com sucesso.','admin','2024-04-16 12:23:16','Carlos Cota'),(3306,114,'Este ticket foi fechado com sucesso.','admin','2024-04-16 12:23:26','Carlos Cota');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text COLLATE utf8mb4_general_ci,
  `date` date DEFAULT NULL,
  `state` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `attributed_to` int DEFAULT NULL,
  `topic_id` int DEFAULT NULL,
  `contacto` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `group_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `closed_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `UnidadeOrg` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `attributed_to_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `attributed_to` (`attributed_to`),
  KEY `fk_topic_id` (`topic_id`),
  KEY `fk_tickets_group_id` (`group_id`),
  CONSTRAINT `fk_attributed_to` FOREIGN KEY (`attributed_to`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_tickets_group_id` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`id`),
  CONSTRAINT `fk_topic_id` FOREIGN KEY (`topic_id`) REFERENCES `Topics` (`id`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (114,'<p>Ticket inicial</p>','2024-04-16','closed',1,5,2,'1823','test_user',1,'Novo ticket','Carlos Cota','EBSV - Escola Básica Secundária Velas','Carlos Cota');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Topics`
--

DROP TABLE IF EXISTS `Topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Topics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key_word` text COLLATE utf8mb4_general_ci,
  `group_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_topics_group_id` (`group_id`),
  CONSTRAINT `fk_topics_group_id` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Topics`
--

LOCK TABLES `Topics` WRITE;
/*!40000 ALTER TABLE `Topics` DISABLE KEYS */;
INSERT INTO `Topics` VALUES (1,'password',1),(2,'Geral',1),(3,'certificados',2),(4,'Criar conta EDU',1),(5,'Reset MFA EDU',1),(6,'Reset password EDU',1),(7,'Adicionar MACaddress a controladora',1);
/*!40000 ALTER TABLE `Topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `group_id` int DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `uo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_group_id` (`group_id`),
  CONSTRAINT `fk_group_id` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'test_user','password%100','user','2024-03-27 12:57:43',NULL,'rafael.b.pereira@azores.gov.pt','EBSLP'),(2,'admin','admin_password','admin','2024-03-27 17:06:41',1,'rafaelpereira0808@gmail.com','srec-nit'),(3,'Pedro Santos','password%100','admin','2024-04-02 11:55:34',2,'Pedro.MM.Santos2@azores.gov.pt','srec-nit'),(4,'Luis Martins','password%100','admin','2024-04-02 11:55:46',2,'Luis.FL.Martins@azores.gov.pt','srec-nit'),(5,'Carlos Cota','password%100','admin','2024-04-02 11:55:59',1,'Carlos.AE.Cota@azores.gov.pt','srec-nit'),(6,'PS1009','password%100','user','2024-04-09 15:05:39',NULL,'pedrosantos@azores.gov.pt',NULL),(7,'newpass','newpass','user','2024-04-09 15:14:41',NULL,'rasr@azores.gov.pt',NULL),(8,'Antonio Santos','password%100','admin','2024-04-09 15:43:49',1,'Antonio.JC.Santos@azores.gov.pt',NULL),(9,'Teresa Cota','password%!00','admin','2024-04-09 15:53:27',1,'Teresa.JL.Cota@azores.gov.pt',NULL),(10,'Elisabete Martins','password%100','admin','2024-04-09 15:55:49',1,'Elisabete.MS.Martins@azores.gov.pt',NULL),(11,'Maria da Conceição Duarte','password%100','admin','2024-04-09 16:01:24',1,'Maria.CF.Duarte@azores.gov.pt',NULL),(12,'test_edu','password%100','user','2024-04-10 11:38:58',1,'test_edu@edu.azores.gov.pt',NULL),(14,'test_gra','password%100','user','2024-04-15 10:04:44',1,'testgra@azores.gov.pt',NULL);
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

-- Dump completed on 2024-04-16 12:23:58
