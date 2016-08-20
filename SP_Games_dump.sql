CREATE DATABASE  IF NOT EXISTS `sp_games` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `sp_games`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: sp_games
-- ------------------------------------------------------
-- Server version	5.7.12-log

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `Email` varchar(45) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Password` char(64) NOT NULL,
  `Secret_Key` char(64) NOT NULL,
  `isAdmin` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('admin@test.com','Admin Test','e4a0fb0573d8b91f7533ec580ed8f3fee11662a69de640cc48f9ba3e73e3fd5b','20ebb57e1e02582df532f86770fd815b8f64999e7009f5b5c90e2f5a5526fcba','Y'),('aloy.cp@gmail.com','Aloysius','2b27387106c13d910c18999a1f22475aebf175511755658a1a867405c3840ef7','3a444bdae437dc1c864906e77e7cc5a97fb8b7deef149f8e503baa935560afe2','Y'),('member@test.com','Member Test','184e833c422eff50eeba4f4a3039f9e460f6f567c865d168fc13d1a9c3028ef2','4b537c130b0476532d263d51f6ffbb8ad93d8e4fcf4441f6f5d57eeca278e03d','N'),('tsekinping2010@gmail.com','Kin Ping','80b7cc2afe95f465c20116139b24391d694af1056d12fffe441f595b18728e40','42ac92841f5de586905e7dd2d7b38bfaec33f5890fad12d2cb93498528898dc5','N');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `developer`
--

DROP TABLE IF EXISTS `developer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `developer` (
  `Developer_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Developer_Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Developer_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `developer`
--

LOCK TABLES `developer` WRITE;
/*!40000 ALTER TABLE `developer` DISABLE KEYS */;
INSERT INTO `developer` VALUES (1,'Valve'),(2,'Squad'),(3,'The Sims Studio'),(4,'Microsoft Games Studios'),(5,'Thekla, Inc'),(6,'Oberon Media'),(7,'Microsoft Corporation');
/*!40000 ALTER TABLE `developer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game` (
  `Game_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) NOT NULL,
  `Developer_ID` int(11) NOT NULL,
  `Publisher_ID` int(11) NOT NULL,
  `Release_Date` date NOT NULL,
  `Description` varchar(5000) NOT NULL,
  `Price` double NOT NULL,
  `Preowned` char(1) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Image_Path` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`Game_ID`,`Developer_ID`,`Publisher_ID`),
  KEY `fk_Game_Publisher_idx` (`Publisher_ID`),
  KEY `fk_Game_Developer_idx` (`Developer_ID`),
  CONSTRAINT `fk_Game_Developer` FOREIGN KEY (`Developer_ID`) REFERENCES `developer` (`Developer_ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_Game_Publisher` FOREIGN KEY (`Publisher_ID`) REFERENCES `publisher` (`Publisher_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (1,'Team Fortress 2',1,1,'2007-10-10','One of the most popular online action games of all time, Team Fortress 2 delivers constant free updates - new game modes, maps, equipment and, most importantly, hats. Nine distinct classes provide a broad range of tactical abilities and personalities, and lend themselves to a variety of player skills.<br><br>New to TF? Don\'t sweat it!<br>No matter what your style and experience, we\'ve got a character for you. Detailed training and offline practice modes will help you hone your skills before jumping into one of TF2\'s many game modes, including Capture the Flag, Control Point, Payload, Arena, King of the Hill and more.<br><br>Make a character your own!<br>There are hundreds of weapons, hats and more to collect, craft, buy and trade. Tweak your favorite class to suit your gameplay style and personal taste. You don\'t need to pay to win-virtually all of the items in the Mann Co. Store can also be found in-game.',14.99,'Y',26,'images/game/Team Fortress 2.jpg'),(2,'Dota 2',1,1,'2013-07-09','Dota is a competitive game of action and strategy, played both professionally and casually by millions of passionate fans worldwide. Players pick from a pool of over a hundred heroes, forming two teams of five players. Radiant heroes then battle their Dire counterparts to control a gorgeous fantasy landscape, waging campaigns of cunning, stealth, and outright warfare.<br> <br> Irresistibly colorful on the surface, Dota is a game of infinite depth and complexity. Every hero has an array of skills and abilities that combine with the skills of their allies in unexpected ways, to ensure that no game is ever remotely alike. This is one of the reasons that the Dota phenomenon has continued to grow. Originating as a fan-made Warcraft 3 modification, Dota was an instant underground hit. After coming to Valve, the original community developers have bridged the gap to a more inclusive audience, so that the rest of the world can experience the same core gameplay, but with the level of polish that only Valve can provide.<br> <br> Get a taste of the game that has enthralled millions.',19.99,'N',250,'images/game/Dota 2.jpg'),(3,'Kerbal Space Program',2,2,'2015-04-28','In KSP you must build a space-worthy craft, capable of flying its crew out into space without killing them. At your disposal is a collection of parts, which must be assembled to create a functional ship. Each part has its own function and will affect the way a ship flies (or doesn\'t). So strap yourself in, and get ready to try some Rocket Science! <br> <br>The game offers three gameplay modes: Sandbox, in which you are free to build anything you can think of; Science Mode, which lets you perform Scientific experiments to advance the knowledge of Kerbalkind and further the available technology; and Career Mode, in which you must manage every aspect of your Space Program, including administration strategies, Crew Management, Reputation, as well as taking up Contracts to earn Funds and upgrade your Space Center Facilities (or repair them). <br> <br>Add to this the ability to capture asteroids (a feature done in collaboration with NASA), Mining for resources out across the furthest reaches of the Solar System, Constructing Bases and Space Stations in and around other worlds; plus literally thousands of mods from a huge active modding community, all add up into the award-winning game that has taken the space sim genre by storm.',39.99,'N',36,'images/game/Kerbal Space Program.jpg'),(4,'The Sims 3',3,3,'2009-06-02','Play with Life.<br> <br> Create the lives you\'ve always wanted!<br> <br> Ready to live a freer, more creative life? In The Sims™ 3, you can let your fantasies run wild as you design your ideal world. Start with your Sim, refining each shape, color and personality trait until you get the precise person that pleases you. Design your dream home, but don’t let a grid limit you; place, rotate and stack furniture and walls freely and to your heart’s content.<br> <br> Once the “hard work” is over, it’s time to be a mentor. Guide your Sim’s path through life, developing a career, finding love, and pursuing dreams and desires. Spending time with friends and family is just as important as mastering painting or accumulating knowledge.<br> <br> Take things to the next level and record movies of your Sim’s adventures and share them with the ever-growing and thriving community. With a huge catalog of expansion packs and fun objects to discover, there is no end to the possibilities awaiting you. It all begins here; your adventure awaits!',24.99,'N',17,''),(5,'Flight Simulator X',4,4,'2006-10-16','Take to the skies in the World’s favourite flight simulator! <br> <br> The multi award winning Microsoft Flight Simulator X lands on Steam for the first time. Take off from anywhere in the world, flying some of the world’s most iconic aircraft to any one of 24,000 destinations. Microsoft Flight Simulator X Steam Edition has updated multiplayer and Windows 8.1 support. <br> <br> Take the controls of aircraft such as the 747 jumbo jet, F/A-18 Hornet, P-51D Mustang, EH-101 helicopter and others - an aircraft for every kind of flying and adventure. Select your starting location, set the time, the season, and the weather. Take off from one of more than 24,000 airports and explore a world of aviation beauty that has entranced millions of plane fans from across the globe. <br> <br> FSX Steam Edition offers players a connected world where they can choose who they want to be, from air-traffic controller to pilot or co-pilot. Racing mode allows you to compete against friends with four types of racing, including Red Bull Air Race courses, the unlimited Reno National Championship course, as well as cross country, competition sailplane courses and fictional courses like the Hoop and Jet Canyon. Test your skills with three different levels of difficulty, from simple pylon racing to racing highly challenging courses in a variety of weather conditions. <br> <br> With over 80 missions, test your prowess to earn rewards. Try your hand at Search and Rescue, Test Pilot, Carrier Operations, and more. Keep track of how you have done on each mission and improve your skill levels until you’re ready for the next challenge. <br> <br> FSX Steam Edition enables pilots to fly the aircraft of their dreams, from the De Havilland DHC-2 Beaver floatplane and Grumman G-21A Goose to the AirCreation 582SL Ultralight and Maule M7 Orion with wheels and skis. Add to your collection of aircraft and improve the fidelity of your world with FSX Add-ons. <br> <br> The inclusion of AI-controlled jetways, fuel trucks and moving baggage carts, adds extra realism to the experience of flying at busy airports. <br> <br> Whether you want to challenge your friends to a heart-pounding race or just take in the scenery, FSX Steam Edition will immerse you in a dynamic, living world that brings a realistic flying experience into your home.',24.99,'Y',32,'images/game/Microsoft Flight Simulator X.jpg'),(6,'The Witness',5,5,'2016-01-26','You wake up, alone, on a strange island full of puzzles that will challenge and surprise you.<br> <br> You don\'t remember who you are, and you don\'t remember how you got here, but there\'s one thing you can do: explore the island in hope of discovering clues, regaining your memory, and somehow finding your way home.<br> <br> The Witness is a single-player game in an open world with dozens of locations to explore and over 500 puzzles. This game respects you as an intelligent player and it treats your time as precious. There\'s no filler; each of those puzzles brings its own new idea into the mix. So, this is a game full of ideas.',99.99,'N',0,'images/game/The Witness.jpg'),(7,'Zuma',6,6,'2003-12-12','Zuma is a tile-matching puzzle video game published by PopCap Games.<br><br>It can be played for free online at several Web sites, and can be purchased for a number of platforms, including PDAs, mobile phones, and the iPod.<br><br>An enhanced version, called Zuma Deluxe, is available for purchase in Windows and Mac OS X versions and as an Xbox Live Arcade download for the Xbox 360 and a PlayStation Network download for the PlayStation 3.',29.99,'Y',0,''),(8,'Microsoft Solitaire',4,7,'2016-03-02','Solitaire remains the most played computer game of all time, and for good reason.<br><br>Simple rules and straightforward gameplay make it easy to pick up for everyone.',19.99,'N',56,'images/game/Microsoft Solitaire Collection.jpg'),(9,'Microsoft Minesweeper',7,7,'2008-02-04','Microsoft Minesweeper is a minesweeper computer game created by Curt Johnson, originally for OS/2, and ported to Microsoft Windows by Robert Donner, both Microsoft employees at the time.',9.99,'N',20,'');
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_genre`
--

DROP TABLE IF EXISTS `game_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_genre` (
  `Game_ID` int(11) NOT NULL,
  `Genre_ID` int(11) NOT NULL,
  PRIMARY KEY (`Game_ID`,`Genre_ID`),
  KEY `fk_Game_Genre_Genre_ID_idx` (`Genre_ID`),
  KEY `fk_Game_Genre_Game_ID_idx` (`Game_ID`),
  CONSTRAINT `fk_Game_Genre_Game_ID` FOREIGN KEY (`Game_ID`) REFERENCES `game` (`Game_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Game_Genre_Genre_ID` FOREIGN KEY (`Genre_ID`) REFERENCES `genre` (`Genre_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_genre`
--

LOCK TABLES `game_genre` WRITE;
/*!40000 ALTER TABLE `game_genre` DISABLE KEYS */;
INSERT INTO `game_genre` VALUES (1,1),(2,1),(1,2),(5,2),(1,3),(2,4),(7,4),(9,4),(2,5),(3,6),(3,7),(4,7),(5,7),(4,8),(5,8),(7,8),(8,8),(9,8),(6,9),(6,10),(7,11),(8,11),(9,11),(8,12);
/*!40000 ALTER TABLE `game_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genre` (
  `Genre_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Genre_Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Genre_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (1,'Action'),(2,'Multi-player'),(3,'First Person Shooter'),(4,'Strategy'),(5,'MOBA'),(6,'Indie'),(7,'Simulation'),(8,'Single-player'),(9,'Adventure'),(10,'Virtual Reality'),(11,'Board'),(12,'Card');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `Email` varchar(45) NOT NULL,
  `Phone_Number` int(11) NOT NULL,
  `Address1` varchar(100) NOT NULL,
  `Address2` varchar(100) DEFAULT NULL,
  `Postal_Code` int(11) NOT NULL,
  PRIMARY KEY (`Email`),
  CONSTRAINT `fk_Member_Account1` FOREIGN KEY (`Email`) REFERENCES `account` (`Email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('member@test.com',98765432,'Block 789 XYZ Road','#10-987',456789),('tsekinping2010@gmail.com',87654321,'Block 321 ABC Road','#12-345',654321);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher` (
  `Publisher_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Publisher_Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Publisher_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES (1,'Valve'),(2,'Squad'),(3,'Electronic Arts'),(4,'Dovetail Games'),(5,'Thekla, Inc'),(6,'PopCap Games'),(7,'Microsoft Corporation');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `Review_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Game_ID` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Comment` varchar(5000) NOT NULL,
  `Rating` int(11) NOT NULL,
  `Review_Date` datetime NOT NULL,
  PRIMARY KEY (`Review_ID`,`Game_ID`),
  KEY `fk_Review_Game_idx` (`Game_ID`),
  CONSTRAINT `fk_Review_Game` FOREIGN KEY (`Game_ID`) REFERENCES `game` (`Game_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,5,'Tom','Best game ever!!!',5,'2016-08-12 16:20:20'),(2,5,'Jerry','A very nice game to play with. Love the graphics!',5,'2016-05-20 22:15:23'),(3,5,'Jacky','Trying to figure out how to play at first. Thanks to the tutorial, I learnt how to play within an hour',4,'2015-12-12 12:12:12'),(4,8,'Ali','Reminds me of my childhood!',5,'2016-04-06 14:42:56'),(5,8,'John','The game always lag. Wasted too much time waiting for it to load! If you are too free, then you can play. If you have not much time to spare, then preferably not!',0,'2015-10-23 00:12:57'),(6,9,'May','Best game to play during boring lectures! All students should have this game!',4,'2016-01-16 09:05:33'),(7,8,'Tommy','An okay game',3,'2016-04-16 14:41:55'),(8,5,'Alice','Played this game for many hours and I highly recommend it. However there is quite a large learning curve when playng this game. You literally fly the plane like how a real pilot would fly it!',5,'2015-05-20 01:12:35'),(9,9,'Samuel','Fun but challenging!',4,'2016-04-28 15:15:00'),(10,9,'Sandy','I KEEP CLICKING ON A MINE!!!',3,'2010-08-09 10:55:27');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `Transaction_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Email` varchar(45) NOT NULL,
  `Transaction_Date` datetime NOT NULL,
  PRIMARY KEY (`Transaction_ID`),
  KEY `fk_Transaction_Member1_idx` (`Email`),
  CONSTRAINT `fk_Transaction_Member1` FOREIGN KEY (`Email`) REFERENCES `member` (`Email`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,'tsekinping2010@gmail.com','2016-06-30 12:05:34');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_details`
--

DROP TABLE IF EXISTS `transaction_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_details` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Transaction_ID` int(11) NOT NULL,
  `Game_ID` int(11) NOT NULL,
  `Quantity_Bought` int(11) NOT NULL,
  PRIMARY KEY (`ID`,`Transaction_ID`),
  KEY `fk_Transaction_Details_Transaction1_idx` (`Transaction_ID`),
  KEY `fk_Transaction_Details_Game1_idx` (`Game_ID`),
  CONSTRAINT `fk_Transaction_Details_Game1` FOREIGN KEY (`Game_ID`) REFERENCES `game` (`Game_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Transaction_Details_Transaction1` FOREIGN KEY (`Transaction_ID`) REFERENCES `transaction` (`Transaction_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_details`
--

LOCK TABLES `transaction_details` WRITE;
/*!40000 ALTER TABLE `transaction_details` DISABLE KEYS */;
INSERT INTO `transaction_details` VALUES (1,1,1,9),(2,1,8,6),(3,1,9,4);
/*!40000 ALTER TABLE `transaction_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-18 10:43:11
