CREATE SCHEMA optica;

CREATE TABLE IF NOT EXISTS `Optica`.`suppliers` (
  `id_supplier` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `street` VARCHAR(45) NULL,
  `number` VARCHAR(10) NULL,
  `floor` VARCHAR(10) NULL,
  `door` VARCHAR(10) NULL,
  `city` VARCHAR(45) NULL,
  `postalCode` VARCHAR(5) NULL,
  `country` VARCHAR(45) NULL,
  `telephone` VARCHAR(45) NULL,
  `fax` VARCHAR(45) NULL,
  PRIMARY KEY (`id_supplier`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Optica`.`clients` (
  `id_client` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `registration_date` DATE NOT NULL,
  `postal_adress` VARCHAR(120) NULL,
  `telephone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `recomendation_id` INT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `recomendation_id_idx` (`recomendation_id` ASC) VISIBLE ,
  CONSTRAINT `recomendation_id`
    FOREIGN KEY (`recomendation_id`)
    REFERENCES `Optica`.`clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Optica`.`glasses` (
  `id_glasses` INT NOT NULL,
  `id_client` INT NOT NULL,
  `id_supplier` INT NOT NULL,
  `brand` VARCHAR(45) NOT NULL,
  `price` DECIMAL(7,2) NOT NULL,
  `frame_type` VARCHAR(8) NOT NULL,
  `frame_color` VARCHAR(45) NOT NULL,
  `graduation_L` VARCHAR(10) NULL,
  `graduation_R` VARCHAR(10) NULL,
  `glass_color` VARCHAR(45) NULL,
  PRIMARY KEY (`id_glasses`),
  INDEX `id_clients_idx` (`id_client` ASC) VISIBLE ,
  INDEX `id_supplier_idx` (`id_supplier` ASC) VISIBLE ,
  CONSTRAINT `id_client`
    FOREIGN KEY (`id_client`)
    REFERENCES `Optica`.`clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_supplier`
    FOREIGN KEY (`id_supplier`)
    REFERENCES `Optica`.`suppliers` (`id_supplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB