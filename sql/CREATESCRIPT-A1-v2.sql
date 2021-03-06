SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`City`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`City` ;

CREATE TABLE IF NOT EXISTS `mydb`.`City` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Province`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Province` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Province` (
  `province_id` INT NOT NULL AUTO_INCREMENT,
  `city_id` INT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`province_id`),
  CONSTRAINT `province_to_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `mydb`.`City` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Country` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Country` (
  `country_id` INT NOT NULL,
  `province_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`country_id`),
  CONSTRAINT `location_to_province`
    FOREIGN KEY (`province_id`)
    REFERENCES `mydb`.`Province` (`province_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Manager` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Manager` (
  `idManager` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idManager`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Store`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Store` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Store` (
  `store_id` INT NOT NULL AUTO_INCREMENT,
  `manager_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`store_id`),
  CONSTRAINT `store_to_location`
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`Country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `store_to_manager`
    FOREIGN KEY (`manager_id`)
    REFERENCES `mydb`.`Manager` (`idManager`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(45) NOT NULL,
  `dob` INT NOT NULL,
  `sex` BIT NOT NULL COMMENT '0 for Male or 1 for Female\n',
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Product` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NULL,
  `price` FLOAT NULL,
  `initialcost` FLOAT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProductGroup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ProductGroup` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ProductGroup` (
  `productGroup_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NULL,
  `product_id` INT NULL,
  PRIMARY KEY (`productGroup_id`),
  CONSTRAINT `ProductGroup_To_Product`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`Product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Day`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Day` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Day` (
  `idDay` INT NOT NULL,
  `value` VARCHAR(45) NULL,
  PRIMARY KEY (`idDay`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Month`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Month` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Month` (
  `idMonth` INT NOT NULL,
  `day_id` INT NOT NULL,
  `value` VARCHAR(45) NULL,
  PRIMARY KEY (`idMonth`),
  CONSTRAINT `month_to_day`
    FOREIGN KEY (`day_id`)
    REFERENCES `mydb`.`Day` (`idDay`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Year` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Year` (
  `idYear` INT NOT NULL,
  `value` INT NULL,
  `month_id` INT NULL,
  PRIMARY KEY (`idYear`),
  CONSTRAINT `year_to_month`
    FOREIGN KEY (`month_id`)
    REFERENCES `mydb`.`Month` (`idMonth`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Sales` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Sales` (
  `sale_id` INT NOT NULL AUTO_INCREMENT,
  `store_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `productgroup_id` INT NOT NULL,
  `qty` INT NOT NULL,
  `time_year_id` INT NOT NULL,
  PRIMARY KEY (`sale_id`),
  CONSTRAINT `sales_to_store`
    FOREIGN KEY (`store_id`)
    REFERENCES `mydb`.`Store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sales_to_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sales_to_product`
    FOREIGN KEY (`productgroup_id`)
    REFERENCES `mydb`.`ProductGroup` (`productGroup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sale_to_timeyear`
    FOREIGN KEY (`time_year_id`)
    REFERENCES `mydb`.`Year` (`idYear`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AgeGroup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`AgeGroup` ;

CREATE TABLE IF NOT EXISTS `mydb`.`AgeGroup` (
  `ageGroup_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `begin` INT NULL,
  `end` INT NULL,
  PRIMARY KEY (`ageGroup_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Account` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Account` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sortOrder` BIT NULL,
  `typeId` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Payee` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Payee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Category` (
  `id` INT NOT NULL,
  `term` VARCHAR(45) NULL,
  `descr` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AccntType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`AccntType` ;

CREATE TABLE IF NOT EXISTS `mydb`.`AccntType` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `term` VARCHAR(45) NULL,
  `descr` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `term_UNIQUE` (`term` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Trade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Trade` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Trade` (
  `id` INT NOT NULL,
  `accntid` VARCHAR(45) NULL,
  `tdate` VARCHAR(45) NULL,
  `number` VARCHAR(45) NULL,
  `payeeid` VARCHAR(45) NULL,
  `payment` VARCHAR(45) NULL,
  `deposit` VARCHAR(45) NULL,
  `recon` VARCHAR(45) NULL,
  `catId` VARCHAR(45) NULL,
  `memo` VARCHAR(45) NULL,
  `txtfrId` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Loan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Loan` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Loan` (
  `id` INT NOT NULL,
  `lenderid` VARCHAR(45) NULL,
  `principal` VARCHAR(45) NULL,
  `apr` VARCHAR(45) NULL,
  `years` VARCHAR(45) NULL,
  `freqid` VARCHAR(45) NULL,
  `firstDate` VARCHAR(45) NULL,
  `escrow` VARCHAR(45) NULL,
  `extraPrinc` VARCHAR(45) NULL,
  `payment` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recurring`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Recurring` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Recurring` (
  `id` INT NOT NULL,
  `accntid` VARCHAR(45) NULL,
  `freqid` VARCHAR(45) NULL,
  `nextDate` VARCHAR(45) NULL,
  `typeid` VARCHAR(45) NULL,
  `payeeid` VARCHAR(45) NULL,
  `payment` VARCHAR(45) NULL,
  `deposit` VARCHAR(45) NULL,
  `catid` VARCHAR(45) NULL,
  `memo` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TransType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TransType` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TransType` (
  `id` INT NOT NULL,
  `term` VARCHAR(45) NULL,
  `descr` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Void`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Void` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Void` (
  `id` INT NOT NULL,
  `payeeid` VARCHAR(45) NULL,
  `payment` VARCHAR(45) NULL,
  `deposit` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Contact` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Contact` (
  `id` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `street1` VARCHAR(45) NULL,
  `street2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `stateid` VARCHAR(45) NULL,
  `zip` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Website`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Website` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Website` (
  `id` INT NOT NULL,
  `uri` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `other` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`State`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`State` ;

CREATE TABLE IF NOT EXISTS `mydb`.`State` (
  `id` INT NOT NULL,
  `abbrev` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Frequency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Frequency` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Frequency` (
  `id` INT NOT NULL,
  `term` VARCHAR(45) NULL,
  `descr` VARCHAR(45) NULL,
  `days` VARCHAR(45) NULL,
  `simpBudgetQuery` VARCHAR(45) NULL,
  `cplxBudgetQuery` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PopulationByYearByProvince`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PopulationByYearByProvince` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PopulationByYearByProvince` (
  `idPopulationByYearByProvince` INT NOT NULL AUTO_INCREMENT,
  `province` VARCHAR(45) NOT NULL,
  `year09` INT NOT NULL,
  `year10` INT NOT NULL,
  `year11` INT NOT NULL,
  `year12` INT NOT NULL,
  `year13` INT NOT NULL,
  PRIMARY KEY (`idPopulationByYearByProvince`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OntarioTopBabyNames`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`OntarioTopBabyNames` ;

CREATE TABLE IF NOT EXISTS `mydb`.`OntarioTopBabyNames` (
  `idOntarioTopBabyNames` INT NOT NULL AUTO_INCREMENT,
  `year` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `frequency` INT NOT NULL,
  `gender` BIT NOT NULL,
  PRIMARY KEY (`idOntarioTopBabyNames`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LifeExpectency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`LifeExpectency` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LifeExpectency` (
  `idLifeExpectency` INT NOT NULL AUTO_INCREMENT,
  `year_from` INT NOT NULL,
  `year_to` INT NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `male_count` INT NOT NULL,
  `female_count` INT NOT NULL,
  PRIMARY KEY (`idLifeExpectency`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`ProductGroup`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`ProductGroup` (`productGroup_id`, `product_name`, `product_id`) VALUES (1, 'Personalized Golf Clubs', NULL);
INSERT INTO `mydb`.`ProductGroup` (`productGroup_id`, `product_name`, `product_id`) VALUES (2, 'Magnets', NULL);
INSERT INTO `mydb`.`ProductGroup` (`productGroup_id`, `product_name`, `product_id`) VALUES (3, 'Bedroom Door Signs', NULL);
INSERT INTO `mydb`.`ProductGroup` (`productGroup_id`, `product_name`, `product_id`) VALUES (4, 'Graduation Plaques', NULL);
INSERT INTO `mydb`.`ProductGroup` (`productGroup_id`, `product_name`, `product_id`) VALUES (5, 'Bedroom Door Signs', NULL);
INSERT INTO `mydb`.`ProductGroup` (`productGroup_id`, `product_name`, `product_id`) VALUES (6, 'Retirement Plaques', NULL);
INSERT INTO `mydb`.`ProductGroup` (`productGroup_id`, `product_name`, `product_id`) VALUES (7, 'Sports Jersey', NULL);
INSERT INTO `mydb`.`ProductGroup` (`productGroup_id`, `product_name`, `product_id`) VALUES (8, 'Custom License Plates', NULL);

COMMIT;

