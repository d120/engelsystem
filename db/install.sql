-- MySQL dump 10.13  Distrib 5.5.53, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: engelsystem
-- ------------------------------------------------------
-- Server version	5.5.53-0+deb8u1

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
-- Table structure for table `AngelTypes`
--

DROP TABLE IF EXISTS `AngelTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AngelTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `restricted` int(1) NOT NULL,
  `description` text NOT NULL,
  `requires_driver_license` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `GroupPrivileges`
--

DROP TABLE IF EXISTS `GroupPrivileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GroupPrivileges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `privilege_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`,`privilege_id`),
  KEY `privilege_id` (`privilege_id`),
  CONSTRAINT `groupprivileges_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `groupprivileges_ibfk_2` FOREIGN KEY (`privilege_id`) REFERENCES `Privileges` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=334 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Groups`
--

DROP TABLE IF EXISTS `Groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Groups` (
  `Name` varchar(35) NOT NULL,
  `UID` int(11) NOT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `LogEntries`
--

DROP TABLE IF EXISTS `LogEntries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LogEntries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` int(11) NOT NULL,
  `nick` text NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=2773 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Messages`
--

DROP TABLE IF EXISTS `Messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Datum` int(11) NOT NULL,
  `SUID` int(11) NOT NULL DEFAULT '0',
  `RUID` int(11) NOT NULL DEFAULT '0',
  `isRead` char(1) NOT NULL DEFAULT 'N',
  `Text` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Datum` (`Datum`),
  KEY `SUID` (`SUID`),
  KEY `RUID` (`RUID`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`SUID`) REFERENCES `User` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`RUID`) REFERENCES `User` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Fuers interen Communikationssystem';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NeededAngelTypes`
--

