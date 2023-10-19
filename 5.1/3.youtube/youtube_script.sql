CREATE SCHEMA IF NOT EXISTS `youtube`;

CREATE TABLE IF NOT EXISTS `youtube`.`users` (
  `id_user` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `birthdate` DATETIME NOT NULL,
  `sex` TINYINT NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`channels` (
  `id_channel` INT NOT NULL,
  `user_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `creation_date` DATETIME NOT NULL,
  `description` MEDIUMTEXT NULL,
  PRIMARY KEY (`id_channel`, `user_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `id_channel_UNIQUE` (`id_channel` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `chanel_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`subscriptions` (
  `id_subscription` INT NOT NULL,
  `user_id` INT NOT NULL,
  `channel_id` INT NOT NULL,
  PRIMARY KEY (`id_subscription`, `user_id`, `channel_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `channel_id_idx` (`channel_id` ASC) VISIBLE,
  UNIQUE INDEX `id_subscription_UNIQUE` (`id_subscription` ASC) VISIBLE,
  CONSTRAINT `subscription_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `subscription_channel_id`
    FOREIGN KEY (`channel_id`)
    REFERENCES `youtube`.`channels` (`id_channel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`videos` (
  `id_video` INT NOT NULL,
  `channel_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `size` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `duration` TIME NOT NULL,
  `reproductions` INT NOT NULL,
  `thumbnail` BLOB NULL,
  `description` MEDIUMTEXT NULL,
  `creation_date` DATETIME NOT NULL,
  `is_private` TINYINT NOT NULL,
  `is_ocult` TINYINT NOT NULL,
  PRIMARY KEY (`id_video`, `channel_id`),
  INDEX `chanel_id_idx` (`channel_id` ASC) VISIBLE,
  UNIQUE INDEX `id_video_UNIQUE` (`id_video` ASC) VISIBLE,
  CONSTRAINT `video_chanel_id`
    FOREIGN KEY (`channel_id`)
    REFERENCES `youtube`.`channels` (`id_channel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`tags` (
  `id_tag` INT NOT NULL,
  `video_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tag`, `video_id`),
  INDEX `video_id_idx` (`video_id` ASC) VISIBLE,
  UNIQUE INDEX `id_tag_UNIQUE` (`id_tag` ASC) VISIBLE,
  CONSTRAINT `tag_video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`video_likes` (
  `id_video_like` INT NOT NULL,
  `user_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `like/dislike` TINYINT NOT NULL,
  `creation_date` DATETIME NOT NULL,
  PRIMARY KEY (`id_video_like`, `user_id`, `video_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `video_id_idx` (`video_id` ASC) VISIBLE,
  UNIQUE INDEX `id_video_like_UNIQUE` (`id_video_like` ASC) VISIBLE,
  CONSTRAINT `video_like_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `video_like_video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`likes_counter` (
  `id_likes_counter` INT NOT NULL,
  `video_id` INT NOT NULL,
  `video_like_id` INT NOT NULL,
  PRIMARY KEY (`id_likes_counter`),
  INDEX `video_id_idx` (`video_id` ASC) VISIBLE,
  INDEX `like_id_idx` (`video_like_id` ASC) VISIBLE,
  UNIQUE INDEX `id_likes_counter_UNIQUE` (`id_likes_counter` ASC) VISIBLE,
  CONSTRAINT `likes_counter_video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `likes_counter_like_id`
    FOREIGN KEY (`video_like_id`)
    REFERENCES `youtube`.`video_likes` (`id_video_like`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`dislikes_counter` (
  `id_dislikes_counter` INT NOT NULL,
  `video_id` INT NOT NULL,
  `video_dislike_id` INT NOT NULL,
  PRIMARY KEY (`id_dislikes_counter`),
  INDEX `video_id_idx` (`video_id` ASC) VISIBLE,
  INDEX `like_id_idx` (`video_dislike_id` ASC) VISIBLE,
  UNIQUE INDEX `id_dislikes_counter_UNIQUE` (`id_dislikes_counter` ASC) VISIBLE,
  CONSTRAINT `dislikes_counter_video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dislikes_counter_like_id`
    FOREIGN KEY (`video_dislike_id`)
    REFERENCES `youtube`.`video_likes` (`id_video_like`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`playlists` (
  `id_playlist` INT NOT NULL,
  `user_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `creation_date` DATETIME NOT NULL,
  `is_private` TINYINT NOT NULL,
  PRIMARY KEY (`id_playlist`, `user_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `id_playlist_UNIQUE` (`id_playlist` ASC) VISIBLE,
  CONSTRAINT `playlist_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`playlist_content` (
  `id_playlist_content` INT NOT NULL,
  `playlist_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  PRIMARY KEY (`id_playlist_content`, `playlist_id`, `video_id`),
  INDEX `playlist_id_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `video_id_idx` (`video_id` ASC) VISIBLE,
  UNIQUE INDEX `id_playlist_content_UNIQUE` (`id_playlist_content` ASC) VISIBLE,
  CONSTRAINT `playlist_content_playlist_id`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `youtube`.`playlists` (`id_playlist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `playlist_content_video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`coments` (
  `id_coment` INT NOT NULL,
  `user_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `content` MEDIUMTEXT NOT NULL,
  `creation_date` DATETIME NOT NULL,
  PRIMARY KEY (`id_coment`, `user_id`, `video_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `video_id_idx` (`video_id` ASC) VISIBLE,
  UNIQUE INDEX `id_coment_UNIQUE` (`id_coment` ASC) VISIBLE,
  CONSTRAINT `coment_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `coment_video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`coment_likes` (
  `id_coment_likes` INT NOT NULL,
  `user_id` INT NOT NULL,
  `coment_id` INT NOT NULL,
  `like/dislike` TINYINT NOT NULL,
  `creation_date` DATETIME NOT NULL,
  PRIMARY KEY (`id_coment_likes`, `coment_id`, `user_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `coment_id_idx` (`coment_id` ASC) VISIBLE,
  UNIQUE INDEX `id_coment_likes_UNIQUE` (`id_coment_likes` ASC) VISIBLE,
  CONSTRAINT `coment_like_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `coment_like_coment_id`
    FOREIGN KEY (`coment_id`)
    REFERENCES `youtube`.`coments` (`id_coment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;