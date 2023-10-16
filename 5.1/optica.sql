CREATE SCHEMA optica;

CREATE TABLE IF NOT EXISTS `Optica`.`suppliers` (
  `id_supplier` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `street` VARCHAR(45),
  `number` VARCHAR(10),
  `floor` VARCHAR(10),
  `door` VARCHAR(10),
  `city` VARCHAR(45),
  `postalCode` VARCHAR(5),
  `country` VARCHAR(45),
  `telephone` VARCHAR(45),
  `fax` VARCHAR(45) NULL,
  PRIMARY KEY (`id_supplier`));

CREATE TABLE IF NOT EXISTS `Optica`.`clients` (
  `id_client` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `registration_date` DATE NOT NULL,
  `postal_adress` VARCHAR(120),
  `telephone` VARCHAR(45),
  `email` VARCHAR(45),
  `recomendation_id` INT,
  PRIMARY KEY (`id_client`),
  CONSTRAINT `recomendation_id`
    FOREIGN KEY (`recomendation_id`)
    REFERENCES `Optica`.`clients` (`id_client`)
);

CREATE TABLE IF NOT EXISTS `Optica`.`glasses` (
  `id_glasses` INT NOT NULL,
  `id_client` INT NULL,
  `id_supplier` INT NOT NULL,
  `brand` VARCHAR(45) NOT NULL,
  `price` DECIMAL(7,2) NOT NULL,
  `frame_type` VARCHAR(8) NOT NULL,
  `frame_color` VARCHAR(45) NOT NULL,
  `graduation_L` VARCHAR(10),
  `graduation_R` VARCHAR(10),
  `glass_color` VARCHAR(45),
  PRIMARY KEY (`id_glasses`),
  CONSTRAINT `id_client`
    FOREIGN KEY (`id_client`)
    REFERENCES `Optica`.`clients` (`id_client`),
  CONSTRAINT `id_supplier`
    FOREIGN KEY (`id_supplier`)
    REFERENCES `Optica`.`suppliers` (`id_supplier`)
    );