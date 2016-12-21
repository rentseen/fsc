-- MySQL Script generated by MySQL Workbench
-- 2016年12月08日 星期四 13时50分48秒
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `ClientDatabase`.`StockInformation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClientDatabase`.`StockInformation` (
  `Timestamp` DATE NOT NULL,
  `Price` FLOAT NULL,
  `Quantity` FLOAT NULL,
  `High` FLOAT NULL,
  `Low` FLOAT NULL,
  PRIMARY KEY (`Timestamp`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClientDatabase`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClientDatabase`.`Order` (
  `OrderID` VARCHAR(45) NOT NULL,
  `TransactionTime` DATE NULL,
  `Side` INT NULL,
  `OrderType` INT NULL,
  `OrderPrice` FLOAT NULL,
  `OrderQuantity` FLOAT NULL,
  `LastStatus` INT NULL,
  `MaturityDate` DATE NULL,
  `QuantityFilled` FLOAT NULL,
  `AveragePrice` FLOAT NULL,
  PRIMARY KEY (`OrderID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClientDatabase`.`OrderResult`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClientDatabase`.`OrderResult` (
  `OrderID` VARCHAR(45) NOT NULL,
  `OrderTransactionTime` DATE NULL,
  `ResultTime` DATE NULL,
  `Quantity` FLOAT NULL,
  `Price` FLOAT NULL,
  PRIMARY KEY (`OrderID`),
  CONSTRAINT `OrderID`
    FOREIGN KEY (`OrderID`)
    REFERENCES `ClientDatabase`.`Order` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

