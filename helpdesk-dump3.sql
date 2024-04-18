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
) ENGINE=InnoDB AUTO_INCREMENT=3314 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (3305,114,'Este ticket foi aceite com sucesso.','admin','2024-04-16 12:23:16','Carlos Cota'),(3306,114,'Este ticket foi fechado com sucesso.','admin','2024-04-16 12:23:26','Carlos Cota'),(3307,114,'<p>teste mensagem com editor</p>','user','2024-04-16 16:47:38','test_user'),(3308,114,'teste','user','2024-04-16 16:48:32','test_user'),(3309,114,'<strong>teste mensagem em italico&nbsp;</strong>','user','2024-04-16 16:49:20','test_user'),(3310,123,'ok bom','user','2024-04-16 23:13:31','test_user'),(3311,122,'ok','user','2024-04-16 23:13:43','test_user'),(3312,123,'Este ticket foi aceite com sucesso.','admin','2024-04-16 23:13:58','Carlos Cota'),(3313,128,'Ola obrigado pelo apoio','user','2024-04-17 11:38:56','test_edu');
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
  `file` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `attributed_to` (`attributed_to`),
  KEY `fk_topic_id` (`topic_id`),
  KEY `fk_tickets_group_id` (`group_id`),
  CONSTRAINT `fk_attributed_to` FOREIGN KEY (`attributed_to`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_tickets_group_id` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`id`),
  CONSTRAINT `fk_topic_id` FOREIGN KEY (`topic_id`) REFERENCES `Topics` (`id`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (114,'<p>Ticket inicial</p>','2024-04-16','closed',1,5,2,'1823','test_user',1,'Novo ticket','Carlos Cota','EBSV - Escola Básica Secundária Velas','Carlos Cota',NULL),(115,'<table style=\"width: 24.4125%; height: 67.1953px;\" border=\"1\">\r\n<tbody>\r\n<tr style=\"height: 44.7969px;\">\r\n<th style=\"width: 65.3326%; height: 44.7969px;\">Nome completo</th>\r\n<th style=\"width: 19.548%; height: 44.7969px;\">User</th>\r\n</tr>\r\n<tr style=\"height: 22.3984px;\">\r\n<td style=\"width: 65.3326%; height: 22.3984px;\">name</td>\r\n<td style=\"width: 19.548%; height: 22.3984px;\">user</td>\r\n</tr>\r\n</tbody>\r\n</table>','2024-04-16','open',1,NULL,12,'1823','test_user',1,'teste file',NULL,'EBIRP - Escola Básica Integrada Rabo Peixe',NULL,NULL),(116,'<p>teste file</p>','2024-04-16','open',1,NULL,2,'123','test_user',1,'teste file',NULL,'EBIPV - Escola Básica Integrada Praia Vitória',NULL,'PEM.png'),(117,'<p>teste ficheiro</p>','2024-04-16','open',1,NULL,2,'1234','test_user',1,'teste file',NULL,'DAIP',NULL,'2015.pdf'),(118,'<p>fieaidm</p>','2024-04-16','open',1,NULL,2,'1234','test_user',1,'ticket sem file',NULL,'EBIPV - Escola Básica Integrada Praia Vitória',NULL,NULL),(119,'<p>tikcet com file</p>','2024-04-16','open',1,NULL,2,'1244','test_user',1,'ticket com file',NULL,'EBSC - Escola Básica Secundária Calheta',NULL,'2015_1.pdf'),(120,'<p>12343124</p>','2024-04-16','open',1,NULL,2,'123','test_user',1,'ticket ',NULL,'EBSC - Escola Básica Secundária Calheta',NULL,NULL),(121,'<p>123123132</p>','2024-04-16','open',1,NULL,2,'12312','test_user',1,'teste1234',NULL,'EBSC - Escola Básica Secundária Calheta',NULL,'Sem ficheiro.'),(122,'<p>teste com file</p>','2024-04-16','open',1,NULL,2,'1234','test_user',1,'Ticket com file',NULL,'EBSC - Escola Básica Secundária Calheta',NULL,'Criacao_de_Contas-template.xlsx'),(123,'<p>teste 1234</p>','2024-04-16','em execucao',1,5,2,'123','test_user',1,'ticket sem file',NULL,'EBIPV - Escola Básica Integrada Praia Vitória','Carlos Cota','Sem ficheiro.'),(124,'<p>teste file</p>','2024-04-17','open',1,NULL,2,'1234','test_user',1,'file com ticket',NULL,'DSTF',NULL,'2015_1.pdf'),(125,'<p>teste file</p>','2024-04-17','open',1,NULL,2,'1234','test_user',1,'file com ticket',NULL,'DSTF',NULL,'2015_1.pdf'),(126,'<p>teste</p>','2024-04-17','open',1,NULL,16,'124','test_user',1,'teste file',NULL,'DAIP-Aprovisionamento',NULL,'2015_1.pdf'),(127,'<p>configurar algo&nbsp;</p>','2024-04-17','open',12,NULL,45,'10923','test_edu',2,'configurar qualquer coisa ',NULL,'EBI dos Biscoitos',NULL,'Sem ficheiro.'),(128,'<p>apooio no website<strong> http://ebs-asdkjndas.com</strong></p>','2024-04-17','open',12,NULL,26,'teste','test_edu',1,'apoio no website tal',NULL,'EBIRG - Escola Básica Integrada Ribeira Grande',NULL,'Captura_de_ecra_2024-04-16_as_22.48.29.png'),(129,'<p>teste gra topico</p>','2024-04-17','open',1,NULL,2,'1234','test_user',1,'topico gra',NULL,'DAIP-Expediente',NULL,'Sem ficheiro.'),(130,'<p>teste</p>','2024-04-17','open',1,NULL,16,'1234','test_user',1,'apoio utilizador',NULL,'DAIP',NULL,'Captura_de_ecra_2024-04-16_as_22.48.29.png'),(131,'<p>teste com ficheiro</p>','2024-04-17','open',1,NULL,2,'1234','test_user',1,'teste com ficheiro',NULL,'DAIP',NULL,'Captura_de_ecra_2024-04-16_as_22.48.29.png'),(132,'<p>teste 1234 teste</p>','2024-04-17','open',12,NULL,2,'15678','test_edu',1,'teste ficheiro',NULL,'ES Manuel Arriaga',NULL,'Captura_de_ecra_2024-04-16_as_22.48.29.png'),(133,'<p>teste ticket</p>','2024-04-17','open',1,NULL,2,'1234','test_user',1,'novo ticket',NULL,'DSTF',NULL,'Sem ficheiro.'),(134,'<p>file test</p>','2024-04-17','open',1,NULL,10,'1823','test_user',1,'teste com file',NULL,'DREAE-CF',NULL,'Captura_de_ecra_2024-04-16_as_22.48.29.png'),(135,'<p>teste ticket</p>','2024-04-17','open',1,NULL,2,'1234','test_user',1,'teste',NULL,'DAIP',NULL,'Sem ficheiro.'),(136,'<p>teste ticket</p>','2024-04-17','open',1,NULL,2,'1234','test_user',1,'teste',NULL,'DAIP',NULL,'Sem ficheiro.'),(137,'<p>teq3424</p>','2024-04-17','open',1,NULL,14,'1234','test_user',1,'teteett',NULL,'DAIP',NULL,'Sem ficheiro.'),(138,'<p>teste ticket geral</p>','2024-04-17','open',1,NULL,2,'81723','test_user',1,'teste geral ticket',NULL,'DAIP',NULL,'Captura_de_ecra_2024-04-16_as_22.48.29.png'),(139,'<table style=\"width: 46.2141%; height: 67.1953px;\" border=\"1\">\r\n<tbody>\r\n<tr style=\"height: 44.7969px;\">\r\n<th style=\"width: 34.5119%; height: 44.7969px;\">Nome completo</th>\r\n<th style=\"width: 10.1916%; height: 44.7969px;\">NIF</th>\r\n<th style=\"width: 43.3859%; height: 44.7969px;\">Data de nascimento</th>\r\n</tr>\r\n<tr style=\"height: 22.3984px;\">\r\n<td style=\"width: 34.5119%; height: 22.3984px;\">andre</td>\r\n<td style=\"width: 10.1916%; height: 22.3984px;\">8123</td>\r\n<td style=\"width: 43.3859%; height: 22.3984px;\">nascimento</td>\r\n</tr>\r\n</tbody>\r\n</table>','2024-04-17','open',12,NULL,4,'1923','test_edu',1,'criacao de uma conta',NULL,'ES Manuel Arriaga',NULL,'Sem ficheiro.'),(140,'<p>teste&nbsp;</p>','2024-04-17','open',1,NULL,16,'1234','test_user',1,'teste',NULL,'DAIP',NULL,'Sem ficheiro.'),(141,'<p>teste</p>','2024-04-17','open',1,NULL,2,'123','test_user',1,'teste ticket',NULL,'DAIP',NULL,'Sem ficheiro.'),(142,'<p>teste</p>','2024-04-17','open',1,NULL,2,'123','test_user',1,'teste ticket',NULL,'DAIP',NULL,'Sem ficheiro.'),(143,'<p>teste teste&nbsp;</p>','2024-04-17','open',1,NULL,2,'1023','test_user',1,'teste ticket',NULL,'DAIP-Aprovisionamento',NULL,'Sem ficheiro.'),(144,'<p>teste</p>','2024-04-17','open',12,NULL,2,'1234','test_edu',1,'teste',NULL,'EBI Francisco Ferreira Drummond',NULL,'Sem ficheiro.'),(145,'<p>teste</p>','2024-04-17','open',12,NULL,2,'1234','test_edu',1,'teste',NULL,'EBI Francisco Ferreira Drummond',NULL,'Sem ficheiro.'),(146,'<table border=\"1\">\r\n<tbody>\r\n<tr>\r\n<th>Nome completo</th>\r\n<th>User</th>\r\n</tr>\r\n<tr>\r\n<td>name</td>\r\n<td>user</td>\r\n</tr>\r\n</tbody>\r\n</table>','2024-04-17','open',12,NULL,5,'1092','test_edu',1,'teste',NULL,'ES Manuel Arriaga',NULL,'Sem ficheiro.'),(147,'<p>teste</p>','2024-04-17','open',12,NULL,2,'1234','test_edu',1,'teste',NULL,'EBIM - Escola Básica Integrada Maia',NULL,'Sem ficheiro.'),(148,'<p>teste ftickcet</p>','2024-04-17','open',1,NULL,2,'1256','test_user',1,'teste',NULL,'DSTF',NULL,'Sem ficheiro.'),(149,'<p>12341 teste&nbsp;</p>','2024-04-17','open',1,NULL,2,'124','test_user',1,'teste 123',NULL,'DSTF',NULL,'Sem ficheiro.'),(150,'<p>teste 1234</p>','2024-04-17','open',12,NULL,2,'1145','test_edu',1,'teste teste ',NULL,'EBIVT - Escola Básica Integrada Vila Topo',NULL,'Sem ficheiro.'),(151,'<p>teste 12356</p>','2024-04-17','open',12,NULL,2,'1920','test_edu',1,'teste problema',NULL,'EBI Francisco Ferreira Drummond',NULL,'Sem ficheiro.'),(152,'<p>teste not edu&nbsp;</p>','2024-04-17','open',1,NULL,2,'1928','test_user',1,'teste not edu',NULL,'DSTF',NULL,'Sem ficheiro.'),(153,'<p>teste teste&nbsp;</p>','2024-04-17','open',12,NULL,2,'1202','test_edu',1,'teste',NULL,'EBICM - Escola Básica Integrada Canto Maia',NULL,'Sem ficheiro.'),(154,'<p>testw 123</p>','2024-04-17','open',12,NULL,2,'102','test_edu',1,'test teste',NULL,'ES Manuel Arriaga',NULL,'Sem ficheiro.'),(155,'<table border=\"1\">\r\n<tbody>\r\n<tr>\r\n<th>Nome completo</th>\r\n<th>User</th>\r\n</tr>\r\n<tr>\r\n<td>user</td>\r\n<td>teste</td>\r\n</tr>\r\n</tbody>\r\n</table>','2024-04-17','open',1,NULL,12,'10293','test_user',1,'teste teste',NULL,'DAIP',NULL,'Sem ficheiro.'),(156,'<p>teste edu</p>','2024-04-17','open',12,NULL,2,'10293','test_edu',1,'teste',NULL,'EBIM - Escola Básica Integrada Maia',NULL,'Sem ficheiro.'),(157,'<p>teste edu</p>','2024-04-17','open',12,NULL,2,'1023','test_edu',1,'teste edu',NULL,'EBI da Praia da Vitória',NULL,'Sem ficheiro.'),(158,'<p>teste ticket edu</p>','2024-04-17','open',12,NULL,2,'1023','test_edu',1,'teste edu ',NULL,'EBI de Angra do Heroísmo',NULL,'Sem ficheiro.'),(159,'<table border=\"1\">\r\n<tbody>\r\n<tr>\r\n<th>Nome completo</th>\r\n<th>User</th>\r\n</tr>\r\n<tr>\r\n<td>user</td>\r\n<td>name1092</td>\r\n</tr>\r\n</tbody>\r\n</table>','2024-04-17','open',1,NULL,12,'1029','test_user',1,'teste ticket not edu',NULL,'DAIP-Técnicos',NULL,'Sem ficheiro.'),(160,'<p>descricao ticket</p>','2024-04-17','open',1,NULL,2,'10923','test_user',1,'novo ticket smtp',NULL,'DAIP',NULL,'Sem ficheiro.'),(161,'<table border=\"1\">\r\n<tbody>\r\n<tr>\r\n<th>Nome completo</th>\r\n<th>NIF</th>\r\n<th>Data de nascimento</th>\r\n<th>SGC</th>\r\n<th>Rel&oacute;gio ponto</th>\r\n</tr>\r\n<tr>\r\n<td>andre</td>\r\n<td>019</td>\r\n<td>10/12/00</td>\r\n<td>nao</td>\r\n<td>nao</td>\r\n<td>&nbsp;</td>\r\n</tr>\r\n</tbody>\r\n</table>','2024-04-17','open',1,NULL,11,'1023','test_user',1,'criacao utilizador',NULL,'DAIP',NULL,'Sem ficheiro.'),(162,'<p>teste novo ticket&nbsp;</p>','2024-04-17','open',1,NULL,16,'10293','test_user',1,'test novo ticket',NULL,'DAIP-Técnicos',NULL,'Sem ficheiro.'),(163,'<p>utilizador x precisa de apoio.</p>','2024-04-17','open',1,NULL,16,'1884','test_user',1,'Utilizador precisa de apoio',NULL,'DAIP-Expediente',NULL,'Sem ficheiro.'),(164,'<table border=\"1\">\r\n<tbody>\r\n<tr>\r\n<th>Nome completo</th>\r\n<th>User</th>\r\n</tr>\r\n<tr>\r\n<td>andre rodrigues</td>\r\n<td>username</td>\r\n</tr>\r\n</tbody>\r\n</table>','2024-04-17','open',1,NULL,12,'10924','test_user',1,'Ativar mfa ',NULL,'DSTF',NULL,'Sem ficheiro.'),(165,'<p>reset manuais digitais</p>','2024-04-18','open',12,NULL,48,'10923','test_edu',1,'reset manuais digitais',NULL,'EBI dos Biscoitos',NULL,'Sem ficheiro.');
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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Topics`
--

LOCK TABLES `Topics` WRITE;
/*!40000 ALTER TABLE `Topics` DISABLE KEYS */;
INSERT INTO `Topics` VALUES (1,'password',1),(2,'Geral',1),(3,'certificados',2),(4,'Criar conta EDU',1),(5,'Reset MFA EDU',1),(6,'Reset password EDU',1),(7,'Adicionar MACaddress a controladora',1),(9,'Reconfiguração portas switch',2),(10,'Dados aluno',1),(11,'Criar novo utilizador',1),(12,'Autenticação MFA',1),(13,'Criar grupo de distribuição',1),(14,'Licença 0365',1),(15,'Partilhas na rede',1),(16,'Apoio ao Utilizador',1),(25,'Atribuicao de computadores',1),(26,'Apoio a websites EDU',1),(27,'Pedido de Equipamento',1),(28,'Pedido de SUP individual',1),(29,'Pedido de Swicth - avaria',2),(30,'Pedido de Switch - configuração',2),(31,'Pedido de VPN ',2),(32,'Preparaçao de local para evento ',1),(33,'Alteração de Redes ',2),(34,'Pedido de parecer',1),(35,'Incidente de segurança',2),(45,'Configuração/problema de rede EDU',2),(46,'Pedido de parecer EDU',1),(47,'Configuração APs EDU',2),(48,'Manuais digitais',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'test_user','password%100','user','2024-03-27 12:57:43',NULL,'rafael.b.pereira@azores.gov.pt','EBSLP'),(2,'admin','admin_password','admin','2024-03-27 17:06:41',1,'rafaelpereira0808@gmail.com','srec-nit'),(3,'Pedro Santos','password%100','admin','2024-04-02 11:55:34',2,'Pedro.MM.Santos2@azores.gov.pt','srec-nit'),(4,'Luis Martins','password%100','admin','2024-04-02 11:55:46',2,'Luis.FL.Martins@azores.gov.pt','srec-nit'),(5,'Carlos Cota','password%100','admin','2024-04-02 11:55:59',1,'Carlos.AE.Cota@azores.gov.pt','srec-nit'),(6,'PS1009','password%100','user','2024-04-09 15:05:39',NULL,'pedrosantos@azores.gov.pt',NULL),(7,'newpass','newpass','user','2024-04-09 15:14:41',NULL,'rasr@azores.gov.pt',NULL),(8,'Antonio Santos','password%100','admin','2024-04-09 15:43:49',1,'Antonio.JC.Santos@azores.gov.pt',NULL),(9,'Teresa Cota','password%!00','admin','2024-04-09 15:53:27',1,'Teresa.JL.Cota@azores.gov.pt',NULL),(10,'Elisabete Martins','password%100','admin','2024-04-09 15:55:49',1,'Elisabete.MS.Martins@azores.gov.pt',NULL),(11,'Maria da Conceição Duarte','password%100','admin','2024-04-09 16:01:24',1,'Maria.CF.Duarte@azores.gov.pt',NULL),(12,'test_edu','password%100','user','2024-04-10 11:38:58',1,'test_edu@edu.azores.gov.pt',NULL),(14,'test_gra','password%100','user','2024-04-15 10:04:44',1,'testgra@azores.gov.pt',NULL),(15,'Rodrigo Silva','password%100','admin','2024-04-18 11:23:46',1,'Rodrigo.CP.Silva@azores.gov.pt',NULL);
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

-- Dump completed on 2024-04-18 11:24:16
