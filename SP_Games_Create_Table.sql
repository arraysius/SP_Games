-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sp_games
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sp_games` ;

-- -----------------------------------------------------
-- Schema sp_games
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sp_games` DEFAULT CHARACTER SET utf8 ;
USE `sp_games` ;

-- -----------------------------------------------------
-- Table `sp_games`.`Publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sp_games`.`Publisher` ;

CREATE TABLE IF NOT EXISTS `sp_games`.`Publisher` (
  `Publisher_ID` INT NOT NULL AUTO_INCREMENT,
  `Publisher_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Publisher_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sp_games`.`Developer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sp_games`.`Developer` ;

CREATE TABLE IF NOT EXISTS `sp_games`.`Developer` (
  `Developer_ID` INT NOT NULL AUTO_INCREMENT,
  `Developer_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Developer_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sp_games`.`Game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sp_games`.`Game` ;

CREATE TABLE IF NOT EXISTS `sp_games`.`Game` (
  `Game_ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(100) NOT NULL,
  `Developer_ID` INT NOT NULL,
  `Publisher_ID` INT NOT NULL,
  `Release_Date` DATE NOT NULL,
  `Description` VARCHAR(5000) NOT NULL,
  `Price` DOUBLE NOT NULL,
  `Preowned` CHAR(1) NOT NULL,
  `Quantity` INT NOT NULL,
  `Image_Path` VARCHAR(1000) NULL,
  PRIMARY KEY (`Game_ID`, `Developer_ID`, `Publisher_ID`),
  INDEX `fk_Game_Publisher_idx` (`Publisher_ID` ASC),
  INDEX `fk_Game_Developer_idx` (`Developer_ID` ASC),
  CONSTRAINT `fk_Game_Publisher`
    FOREIGN KEY (`Publisher_ID`)
    REFERENCES `sp_games`.`Publisher` (`Publisher_ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Game_Developer`
    FOREIGN KEY (`Developer_ID`)
    REFERENCES `sp_games`.`Developer` (`Developer_ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sp_games`.`Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sp_games`.`Genre` ;

CREATE TABLE IF NOT EXISTS `sp_games`.`Genre` (
  `Genre_ID` INT NOT NULL AUTO_INCREMENT,
  `Genre_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Genre_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sp_games`.`Review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sp_games`.`Review` ;

CREATE TABLE IF NOT EXISTS `sp_games`.`Review` (
  `Review_ID` INT NOT NULL AUTO_INCREMENT,
  `Game_ID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Comment` VARCHAR(5000) NOT NULL,
  `Rating` INT NOT NULL,
  `Review_Date` DATETIME NOT NULL,
  PRIMARY KEY (`Review_ID`, `Game_ID`),
  INDEX `fk_Review_Game_idx` (`Game_ID` ASC),
  CONSTRAINT `fk_Review_Game`
    FOREIGN KEY (`Game_ID`)
    REFERENCES `sp_games`.`Game` (`Game_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sp_games`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sp_games`.`Account` ;

CREATE TABLE IF NOT EXISTS `sp_games`.`Account` (
  `Email` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Password` CHAR(64) NOT NULL,
  `Secret_Key` CHAR(64) NOT NULL,
  `isAdmin` CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sp_games`.`Game_Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sp_games`.`Game_Genre` ;

CREATE TABLE IF NOT EXISTS `sp_games`.`Game_Genre` (
  `Game_ID` INT NOT NULL,
  `Genre_ID` INT NOT NULL,
  PRIMARY KEY (`Game_ID`, `Genre_ID`),
  INDEX `fk_Game_Genre_Genre_ID_idx` (`Genre_ID` ASC),
  INDEX `fk_Game_Genre_Game_ID_idx` (`Game_ID` ASC),
  CONSTRAINT `fk_Game_Genre_Game_ID`
    FOREIGN KEY (`Game_ID`)
    REFERENCES `sp_games`.`Game` (`Game_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Game_Genre_Genre_ID`
    FOREIGN KEY (`Genre_ID`)
    REFERENCES `sp_games`.`Genre` (`Genre_ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sp_games`.`Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sp_games`.`Member` ;

CREATE TABLE IF NOT EXISTS `sp_games`.`Member` (
  `Email` VARCHAR(45) NOT NULL,
  `Phone_Number` INT NOT NULL,
  `Address1` VARCHAR(100) NOT NULL,
  `Address2` VARCHAR(100) NULL,
  `Postal_Code` INT NOT NULL,
  PRIMARY KEY (`Email`),
  CONSTRAINT `fk_Member_Account1`
    FOREIGN KEY (`Email`)
    REFERENCES `sp_games`.`Account` (`Email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sp_games`.`Transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sp_games`.`Transaction` ;

CREATE TABLE IF NOT EXISTS `sp_games`.`Transaction` (
  `Transaction_ID` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(45) NOT NULL,
  `Transaction_Date` DATETIME NOT NULL,
  PRIMARY KEY (`Transaction_ID`),
  INDEX `fk_Transaction_Member1_idx` (`Email` ASC),
  CONSTRAINT `fk_Transaction_Member1`
    FOREIGN KEY (`Email`)
    REFERENCES `sp_games`.`Member` (`Email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sp_games`.`Transaction_Details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sp_games`.`Transaction_Details` ;

CREATE TABLE IF NOT EXISTS `sp_games`.`Transaction_Details` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Transaction_ID` INT NOT NULL,
  `Game_ID` INT NOT NULL,
  `Quantity_Bought` INT NOT NULL,
  PRIMARY KEY (`ID`, `Transaction_ID`),
  INDEX `fk_Transaction_Details_Transaction1_idx` (`Transaction_ID` ASC),
  INDEX `fk_Transaction_Details_Game1_idx` (`Game_ID` ASC),
  CONSTRAINT `fk_Transaction_Details_Transaction1`
    FOREIGN KEY (`Transaction_ID`)
    REFERENCES `sp_games`.`Transaction` (`Transaction_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Transaction_Details_Game1`
    FOREIGN KEY (`Game_ID`)
    REFERENCES `sp_games`.`Game` (`Game_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
