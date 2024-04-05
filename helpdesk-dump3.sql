-- MySQL dump 10.13  Distrib 8.2.0, for macos13.5 (x86_64)
--
-- Host: localhost    Database: helpdesk3
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
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `sender_type` enum('user','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `sender_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3205 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (3129,32,'ola','admin','2024-04-03 15:59:36','admin'),(3130,32,'Ticket fechado pelo admin at 03-04-2024 15:59:39','admin','2024-04-03 15:59:39',NULL),(3131,32,'This ticket has been closed.','admin','2024-04-03 15:59:39','admin'),(3132,32,'Olá','admin','2024-04-04 11:17:35','admin'),(3133,32,'This ticket has been closed.','admin','2024-04-04 11:17:41','admin'),(3134,32,'This ticket has been reopened.','admin','2024-04-04 11:17:51','admin'),(3135,32,'This ticket has been closed.','admin','2024-04-04 11:18:08','admin'),(3136,32,'Ticket reopened by admin at 04-04-2024 11:22:49','admin','2024-04-04 11:22:49',NULL),(3137,32,'This ticket has been reopened.','admin','2024-04-04 11:22:49','admin'),(3138,32,'Ticket fechado pelo admin at 04-04-2024 11:22:59','admin','2024-04-04 11:22:59',NULL),(3139,32,'This ticket has been closed.','admin','2024-04-04 11:22:59','admin'),(3140,32,'Bem vindo','admin','2024-04-04 11:23:19','Pedro Santos'),(3141,32,'Ticket reopened by admin at 04-04-2024 11:23:25','admin','2024-04-04 11:23:25',NULL),(3142,32,'This ticket has been reopened.','admin','2024-04-04 11:23:25','Pedro Santos'),(3143,32,'Ticket fechado pelo admin at 04-04-2024 11:24:07','admin','2024-04-04 11:24:07',NULL),(3144,32,'This ticket has been closed.','admin','2024-04-04 11:24:07','Pedro Santos'),(3145,32,'Ticket fechado pelo admin at 04-04-2024 11:24:24','admin','2024-04-04 11:24:24',NULL),(3146,32,'This ticket has been closed.','admin','2024-04-04 11:24:24','Pedro Santos'),(3147,32,'Ticket fechado pelo admin at 04-04-2024 11:24:58','admin','2024-04-04 11:24:58',NULL),(3148,32,'This ticket has been closed.','admin','2024-04-04 11:24:58','Carlos Cota'),(3149,32,'Olá','admin','2024-04-04 11:26:21','admin'),(3150,32,'Ticket reopened by admin at 04-04-2024 11:26:29','admin','2024-04-04 11:26:29',NULL),(3151,32,'This ticket has been reopened.','admin','2024-04-04 11:26:29','admin'),(3152,32,'Ticket reopened by admin at 04-04-2024 11:27:41','admin','2024-04-04 11:27:41',NULL),(3153,32,'This ticket has been reopened.','admin','2024-04-04 11:27:41','Pedro Santos'),(3154,32,'Ticket reopened by admin at 04-04-2024 11:28:39','admin','2024-04-04 11:28:39',NULL),(3155,32,'This ticket has been reopened.','admin','2024-04-04 11:28:39','Pedro Santos'),(3156,32,'Ticket fechado pelo admin at 04-04-2024 11:28:52','admin','2024-04-04 11:28:52',NULL),(3157,32,'This ticket has been closed.','admin','2024-04-04 11:28:52','Pedro Santos'),(3158,33,'Olá admin','user','2024-04-04 11:33:51','test_user'),(3159,33,'Olá user','admin','2024-04-04 11:34:22','admin'),(3160,33,'Ticket fechado pelo admin at 04-04-2024 11:55:55','admin','2024-04-04 11:55:55',NULL),(3161,33,'This ticket has been closed.','admin','2024-04-04 11:55:55','admin'),(3162,33,'ola','admin','2024-04-04 11:56:02','admin'),(3163,33,'Ticket reopened by admin at 04-04-2024 11:56:15','admin','2024-04-04 11:56:15',NULL),(3164,33,'This ticket has been reopened.','admin','2024-04-04 11:56:15','admin'),(3165,33,'Ticket fechado pelo admin at 04-04-2024 12:12:53','admin','2024-04-04 12:12:53',NULL),(3166,33,'This ticket has been closed.','admin','2024-04-04 12:12:53','admin'),(3167,35,'mensagem teste Duate','user','2024-04-04 14:21:25','test_user'),(3168,35,'Ticket fechado pelo admin at 04-04-2024 14:22:10','admin','2024-04-04 14:22:10',NULL),(3169,35,'This ticket has been closed.','admin','2024-04-04 14:22:10','admin'),(3170,36,'ewrvtwertwre','admin','2024-04-04 15:18:26','Carlos Cota'),(3171,36,'ghjghjghjgh','admin','2024-04-04 15:18:31','Carlos Cota'),(3172,36,'Ticket fechado pelo admin at 04-04-2024 15:18:38','admin','2024-04-04 15:18:38',NULL),(3173,36,'This ticket has been closed.','admin','2024-04-04 15:18:38','Carlos Cota'),(3174,40,'Ticket fechado pelo admin at 04-04-2024 16:38:41','admin','2024-04-04 16:38:41',NULL),(3175,40,'This ticket has been closed.','admin','2024-04-04 16:38:41','Luis Martins'),(3176,39,'Ticket fechado pelo admin at 04-04-2024 16:43:28','admin','2024-04-04 16:43:28',NULL),(3177,39,'This ticket has been closed.','admin','2024-04-04 16:43:28','Luis Martins'),(3178,38,'Ticket fechado pelo admin at 04-04-2024 16:44:13','admin','2024-04-04 16:44:13',NULL),(3179,38,'This ticket has been closed.','admin','2024-04-04 16:44:13','Luis Martins'),(3180,37,'Ticket fechado pelo admin at 04-04-2024 16:45:41','admin','2024-04-04 16:45:41',NULL),(3181,37,'This ticket has been closed.','admin','2024-04-04 16:45:41','Luis Martins'),(3182,40,'This ticket has been reopened.','admin','2024-04-04 16:54:59','admin'),(3183,40,'Ticket reopened by admin at 04-04-2024 16:54:59','admin','2024-04-04 16:54:59',NULL),(3184,40,'Ticket fechado pelo admin at 04-04-2024 16:55:11','admin','2024-04-04 16:55:11',NULL),(3185,40,'This ticket has been closed.','admin','2024-04-04 16:55:11','admin'),(3186,45,'ola','user','2024-04-05 10:48:14','test_user'),(3187,44,'This ticket has been accepted by you.','admin','2024-04-05 11:38:34','Pedro Santos'),(3188,44,'Ticket accepted by admin at 05-04-2024 11:38:34','admin','2024-04-05 11:38:34',NULL),(3189,47,'Ticket accepted by admin at 05-04-2024 11:41:36','admin','2024-04-05 11:41:36',NULL),(3190,47,'This ticket has been accepted by you.','admin','2024-04-05 11:41:36','Carlos Cota'),(3191,46,'Ticket accepted by admin at 05-04-2024 11:58:14','admin','2024-04-05 11:58:14',NULL),(3192,46,'This ticket has been accepted by you.','admin','2024-04-05 11:58:14','Carlos Cota'),(3193,48,'Ticket accepted by admin at 05-04-2024 12:04:23','admin','2024-04-05 12:04:23',NULL),(3194,48,'This ticket has been accepted by you.','admin','2024-04-05 12:04:23','Carlos Cota'),(3195,48,'Ticket accepted by admin at 05-04-2024 12:05:52','admin','2024-04-05 12:05:52',NULL),(3196,48,'This ticket has been accepted by you.','admin','2024-04-05 12:05:52','Carlos Cota'),(3197,50,'Ticket accepted by admin at 05-04-2024 12:13:55','admin','2024-04-05 12:13:55',NULL),(3198,50,'This ticket has been accepted by you.','admin','2024-04-05 12:13:55','Carlos Cota'),(3199,49,'Ticket accepted by admin at 05-04-2024 12:14:01','admin','2024-04-05 12:14:01',NULL),(3200,49,'This ticket has been accepted by you.','admin','2024-04-05 12:14:01','Carlos Cota'),(3201,50,'This ticket has been closed.','admin','2024-04-05 14:28:30','admin'),(3202,50,'Ticket fechado pelo admin at 05-04-2024 14:28:30','admin','2024-04-05 14:28:30',NULL),(3203,46,'This ticket has been accepted by you.','admin','2024-04-05 14:54:26','admin'),(3204,46,'Ticket accepted by admin at 05-04-2024 14:54:26','admin','2024-04-05 14:54:26',NULL);
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
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `date` date DEFAULT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `attributed_to` int DEFAULT NULL,
  `topic_id` int DEFAULT NULL,
  `contacto` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `group_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `closed_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `attributed_to` (`attributed_to`),
  KEY `fk_topic_id` (`topic_id`),
  KEY `fk_tickets_group_id` (`group_id`),
  CONSTRAINT `fk_tickets_group_id` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`id`),
  CONSTRAINT `fk_topic_id` FOREIGN KEY (`topic_id`) REFERENCES `Topics` (`id`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `Users` (`id`),
  CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`attributed_to`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (32,'<p>novo ticket criado</p>','2024-04-03','closed',1,NULL,1,'1234','test_user',1,'New ticket','Pedro Santos'),(33,'<p>Descri&ccedil;&atilde;o para um novo ticket</p>','2024-04-04','closed',1,NULL,2,'175','test_user',1,'Novo titulo','admin'),(34,'<p><strong>Obtive um problema</strong></p>\r\n<p>problema nos certificados</p>','2024-04-04','open',1,NULL,3,'310179','test_user',2,'Problema com certificado',NULL),(35,'<p>test</p>','2024-04-04','closed',1,NULL,2,'3103100','test_user',1,'teste_sig','admin'),(36,'<p>do user joao rat&atilde;o</p>','2024-04-04','closed',1,NULL,1,'999999','test_user',1,'alterar password','Carlos Cota'),(37,'<p>odeokaoe,odo teste</p>','2024-04-04','closed',1,NULL,3,'1234','test_user',2,'teste_email','Luis Martins'),(38,'<p>teste email&nbsp;</p>','2024-04-04','closed',1,NULL,3,'123','test_user',2,'test_123','Luis Martins'),(39,'<p>123124</p>','2024-04-04','closed',1,NULL,1,'123','test_user',1,'teste','Luis Martins'),(40,'<p>teste123</p>','2024-04-04','closed',1,NULL,1,'123w','test_user',1,'aaaaa','admin'),(41,'<p>nova descricao ashdahb</p>','2024-04-04','open',1,NULL,3,'q2345','test_user',2,'new ticet',NULL),(42,'','2024-04-04','open',1,NULL,1,'a','test_user',1,'a',NULL),(43,'<p>aaa</p>','2024-04-05','open',1,NULL,2,'123','test_user',1,'aa',NULL),(44,'<table style=\"border-collapse: collapse; width: 100%;\" border=\"1\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width: 18.1727%;\">a</td>\r\n<td style=\"width: 18.1727%;\">b</td>\r\n<td style=\"width: 18.1727%;\">b</td>\r\n<td style=\"width: 18.1727%;\">vc</td>\r\n<td style=\"width: 18.1727%;\">ddd</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width: 18.1727%;\">&nbsp;</td>\r\n<td style=\"width: 18.1727%;\">&nbsp;</td>\r\n<td style=\"width: 18.1727%;\">&nbsp;</td>\r\n<td style=\"width: 18.1727%;\">&nbsp;</td>\r\n<td style=\"width: 18.1727%;\">&nbsp;</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width: 18.1727%;\">&nbsp;</td>\r\n<td style=\"width: 18.1727%;\">&nbsp;</td>\r\n<td style=\"width: 18.1727%;\">&nbsp;</td>\r\n<td style=\"width: 18.1727%;\">&nbsp;</td>\r\n<td style=\"width: 18.1727%;\">&nbsp;</td>\r\n</tr>\r\n</tbody>\r\n</table>','2024-04-05','open',1,3,3,'asd123','test_user',2,'teste',NULL),(45,'<div data-ccp-timestamp=\"1712310415164\">\r\n<table style=\"width: 197px; height: 69px;\" width=\"281\"><colgroup><col style=\"width: 40px;\" width=\"64\" /><col style=\"width: 48.7578px;\" span=\"2\" width=\"68\" /><col style=\"width: 60px;\" width=\"81\" /></colgroup>\r\n<tbody>\r\n<tr style=\"height: 15pt;\">\r\n<td style=\"padding-top: 1px; padding-right: 1px; padding-left: 1px; font-size: 11pt; font-family: Calibri, sans-serif; vertical-align: bottom; border: none; text-wrap: nowrap; width: 48pt; height: 15pt;\" width=\"64\" height=\"20\">&nbsp;</td>\r\n<td style=\"padding-top: 1px; padding-right: 1px; padding-left: 1px; font-size: 11pt; font-family: Calibri, sans-serif; vertical-align: bottom; border: none; text-wrap: nowrap; width: 51pt;\" width=\"68\">&nbsp;</td>\r\n<td style=\"padding-top: 1px; padding-right: 1px; padding-left: 1px; font-size: 11pt; font-family: Calibri, sans-serif; vertical-align: bottom; border: none; text-wrap: nowrap; width: 51pt;\" width=\"68\">&nbsp;</td>\r\n<td style=\"padding-top: 1px; padding-right: 1px; padding-left: 1px; font-size: 11pt; font-family: Calibri, sans-serif; vertical-align: bottom; border: none; text-wrap: nowrap; width: 61pt;\" width=\"81\">&nbsp;</td>\r\n</tr>\r\n<tr style=\"height: 15pt;\">\r\n<td class=\"xl23\" style=\"padding-top: 1px; padding-right: 1px; padding-left: 1px; font-size: 11pt; text-decoration-line: underline; font-family: Calibri, sans-serif; vertical-align: bottom; border: none; text-wrap: nowrap; height: 15pt;\" height=\"20\">&nbsp;</td>\r\n<td class=\"xl25\" style=\"padding-top: 1px; padding-right: 1px; padding-left: 1px; color: white; font-size: 11pt; font-weight: bold; font-family: Calibri, sans-serif; vertical-align: bottom; border: none; text-wrap: nowrap; text-align: center; background: black;\">Inicial</td>\r\n<td class=\"xl25\" style=\"padding-top: 1px; padding-right: 1px; padding-left: 1px; color: white; font-size: 11pt; font-weight: bold; font-family: Calibri, sans-serif; vertical-align: bottom; border: none; text-wrap: nowrap; text-align: center; background: black;\">Apostado</td>\r\n<td class=\"xl25\" style=\"padding-top: 1px; padding-right: 1px; padding-left: 1px; color: white; font-size: 11pt; font-weight: bold; font-family: Calibri, sans-serif; vertical-align: bottom; border: none; text-wrap: nowrap; text-align: center; background: black;\">Ganho</td>\r\n</tr>\r\n<tr style=\"height: 15pt;\">\r\n<td style=\"padding-top: 1px; padding-right: 1px; padding-left: 1px; font-size: 11pt; font-family: Calibri, sans-serif; vertical-align: bottom; border: none; text-wrap: nowrap; height: 15pt;\" height=\"20\">&nbsp;</td>\r\n<td class=\"xl25\" style=\"padding-top: 1px; padding-right: 1px; padding-left: 1px; font-size: 11pt; font-family: Calibri, sans-serif; vertical-align: bottom; border: none; text-wrap: nowrap; text-align: center; background: #d9d9d9;\">50</td>\r\n<td class=\"xl25\" style=\"padding-top: 1px; padding-right: 1px; padding-left: 1px; font-size: 11pt; font-family: Calibri, sans-serif; vertical-align: bottom; border: none; text-wrap: nowrap; text-align: center;\">46,45</td>\r\n<td class=\"xl25\" style=\"padding-top: 1px; padding-right: 1px; padding-left: 1px; font-size: 11pt; font-family: Calibri, sans-serif; vertical-align: bottom; border: none; text-wrap: nowrap; text-align: center; background: #d9d9d9;\">16,45</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>','2024-04-05','open',1,NULL,2,'123','test_user',1,'4123',NULL),(46,'<p><strong>Nome completo:&nbsp;</strong>Andr&eacute;<br /><strong>User:&nbsp;</strong>teste_1</p>','2024-04-05','em execucao',1,2,5,'1234','test_user',1,'Reset mfa user',NULL),(47,'<p><strong>Nome completo: </strong><br /><strong>User: </strong></p>','2024-04-05','open',1,5,5,'1','test_user',1,'Novo',NULL),(48,'<p><strong>Nome completo: aaa</strong><br /><strong>User:aaaa</strong></p>','2024-04-05','open',1,5,5,'123','test_user',1,'Novo ticket',NULL),(49,'<p><strong>Nome completo: </strong><br /><strong>User: </strong></p>','2024-04-05','em execucao',1,5,5,'a','test_user',1,'testar execucao',NULL),(50,'<p><strong>Nome completo:a</strong><br /><strong>User:a</strong></p>','2024-04-05','closed',1,5,6,'124','test_user',1,'testar execucao','admin'),(51,'<p><strong>Insira aqui a tabela com os valores.</strong></p>','2024-04-05','open',1,NULL,4,'1256','test_user',1,'123412',NULL);
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
  `key_word` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `group_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_topics_group_id` (`group_id`),
  CONSTRAINT `fk_topics_group_id` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Topics`
--

LOCK TABLES `Topics` WRITE;
/*!40000 ALTER TABLE `Topics` DISABLE KEYS */;
INSERT INTO `Topics` VALUES (1,'password',1),(2,'sighrara',1),(3,'certificados',2),(4,'Criar conta EDU',1),(5,'Reset MFA EDU',1),(6,'Reset password EDU',1),(7,'Adicionar MACaddress a controladora',1);
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
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `group_id` int DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `uo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_group_id` (`group_id`),
  CONSTRAINT `fk_group_id` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'test_user','test_password','user','2024-03-27 12:57:43',NULL,'rafael.b.pereira@azores.gov.pt','EBSLP'),(2,'admin','admin_password','admin','2024-03-27 17:06:41',1,NULL,'srec-nit'),(3,'Pedro Santos','password%100','admin','2024-04-02 11:55:34',2,NULL,'srec-nit'),(4,'Luis Martins','password%100','admin','2024-04-02 11:55:46',2,NULL,'srec-nit'),(5,'Carlos Cota','password%100','admin','2024-04-02 11:55:59',1,NULL,'srec-nit');
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

-- Dump completed on 2024-04-05 15:08:47
