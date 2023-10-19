CREATE SCHEMA IF NOT EXISTS `spotify`;

CREATE TABLE IF NOT EXISTS `spotify`.`users` (
  `id_user` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `sex` TINYINT NULL,
  `country` VARCHAR(45) NULL,
  `postal_code` VARCHAR(5) NULL,
  `is_premium` TINYINT NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `spotify`.`playlists` (
  `id_playlist` INT NOT NULL,
  `user_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `num_songs` INT NOT NULL,
  `creation_date` DATETIME NOT NULL,
  `is_deleted` TINYINT NOT NULL,
  `delete_date` DATETIME NOT NULL,
  PRIMARY KEY (`id_playlist`, `user_id`),
  UNIQUE INDEX `id_playlist_UNIQUE` (`id_playlist` ASC) VISIBLE,
  INDEX `playlist_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `playlist_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `spotify`.`paypals` (
  `id_paypal` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_paypal`),
  UNIQUE INDEX `id_paypal_UNIQUE` (`id_paypal` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `spotify`.`creditcards` (
  `id_creditcards` INT NOT NULL,
  `number` VARCHAR(18) NOT NULL,
  `exp_month` TINYINT NOT NULL,
  `exp_year` VARCHAR(4) NOT NULL,
  `sec_code` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`id_creditcards`),
  UNIQUE INDEX `id_creditcards_UNIQUE` (`id_creditcards` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `spotify`.`suscriptions` (
  `id_suscription` INT NOT NULL,
  `user_id` INT NOT NULL,
  `init_date` DATETIME NOT NULL,
  `re_date` DATETIME NOT NULL,
  `payment` TINYINT NOT NULL,
  `creditcard_id` INT NULL,
  `paypal_id` INT NULL,
  PRIMARY KEY (`id_suscription`, `user_id`),
  UNIQUE INDEX `id_suscription_UNIQUE` (`id_suscription` ASC) VISIBLE,
  INDEX `suscription_user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `suscription_creditcard_id_idx` (`creditcard_id` ASC) VISIBLE,
  INDEX `suscription_paypal_id_idx` (`paypal_id` ASC) VISIBLE,
  CONSTRAINT `suscription_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `suscription_creditcard_id`
    FOREIGN KEY (`creditcard_id`)
    REFERENCES `spotify`.`creditcards` (`id_creditcards`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `suscription_paypal_id`
    FOREIGN KEY (`paypal_id`)
    REFERENCES `spotify`.`paypals` (`id_paypal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `spotify`.`payments` (
  `id_payment` INT NOT NULL,
  `suscription_id` INT NOT NULL,
  `order_num` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `total_import` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id_payment`, `suscription_id`),
  UNIQUE INDEX `id_payment_UNIQUE` (`id_payment` ASC) VISIBLE,
  UNIQUE INDEX `order_num_UNIQUE` (`order_num` ASC) VISIBLE,
  INDEX `payment_suscription_id_idx` (`suscription_id` ASC) VISIBLE,
  CONSTRAINT `payment_suscription_id`
    FOREIGN KEY (`suscription_id`)
    REFERENCES `spotify`.`suscriptions` (`id_suscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `spotify`.`artists` (
  `id_artist` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `image` BLOB NOT NULL,
  PRIMARY KEY (`id_artist`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `id_artist_UNIQUE` (`id_artist` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `spotify`.`releted_artists` (
  `id_releted_artists` INT NOT NULL,
  `artist1_id` INT NOT NULL,
  `artist2_id` INT NOT NULL,
  PRIMARY KEY (`id_releted_artists`, `artist2_id`, `artist1_id`),
  UNIQUE INDEX `id_releted_artists_UNIQUE` (`id_releted_artists` ASC) VISIBLE,
  INDEX `releted_artist1_id_idx` (`artist1_id` ASC) VISIBLE,
  INDEX `releted_artist2_id_idx` (`artist2_id` ASC) VISIBLE,
  CONSTRAINT `releted_artist1_id`
    FOREIGN KEY (`artist1_id`)
    REFERENCES `spotify`.`artists` (`id_artist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `releted_artist2_id`
    FOREIGN KEY (`artist2_id`)
    REFERENCES `spotify`.`artists` (`id_artist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `spotify`.`follows` (
  `id_follow` INT NOT NULL,
  `user_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`id_follow`, `user_id`, `artist_id`),
  UNIQUE INDEX `id_follow_UNIQUE` (`id_follow` ASC) VISIBLE,
  INDEX `follow_user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `follow_artist_id_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `follow_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `follow_artist_id`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artists` (`id_artist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `spotify`.`albums` (
  `id_album` INT NOT NULL,
  `artist_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `publication_date` DATE NOT NULL,
  `cover` BLOB NOT NULL,
  PRIMARY KEY (`id_album`, `artist_id`),
  UNIQUE INDEX `id_album_UNIQUE` (`id_album` ASC) VISIBLE,
  INDEX `album_artist_id_idx` (`artist_id` ASC) VISIBLE,
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE,
  CONSTRAINT `album_artist_id`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artists` (`id_artist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `spotify`.`songs` (
  `id_song` INT NOT NULL,
  `album_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `duration` TIME NOT NULL,
  `reproductions` INT NOT NULL,
  PRIMARY KEY (`id_song`, `album_id`),
  UNIQUE INDEX `id_song_UNIQUE` (`id_song` ASC) VISIBLE,
  INDEX `song_album_id_idx` (`album_id` ASC) VISIBLE,
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE,
  CONSTRAINT `song_album_id`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`albums` (`id_album`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `spotify`.`playlist_content` (
  `id_playlist_content` INT NOT NULL,
  `playlist_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `creation_date` DATETIME NOT NULL,
  PRIMARY KEY (`id_playlist_content`, `playlist_id`, `user_id`, `song_id`),
  UNIQUE INDEX `id_playlist_content_UNIQUE` (`id_playlist_content` ASC) VISIBLE,
  INDEX `playlist_content_playlist_id_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `playlist_content_song_id_idx` (`song_id` ASC) VISIBLE,
  INDEX `playlist_content_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `playlist_content_playlist_id`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlists` (`id_playlist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `playlist_content_song_id`
    FOREIGN KEY (`song_id`)
    REFERENCES `spotify`.`songs` (`id_song`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `playlist_content_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `spotify`.`favorites` (
  `id_favorite` INT NOT NULL,
  `user_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  PRIMARY KEY (`id_favorite`, `song_id`, `user_id`),
  UNIQUE INDEX `id_favorite_UNIQUE` (`id_favorite` ASC) VISIBLE,
  INDEX `favorite_user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `favorite_song_id_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `favorite_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `favorite_song_id`
    FOREIGN KEY (`song_id`)
    REFERENCES `spotify`.`songs` (`id_song`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;