DROP TABLE IF EXISTS `NeededAngelTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NeededAngelTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(11) DEFAULT NULL,
  `shift_id` int(11) DEFAULT NULL,
  `angel_type_id` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `room_id` (`room_id`,`angel_type_id`),
  KEY `shift_id` (`shift_id`),
  KEY `angel_type_id` (`angel_type_id`),
  CONSTRAINT `neededangeltypes_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `Room` (`RID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `neededangeltypes_ibfk_2` FOREIGN KEY (`shift_id`) REFERENCES `Shifts` (`SID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `neededangeltypes_ibfk_3` FOREIGN KEY (`angel_type_id`) REFERENCES `AngelTypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6819 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `News`
--

DROP TABLE IF EXISTS `News`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `News` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Datum` int(11) NOT NULL,
  `Betreff` varchar(150) NOT NULL DEFAULT '',
  `Text` text NOT NULL,
  `UID` int(11) NOT NULL DEFAULT '0',
  `Treffen` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `UID` (`UID`),
  CONSTRAINT `news_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `User` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NewsComments`
--

DROP TABLE IF EXISTS `NewsComments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NewsComments` (
  `ID` bigint(11) NOT NULL AUTO_INCREMENT,
  `Refid` int(11) NOT NULL DEFAULT '0',
  `Datum` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Text` text NOT NULL,
  `UID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Refid` (`Refid`),
  KEY `UID` (`UID`),
  CONSTRAINT `newscomments_ibfk_1` FOREIGN KEY (`Refid`) REFERENCES `News` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `newscomments_ibfk_2` FOREIGN KEY (`UID`) REFERENCES `User` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Privileges`
--

DROP TABLE IF EXISTS `Privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Privileges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `desc` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Questions`
--

DROP TABLE IF EXISTS `Questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Questions` (
  `QID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UID` int(11) NOT NULL DEFAULT '0',
  `Question` text NOT NULL,
  `AID` int(11) DEFAULT NULL,
  `Answer` text,
  PRIMARY KEY (`QID`),
  KEY `UID` (`UID`),
  KEY `AID` (`AID`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `User` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `questions_ibfk_2` FOREIGN KEY (`AID`) REFERENCES `User` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Fragen und Antworten';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Room`
--

DROP TABLE IF EXISTS `Room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Room` (
  `RID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(35) NOT NULL DEFAULT '',
  `Man` text,
  `FromPentabarf` char(1) NOT NULL DEFAULT 'N',
  `show` char(1) NOT NULL DEFAULT 'Y',
  `Number` int(11) DEFAULT NULL,
  PRIMARY KEY (`RID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ShiftEntry`
--

DROP TABLE IF EXISTS `ShiftEntry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ShiftEntry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `SID` int(11) NOT NULL DEFAULT '0',
  `TID` int(11) NOT NULL DEFAULT '0',
  `UID` int(11) NOT NULL DEFAULT '0',
  `Comment` text,
  `freeload_comment` text,
  `freeloaded` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `TID` (`TID`),
  KEY `UID` (`UID`),
  KEY `SID` (`SID`,`TID`),
  KEY `freeloaded` (`freeloaded`),
  CONSTRAINT `shiftentry_ibfk_1` FOREIGN KEY (`SID`) REFERENCES `Shifts` (`SID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shiftentry_ibfk_2` FOREIGN KEY (`UID`) REFERENCES `User` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shiftentry_ibfk_3` FOREIGN KEY (`TID`) REFERENCES `AngelTypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ShiftTypes`
--

DROP TABLE IF EXISTS `ShiftTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ShiftTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `angeltype_id` int(11) DEFAULT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `angeltype_id` (`angeltype_id`),
  CONSTRAINT `shifttypes_ibfk_1` FOREIGN KEY (`angeltype_id`) REFERENCES `AngelTypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Shifts`
--

DROP TABLE IF EXISTS `Shifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Shifts` (
  `SID` int(11) NOT NULL AUTO_INCREMENT,
  `title` text,
  `shifttype_id` int(11) NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  `RID` int(11) NOT NULL DEFAULT '0',
  `URL` text,
  `PSID` int(11) DEFAULT NULL,
  `created_by_user_id` int(11) DEFAULT NULL,
  `created_at_timestamp` int(11) NOT NULL,
  `edited_by_user_id` int(11) DEFAULT NULL,
  `edited_at_timestamp` int(11) NOT NULL,
  PRIMARY KEY (`SID`),
  UNIQUE KEY `PSID` (`PSID`),
  KEY `RID` (`RID`),
  KEY `shifttype_id` (`shifttype_id`),
  KEY `created_by_user_id` (`created_by_user_id`),
  KEY `edited_by_user_id` (`edited_by_user_id`),
  CONSTRAINT `shifts_ibfk_1` FOREIGN KEY (`RID`) REFERENCES `Room` (`RID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shifts_ibfk_2` FOREIGN KEY (`shifttype_id`) REFERENCES `ShiftTypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shifts_ibfk_3` FOREIGN KEY (`created_by_user_id`) REFERENCES `User` (`UID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `shifts_ibfk_4` FOREIGN KEY (`edited_by_user_id`) REFERENCES `User` (`UID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=577 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `Nick` varchar(23) NOT NULL DEFAULT '',
  `Name` varchar(23) DEFAULT NULL,
  `Vorname` varchar(23) DEFAULT NULL,
  `Alter` int(4) DEFAULT NULL,
  `Telefon` varchar(40) DEFAULT NULL,
  `DECT` varchar(5) DEFAULT NULL,
  `Handy` varchar(40) DEFAULT NULL,
  `email` varchar(123) DEFAULT NULL,
  `email_shiftinfo` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'User wants to be informed by mail about changes in his shifts',
  `jabber` varchar(200) DEFAULT NULL,
  `Size` varchar(4) DEFAULT NULL,
  `Passwort` varchar(128) DEFAULT NULL,
  `password_recovery_token` varchar(32) DEFAULT NULL,
  `Gekommen` tinyint(4) NOT NULL DEFAULT '0',
  `Aktiv` tinyint(4) NOT NULL DEFAULT '0',
  `force_active` tinyint(1) NOT NULL,
  `Tshirt` tinyint(4) DEFAULT '0',
  `color` tinyint(4) DEFAULT '10',
  `Sprache` char(64) NOT NULL,
  `Menu` char(1) NOT NULL DEFAULT 'L',
  `lastLogIn` int(11) NOT NULL,
  `CreateDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Art` varchar(30) DEFAULT NULL,
  `kommentar` text,
  `Hometown` varchar(255) NOT NULL DEFAULT '',
  `api_key` varchar(32) NOT NULL,
  `got_voucher` int(11) NOT NULL,
  `arrival_date` int(11) DEFAULT NULL,
  `planned_arrival_date` int(11) NOT NULL,
  `planned_departure_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`UID`),
  UNIQUE KEY `Nick` (`Nick`),
  KEY `api_key` (`api_key`),
  KEY `password_recovery_token` (`password_recovery_token`),
  KEY `force_active` (`force_active`),
  KEY `arrival_date` (`arrival_date`,`planned_arrival_date`),
  KEY `planned_departure_date` (`planned_departure_date`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserAngelTypes`
--

DROP TABLE IF EXISTS `UserAngelTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserAngelTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `angeltype_id` int(11) NOT NULL,
  `confirm_user_id` int(11) DEFAULT NULL,
  `coordinator` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`angeltype_id`,`confirm_user_id`),
  KEY `angeltype_id` (`angeltype_id`),
  KEY `confirm_user_id` (`confirm_user_id`),
  KEY `coordinator` (`coordinator`),
  CONSTRAINT `userangeltypes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userangeltypes_ibfk_2` FOREIGN KEY (`angeltype_id`) REFERENCES `AngelTypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userangeltypes_ibfk_3` FOREIGN KEY (`confirm_user_id`) REFERENCES `User` (`UID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=437 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserDriverLicenses`
--

DROP TABLE IF EXISTS `UserDriverLicenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserDriverLicenses` (
  `user_id` int(11) NOT NULL,
  `has_car` tinyint(1) NOT NULL,
  `has_license_car` tinyint(1) NOT NULL,
  `has_license_3_5t_transporter` tinyint(1) NOT NULL,
  `has_license_7_5t_truck` tinyint(1) NOT NULL,
  `has_license_12_5t_truck` tinyint(1) NOT NULL,
  `has_license_forklift` tinyint(1) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `userdriverlicenses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserGroups`
--

DROP TABLE IF EXISTS `UserGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserGroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `usergroups_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usergroups_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `User` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-05 14:47:27
