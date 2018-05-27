-- MySQL Script generated by MySQL Workbench
-- Sat 26 May 2018 08:41:22 PM -03
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema unamectf
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `unamectf` ;

-- -----------------------------------------------------
-- Schema unamectf
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `unamectf` DEFAULT CHARACTER SET utf8 ;
USE `unamectf` ;

-- -----------------------------------------------------
-- Table `unamectf`.`team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unamectf`.`team` ;

CREATE TABLE IF NOT EXISTS `unamectf`.`team` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(64) NOT NULL,
  `tag` VARCHAR(5) NULL,
  `token` CHAR(32) NULL,
  `avatar` VARCHAR(128) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `unamectf`.`permissao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unamectf`.`permissao` ;

CREATE TABLE IF NOT EXISTS `unamectf`.`permissao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `permissao` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `permissao_UNIQUE` (`permissao` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `unamectf`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unamectf`.`users` ;

CREATE TABLE IF NOT EXISTS `unamectf`.`users` (
  `id` CHAR(32) NOT NULL,
  `nickname` VARCHAR(64) NOT NULL,
  `email` VARCHAR(128) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  `remember_token` VARCHAR(100) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `avatar` VARCHAR(128) NULL,
  `categoria_favorita` VARCHAR(64) NULL,
  `capitao` TINYINT(1) NULL,
  `team_id` INT NULL,
  `permissao_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_team1_idx` (`team_id` ASC),
  INDEX `fk_users_permissao1_idx` (`permissao_id` ASC),
  CONSTRAINT `fk_users_team1`
    FOREIGN KEY (`team_id`)
    REFERENCES `unamectf`.`team` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_permissao1`
    FOREIGN KEY (`permissao_id`)
    REFERENCES `unamectf`.`permissao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `unamectf`.`maestrias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unamectf`.`maestrias` ;

CREATE TABLE IF NOT EXISTS `unamectf`.`maestrias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `maestria` VARCHAR(60) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `modificado_por` VARCHAR(64) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `unamectf`.`maestria_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unamectf`.`maestria_users` ;

CREATE TABLE IF NOT EXISTS `unamectf`.`maestria_users` (
  `users_id` CHAR(32) NOT NULL,
  `maestrias_id` INT NOT NULL,
  INDEX `fk_users_has_maestrias_maestrias1_idx` (`maestrias_id` ASC),
  INDEX `fk_users_has_maestrias_users_idx` (`users_id` ASC),
  PRIMARY KEY (`users_id`, `maestrias_id`),
  CONSTRAINT `fk_users_has_maestrias_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `unamectf`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_maestrias_maestrias1`
    FOREIGN KEY (`maestrias_id`)
    REFERENCES `unamectf`.`maestrias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `unamectf`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unamectf`.`categories` ;

CREATE TABLE IF NOT EXISTS `unamectf`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(64) NOT NULL,
  `descricao` VARCHAR(2048) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `color` VARCHAR(7) NOT NULL,
  `modificado_por` VARCHAR(64) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `unamectf`.`challenges`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unamectf`.`challenges` ;

CREATE TABLE IF NOT EXISTS `unamectf`.`challenges` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(64) NOT NULL,
  `pontos` INT NOT NULL,
  `enunciado` VARCHAR(8192) NOT NULL,
  `autor` VARCHAR(64) NULL,
  `flag` VARCHAR(128) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `disponivel` TINYINT(1) NOT NULL,
  `categories_id` INT NOT NULL,
  `modificado_por` VARCHAR(64) NULL,
  PRIMARY KEY (`id`, `categories_id`),
  INDEX `fk_challenges_categories1_idx` (`categories_id` ASC),
  CONSTRAINT `fk_challenges_categories1`
    FOREIGN KEY (`categories_id`)
    REFERENCES `unamectf`.`categories` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `unamectf`.`challenges_resolvidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unamectf`.`challenges_resolvidos` ;

CREATE TABLE IF NOT EXISTS `unamectf`.`challenges_resolvidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` CHAR(32) NOT NULL,
  `challenges_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`, `users_id`, `challenges_id`),
  INDEX `fk_users_has_challenges_challenges1_idx` (`challenges_id` ASC),
  INDEX `fk_users_has_challenges_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_users_has_challenges_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `unamectf`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_challenges_challenges1`
    FOREIGN KEY (`challenges_id`)
    REFERENCES `unamectf`.`challenges` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `unamectf`.`hints`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unamectf`.`hints` ;

CREATE TABLE IF NOT EXISTS `unamectf`.`hints` (
  `id` INT NOT NULL,
  `autor` VARCHAR(64) NULL,
  `nome` VARCHAR(128) NOT NULL,
  `descricao` VARCHAR(2048) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `challenges_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hints_challenges1_idx` (`challenges_id` ASC),
  CONSTRAINT `fk_hints_challenges1`
    FOREIGN KEY (`challenges_id`)
    REFERENCES `unamectf`.`challenges` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `unamectf`.`noticias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unamectf`.`noticias` ;

CREATE TABLE IF NOT EXISTS `unamectf`.`noticias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` CHAR(32) NOT NULL,
  `descricao` VARCHAR(2048) NOT NULL,
  `titulo` VARCHAR(64) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `modificado_por` VARCHAR(64) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_noticias_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_noticias_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `unamectf`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `unamectf`.`challs_logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unamectf`.`challs_logs` ;

CREATE TABLE IF NOT EXISTS `unamectf`.`challs_logs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` CHAR(32) NOT NULL,
  `challenges_id` INT NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`, `users_id`, `challenges_id`),
  INDEX `fk_users_has_challenges_challenges2_idx` (`challenges_id` ASC),
  INDEX `fk_users_has_challenges_users2_idx` (`users_id` ASC),
  CONSTRAINT `fk_users_has_challenges_users2`
    FOREIGN KEY (`users_id`)
    REFERENCES `unamectf`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_challenges_challenges2`
    FOREIGN KEY (`challenges_id`)
    REFERENCES `unamectf`.`challenges` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `unamectf`.`maestria_required`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unamectf`.`maestria_required` ;

CREATE TABLE IF NOT EXISTS `unamectf`.`maestria_required` (
  `maestrias_id` INT NOT NULL,
  `challenges_id` INT NOT NULL,
  `challenges_categories_id` INT NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_maestrias_has_challenges_challenges1_idx` (`challenges_id` ASC, `challenges_categories_id` ASC),
  INDEX `fk_maestrias_has_challenges_maestrias1_idx` (`maestrias_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_maestrias_has_challenges_maestrias1`
    FOREIGN KEY (`maestrias_id`)
    REFERENCES `unamectf`.`maestrias` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_maestrias_has_challenges_challenges1`
    FOREIGN KEY (`challenges_id` , `challenges_categories_id`)
    REFERENCES `unamectf`.`challenges` (`id` , `categories_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
