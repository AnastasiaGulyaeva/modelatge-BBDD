-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `idAddress` INT(11) NOT NULL,
  `street` VARCHAR(30) NOT NULL,
  `number` INT(11) NOT NULL,
  `floor` INT(11) NULL DEFAULT NULL,
  `door` INT(11) NULL DEFAULT NULL,
  `city` VARCHAR(15) NOT NULL,
  `zipCode` INT(11) NOT NULL,
  `country` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idAddress`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`client` (
  `idClient` INT(11) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `registrationDate` DATE NOT NULL,
  `recommendation` VARCHAR(100) NULL DEFAULT NULL,
  `Address_idAddress` INT(11) NOT NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE INDEX `e-mail_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_Client_Address1_idx` (`Address_idAddress` ASC) VISIBLE,
  CONSTRAINT `fk_Client_Address1`
    FOREIGN KEY (`Address_idAddress`)
    REFERENCES `mydb`.`address` (`idAddress`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`typeofmount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`typeofmount` (
  `idTypeOfMount` INT(11) NOT NULL,
  `type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idTypeOfMount`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`eyeglasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`eyeglasses` (
  `idEyeGlasses` INT(11) NOT NULL,
  `brand` VARCHAR(20) NOT NULL,
  `graduationRight` VARCHAR(10) NOT NULL,
  `graduationLeft` VARCHAR(10) NOT NULL,
  `price` FLOAT NOT NULL,
  `colourOfMount` VARCHAR(10) NOT NULL,
  `colourOfGlass` VARCHAR(10) NOT NULL,
  `TypeOfMount_idTypeOfMount` INT(11) NOT NULL,
  PRIMARY KEY (`idEyeGlasses`),
  INDEX `fk_EyeGlasses_TypeOfMount_idx` (`TypeOfMount_idTypeOfMount` ASC) VISIBLE,
  CONSTRAINT `fk_EyeGlasses_TypeOfMount`
    FOREIGN KEY (`TypeOfMount_idTypeOfMount`)
    REFERENCES `mydb`.`typeofmount` (`idTypeOfMount`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`provider` (
  `idProvider` INT(11) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `telephone` INT(11) NOT NULL,
  `fax` INT(11) NOT NULL,
  `nif` INT(11) NOT NULL,
  `Address_idAddress` INT(11) NOT NULL,
  `EyeGlasses_idEyeGlasses` INT(11) NOT NULL,
  PRIMARY KEY (`idProvider`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `telephone_UNIQUE` (`telephone` ASC) VISIBLE,
  UNIQUE INDEX `fax_UNIQUE` (`fax` ASC) VISIBLE,
  UNIQUE INDEX `NIF_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `fk_Provider_Address1_idx` (`Address_idAddress` ASC) VISIBLE,
  INDEX `fk_Provider_EyeGlasses1_idx` (`EyeGlasses_idEyeGlasses` ASC) VISIBLE,
  CONSTRAINT `fk_Provider_Address1`
    FOREIGN KEY (`Address_idAddress`)
    REFERENCES `mydb`.`address` (`idAddress`),
  CONSTRAINT `fk_Provider_EyeGlasses1`
    FOREIGN KEY (`EyeGlasses_idEyeGlasses`)
    REFERENCES `mydb`.`eyeglasses` (`idEyeGlasses`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`sell`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sell` (
  `idSell` INT(11) NOT NULL,
  `totalPrice` FLOAT NOT NULL,
  `Client_idClient` INT(11) NOT NULL,
  `Provider_idProvider` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  PRIMARY KEY (`idSell`),
  INDEX `fk_Sell_Client1_idx` (`Client_idClient` ASC) VISIBLE,
  INDEX `fk_Sell_Provider1_idx` (`Provider_idProvider` ASC) VISIBLE,
  CONSTRAINT `fk_Sell_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `mydb`.`client` (`idClient`),
  CONSTRAINT `fk_Sell_Provider1`
    FOREIGN KEY (`Provider_idProvider`)
    REFERENCES `mydb`.`provider` (`idProvider`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
