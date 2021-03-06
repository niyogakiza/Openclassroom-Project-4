-- MySQL Script generated by MySQL Workbench
-- Fri Nov  3 14:47:21 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
SET sql_notes = 0;

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
  `id` INT(10) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `house_number` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `customers_id` INT(10) NOT NULL,
  `complementary` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_address_customers2_idx` (`customers_id` ASC),
  CONSTRAINT `fk_address_customers2`
    FOREIGN KEY (`customers_id`)
    REFERENCES `mydb`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `id` INT(10) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `main_address_id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customers_address1_idx` (`main_address_id` ASC),
  CONSTRAINT `fk_customers_address1`
    FOREIGN KEY (`main_address_id`)
    REFERENCES `mydb`.`address` (`customers_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`delivery_team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`delivery_team` (
  `id` INT(10) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dish` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `price` DECIMAL NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`menu` (
  `id` INT(10) NOT NULL,
  `date` DATE NOT NULL,
  `dish_1_id` INT(10) NOT NULL,
  `dish_2_id` INT(10) NOT NULL,
  `dessert_1_id` INT(10) NOT NULL,
  `dessert_2_id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_menu_dish1_idx` (`dish_1_id` ASC),
  INDEX `fk_menu_dish2_idx` (`dish_2_id` ASC),
  INDEX `fk_menu_dish3_idx` (`dessert_1_id` ASC),
  INDEX `fk_menu_dish4_idx` (`dessert_2_id` ASC),
  CONSTRAINT `fk_menu_dish1`
    FOREIGN KEY (`dish_1_id`)
    REFERENCES `mydb`.`dish` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_dish2`
    FOREIGN KEY (`dish_2_id`)
    REFERENCES `mydb`.`dish` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_dish3`
    FOREIGN KEY (`dessert_1_id`)
    REFERENCES `mydb`.`dish` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_dish4`
    FOREIGN KEY (`dessert_2_id`)
    REFERENCES `mydb`.`dish` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `id` INT(10) NOT NULL,
  `customers_id` INT(10) NOT NULL,
  `delivery_team_id` INT NULL,
  `menu_id` INT(10) NOT NULL,
  `address_id` INT(10) NOT NULL,
  `order_date_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orders_customers1_idx` (`customers_id` ASC),
  INDEX `fk_orders_delivery_team1_idx` (`delivery_team_id` ASC),
  INDEX `fk_orders_menu1_idx` (`menu_id` ASC),
  INDEX `fk_orders_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `mydb`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_delivery_team1`
    FOREIGN KEY (`delivery_team_id`)
    REFERENCES `mydb`.`delivery_team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_menu1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `mydb`.`menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orders_has_dish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orders_has_dish` (
  `orders_id` INT(10) NOT NULL,
  `dish_id` INT(10) NOT NULL,
  PRIMARY KEY (`orders_id`, `dish_id`),
  INDEX `fk_orders_has_dish_dish1_idx` (`dish_id` ASC),
  INDEX `fk_orders_has_dish_orders1_idx` (`orders_id` ASC),
  CONSTRAINT `fk_orders_has_dish_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `mydb`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_dish_dish1`
    FOREIGN KEY (`dish_id`)
    REFERENCES `mydb`.`dish` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
