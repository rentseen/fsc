-- MySQL Script generated by MySQL Workbench
-- 2016年11月24日 星期四 18时39分13秒
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `ServerDatabase`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServerDatabase`.`Stock` (
  `Ticker` VARCHAR(6) NOT NULL,
  `CompanyName` VARCHAR(45) NULL,
  `LotSize` INT NULL,
  `TickSize` DECIMAL(20,2) NULL,
  `TotalVolume` FLOAT NULL,
  PRIMARY KEY (`Ticker`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServerDatabase`.`AccountRole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServerDatabase`.`AccountRole` (
  `RoleID` INT NOT NULL,
  `RoleName` VARCHAR(15) NULL,
  PRIMARY KEY (`RoleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServerDatabase`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServerDatabase`.`Account` (
  `CompanyID` VARCHAR(20) NOT NULL,
  `CompanyName` VARCHAR(30) NULL,
  `Password` VARCHAR(45) NULL,
  `RoleID` INT NULL,
  PRIMARY KEY (`CompanyID`),
  INDEX `fk_Account_AccountRole_idx` (`RoleID` ASC),
  CONSTRAINT `fk_Account_AccountRole`
    FOREIGN KEY (`RoleID`)
    REFERENCES `ServerDatabase`.`AccountRole` (`RoleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServerDatabase`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServerDatabase`.`Order` (
  `ClientOrderID` VARCHAR(45) NOT NULL,
  `Account_CompanyID` VARCHAR(20) NOT NULL,
  `ReceivedDate` DATE NOT NULL,
  `HandlingInstruction` INT NULL,
  `Stock_Ticker` VARCHAR(6) NULL,
  `Side` INT NULL,
  `MaturityDate` DATE NULL,
  `OrderType` INT NULL,
  `OrderQuantity` FLOAT NULL,
  `CashOrderQuantity` DECIMAL(2) NULL,
  `Price` FLOAT NULL,
  `LastStatus` INT NULL,
  `MsgSeqNum` INT NULL,
  `OnBehalfOfCompanyID` VARCHAR(45) NULL,
  `SenderSubID` VARCHAR(45) NULL,
  PRIMARY KEY (`ClientOrderID`, `Account_CompanyID`, `ReceivedDate`),
  INDEX `fk_Order_Stock1_idx` (`Stock_Ticker` ASC),
  INDEX `fk_Order_Account1_idx` (`Account_CompanyID` ASC),
  CONSTRAINT `fk_Order_Stock1`
    FOREIGN KEY (`Stock_Ticker`)
    REFERENCES `ServerDatabase`.`Stock` (`Ticker`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Account1`
    FOREIGN KEY (`Account_CompanyID`)
    REFERENCES `ServerDatabase`.`Account` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServerDatabase`.`OrderExecution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServerDatabase`.`OrderExecution` (
  `ExecutionID` INT NOT NULL AUTO_INCREMENT,
  `OrderExecutionQuantity` FLOAT NULL,
  `OrderExecutionPrice` FLOAT NULL,
  `ExecutionTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `MsgSeqNum` INT NULL,
  `Order_BuyClientOrderID` VARCHAR(45) NOT NULL,
  `Order_BuyCompanyID` VARCHAR(20) NOT NULL,
  `Order_BuyReceivedDate` DATE NOT NULL,
  `Order_SellClientOrderID` VARCHAR(45) NOT NULL,
  `Order_SellCompanyID` VARCHAR(20) NOT NULL,
  `Order_SellReceivedDate` DATE NOT NULL,
  PRIMARY KEY (`ExecutionID`),
  INDEX `fk_OrderExecution_Order1_idx` (`Order_BuyClientOrderID` ASC, `Order_BuyCompanyID` ASC, `Order_BuyReceivedDate` ASC),
  INDEX `fk_OrderExecution_Order2_idx` (`Order_SellClientOrderID` ASC, `Order_SellCompanyID` ASC, `Order_SellReceivedDate` ASC),
  CONSTRAINT `fk_OrderExecution_Order1`
    FOREIGN KEY (`Order_BuyClientOrderID` , `Order_BuyCompanyID` , `Order_BuyReceivedDate`)
    REFERENCES `ServerDatabase`.`Order` (`ClientOrderID` , `Account_CompanyID` , `ReceivedDate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderExecution_Order2`
    FOREIGN KEY (`Order_SellClientOrderID` , `Order_SellCompanyID` , `Order_SellReceivedDate`)
    REFERENCES `ServerDatabase`.`Order` (`ClientOrderID` , `Account_CompanyID` , `ReceivedDate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServerDatabase`.`OrderCancel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServerDatabase`.`OrderCancel` (
  `Side` INT NULL,
  `ReceivedTime` TIMESTAMP NULL,
  `LastStatus` INT NULL,
  `MsgSeqNum` INT NULL,
  `Order_ClientOrderID` VARCHAR(45) NOT NULL,
  `Order_Account_CompanyID` VARCHAR(20) NOT NULL,
  `Order_ReceivedDate` DATE NOT NULL,
  `OrderCancelID` VARCHAR(45) NOT NULL,
  `CancelQuantity` VARCHAR(45) BINARY NULL,
  `ExecutionTime` TIMESTAMP NULL,
  PRIMARY KEY (`OrderCancelID`),
  CONSTRAINT `fk_OrderCancel_Order1`
    FOREIGN KEY (`Order_ClientOrderID` , `Order_Account_CompanyID` , `Order_ReceivedDate`)
    REFERENCES `ServerDatabase`.`Order` (`ClientOrderID` , `Account_CompanyID` , `ReceivedDate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServerDatabase`.`Session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServerDatabase`.`Session` (
  `SessionID` INT NOT NULL AUTO_INCREMENT,
  `Account_UserID` VARCHAR(20) NOT NULL,
  `BeginOfSession` TIMESTAMP NULL,
  PRIMARY KEY (`SessionID`),
  INDEX `fk_Sessions_Account1_idx` (`Account_UserID` ASC),
  CONSTRAINT `fk_Sessions_Account1`
    FOREIGN KEY (`Account_UserID`)
    REFERENCES `ServerDatabase`.`Account` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
