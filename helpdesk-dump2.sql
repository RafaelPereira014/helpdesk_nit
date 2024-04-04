-- MySQL dump 10.13  Distrib 8.2.0, for macos13.5 (x86_64)
--
-- Host: localhost    Database: helpdesk2
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
) ENGINE=InnoDB AUTO_INCREMENT=3186 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (3129,32,'ola','admin','2024-04-03 15:59:36','admin'),(3130,32,'Ticket fechado pelo admin at 03-04-2024 15:59:39','admin','2024-04-03 15:59:39',NULL),(3131,32,'This ticket has been closed.','admin','2024-04-03 15:59:39','admin'),(3132,32,'Olá','admin','2024-04-04 11:17:35','admin'),(3133,32,'This ticket has been closed.','admin','2024-04-04 11:17:41','admin'),(3134,32,'This ticket has been reopened.','admin','2024-04-04 11:17:51','admin'),(3135,32,'This ticket has been closed.','admin','2024-04-04 11:18:08','admin'),(3136,32,'Ticket reopened by admin at 04-04-2024 11:22:49','admin','2024-04-04 11:22:49',NULL),(3137,32,'This ticket has been reopened.','admin','2024-04-04 11:22:49','admin'),(3138,32,'Ticket fechado pelo admin at 04-04-2024 11:22:59','admin','2024-04-04 11:22:59',NULL),(3139,32,'This ticket has been closed.','admin','2024-04-04 11:22:59','admin'),(3140,32,'Bem vindo','admin','2024-04-04 11:23:19','Pedro Santos'),(3141,32,'Ticket reopened by admin at 04-04-2024 11:23:25','admin','2024-04-04 11:23:25',NULL),(3142,32,'This ticket has been reopened.','admin','2024-04-04 11:23:25','Pedro Santos'),(3143,32,'Ticket fechado pelo admin at 04-04-2024 11:24:07','admin','2024-04-04 11:24:07',NULL),(3144,32,'This ticket has been closed.','admin','2024-04-04 11:24:07','Pedro Santos'),(3145,32,'Ticket fechado pelo admin at 04-04-2024 11:24:24','admin','2024-04-04 11:24:24',NULL),(3146,32,'This ticket has been closed.','admin','2024-04-04 11:24:24','Pedro Santos'),(3147,32,'Ticket fechado pelo admin at 04-04-2024 11:24:58','admin','2024-04-04 11:24:58',NULL),(3148,32,'This ticket has been closed.','admin','2024-04-04 11:24:58','Carlos Cota'),(3149,32,'Olá','admin','2024-04-04 11:26:21','admin'),(3150,32,'Ticket reopened by admin at 04-04-2024 11:26:29','admin','2024-04-04 11:26:29',NULL),(3151,32,'This ticket has been reopened.','admin','2024-04-04 11:26:29','admin'),(3152,32,'Ticket reopened by admin at 04-04-2024 11:27:41','admin','2024-04-04 11:27:41',NULL),(3153,32,'This ticket has been reopened.','admin','2024-04-04 11:27:41','Pedro Santos'),(3154,32,'Ticket reopened by admin at 04-04-2024 11:28:39','admin','2024-04-04 11:28:39',NULL),(3155,32,'This ticket has been reopened.','admin','2024-04-04 11:28:39','Pedro Santos'),(3156,32,'Ticket fechado pelo admin at 04-04-2024 11:28:52','admin','2024-04-04 11:28:52',NULL),(3157,32,'This ticket has been closed.','admin','2024-04-04 11:28:52','Pedro Santos'),(3158,33,'Olá admin','user','2024-04-04 11:33:51','test_user'),(3159,33,'Olá user','admin','2024-04-04 11:34:22','admin'),(3160,33,'Ticket fechado pelo admin at 04-04-2024 11:55:55','admin','2024-04-04 11:55:55',NULL),(3161,33,'This ticket has been closed.','admin','2024-04-04 11:55:55','admin'),(3162,33,'ola','admin','2024-04-04 11:56:02','admin'),(3163,33,'Ticket reopened by admin at 04-04-2024 11:56:15','admin','2024-04-04 11:56:15',NULL),(3164,33,'This ticket has been reopened.','admin','2024-04-04 11:56:15','admin'),(3165,33,'Ticket fechado pelo admin at 04-04-2024 12:12:53','admin','2024-04-04 12:12:53',NULL),(3166,33,'This ticket has been closed.','admin','2024-04-04 12:12:53','admin'),(3167,35,'mensagem teste Duate','user','2024-04-04 14:21:25','test_user'),(3168,35,'Ticket fechado pelo admin at 04-04-2024 14:22:10','admin','2024-04-04 14:22:10',NULL),(3169,35,'This ticket has been closed.','admin','2024-04-04 14:22:10','admin'),(3170,36,'ewrvtwertwre','admin','2024-04-04 15:18:26','Carlos Cota'),(3171,36,'ghjghjghjgh','admin','2024-04-04 15:18:31','Carlos Cota'),(3172,36,'Ticket fechado pelo admin at 04-04-2024 15:18:38','admin','2024-04-04 15:18:38',NULL),(3173,36,'This ticket has been closed.','admin','2024-04-04 15:18:38','Carlos Cota'),(3174,40,'Ticket fechado pelo admin at 04-04-2024 16:38:41','admin','2024-04-04 16:38:41',NULL),(3175,40,'This ticket has been closed.','admin','2024-04-04 16:38:41','Luis Martins'),(3176,39,'Ticket fechado pelo admin at 04-04-2024 16:43:28','admin','2024-04-04 16:43:28',NULL),(3177,39,'This ticket has been closed.','admin','2024-04-04 16:43:28','Luis Martins'),(3178,38,'Ticket fechado pelo admin at 04-04-2024 16:44:13','admin','2024-04-04 16:44:13',NULL),(3179,38,'This ticket has been closed.','admin','2024-04-04 16:44:13','Luis Martins'),(3180,37,'Ticket fechado pelo admin at 04-04-2024 16:45:41','admin','2024-04-04 16:45:41',NULL),(3181,37,'This ticket has been closed.','admin','2024-04-04 16:45:41','Luis Martins'),(3182,40,'This ticket has been reopened.','admin','2024-04-04 16:54:59','admin'),(3183,40,'Ticket reopened by admin at 04-04-2024 16:54:59','admin','2024-04-04 16:54:59',NULL),(3184,40,'Ticket fechado pelo admin at 04-04-2024 16:55:11','admin','2024-04-04 16:55:11',NULL),(3185,40,'This ticket has been closed.','admin','2024-04-04 16:55:11','admin');
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
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `attributed_to` (`attributed_to`),
  KEY `fk_topic_id` (`topic_id`),
  KEY `fk_tickets_group_id` (`group_id`),
  CONSTRAINT `fk_tickets_group_id` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`id`),
  CONSTRAINT `fk_topic_id` FOREIGN KEY (`topic_id`) REFERENCES `Topics` (`id`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `Users` (`id`),
  CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`attributed_to`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (32,'<p>novo ticket criado</p>','2024-04-03','closed',1,NULL,1,'1234','test_user',1,'New ticket','Pedro Santos'),(33,'<p>Descri&ccedil;&atilde;o para um novo ticket</p>','2024-04-04','closed',1,NULL,2,'175','test_user',1,'Novo titulo','admin'),(34,'<p><strong>Obtive um problema</strong></p>\r\n<p>problema nos certificados</p>','2024-04-04','open',1,NULL,3,'310179','test_user',2,'Problema com certificado',NULL),(35,'<p>test</p>','2024-04-04','closed',1,NULL,2,'3103100','test_user',1,'teste_sig','admin'),(36,'<p>do user joao rat&atilde;o</p>','2024-04-04','closed',1,NULL,1,'999999','test_user',1,'alterar password','Carlos Cota'),(37,'<p>odeokaoe,odo teste</p>','2024-04-04','closed',1,NULL,3,'1234','test_user',2,'teste_email','Luis Martins'),(38,'<p>teste email&nbsp;</p>','2024-04-04','closed',1,NULL,3,'123','test_user',2,'test_123','Luis Martins'),(39,'<p>123124</p>','2024-04-04','closed',1,NULL,1,'123','test_user',1,'teste','Luis Martins'),(40,'<p>teste123</p>','2024-04-04','closed',1,NULL,1,'123w','test_user',1,'aaaaa','admin'),(41,'<p>nova descricao ashdahb</p>','2024-04-04','open',1,NULL,3,'q2345','test_user',2,'new ticet',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Topics`
--

LOCK TABLES `Topics` WRITE;
/*!40000 ALTER TABLE `Topics` DISABLE KEYS */;
INSERT INTO `Topics` VALUES (1,'password',1),(2,'sighrara',1),(3,'certificados',2);
/*!40000 ALTER TABLE `Topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `group_id` int DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_group_id` (`group_id`),
  CONSTRAINT `fk_group_id` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'test_user','test_password','user','2024-03-27 12:57:43',NULL,'rafael.b.pereira@azores.gov.pt'),(2,'admin','admin_password','admin','2024-03-27 17:06:41',1,NULL),(3,'Pedro Santos','password%100','admin','2024-04-02 11:55:34',2,NULL),(4,'Luis Martins','password%100','admin','2024-04-02 11:55:46',2,NULL),(5,'Carlos Cota','password%100','admin','2024-04-02 11:55:59',1,NULL);
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-04 16:59:58
