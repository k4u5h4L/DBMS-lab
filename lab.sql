-- MariaDB dump 10.17  Distrib 10.4.14-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: labDBMS
-- ------------------------------------------------------
-- Server version	10.4.14-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `customerID` int(6) NOT NULL,
  `customertype` varchar(12) NOT NULL,
  `customername` varchar(20) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `spouse` int(6) NOT NULL,
  `emailID` varchar(30) NOT NULL,
  `mobileno` int(10) NOT NULL,
  `rescontactno` int(10) DEFAULT NULL,
  `workcontactno` int(10) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customerID`),
  KEY `spouse` (`spouse`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`spouse`) REFERENCES `customer` (`customerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `empid` int(10) NOT NULL,
  `empname` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `designation` varchar(20) NOT NULL,
  `emailID` varchar(30) DEFAULT NULL,
  `contactno` int(10) NOT NULL,
  `worksin` varchar(6) NOT NULL,
  `salary` int(20) NOT NULL,
  PRIMARY KEY (`empid`),
  KEY `worksin` (`worksin`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`worksin`) REFERENCES `retailoutlet` (`retailoutletID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inwarditem`
--

DROP TABLE IF EXISTS `inwarditem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inwarditem` (
  `orderID` varchar(6) NOT NULL,
  `inwarddate` date NOT NULL,
  `inwardqty` int(5) DEFAULT NULL,
  PRIMARY KEY (`orderID`,`inwarddate`),
  CONSTRAINT `inwarditem_ibfk_1` FOREIGN KEY (`orderID`) REFERENCES `orderstatus` (`orderid`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`inwardqty` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inwarditem`
--

LOCK TABLES `inwarditem` WRITE;
/*!40000 ALTER TABLE `inwarditem` DISABLE KEYS */;
/*!40000 ALTER TABLE `inwarditem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `itemcode` varchar(6) NOT NULL,
  `itemtype` varchar(100) NOT NULL,
  `description` varchar(30) NOT NULL,
  `price` int(20) NOT NULL,
  `reorderlevel` int(5) NOT NULL,
  `quantityonhand` int(10) NOT NULL,
  `category` varchar(1) NOT NULL,
  PRIMARY KEY (`itemcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderstatus`
--

DROP TABLE IF EXISTS `orderstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderstatus` (
  `orderID` varchar(6) NOT NULL,
  `quotationID` varchar(6) NOT NULL,
  `qtyordered` int(5) DEFAULT NULL,
  `orderdate` date NOT NULL,
  `status` varchar(20) NOT NULL,
  `paymentdate` date DEFAULT NULL,
  `amountpaid` int(5) NOT NULL,
  `paymentmode` varchar(20) NOT NULL,
  PRIMARY KEY (`orderID`),
  KEY `quotationID` (`quotationID`),
  CONSTRAINT `orderstatus_ibfk_1` FOREIGN KEY (`quotationID`) REFERENCES `quotation` (`quotationID`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`qtyordered` > 0),
  CONSTRAINT `CONSTRAINT_2` CHECK (`status` in ('Ordered','Partial','Delivery','Delivered')),
  CONSTRAINT `CONSTRAINT_3` CHECK (`paymentmode` in ('Cash','Cheque'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderstatus`
--

LOCK TABLES `orderstatus` WRITE;
/*!40000 ALTER TABLE `orderstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotation`
--

DROP TABLE IF EXISTS `quotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotation` (
  `quotationID` varchar(6) NOT NULL,
  `supplierID` varchar(6) NOT NULL,
  `itemcode` varchar(3) DEFAULT NULL,
  `quotedprice` int(5) DEFAULT NULL,
  `quotationdate` date NOT NULL,
  `quotationstatus` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`quotationID`),
  KEY `supplierID` (`supplierID`),
  KEY `itemcode` (`itemcode`),
  CONSTRAINT `quotation_ibfk_1` FOREIGN KEY (`supplierID`) REFERENCES `supplier` (`Supplier_ID`),
  CONSTRAINT `quotation_ibfk_2` FOREIGN KEY (`itemcode`) REFERENCES `item` (`itemcode`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`quotationstatus` in ('Accepted','Rejected','Closed'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotation`
--

LOCK TABLES `quotation` WRITE;
/*!40000 ALTER TABLE `quotation` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retailoutlet`
--

DROP TABLE IF EXISTS `retailoutlet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retailoutlet` (
  `retailoutletID` varchar(6) NOT NULL,
  `retailoutletlocation` varchar(30) NOT NULL,
  `retailoutletmanagerid` int(5) NOT NULL,
  PRIMARY KEY (`retailoutletID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retailoutlet`
--

LOCK TABLES `retailoutlet` WRITE;
/*!40000 ALTER TABLE `retailoutlet` DISABLE KEYS */;
/*!40000 ALTER TABLE `retailoutlet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier` (
  `Supplier_ID` varchar(6) NOT NULL,
  `Supplier_Name` varchar(30) NOT NULL,
  `Supplier_ContactNo` varchar(15) NOT NULL,
  `Supplier_MailID` varchar(30) NOT NULL,
  PRIMARY KEY (`Supplier_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES ('100001','Supplier A','9747389205','supplierA@gmail.com'),('100002','Supplier B','9519389623','supplierB@hotmail.com'),('100003','Supplier C','9878101202','supplierC@yahoo.com'),('100004','Supplier D','9107259898','supplierD@gmail.com'),('100005','Supplier E','8321389234','supplierE@hotmail.com');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `x` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-21 11:52:45
