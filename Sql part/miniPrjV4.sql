-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: localhost    Database: miniPrj
-- ------------------------------------------------------
-- Server version	8.0.22-0ubuntu0.20.04.2

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
-- Table structure for table `Comment_Table`
--

DROP TABLE IF EXISTS `Comment_Table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Comment_Table` (
  `comment` varchar(500) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `comment_by` varchar(30) DEFAULT NULL,
  `teamCode` varchar(20) DEFAULT NULL,
  KEY `teamCode` (`teamCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comment_Table`
--

LOCK TABLES `Comment_Table` WRITE;
/*!40000 ALTER TABLE `Comment_Table` DISABLE KEYS */;
INSERT INTO `Comment_Table` VALUES ('good','2020-11-25 19:30:59','tony stark','thaeco2973'),('perfect','2020-11-25 19:33:16','tony stark','thaeco2973'),('perfect...............................','2020-11-25 19:36:08','tony stark','thaeco2973'),('last test........................','2020-11-25 19:40:54','tony stark','thaeco2973'),('done....','2020-11-25 19:41:48','tony stark','thaeco2973'),('reviewer test','2020-11-25 19:52:04','tony stark','thaeco2973'),('well done....','2020-11-25 21:57:26','tony stark','thaeco2973'),('sdflksdjflkjsdlkf','2020-11-25 22:12:04','tony stark','thaeco2973'),('dsfkjdhfkjdhgdfgdfgdfgd cdfgdgfg','2020-11-25 22:52:34','prabhas megastar','thaeco2973'),('great..............','2020-11-26 19:08:21','prabhas megastar','thaeco2973'),('dfkjdfkgjdhfkjgdfg','2020-11-26 19:23:43','prabhas megastar','vaisys388'),('fkjdfhkdfgj','2020-11-26 19:26:09','tony stark','vaisys388'),('very goood , good work....','2020-11-26 21:36:52','tony stark','Irocod9593'),('very good','2020-11-26 22:03:05','tony stark','hullib2340'),('goood go','2020-11-26 22:11:23','tony stark','tesmov1855');
/*!40000 ALTER TABLE `Comment_Table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignPrj`
--

DROP TABLE IF EXISTS `assignPrj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignPrj` (
  `instructorId` varchar(20) DEFAULT NULL,
  `subjectCode` varchar(60) DEFAULT NULL,
  `prjAssignDate` date DEFAULT NULL,
  `problemStatementDate` date DEFAULT NULL,
  `codeSubmissionDate` date DEFAULT NULL,
  KEY `instructorId` (`instructorId`),
  CONSTRAINT `assignPrj_ibfk_1` FOREIGN KEY (`instructorId`) REFERENCES `instructor` (`instructorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignPrj`
--

LOCK TABLES `assignPrj` WRITE;
/*!40000 ALTER TABLE `assignPrj` DISABLE KEYS */;
INSERT INTO `assignPrj` VALUES ('ironman@3','170003','2020-11-23','2020-11-28','2020-12-31'),('ironman@3','140002','2020-11-24','2020-11-26','2020-11-30'),('prabhas@7','170002','2020-11-19','2020-11-28','2020-12-30'),('ironman@3','410001','2020-11-20','2020-11-27','2020-12-30');
/*!40000 ALTER TABLE `assignPrj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deletedTeams`
--

DROP TABLE IF EXISTS `deletedTeams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deletedTeams` (
  `enroll` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `teamName` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `noOfMembers` int DEFAULT NULL,
  `projectName` varchar(300) CHARACTER SET utf8 DEFAULT NULL,
  `subjectCode` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `instructorId` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `teamCode` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `teamLogoName` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `deletedDate` date DEFAULT NULL,
  KEY `teamCode` (`teamCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deletedTeams`
--

LOCK TABLES `deletedTeams` WRITE;
/*!40000 ALTER TABLE `deletedTeams` DISABLE KEYS */;
INSERT INTO `deletedTeams` VALUES ('vaibhav3','thanos',4,'ecommerce wesbite','170003','tony stark','thaeco7168','thaeco7168.png','2020-11-23'),('vvaibhav3','thanos',4,'ecommerce wesbite','170003','tony stark','thaeco3401','thaeco3401.51.28 PM.jpeg','2020-11-23'),('vvaibhav3','thanos',4,'ecommerce wesbite','170003','tony stark','thaeco1566','thaeco1566.png','2020-11-23'),('vvaibhav3','thanos',2,'ecommerce wesbite','170003','tony stark','thaeco1','thaeco1.png','2020-11-23'),('vikrant@3','ddfg',2,'sdfvfd','140002','prabhas@7','ddfsdf1593','ddfsdf1593.jpg','2020-11-26'),('vikrant@3','jhonny depp',4,'coding by voice','140002','prabhas@7','jhocod4372','jhocod4372.png','2020-11-26'),('vikrant@3','sdkhskfd',2,'sdfvfd','170003','prabhas@7','sdksdf5728','sdksdf5728.11.36.png','2020-11-26'),('vikrant@3','test',2,'movie website','170003','prabhas@7','tesmov2078','tesmov2078.11.36.png','2020-11-26'),('vikrant@3','test',1,'xuz','170003','prabhas@7','tesxuz9364','tesxuz9364.png','2020-11-26');
/*!40000 ALTER TABLE `deletedTeams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `displayPrj`
--

DROP TABLE IF EXISTS `displayPrj`;
/*!50001 DROP VIEW IF EXISTS `displayPrj`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `displayPrj` AS SELECT 
 1 AS `domain`,
 1 AS `pstmt`,
 1 AS `abstract`,
 1 AS `report`,
 1 AS `prjAssignDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `instructor`
--

DROP TABLE IF EXISTS `instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor` (
  `instructorId` varchar(20) NOT NULL,
  `uname` varchar(20) DEFAULT NULL,
  `fname` varchar(20) DEFAULT NULL,
  `lname` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `pno` varchar(12) DEFAULT NULL,
  `psw` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`instructorId`),
  UNIQUE KEY `unique_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor`
--

LOCK TABLES `instructor` WRITE;
/*!40000 ALTER TABLE `instructor` DISABLE KEYS */;
INSERT INTO `instructor` VALUES ('ironman@3','ironman@3','tony','stark','test@gmail.com','9988775566','1234'),('prabhas@7','prabhas@7','prabhas','megastar','test4@gmail.com','9988775566','1234');
/*!40000 ALTER TABLE `instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectDesc`
--

DROP TABLE IF EXISTS `projectDesc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectDesc` (
  `domain` varchar(50) DEFAULT NULL,
  `pstmt` varchar(100) DEFAULT NULL,
  `descPs` varchar(500) DEFAULT NULL,
  `teamCode` varchar(20) NOT NULL,
  `abstract` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `output` varchar(50) DEFAULT NULL,
  `report` varchar(50) DEFAULT NULL,
  `PsStatus` varchar(50) DEFAULT 'Problem Statement Submitted',
  `marks` int DEFAULT NULL,
  `reviewer` varchar(50) DEFAULT NULL,
  `suggestion` varchar(500) DEFAULT NULL,
  KEY `teamCode` (`teamCode`),
  CONSTRAINT `projectDesc_ibfk_1` FOREIGN KEY (`teamCode`) REFERENCES `teams` (`teamCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectDesc`
--

LOCK TABLES `projectDesc` WRITE;
/*!40000 ALTER TABLE `projectDesc` DISABLE KEYS */;
INSERT INTO `projectDesc` VALUES ('test','sdfsdf','sdfsdf','thaeco2973','thaeco2973_abstract.pdf','thaeco2973_Code.zip','thaeco2973_Output.pdf','thaeco2973_Report.pdf','Problem Statement Accepted',150,NULL,'sdsdfsdf'),('Os','implementing simple system call','adding system call in linux arch...','vaisys388','vaisys388_abstract.pdf','vaisys388_Code.zip','vaisys388_Output.pdf','vaisys388_Report.pdf','Problem Statement Accepted',200,NULL,'no'),('Ai','Coding by voice','creating edditor with voice','Irocod9593','Irocod9593_abstract.pdf','Irocod9593_Code.zip','Irocod9593_Output.pdf','Irocod9593_Report.pdf','Problem Statement Accepted',100,NULL,'good one'),('Ai','Library management system','test 1212 23 234234234','hullib2340','hullib2340_abstract.pdf','hullib2340_Code.zip','hullib2340_Output.pdf','hullib2340_Report.pdf','Problem Statement Accepted',100,NULL,'good carry on'),('Ml','svdjsdfjhgsdf gsdfgskd f','dfsjdfkjslkdjf','tesmov1855','tesmov1855_abstract.pdf','tesmov1855_Code.zip','tesmov1855_Output.pdf','tesmov1855_Report.pdf','Problem Statement Accepted',99,NULL,'go');
/*!40000 ALTER TABLE `projectDesc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviewer`
--

DROP TABLE IF EXISTS `reviewer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviewer` (
  `teamCode` varchar(20) NOT NULL,
  `reviewer` varchar(20) NOT NULL,
  PRIMARY KEY (`teamCode`,`reviewer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviewer`
--

LOCK TABLES `reviewer` WRITE;
/*!40000 ALTER TABLE `reviewer` DISABLE KEYS */;
INSERT INTO `reviewer` VALUES ('thaeco2973','prabhas@7'),('vaisys388','ironman@3');
/*!40000 ALTER TABLE `reviewer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `showDate`
--

DROP TABLE IF EXISTS `showDate`;
/*!50001 DROP VIEW IF EXISTS `showDate`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `showDate` AS SELECT 
 1 AS `teamCode`,
 1 AS `prjAssignDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `enroll` varchar(20) NOT NULL,
  `uname` varchar(20) DEFAULT NULL,
  `fname` varchar(20) DEFAULT NULL,
  `lname` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `pno` varchar(12) DEFAULT NULL,
  `psw` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`enroll`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('swapnil@9','swapnil@9','swapnil','waghamare','test9@gmail.com','9988775566','1234'),('test@123','test','swapna','salunkhe','swapnasalunkhe2017@gmail.com','9988775544','1234'),('vikrant@3','vikrant@3','vikrant','waghamare','test2@gmail.com','9988775566','1234'),('vvaibhav3','vvaibhav3','vaibhav','vaibhav','test@gmail.com','9988775566','Silent@37937');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentTeams`
--

DROP TABLE IF EXISTS `studentTeams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentTeams` (
  `enroll` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `teamCode` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  KEY `teamCode` (`teamCode`),
  CONSTRAINT `studentTeams_ibfk_1` FOREIGN KEY (`teamCode`) REFERENCES `teams` (`teamCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentTeams`
--

LOCK TABLES `studentTeams` WRITE;
/*!40000 ALTER TABLE `studentTeams` DISABLE KEYS */;
INSERT INTO `studentTeams` VALUES ('vvaibhav3','thaeco2973'),('vvaibhav3','hullib2340'),('vikrant@3','thaeco2973'),('vikrant@3','vaisys388'),('swapnil@9','thocod3600'),('vikrant@3','Irocod9593'),('vikrant@3','hullib2340'),('vvaibhav3','tesmov1855');
/*!40000 ALTER TABLE `studentTeams` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `afterTeamLeave` AFTER DELETE ON `studentTeams` FOR EACH ROW begin insert into studentTeamsLeave values(old.enroll,old.teamCode,curdate()); end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `studentTeamsLeave`
--

DROP TABLE IF EXISTS `studentTeamsLeave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentTeamsLeave` (
  `enroll` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `teamCode` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `leaveDate` date DEFAULT NULL,
  KEY `teamCode` (`teamCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentTeamsLeave`
--

LOCK TABLES `studentTeamsLeave` WRITE;
/*!40000 ALTER TABLE `studentTeamsLeave` DISABLE KEYS */;
INSERT INTO `studentTeamsLeave` VALUES ('vvaibhav3','thaeco1','2020-11-23'),('vvaibhav3','thaeco1','2020-11-23'),('vikrant@3','hullib2340','2020-11-26'),('vikrant@3','jhocod4372','2020-11-26'),('vikrant@3','tesmov2078','2020-11-26'),('vikrant@3','tesxuz9364','2020-11-26'),('vikrant@3','sdksdf5728','2020-11-26'),('vikrant@3','ddfsdf1593','2020-11-26'),('vikrant@3','tesmov1855','2020-11-26');
/*!40000 ALTER TABLE `studentTeamsLeave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `instructorId` varchar(20) NOT NULL,
  `subjectName` varchar(30) DEFAULT NULL,
  `subjectCode` varchar(20) DEFAULT NULL,
  KEY `instructorId` (`instructorId`),
  CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`instructorId`) REFERENCES `instructor` (`instructorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES ('ironman@3','data structure','170003'),('ironman@3','java','140002'),('prabhas@7','OS','170002'),('ironman@3','skjdbkjsdkfjs','410001'),('ironman@3','Hci','120001');
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `enroll` varchar(20) DEFAULT NULL,
  `teamName` varchar(20) DEFAULT NULL,
  `noOfMembers` int DEFAULT NULL,
  `projectName` varchar(300) DEFAULT NULL,
  `subjectCode` varchar(60) DEFAULT NULL,
  `instructorId` varchar(20) DEFAULT NULL,
  `teamCode` varchar(20) NOT NULL,
  `teamLogoName` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`teamCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES ('vvaibhav3','hulk',1,'library management','140002','ironman@3','hullib2340','hullib2340.png'),('vikrant@3','IronMan',2,'coding by voice','140002','ironman@3','Irocod9593','Irocod9593.11.36.png'),('vikrant@3','test',2,'movie website','170003','ironman@3','tesmov1855','tesmov1855.png'),('vvaibhav3','thanos',2,'ecommerce wesbite','170003','ironman@3','thaeco2973','thaeco2973.png'),('swapnil@9','thor',2,'coding by voice','140002','ironman@3','thocod3600','thocod3600.png'),('vikrant@3','vaibhav',2,'system call implementation','170002','prabhas@7','vaisys388','vaisys388.png');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `afterCreateTeam` AFTER INSERT ON `teams` FOR EACH ROW begin insert into studentTeams values(new.enroll,new.teamCode); end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `beforeDeleteOnTeams` BEFORE DELETE ON `teams` FOR EACH ROW begin insert into deletedTeams values(old.enroll,old.teamName,old.noOfMembers,old.projectName,old.subjectCode,old.instructorid,old.teamCode,old.teamLogoName,curdate()); end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `displayPrj`
--

/*!50001 DROP VIEW IF EXISTS `displayPrj`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `displayPrj` AS select `p`.`domain` AS `domain`,`p`.`pstmt` AS `pstmt`,`p`.`abstract` AS `abstract`,`p`.`report` AS `report`,`d`.`prjAssignDate` AS `prjAssignDate` from (`projectDesc` `p` join `showDate` `d`) where (`p`.`teamCode` = `d`.`teamCode`) order by `d`.`prjAssignDate` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `showDate`
--

/*!50001 DROP VIEW IF EXISTS `showDate`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `showDate` AS select `t`.`teamCode` AS `teamCode`,`ap`.`prjAssignDate` AS `prjAssignDate` from (`teams` `t` join `assignPrj` `ap`) where ((convert(`t`.`subjectCode` using utf8mb4) = `ap`.`subjectCode`) and (convert(`t`.`instructorId` using utf8mb4) = `ap`.`instructorId`)) */;
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

-- Dump completed on 2020-11-26 22:32:03
