-- MySQL dump 10.13  Distrib 5.5.32, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: hochuli
-- ------------------------------------------------------
-- Server version	5.5.32-0ubuntu0.12.04.1

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
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collections`
--

LOCK TABLES `collections` WRITE;
/*!40000 ALTER TABLE `collections` DISABLE KEYS */;
INSERT INTO `collections` VALUES (1,'Одежда',101,'2013-08-14 00:15:42','2013-08-14 00:15:42'),(4,'jhb',102,'2013-08-14 09:27:40','2013-08-14 09:27:40'),(5,'Толстовки',103,'2013-08-14 18:05:55','2013-08-14 18:05:55'),(6,'Шуз',103,'2013-08-14 18:08:29','2013-08-14 18:08:29'),(8,'Сумки',103,'2013-08-15 15:29:41','2013-08-15 15:29:41'),(11,'zx',107,'2013-08-17 09:26:49','2013-08-17 09:26:49'),(13,'Игрушки',103,'2013-08-17 11:26:23','2013-08-17 11:26:23'),(14,'Для авто',103,'2013-08-17 11:29:11','2013-08-17 11:29:11'),(15,'Кресла',103,'2013-08-22 17:16:07','2013-08-22 17:16:07'),(16,'Гигиена',103,'2013-08-22 17:22:08','2013-08-22 17:22:08'),(17,'Гаджеты',103,'2013-08-22 17:29:24','2013-08-22 17:29:24'),(19,'111',148,'2013-08-23 18:42:17','2013-08-23 18:42:17'),(20,'sd',146,'2013-08-23 23:07:52','2013-08-23 23:07:52'),(21,'Спорт',148,'2013-08-24 08:48:16','2013-08-24 08:48:16'),(22,'123',147,'2013-08-24 09:06:45','2013-08-24 09:06:45'),(23,'Телефоны',148,'2013-08-24 09:24:53','2013-08-24 09:24:53'),(24,'Спорт',103,'2013-08-25 15:44:53','2013-08-25 15:44:53');
/*!40000 ALTER TABLE `collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `user_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (39,'чет никто не комментит ( ',148,48,'2013-08-24 10:53:18','2013-08-24 10:53:18'),(40,'Лето кончилось, а мороженого хочется ',103,50,'2013-08-24 16:04:28','2013-08-24 16:04:28'),(42,'Интерфейсы для съемки и общения. Видеозвонки,  функция FaceTime, а также две камеры – на передней и задней панелях iPhone 4. Можно снимать и монтировать HD-видео. И не дорого )',103,44,'2013-08-24 16:06:35','2013-08-24 16:06:35'),(43,'#телефон',103,44,'2013-08-24 16:11:20','2013-08-24 16:11:20');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `follows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `followable_id` int(11) NOT NULL,
  `followable_type` varchar(255) NOT NULL,
  `follower_id` int(11) NOT NULL,
  `follower_type` varchar(255) NOT NULL,
  `blocked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_follows` (`follower_id`,`follower_type`),
  KEY `fk_followables` (`followable_id`,`followable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows`
--

LOCK TABLES `follows` WRITE;
/*!40000 ALTER TABLE `follows` DISABLE KEYS */;
INSERT INTO `follows` VALUES (1,1,'Item',101,'User',0,'2013-08-14 00:15:51','2013-08-14 00:15:51'),(2,1,'Item',1,'Collection',0,'2013-08-14 00:15:51','2013-08-14 00:15:51'),(3,2,'Item',101,'User',0,'2013-08-14 00:16:23','2013-08-14 00:16:23'),(4,2,'Item',1,'Collection',0,'2013-08-14 00:16:23','2013-08-14 00:16:23'),(9,2,'Item',100,'User',0,'2013-08-14 01:53:23','2013-08-14 01:53:23'),(11,1,'Item',100,'User',0,'2013-08-14 01:54:06','2013-08-14 01:54:06'),(17,101,'User',100,'User',0,'2013-08-14 02:05:24','2013-08-14 02:05:24'),(18,100,'User',101,'User',0,'2013-08-14 02:23:43','2013-08-14 02:23:43'),(19,100,'User',102,'User',0,'2013-08-14 09:26:49','2013-08-14 09:26:49'),(20,1,'Item',102,'User',0,'2013-08-14 09:27:41','2013-08-14 09:27:41'),(21,1,'Item',4,'Collection',0,'2013-08-14 09:27:41','2013-08-14 09:27:41'),(25,101,'User',103,'User',0,'2013-08-14 18:06:14','2013-08-14 18:06:14'),(26,1,'Item',103,'User',0,'2013-08-14 18:08:30','2013-08-14 18:08:30'),(27,1,'Item',6,'Collection',0,'2013-08-14 18:08:30','2013-08-14 18:08:30'),(61,30,'Item',103,'User',0,'2013-08-15 15:30:07','2013-08-15 15:30:07'),(62,30,'Item',8,'Collection',0,'2013-08-15 15:30:07','2013-08-15 15:30:07'),(69,35,'Item',106,'User',0,'2013-08-16 12:09:59','2013-08-16 12:09:59'),(70,35,'Item',103,'User',0,'2013-08-16 14:58:24','2013-08-16 14:58:24'),(71,35,'Item',6,'Collection',0,'2013-08-16 14:58:37','2013-08-16 14:58:37'),(72,106,'User',103,'User',0,'2013-08-16 14:58:45','2013-08-16 14:58:45'),(75,2,'Item',103,'User',0,'2013-08-16 15:48:43','2013-08-16 15:48:43'),(93,43,'Item',103,'User',0,'2013-08-22 17:16:31','2013-08-22 17:16:31'),(94,43,'Item',15,'Collection',0,'2013-08-22 17:16:31','2013-08-22 17:16:31'),(95,44,'Item',103,'User',0,'2013-08-22 17:29:55','2013-08-22 17:29:55'),(96,44,'Item',17,'Collection',0,'2013-08-22 17:29:55','2013-08-22 17:29:55'),(97,100,'User',103,'User',0,'2013-08-22 17:35:04','2013-08-22 17:35:04'),(106,104,'User',103,'User',0,'2013-08-23 16:04:32','2013-08-23 16:04:32'),(107,30,'Item',148,'User',0,'2013-08-23 18:22:52','2013-08-23 18:22:52'),(108,35,'Item',148,'User',0,'2013-08-23 18:30:16','2013-08-23 18:30:16'),(109,43,'Item',148,'User',0,'2013-08-23 18:30:57','2013-08-23 18:30:57'),(110,44,'Item',146,'User',0,'2013-08-23 23:07:58','2013-08-23 23:07:58'),(111,44,'Item',20,'Collection',0,'2013-08-23 23:07:58','2013-08-23 23:07:58'),(112,1,'Item',146,'User',0,'2013-08-23 23:08:52','2013-08-23 23:08:52'),(113,35,'Item',146,'User',0,'2013-08-23 23:24:02','2013-08-23 23:24:02'),(114,35,'Item',20,'Collection',0,'2013-08-23 23:24:02','2013-08-23 23:24:02'),(115,148,'User',103,'User',0,'2013-08-24 08:32:28','2013-08-24 08:32:28'),(116,47,'Item',148,'User',0,'2013-08-24 08:52:35','2013-08-24 08:52:35'),(117,47,'Item',21,'Collection',0,'2013-08-24 08:52:35','2013-08-24 08:52:35'),(118,48,'Item',148,'User',0,'2013-08-24 08:55:23','2013-08-24 08:55:23'),(119,48,'Item',21,'Collection',0,'2013-08-24 08:55:23','2013-08-24 08:55:23'),(120,43,'Item',147,'User',0,'2013-08-24 09:06:47','2013-08-24 09:06:47'),(121,43,'Item',22,'Collection',0,'2013-08-24 09:06:47','2013-08-24 09:06:47'),(124,50,'Item',103,'User',0,'2013-08-24 16:03:42','2013-08-24 16:03:42'),(125,50,'Item',17,'Collection',0,'2013-08-24 16:03:42','2013-08-24 16:03:42'),(126,51,'Item',103,'User',0,'2013-08-24 16:09:28','2013-08-24 16:09:28'),(127,51,'Item',17,'Collection',0,'2013-08-24 16:09:28','2013-08-24 16:09:28'),(128,52,'Item',103,'User',0,'2013-08-24 16:10:28','2013-08-24 16:10:28'),(129,52,'Item',17,'Collection',0,'2013-08-24 16:10:28','2013-08-24 16:10:28'),(130,53,'Item',103,'User',0,'2013-08-25 15:45:19','2013-08-25 15:45:19'),(131,53,'Item',24,'Collection',0,'2013-08-25 15:45:19','2013-08-25 15:45:19');
/*!40000 ALTER TABLE `follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `sex` int(11) DEFAULT '0',
  `prise` int(11) DEFAULT NULL,
  `comment` text CHARACTER SET utf8,
  `clothes` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `image_file_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `image_content_type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `cached_comments` int(11) DEFAULT '0',
  `url` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `followers_count_cache` int(11) DEFAULT '0',
  `raiting` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Обувь для туризма climacool DAROGA TWO 13',2,2990,'',0,'2013-08-14 00:15:51','2013-08-22 17:37:34','open-uri20130814-13087-1txkk8u','image/jpeg',31424,'2013-08-14 00:15:51',101,1,'http://adidas.ru/g64437_620/G64437_620.html',1,'http://demandware.edgesuite.net/aagl_prd/on/demandware.static/Sites-adidas-RU-Site/Sites-adidas-products/ru_RU/v1376387745846/pdp/G64437_SL_B2CCat.jpg',1,7),(2,'Зимние кроссовки Choleah Sneaker Primaloft',1,4990,'',0,'2013-08-14 00:16:23','2013-08-14 01:53:24','open-uri20130814-13087-1rx3wng','image/jpeg',27888,'2013-08-14 00:16:23',101,0,'http://adidas.ru/g97346_540/G97346_540.html',1,'http://demandware.edgesuite.net/aagl_prd/on/demandware.static/Sites-adidas-RU-Site/Sites-adidas-products/ru_RU/v1376387745846/pdp/G97346_SL_B2CCat.jpg',1,6),(30,'Сумка',0,1600,'',1,'2013-08-15 15:30:07','2013-08-23 18:22:52','open-uri20130815-27809-1444m3y','image/jpeg',47555,'2013-08-15 15:30:06',103,0,'http://adidas.com/us/product/originals-iconics-pack/Q45316X?cid',4,'http://a248.e.akamai.net/f/248/9086/10h/origin-d5.scene7.com/is/image/adidasgroup/Q45316_01?wid=500&hei=500&fmt=jpeg&qlt=92,0&resMode=sharp2&op_usm=1.1,0.5,1,0',1,6),(35,'охеренные боты',2,889,'',0,'2013-08-16 12:09:59','2013-08-16 14:58:24','open-uri20130816-25421-lfosmn','image/jpeg',33041,'2013-08-16 12:09:58',106,0,'http://adidas.ru/g64684_590/G64684_590.html?pr',1,'http://demandware.edgesuite.net/aagl_prd/on/demandware.static/Sites-adidas-RU-Site/Sites-adidas-products/ru_RU/v1376629488280/pdp/G64684_SL.jpg',1,6),(43,'Кресло',0,9990,'#мебель',1,'2013-08-22 17:16:31','2013-08-23 18:30:57','open-uri20130822-25724-yc8chy','image/jpeg',198538,'2013-08-22 17:16:30',103,0,'http://enter.ru/product/furniture/kreslo-krovat-bene-2050600010716',9,'http://fs05.enter.ru/1/1/500/fb/199909.jpg',1,6),(44,'Смартфон Apple iPhone 4 8Gb (белый) ',0,13990,'#iphone',1,'2013-08-22 17:29:55','2013-08-24 16:11:20','open-uri20130822-25724-1gyr5vg','image/jpeg',13917,'2013-08-22 17:29:55',103,3,'http://svyaznoy.ru/catalog/phone/224/1440479',11,'http://static.svyaznoy.ru/upload/iblock/466/iphone-4-white-1.jpg/resize/350x350/',1,9),(47,'FINALE 13 OFFICIAL MATCH BALL',2,500,'#sport,  #футбол, отличный мячик )  ',1,'2013-08-24 08:52:35','2013-08-24 08:52:35','open-uri20130824-31617-f1xnlt','image/jpeg',80123,'2013-08-24 08:52:35',148,0,'http://adidas.com/us/product/mens-soccer-finale-13-official-match-ball/AJ689?cid',4,'http://a248.e.akamai.net/f/248/9086/10h/origin-d5.scene7.com/is/image/adidasgroup/G73454_01?wid=500&hei=500&fmt=jpeg&qlt=92,0&resMode=sharp2&op_usm=1.1,0.5,1,0',0,0),(48,'COLORADO RIPSTOP WINDBREAKER',2,1900,'#sport, @ilyadolinin',0,'2013-08-24 08:55:23','2013-08-24 10:53:18','open-uri20130824-31617-19w22qs','image/jpeg',56710,'2013-08-24 08:55:22',148,1,'http://adidas.com/us/product/mens-originals-colorado-ripstop-windbreaker/AC936?cid',4,'http://a248.e.akamai.net/f/248/9086/10h/origin-d5.scene7.com/is/image/adidasgroup/G84969_01?wid=500&hei=500&fmt=jpeg&qlt=92,0&resMode=sharp2&op_usm=1.1,0.5,1,0',0,4),(50,'Мороженица Delimano Clarity',0,1490,'#бытовые_товары',1,'2013-08-24 16:03:42','2013-08-24 16:04:28','open-uri20130824-31617-17gky8d','image/jpeg',10636,'2013-08-24 16:03:41',103,1,'http://top-shop.ru/product/67153-delimano-clarity/?webSyncID',13,'http://cdn1.top-shop.ru/ac5c663f7b6346b2667b9dc73f791a6f.jpg',0,4),(51,'Смартфон SAMSUNG I9500 Galaxy S4 16Gb White',0,24989,'#телефон',1,'2013-08-24 16:09:28','2013-08-24 16:09:28','open-uri20130824-31617-bqqweu','image/jpeg',24361,'2013-08-24 16:09:27',103,0,'http://eldorado.ru/cat/detail/71085500/',12,'http://static.eldorado.ru/photos/71/new_71085500_l_565.jpeg/resize/350x300/',0,0),(52,'Планшет APPLE iPad Mini Wi-Fi+Cellular 32GB White MD544',0,19999,'#ipad',1,'2013-08-24 16:10:28','2013-08-24 16:10:28','open-uri20130824-31617-10rhak2','image/jpeg',23127,'2013-08-24 16:10:28',103,0,'http://eldorado.ru/cat/detail/71084570/',12,'http://static.eldorado.ru/photos/71/new_71084570_l_945.jpeg/resize/350x300/',0,0),(53,'Спортивное поло adizero',2,3490,'#sport',0,'2013-08-25 15:45:19','2013-08-25 15:45:19','open-uri20130825-31617-2cbo70','image/jpeg',23999,'2013-08-25 15:45:18',103,0,'http://adidas.ru/g69285_360/G69285_360.html',1,'http://demandware.edgesuite.net/aagl_prd/on/demandware.static/Sites-adidas-RU-Site/Sites-adidas-products/ru_RU/v1377351731490/pdp/G69285_F_Torso_B2CCat.jpg',0,0);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentions`
--

DROP TABLE IF EXISTS `mentions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mentions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentions`
--

LOCK TABLES `mentions` WRITE;
/*!40000 ALTER TABLE `mentions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mentions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20130714122933'),('20130714130633'),('20130717092652'),('20130724130746'),('20130724131324'),('20130725065711'),('20130725070416'),('20130725070609'),('20130728115859'),('20130728175130'),('20130728193709'),('20130728233439'),('20130729151348'),('20130729205035'),('20130730093204'),('20130730145544'),('20130731133049'),('20130731133743'),('20130731194802'),('20130803151455'),('20130803183215'),('20130803183744'),('20130805144743'),('20130808181957'),('20130808182525'),('20130810134614'),('20130810135436'),('20130811214844'),('20130811222012'),('20130811225049'),('20130817120949'),('20130823000040');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shops`
--

DROP TABLE IF EXISTS `shops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shops`
--

LOCK TABLES `shops` WRITE;
/*!40000 ALTER TABLE `shops` DISABLE KEYS */;
INSERT INTO `shops` VALUES (1,'adidas.ru','2013-08-14 00:15:51','2013-08-14 00:15:51'),(2,'smartof.ru','2013-08-14 18:26:44','2013-08-14 18:26:44'),(3,'bt.rozetka.com.ua','2013-08-14 19:07:10','2013-08-14 19:07:10'),(4,'adidas.com','2013-08-15 15:29:19','2013-08-15 15:29:19'),(5,'wildberries.ru','2013-08-15 16:16:37','2013-08-15 16:16:37'),(6,'coolairsport.ru','2013-08-15 19:03:41','2013-08-15 19:03:41'),(7,'ulmart.ru','2013-08-17 11:26:47','2013-08-17 11:26:47'),(8,'mishka.ru','2013-08-22 17:10:20','2013-08-22 17:10:20'),(9,'enter.ru','2013-08-22 17:16:29','2013-08-22 17:16:29'),(10,'ozone.ru','2013-08-22 17:22:25','2013-08-22 17:22:25'),(11,'svyaznoy.ru','2013-08-22 17:29:54','2013-08-22 17:29:54'),(12,'eldorado.ru','2013-08-23 07:11:39','2013-08-23 07:11:39'),(13,'top-shop.ru','2013-08-24 16:03:40','2013-08-24 16:03:40');
/*!40000 ALTER TABLE `shops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggings`
--

DROP TABLE IF EXISTS `taggings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) DEFAULT NULL,
  `taggable_id` int(11) DEFAULT NULL,
  `taggable_type` varchar(255) DEFAULT NULL,
  `tagger_id` int(11) DEFAULT NULL,
  `tagger_type` varchar(255) DEFAULT NULL,
  `context` varchar(128) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_taggings_on_tag_id` (`tag_id`),
  KEY `index_taggings_on_taggable_id_and_taggable_type_and_context` (`taggable_id`,`taggable_type`,`context`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggings`
--

LOCK TABLES `taggings` WRITE;
/*!40000 ALTER TABLE `taggings` DISABLE KEYS */;
INSERT INTO `taggings` VALUES (12,8,43,'Item',NULL,NULL,'tags','2013-08-22 17:16:31'),(13,9,44,'Item',NULL,NULL,'tags','2013-08-22 17:29:55'),(14,10,47,'Item',NULL,NULL,'tags','2013-08-24 08:52:35'),(15,11,47,'Item',NULL,NULL,'tags','2013-08-24 08:52:35'),(16,10,48,'Item',NULL,NULL,'tags','2013-08-24 08:55:23'),(18,13,50,'Item',NULL,NULL,'tags','2013-08-24 16:03:42'),(19,14,51,'Item',NULL,NULL,'tags','2013-08-24 16:09:28'),(20,15,52,'Item',NULL,NULL,'tags','2013-08-24 16:10:28'),(21,14,44,'Item',NULL,NULL,'tags','2013-08-24 16:11:20'),(22,10,53,'Item',NULL,NULL,'tags','2013-08-25 15:45:19');
/*!40000 ALTER TABLE `taggings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'удобно'),(2,'спорт'),(3,'dfgdfg'),(4,'sdf'),(5,'fsdfg'),(6,'игрушки'),(7,'авто'),(8,'мебель'),(9,'iphone'),(10,'sport'),(11,'футбол'),(12,'телефоны'),(13,'бытовые_товары'),(14,'телефон'),(15,'ipad');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `about` varchar(255) DEFAULT NULL,
  `sex` int(11) DEFAULT '10',
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `uid` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `avatar_file_name` varchar(255) DEFAULT NULL,
  `avatar_content_type` varchar(255) DEFAULT NULL,
  `avatar_file_size` int(11) DEFAULT NULL,
  `avatar_updated_at` datetime DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `followers_new_count` int(11) DEFAULT '0',
  `followed_by_new_count` int(11) DEFAULT '0',
  `mentions_new_count` int(11) DEFAULT '0',
  `phone` varchar(255) DEFAULT NULL,
  `shop` tinyint(1) DEFAULT '0',
  `followers_counter` int(11) DEFAULT '0',
  `items_count` int(11) DEFAULT '0',
  `admin` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (100,'75632468@vk.com','$2a$10$aowE.Ltb.HZ2HIK6/4hoCOZRle6udYbR708SRfJ4Z1sg/pDX2czwy',NULL,NULL,NULL,'dranik','Irina Dranchuk','Мозырь','',1,1,'2013-08-14 00:11:17','2013-08-14 00:11:17','46.251.92.176','46.251.92.176','2013-08-14 00:11:17','2013-08-22 17:35:04','vkontakte','75632468','http://cs323130.vk.me/v323130468/afd7/c3jrr8isjhY.jpg',NULL,NULL,NULL,NULL,NULL,'2013-08-23 00:02:26',NULL,3,0,0,'89201234567',0,3,0,NULL),(101,'180967766@vk.com','$2a$10$1UZ72Tw9U5HAKEg4RYG55udVPNWb.fW37VNK183GcyHJZPDqTyqjq',NULL,NULL,NULL,'shvetsov','Sergey Shvetsov','Нижний Новгород','',2,4,'2013-08-16 16:01:17','2013-08-16 07:26:59','178.123.60.27','178.123.60.27','2013-08-14 00:12:29','2013-08-16 16:01:17','vkontakte','180967766','http://cs403620.vk.me/v403620766/7ee8/bj6oGdHbncA.jpg','_1452.jpg','image/jpeg',65493,'2013-08-14 00:12:46',NULL,'2013-08-23 00:02:26',NULL,0,0,0,'89201234567',0,2,2,NULL),(102,'190097779@vk.com','$2a$10$X78fgQZRgT9OBH6qeNwTgOIJ9J8f8W9mvz8bnz6J3esXsMESQLR6K',NULL,NULL,NULL,'alexandrruzin','Alexandr Ruzin',NULL,NULL,2,5,'2013-08-22 18:15:37','2013-08-22 17:55:59','176.108.169.148','176.108.169.148','2013-08-14 09:26:15','2013-08-22 18:15:37','vkontakte','190097779','http://cs405927.vk.me/v405927779/8ee0/XJl3st_YchQ.jpg',NULL,NULL,NULL,NULL,NULL,'2013-08-23 00:02:26',NULL,1,0,0,'89012345678',0,1,0,1),(103,'emband@mail.ru','$2a$10$anTGLbtspR3HKBSC90SbnODM5N6EcsyZcOPyEuEYL0cH9eXRCzkM6',NULL,NULL,NULL,'ilyadolinin','Илья Долинин','Москва','',2,25,'2013-08-25 15:43:03','2013-08-24 16:00:15','90.155.167.170','90.155.167.170','2013-08-14 18:04:22','2013-08-25 15:43:03',NULL,NULL,NULL,'22.jpg','image/jpeg',121324,'2013-08-14 18:05:32',NULL,'2013-08-23 00:02:26',NULL,0,0,0,'89201234567',0,0,7,1),(104,'test@test.com','$2a$10$0B5p2PiMc/ZJ9GmTa9FL6eeGLWuuKE2Pzi/lL1.VTrLKYK0WhxY0y',NULL,NULL,NULL,'104','testtest',NULL,NULL,10,1,'2013-08-14 19:05:38','2013-08-14 19:05:38','176.98.73.5','176.98.73.5','2013-08-14 19:05:37','2013-08-23 16:04:32',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2013-08-23 00:02:26',NULL,1,0,0,'89201234567',0,1,0,NULL),(105,'18438636@vk.com','$2a$10$TTnROiyb2Y4W7lVAKsSDxOt3mQf36yfG.yaG1YqOkk201pBrEh/Yu',NULL,NULL,NULL,'vladsamoylenko','Vlad Samoylenko',NULL,NULL,2,3,'2013-08-15 16:16:08','2013-08-15 14:19:33','176.98.73.5','176.98.73.5','2013-08-15 13:56:02','2013-08-15 16:16:08','vkontakte','18438636','https://vk.com/images/camera_c.gif',NULL,NULL,NULL,NULL,NULL,'2013-08-23 00:02:26',NULL,0,0,0,'89012345678',0,0,0,NULL),(106,'dimanfet@yandex.ru','$2a$10$5V5Eb7El1PLce6/REdBGceedkfcg9JONoI2JORUY3ZgphyEkIYRUu',NULL,NULL,NULL,'106','amadi',NULL,NULL,10,1,'2013-08-16 12:08:56','2013-08-16 12:08:56','89.23.171.38','89.23.171.38','2013-08-16 12:08:56','2013-08-16 14:58:45',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2013-08-23 00:02:26',NULL,1,0,0,'89201234567',0,1,1,NULL),(108,'16433218@vk.com','$2a$10$T8jo6TUzC73HdEkszpy4N.xmfm4hxfJmK2Fuajzfs5r752/TBCYn6',NULL,NULL,NULL,'galinaneznayusama','Galina Neznayusama',NULL,NULL,1,2,'2013-08-19 13:03:39','2013-08-18 19:30:15','46.216.183.132','46.216.99.22','2013-08-18 19:30:15','2013-08-19 13:03:39','vkontakte','16433218','http://cs5755.vk.me/u16433218/e_04d19246.jpg',NULL,NULL,NULL,NULL,NULL,'2013-08-23 00:02:26',NULL,0,0,0,'89012345678',0,0,0,NULL),(110,'97892782@vk.com','$2a$10$e.utBEXYaKjC1SNQF6pCx.35izP1e4560NcM1hodRHlDr2RQnW6hW',NULL,NULL,NULL,'golova..','Golova ..',NULL,NULL,1,0,NULL,NULL,NULL,NULL,'2013-08-23 11:03:08','2013-08-23 11:03:08','vkontakte','97892782','http://cs851.vk.me/u97892782/e_d2ea390d.jpg',NULL,NULL,NULL,NULL,'fWnXvhMLuJynF7Zwj66m',NULL,'2013-08-23 11:03:08',0,0,0,'89012345678',0,0,0,NULL),(111,'sasha@ruzin.su','$2a$10$OG3tLH45Thy63qywawXC/u8ET4keFo5ED1a0h/bBlSC5Xq7zawZVG',NULL,NULL,NULL,'sanek','sanek',NULL,NULL,10,0,NULL,NULL,NULL,NULL,'2013-08-23 11:50:56','2013-08-23 11:50:56',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'XDeVBXCTZpYiaxVNysDg',NULL,'2013-08-23 11:50:56',0,0,0,'89201234567',0,0,0,NULL),(112,'6445901@gmail.com','$2a$10$bZ3MH89hSZNwEix.INVvXupEUzEVs6REHg/4TTlkB1HuHUMEE.DRi',NULL,NULL,NULL,'qwe','qwe',NULL,NULL,10,0,NULL,NULL,NULL,NULL,'2013-08-23 11:51:29','2013-08-23 11:51:29',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'q5qiPArzwto7v6JZhxhr',NULL,'2013-08-23 11:51:29',0,0,0,'89201234567',0,0,0,NULL),(114,'testination@gmail.com','$2a$10$jXUjEUzcu0yFI2UBxCQTkuvA.jKE384h/DD1X45knPKnWA94c.46u',NULL,NULL,NULL,'fsaf','fsaf',NULL,NULL,10,0,NULL,NULL,NULL,NULL,'2013-08-23 13:00:05','2013-08-23 13:00:05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'kskXDCE9rv6oV4JcQqHj',NULL,'2013-08-23 13:00:05',0,0,0,'89201234567',0,0,0,NULL),(115,'theanswerzone1@gmail.com','$2a$10$CXvEJgvpBE24uYoak27DGe7eRu.M.xbZHJ10Qju8GqMjBcDtF9KWW',NULL,NULL,NULL,'2432','2432',NULL,NULL,10,0,NULL,NULL,NULL,NULL,'2013-08-23 13:00:42','2013-08-23 13:00:42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'EV2HEbbuhVR9pZmBph7n',NULL,'2013-08-23 13:00:42',0,0,0,'89201234567',0,0,0,NULL),(116,'iamjacke1@gmail.com','$2a$10$bg0djk6Rmj3TWjL6MG76tOjBCpAoqXuf4PnbFs.lI8ZZT8onhHLWi',NULL,NULL,NULL,'116','etetet',NULL,NULL,10,1,'2013-08-23 13:07:58','2013-08-23 13:07:58','37.113.141.0','37.113.141.0','2013-08-23 13:07:58','2013-08-23 13:07:58',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,'89201234567',0,0,0,NULL),(124,'iamjacke@gmail.com','$2a$10$72YzR4L..cB2Qpa4l0UEG.9UfVL.KQcYecoQWvNaqq4Rt94DjInNO',NULL,NULL,NULL,'124','Stanislav','','',10,2,'2013-08-23 15:36:24','2013-08-23 14:06:13','37.113.141.0','37.113.141.0','2013-08-23 14:06:13','2013-08-23 15:36:24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,'89201234567',0,0,0,1),(144,'unlim911@gmail.com','$2a$10$J4wdvSXCufwXiLUkKcSnU.B4CCfe.jqqKx6/uWy7UJXZEBHNw/0cO',NULL,NULL,NULL,'144','qweqwe',NULL,NULL,10,1,'2013-08-23 16:11:12','2013-08-23 16:11:12','176.108.169.148','176.108.169.148','2013-08-23 16:11:12','2013-08-23 16:11:12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,'123123123',0,0,0,NULL),(145,'hi@altup.ru','$2a$10$rbFAI4T9faqKwS.CSGadS.g1RejXhfB.hnZr0x1MCX9GJgGK0RKmu',NULL,NULL,NULL,'145','altup',NULL,NULL,10,1,'2013-08-23 16:13:05','2013-08-23 16:13:05','176.108.169.148','176.108.169.148','2013-08-23 16:13:05','2013-08-23 16:13:05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,'123123123',0,0,0,NULL),(146,'theanswerzone@gmail.com','$2a$10$IYOUlYsJl5ROr4GHuaxztu.Y6lvSwPUk4Q7tuq0FRwBB.5YegzIaS',NULL,NULL,NULL,'146','Stanislav1',NULL,NULL,10,1,'2013-08-23 16:19:09','2013-08-23 16:19:09','37.113.141.0','37.113.141.0','2013-08-23 16:19:09','2013-08-23 16:19:09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,'+79090860451',0,0,0,NULL),(147,'tehsalon@ya.ru','$2a$10$741zppBoPkjNISLQbSFF/.cM1xIs.RFsL/AvSJGzxSN80KOZWPDcG',NULL,NULL,NULL,'147','tehsalon','','',10,1,'2013-08-23 16:23:47','2013-08-23 16:23:47','176.108.169.148','176.108.169.148','2013-08-23 16:23:47','2013-08-23 16:23:53',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,'98765749890',0,0,0,NULL),(148,'info@energomap.com','$2a$10$5vE9vJkyE3KVrPFf5ZkZgOquRRrQ6bvcFwPkmNzcEO09KH3rpZSU2',NULL,NULL,NULL,'adidas','www.adidas.com','Москва','',0,4,'2013-08-24 08:46:30','2013-08-23 18:30:07','90.155.167.170','90.155.167.170','2013-08-23 18:15:43','2013-08-24 08:46:30',NULL,NULL,NULL,'11.jpg','image/jpeg',45778,'2013-08-23 18:16:56',NULL,NULL,NULL,1,0,0,'891999893322',1,1,2,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votes`
--

DROP TABLE IF EXISTS `votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `votable_id` int(11) DEFAULT NULL,
  `votable_type` varchar(255) DEFAULT NULL,
  `voter_id` int(11) DEFAULT NULL,
  `voter_type` varchar(255) DEFAULT NULL,
  `vote_flag` tinyint(1) DEFAULT NULL,
  `vote_scope` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_votes_on_votable_id_and_votable_type` (`votable_id`,`votable_type`),
  KEY `index_votes_on_voter_id_and_voter_type` (`voter_id`,`voter_type`),
  KEY `index_votes_on_voter_id_and_voter_type_and_vote_scope` (`voter_id`,`voter_type`,`vote_scope`),
  KEY `index_votes_on_votable_id_and_votable_type_and_vote_scope` (`votable_id`,`votable_type`,`vote_scope`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votes`
--

LOCK TABLES `votes` WRITE;
/*!40000 ALTER TABLE `votes` DISABLE KEYS */;
/*!40000 ALTER TABLE `votes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-08-25 19:45:40
