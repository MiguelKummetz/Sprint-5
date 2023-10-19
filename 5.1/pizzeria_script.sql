CREATE SCHEMA IF NOT EXISTS `Pizzeria`;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`clients` (
  `id_client` INT NOT NULL,
  `telephone` VARCHAR(20) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `adress` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(5) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE INDEX `id_client_UNIQUE` (`id_client` ASC) VISIBLE,
  UNIQUE INDEX `telephone_UNIQUE` (`telephone` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`stores` (
  `id_stores` INT NOT NULL,
  `adress` VARCHAR(120) NOT NULL,
  `postal_code` VARCHAR(5) NOT NULL,
  `locality` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_stores`),
  UNIQUE INDEX `id_stores_UNIQUE` (`id_stores` ASC) VISIBLE,
  UNIQUE INDEX `adress_UNIQUE` (`adress` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`orders` (
  `id_orders` INT NOT NULL,
  `store_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  `time` DATETIME NOT NULL,
  `is_delivery` TINYINT NOT NULL,
  `total_price` DECIMAL(6,2) NOT NULL,
  `creation_date` DATETIME NOT NULL,
  PRIMARY KEY (`id_orders`, `client_id`, `store_id`),
  INDEX `store_id_idx` (`store_id` ASC) VISIBLE,
  INDEX `client_id_idx` (`client_id` ASC) VISIBLE,
  UNIQUE INDEX `id_orders_UNIQUE` (`id_orders` ASC) VISIBLE,
  CONSTRAINT `orders_store_id`
    FOREIGN KEY (`store_id`)
    REFERENCES `Pizzeria`.`stores` (`id_stores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orders_client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `Pizzeria`.`clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`employees` (
  `id_employee` INT NOT NULL,
  `store_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `telephone` VARCHAR(20) NOT NULL,
  `occupation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_employee`),
  INDEX `store_id_idx` (`store_id` ASC) VISIBLE,
  UNIQUE INDEX `id_employee_UNIQUE` (`id_employee` ASC) VISIBLE,
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE,
  CONSTRAINT `employee_store_id`
    FOREIGN KEY (`store_id`)
    REFERENCES `Pizzeria`.`stores` (`id_stores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`delivery` (
  `id_delivery` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `time` DATETIME NOT NULL,
  PRIMARY KEY (`id_delivery`, `order_id`, `employee_id`),
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
  UNIQUE INDEX `id_delivery_UNIQUE` (`id_delivery` ASC) VISIBLE,
  CONSTRAINT `delivery_employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Pizzeria`.`employees` (`id_employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `delivery_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `Pizzeria`.`orders` (`id_orders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`pizza_categories` (
  `id_pizza_categories` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pizza_categories`),
  UNIQUE INDEX `id_pizza_categories_UNIQUE` (`id_pizza_categories` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`pizzas` (
  `id_pizzas` INT NOT NULL,
  `category_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  `image` BLOB NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`id_pizzas`, `category_id`),
  INDEX `category_id_idx` (`category_id` ASC) VISIBLE,
  UNIQUE INDEX `id_pizzas_UNIQUE` (`id_pizzas` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `p_category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `Pizzeria`.`pizza_categories` (`id_pizza_categories`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`burguers` (
  `id_burguers` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  `image` BLOB NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`id_burguers`),
  UNIQUE INDEX `id_burguers_UNIQUE` (`id_burguers` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`drinks` (
  `id_drinks` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  `image` BLOB NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`id_drinks`),
  UNIQUE INDEX `id_drinks_UNIQUE` (`id_drinks` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`items_counter` (
  `id_items_order` INT NOT NULL,
  `order_id` INT NOT NULL,
  `burguer_id` INT NULL,
  `pizza_id` INT NULL,
  `drink_id` INT NULL,
  PRIMARY KEY (`id_items_order`, `order_id`),
  INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
  INDEX `burguer_id_idx` (`burguer_id` ASC) VISIBLE,
  INDEX `pizza_id_idx` (`pizza_id` ASC) VISIBLE,
  INDEX `drink_id_idx` (`drink_id` ASC) VISIBLE,
  UNIQUE INDEX `id_items_order_UNIQUE` (`id_items_order` ASC) VISIBLE,
  CONSTRAINT `items_counter_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `Pizzeria`.`orders` (`id_orders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `items_counter_burguer_id`
    FOREIGN KEY (`burguer_id`)
    REFERENCES `Pizzeria`.`burguers` (`id_burguers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `items_counter_pizza_id`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `Pizzeria`.`pizzas` (`id_pizzas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `items_counter_drink_id`
    FOREIGN KEY (`drink_id`)
    REFERENCES `Pizzeria`.`drinks` (`id_drinks`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;