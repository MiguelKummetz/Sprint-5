CREATE SCHEMA IF NOT EXISTS `Optica`;

CREATE TABLE IF NOT EXISTS `Optica`.`suppliers` (
  `id_supplier` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `street` VARCHAR(45) NULL DEFAULT NULL,
  `number` VARCHAR(10) NULL DEFAULT NULL,
  `floor` VARCHAR(10) NULL DEFAULT NULL,
  `door` VARCHAR(10) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `postalCode` VARCHAR(5) NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `telephone` VARCHAR(20) NULL DEFAULT NULL,
  `fax` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_supplier`));
  
  CREATE TABLE IF NOT EXISTS `Optica`.`glasses` (
  `id_glasses` INT NOT NULL,
  `supplier_id` INT NOT NULL,
  `brand` VARCHAR(45) NOT NULL,
  `price` DECIMAL(7,2) NOT NULL,
  `frame_type` VARCHAR(8) NOT NULL,
  `frame_color` VARCHAR(45) NOT NULL,
  `graduation_L` VARCHAR(10) NULL DEFAULT NULL,
  `graduation_R` VARCHAR(10) NULL DEFAULT NULL,
  `glass_color` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_glasses`, `supplier_id`),
  INDEX `id_supplier` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `id_supplier`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `Optica`.`suppliers` (`id_supplier`));
    
    CREATE TABLE IF NOT EXISTS `Optica`.`clients` (
  `id_client` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `registration_date` DATE NOT NULL,
  `postal_adress` VARCHAR(120) NULL DEFAULT NULL,
  `telephone` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `recomendation_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `recomendation_id` (`recomendation_id` ASC) VISIBLE,
  CONSTRAINT `recomendation_id`
    FOREIGN KEY (`recomendation_id`)
    REFERENCES `Optica`.`clients` (`id_client`));
    
    CREATE TABLE IF NOT EXISTS `Optica`.`sales` (
  `id_sale` INT NOT NULL,
  `client_id` INT NOT NULL,
  `glasses_id` INT NOT NULL,
  `seller` VARCHAR(45) NOT NULL,
  `time` TIME NOT NULL,
  PRIMARY KEY (`id_sale`, `client_id`),
  INDEX `glasses_id_idx` (`glasses_id` ASC) VISIBLE,
  INDEX `client_id_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `glasses_id`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `Optica`.`glasses` (`id_glasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `Optica`.`clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;