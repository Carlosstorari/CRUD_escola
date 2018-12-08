-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: 127.0.0.1    Database: escola
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.21-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aluno`
--

DROP TABLE IF EXISTS `aluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno` (
  `matricula` varchar(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cpf` varchar(15) DEFAULT NULL,
  `rg` varchar(12) DEFAULT NULL,
  `rua` varchar(70) NOT NULL,
  `nasc` date NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `numcasa` varchar(11) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `block` tinyint(1) NOT NULL,
  `estado` int(11) NOT NULL,
  `campus` int(11) NOT NULL,
  `curso` int(11) NOT NULL,
  `senha` varchar(45) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`matricula`),
  KEY `fk_usuario_estado_idx` (`estado`),
  KEY `fk_usuario_campus1_idx` (`campus`),
  KEY `fk_usuario_curso1_idx` (`curso`),
  CONSTRAINT `fk_usuario_campus1` FOREIGN KEY (`campus`) REFERENCES `campus` (`idcampus`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_curso1` FOREIGN KEY (`curso`) REFERENCES `curso` (`idcurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_estado` FOREIGN KEY (`estado`) REFERENCES `estado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aluno`
--

LOCK TABLES `aluno` WRITE;
/*!40000 ALTER TABLE `aluno` DISABLE KEYS */;
INSERT INTO `aluno` VALUES ('cc02','Ortega','23423423432','234234324','Alfineiros','1904-06-22','Sumaré','34','234324234',0,10,4,2,'1234','ortega@gmail.com'),('FF44','Franklin','34242332343','5345435345','dfgdsg','1981-08-07','Hortolandia','23','23423',0,1,1,2,'1234','franklingmail.com'),('PP00','Anne','4354352435','4353453','rua 4','1917-08-08','ewrewr','43','3645543',0,1,1,1,'1234','anne.@gmail.com'),('PP22','Gabriel Vinicius','123.654.764-09','54.654.213-4','Rua Aparecida','1998-10-01','Sumaré','954','(19) 92313-6543',0,4,1,1,'1234','gabriel.vga99@gmail.com'),('PP33','Carlos Storari','354.376.264-3','45.264.454-4','Rua Desaparecida','1995-08-26','Sumaré','234','(19)98146-1111',0,4,1,1,'1234','carlos.storari95@gmail.com');
/*!40000 ALTER TABLE `aluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boletim`
--

DROP TABLE IF EXISTS `boletim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boletim` (
  `idboletim` int(11) NOT NULL AUTO_INCREMENT,
  `media` float NOT NULL,
  `faltas` int(11) NOT NULL,
  `aluno` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`idboletim`),
  KEY `fk_boletim_aluno1` (`aluno`),
  CONSTRAINT `fk_boletim_aluno1` FOREIGN KEY (`aluno`) REFERENCES `aluno` (`matricula`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletim`
--

LOCK TABLES `boletim` WRITE;
/*!40000 ALTER TABLE `boletim` DISABLE KEYS */;
INSERT INTO `boletim` VALUES (1,9.5,8,'PP22'),(2,10,4,'PP33'),(9,8.9,6,'PP22'),(10,10,10,'PP22'),(34,8.9,34,'cc02'),(54,5.5,30,'FF44');
/*!40000 ALTER TABLE `boletim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boletim_has_materia`
--

DROP TABLE IF EXISTS `boletim_has_materia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boletim_has_materia` (
  `boletim_idboletim` int(11) NOT NULL,
  `materia_idmateria` int(11) NOT NULL,
  PRIMARY KEY (`boletim_idboletim`,`materia_idmateria`),
  KEY `fk_boletim_has_materia_materia1_idx` (`materia_idmateria`),
  KEY `fk_boletim_has_materia_boletim1_idx` (`boletim_idboletim`),
  CONSTRAINT `fk_boletim_has_materia_boletim1` FOREIGN KEY (`boletim_idboletim`) REFERENCES `boletim` (`idboletim`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_boletim_has_materia_materia1` FOREIGN KEY (`materia_idmateria`) REFERENCES `materia` (`idmateria`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletim_has_materia`
--

LOCK TABLES `boletim_has_materia` WRITE;
/*!40000 ALTER TABLE `boletim_has_materia` DISABLE KEYS */;
INSERT INTO `boletim_has_materia` VALUES (1,1),(2,2),(10,2),(34,3),(54,3);
/*!40000 ALTER TABLE `boletim_has_materia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `boletimf`
--

DROP TABLE IF EXISTS `boletimf`;
/*!50001 DROP VIEW IF EXISTS `boletimf`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `boletimf` AS SELECT 
 1 AS `Aluno`,
 1 AS `Matéria`,
 1 AS `Presença(%)`,
 1 AS `Média`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `boletimfinal`
--

DROP TABLE IF EXISTS `boletimfinal`;
/*!50001 DROP VIEW IF EXISTS `boletimfinal`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `boletimfinal` AS SELECT 
 1 AS `Aluno`,
 1 AS `Matéria`,
 1 AS `Presença(%)`,
 1 AS `Média`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `boletiminal`
--

DROP TABLE IF EXISTS `boletiminal`;
/*!50001 DROP VIEW IF EXISTS `boletiminal`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `boletiminal` AS SELECT 
 1 AS `Aluno`,
 1 AS `Matéria`,
 1 AS `Presença(%)`,
 1 AS `Média`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `campus`
--

DROP TABLE IF EXISTS `campus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campus` (
  `idcampus` int(11) NOT NULL AUTO_INCREMENT,
  `cidade` varchar(45) NOT NULL,
  `nomeCampus` varchar(45) NOT NULL,
  `estado_id` int(11) NOT NULL,
  PRIMARY KEY (`idcampus`),
  KEY `fk_campus_estado1_idx` (`estado_id`),
  CONSTRAINT `fk_campus_estado1` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campus`
--

LOCK TABLES `campus` WRITE;
/*!40000 ALTER TABLE `campus` DISABLE KEYS */;
INSERT INTO `campus` VALUES (1,'Campinas','Campinas',4),(2,'São Paulo','São Paulo - Zona Leste',4),(3,'São Paulo','São Paulo - Zona Sul',4),(4,'Salvador','Salvador',10),(5,'Manaus','Manaus',11),(6,'Nova Iguaçu','Nova Iguaçu',5),(7,'Rio de Janeiro','Rio de Janeiro',5);
/*!40000 ALTER TABLE `campus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curso` (
  `idcurso` int(11) NOT NULL AUTO_INCREMENT,
  `nomecurso` varchar(45) NOT NULL,
  `anoinicio` int(11) NOT NULL,
  `mesinicio` varchar(10) NOT NULL,
  `coordenador` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`idcurso`),
  KEY `fk_curso_professor1` (`coordenador`),
  CONSTRAINT `fk_curso_professor1` FOREIGN KEY (`coordenador`) REFERENCES `professor` (`matricula`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` VALUES (1,'Análise e Desenvolvimento de Sistemas Jan2018',2018,'Janeiro','1'),(2,'Pedagogia',2016,'Julho','zz11');
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `UF` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` VALUES (1,'RS'),(2,'SC'),(3,'PR'),(4,'SP'),(5,'RJ'),(6,'MG'),(7,'ES'),(8,'MT'),(9,'MS'),(10,'BA'),(11,'AM'),(12,'GO'),(13,'DF'),(14,'TO'),(15,'PA'),(16,'RN'),(17,'PE'),(18,'RO'),(19,'AC'),(20,'RR'),(21,'AP'),(22,'MA'),(23,'PI'),(24,'CE'),(25,'PB'),(26,'AL'),(27,'SE');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `jtablealteraboletim`
--

DROP TABLE IF EXISTS `jtablealteraboletim`;
/*!50001 DROP VIEW IF EXISTS `jtablealteraboletim`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `jtablealteraboletim` AS SELECT 
 1 AS `idBoltim`,
 1 AS `media`,
 1 AS `fatas`,
 1 AS `aluno`,
 1 AS `materia`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `jtalunos`
--

DROP TABLE IF EXISTS `jtalunos`;
/*!50001 DROP VIEW IF EXISTS `jtalunos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `jtalunos` AS SELECT 
 1 AS `ID`,
 1 AS `nome`,
 1 AS `curso`,
 1 AS `email`,
 1 AS `cpf`,
 1 AS `rg`,
 1 AS `UF`,
 1 AS `campus`,
 1 AS `cidade`,
 1 AS `rua`,
 1 AS `numCasa`,
 1 AS `telefone`,
 1 AS `nasc`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `jtboletim`
--

DROP TABLE IF EXISTS `jtboletim`;
/*!50001 DROP VIEW IF EXISTS `jtboletim`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `jtboletim` AS SELECT 
 1 AS `aluno`,
 1 AS `falta`,
 1 AS `media`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `jtprofessor`
--

DROP TABLE IF EXISTS `jtprofessor`;
/*!50001 DROP VIEW IF EXISTS `jtprofessor`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `jtprofessor` AS SELECT 
 1 AS `matricula`,
 1 AS `professor`,
 1 AS `email`,
 1 AS `cpf`,
 1 AS `RG`,
 1 AS `nomeCampus`,
 1 AS `uf`,
 1 AS `cidade`,
 1 AS `rua`,
 1 AS `numcasa`,
 1 AS `telefone`,
 1 AS `nasc`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `materia`
--

DROP TABLE IF EXISTS `materia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materia` (
  `idmateria` int(11) NOT NULL AUTO_INCREMENT,
  `nomemateria` varchar(45) NOT NULL,
  `curso` int(11) NOT NULL,
  `professor` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`idmateria`),
  KEY `fk_materia_curso1_idx` (`curso`),
  KEY `fk_materia_professor1` (`professor`),
  CONSTRAINT `fk_materia_curso1` FOREIGN KEY (`curso`) REFERENCES `curso` (`idcurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia_professor1` FOREIGN KEY (`professor`) REFERENCES `professor` (`matricula`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materia`
--

LOCK TABLES `materia` WRITE;
/*!40000 ALTER TABLE `materia` DISABLE KEYS */;
INSERT INTO `materia` VALUES (1,'Banco de Dados I 2S-2018',1,NULL),(2,'Sistemas Operacionais 1S-2018',1,NULL),(3,'Comunicação - Técnica 1S-2018',1,NULL),(4,'Literatura I 1S-2017',2,NULL);
/*!40000 ALTER TABLE `materia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `professor` (
  `matricula` varchar(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cpf` varchar(15) DEFAULT NULL,
  `rg` varchar(12) DEFAULT NULL,
  `rua` varchar(70) NOT NULL,
  `nasc` date NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `numcasa` varchar(11) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `block` tinyint(1) NOT NULL,
  `adm` tinyint(1) NOT NULL,
  `estado` int(11) NOT NULL,
  `campus` int(11) NOT NULL,
  `senha` varchar(45) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`matricula`),
  KEY `fk_usuario_estado_idx` (`estado`),
  KEY `fk_usuario_campus1_idx` (`campus`),
  CONSTRAINT `fk_usuario_campus10` FOREIGN KEY (`campus`) REFERENCES `campus` (`idcampus`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_estado0` FOREIGN KEY (`estado`) REFERENCES `estado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
INSERT INTO `professor` VALUES ('0','Gabriel Vinicius Gomes Anazario','214.748.364-07','12.345.678-9','Rua Presidente Prudente de Moraes','1998-10-01','Sumaré','112','(19) 98410-7595',0,0,4,1,'12345678','gabriel.vga@bol.com.br'),('1','José Matias','341.564.211-98','54.321.563-0','Rua Dirceu','1965-03-12','Sorocaba','98','(13) 96521-0091',0,1,4,1,'abcde','jose.matias@gmail.com'),('pp55','Jofferey','3453535','353534545','regretgr','2018-11-01','dsgsrgeg','32','234543',0,1,25,6,'1234','dfgfdgfdgfd'),('zz11','Rogerinho','235544','24234','sadfsdf','2018-11-30','Rio de Janeiro','43','342234',0,0,4,1,'abcde','sadgfsad');
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'escola'
--

--
-- Dumping routines for database 'escola'
--

--
-- Final view structure for view `boletimf`
--

/*!50001 DROP VIEW IF EXISTS `boletimf`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `boletimf` AS select `aluno`.`nome` AS `Aluno`,`materia`.`nomemateria` AS `Matéria`,((80 - `boletim`.`faltas`) * 1.25) AS `Presença(%)`,`boletim`.`media` AS `Média` from (((`boletim` join `aluno` on((`boletim`.`aluno` = `aluno`.`matricula`))) join `boletim_has_materia` on((`boletim_has_materia`.`boletim_idboletim` = `boletim`.`idboletim`))) join `materia` on((`materia`.`idmateria` = `boletim_has_materia`.`materia_idmateria`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `boletimfinal`
--

/*!50001 DROP VIEW IF EXISTS `boletimfinal`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `boletimfinal` AS select `aluno`.`nome` AS `Aluno`,`materia`.`nomemateria` AS `Matéria`,((80 - `boletim`.`faltas`) * 1.25) AS `Presença(%)`,`boletim`.`media` AS `Média` from (((`boletim` join `aluno` on((`boletim`.`aluno` = `aluno`.`matricula`))) join `boletim_has_materia` on((`boletim_has_materia`.`boletim_idboletim` = `boletim`.`idboletim`))) join `materia` on((`materia`.`idmateria` = `boletim_has_materia`.`materia_idmateria`))) where (`boletim`.`aluno` = '0') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `boletiminal`
--

/*!50001 DROP VIEW IF EXISTS `boletiminal`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `boletiminal` AS select `aluno`.`nome` AS `Aluno`,`materia`.`nomemateria` AS `Matéria`,((80 - `boletim`.`faltas`) * 1.25) AS `Presença(%)`,`boletim`.`media` AS `Média` from (((`boletim` join `aluno` on((`boletim`.`aluno` = `aluno`.`matricula`))) join `boletim_has_materia` on((`boletim_has_materia`.`boletim_idboletim` = `boletim`.`idboletim`))) join `materia` on((`materia`.`idmateria` = `boletim_has_materia`.`materia_idmateria`))) where (`boletim`.`aluno` = 'pp22') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `jtablealteraboletim`
--

/*!50001 DROP VIEW IF EXISTS `jtablealteraboletim`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `jtablealteraboletim` AS select `b`.`idboletim` AS `idBoltim`,`b`.`media` AS `media`,`b`.`faltas` AS `fatas`,`a`.`nome` AS `aluno`,`m`.`nomemateria` AS `materia` from (((`boletim_has_materia` `bm` join `boletim` `b` on((`b`.`idboletim` = `bm`.`boletim_idboletim`))) join `materia` `m` on((`bm`.`materia_idmateria` = `m`.`idmateria`))) join `aluno` `a` on((`a`.`matricula` = `b`.`aluno`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `jtalunos`
--

/*!50001 DROP VIEW IF EXISTS `jtalunos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `jtalunos` AS select `a`.`matricula` AS `ID`,`a`.`nome` AS `nome`,`curs`.`nomecurso` AS `curso`,`a`.`email` AS `email`,`a`.`cpf` AS `cpf`,`a`.`rg` AS `rg`,`e`.`UF` AS `UF`,`camp`.`nomeCampus` AS `campus`,`a`.`cidade` AS `cidade`,`a`.`rua` AS `rua`,`a`.`numcasa` AS `numCasa`,`a`.`telefone` AS `telefone`,`a`.`nasc` AS `nasc` from (((`aluno` `a` join `campus` `camp` on((`camp`.`idcampus` = `a`.`campus`))) join `estado` `e` on((`e`.`id` = `a`.`estado`))) join `curso` `curs` on((`a`.`curso` = `curs`.`idcurso`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `jtboletim`
--

/*!50001 DROP VIEW IF EXISTS `jtboletim`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `jtboletim` AS select `a`.`nome` AS `aluno`,`b`.`faltas` AS `falta`,`b`.`media` AS `media` from (`boletim` `b` join `aluno` `a` on((`b`.`aluno` = `a`.`matricula`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `jtprofessor`
--

/*!50001 DROP VIEW IF EXISTS `jtprofessor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `jtprofessor` AS select `p`.`matricula` AS `matricula`,`p`.`nome` AS `professor`,`p`.`email` AS `email`,`p`.`cpf` AS `cpf`,`p`.`rg` AS `RG`,`camp`.`nomeCampus` AS `nomeCampus`,`e`.`UF` AS `uf`,`p`.`cidade` AS `cidade`,`p`.`rua` AS `rua`,`p`.`numcasa` AS `numcasa`,`p`.`telefone` AS `telefone`,`p`.`nasc` AS `nasc` from ((`professor` `p` join `campus` `camp` on((`p`.`campus` = `camp`.`idcampus`))) join `estado` `e` on((`camp`.`estado_id` = `e`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-03  8:30:57
