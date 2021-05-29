/*creates a database or if it already exists it uses*/

CREATE DATABASE IF NOT EXISTS `imdb_db`;

/*use the database*/

use `imdb_db`;


/*creating a table movie*/

CREATE TABLE IF NOT EXISTS `movie` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`movie_number` VARCHAR(255) NOT NULL,
	`movie_name` VARCHAR(250) NOT NULL,
	`duration` VARCHAR(100) NULL,
	`release_date` DATE  NULL,
	CONSTRAINT pk_article_main_id PRIMARY KEY(`id`)
	) AUTO_INCREMENT=1;
 
/*creating a table article_download*/

CREATE TABLE IF NOT EXISTS `source_download` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
	`source_file_path_main_page` VARCHAR(250) NOT NULL UNIQUE,
	`source_file_path_rating_page` VARCHAR(250)  NULL  ,
	`source_file_path_actors_page` VARCHAR(250)  NULL  ,
	`source_download_created_date` DATETIME NOT NULL,
	`source_download_last_updated_date` DATETIME NOT NULL,
	`source_download_url` VARCHAR(250) NOT NULL UNIQUE,
	`source_download_unique_id` VARCHAR(250) NOT NULL UNIQUE,
	`source_download_is_parsed` TINYINT(1) default 0,
	CONSTRAINT pk_article_main_id PRIMARY KEY(`id`))AUTO_INCREMENT=1;

/*creating a table Movie types*/

CREATE TABLE IF NOT EXISTS `movie_type` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`movie_type_name` VARCHAR(250) NOT NULL,
	CONSTRAINT pk_movie_type_id PRIMARY KEY(`id`)
	);

CREATE TABLE IF NOT EXISTS `movie_genres` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`genres_name` VARCHAR(250) NOT NULL,
	CONSTRAINT pk_movie_type_id PRIMARY KEY(`id`));


/*creating a table Movie Rating*/

CREATE TABLE IF NOT EXISTS `movie_rating` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`movie_id`  INT UNSIGNED,
	`rating` FLOAT(2),
	`total_user` INT,
	`one` INT,
	`two` INT,
	`three` INT,
	`four` INT,
	`five` INT,
	`six` INT,
	`seven` INT,
	`eight` INT,
	`nine` INT,
	`ten` INT,
	CONSTRAINT pk_movie_rating_id PRIMARY KEY(`id`),
	CONSTRAINT fk_movie_rating_id FOREIGN KEY(`movie_id`) REFERENCES movie(`id`) ON DELETE NO ACTION
	);

CREATE TABLE IF NOT EXISTS `movie_review` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`movie_id`  INT UNSIGNED,
	`no_of_review` INT ,
	`no_of_critic`  INT,
	CONSTRAINT pk_movie_review_id PRIMARY KEY(`id`),
	CONSTRAINT fk_movie_review_id FOREIGN KEY(`movie_id`) REFERENCES movie(`id`) ON DELETE NO ACTION);


CREATE TABLE IF NOT EXISTS `technical_specs` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`movie_id` INT UNSIGNED,
	`sound_mix` VARCHAR(255) ,
	`color` VARCHAR(255) ,
	`aspect_ratio` VARCHAR(255) ,
	CONSTRAINT pk_movie_review_id PRIMARY KEY(`id`),
	CONSTRAINT fk_movie_technical_id FOREIGN KEY(`movie_id`) REFERENCES movie(`id`) ON DELETE NO ACTION);


CREATE TABLE IF NOT EXISTS `movie_details`(
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`movie_id` INT UNSIGNED,
	`movie_category`  VARCHAR(100),
	`language` VARCHAR(100),
	`country` VARCHAR(200) ,
	`certificate` VARCHAR(100),
	`tag_lines` VARCHAR(500),
	`director_name` VARCHAR(100),
	`production` VARCHAR(100),
	`writer` VARCHAR(100),
	`budget` VARCHAR(500),
	`gross` VARCHAR(500),
	CONSTRAINT pk_movie_details_id PRIMARY KEY(`id`),
	CONSTRAINT fk_movie_moviedetails_id FOREIGN KEY(`movie_id`) REFERENCES movie(`id`) ON DELETE NO ACTION);

CREATE TABLE IF NOT EXISTS `movie_story`(
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`movie_id` INT UNSIGNED,
	`details` TEXT,
	`story_line` TEXT,
	CONSTRAINT pk_movie_story_id PRIMARY KEY(`id`),
	CONSTRAINT fk_movie_story_id FOREIGN KEY(`movie_id`) REFERENCES movie(`id`) ON DELETE NO ACTION);




CREATE TABLE IF NOT EXISTS `actors`(
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`movie_id` INT UNSIGNED NOT NULL,
	`actor_id` VARCHAR(100) default null,
	`name` VARCHAR(300) default null,
	`details` VARCHAR(500) ,
	`img` VARCHAR(1000) default null,
	UNIQUE KEY (movie_id, actor_id),
	CONSTRAINT fk_movie_actors_id FOREIGN KEY(`movie_id`) REFERENCES movie(`id`) ON DELETE NO ACTION
);
 
CREATE TABLE IF NOT EXISTS `job_type` (
	`id`  INT  primary key, 
	`job_type_name` VARCHAR(200)  NOT NULL 
);


INSERT INTO `job_type`(`id`,`job_type_name`) values (1,"Date Range Extractor");
INSERT INTO `job_type`(`id`,`job_type_name`) values (4,"Incremental Extractor");
INSERT INTO `job_type`(`id`,`job_type_name`) values (2,"Parser");
INSERT INTO `job_type`(`id`,`job_type_name`) values (3,"Movie_type_extractor");
INSERT INTO `job_type`(`id`,`job_type_name`) values (5,"Movie_genres_extractor");


CREATE TABLE IF NOT EXISTS `job` (
 	`id` INT  AUTO_INCREMENT PRIMARY KEY,
	`job_name` VARCHAR(30) NOT NULL,
	`start_date` DATE ,
	`no_of_days` INT ,
	`job_type` INT NOT NULL,
	`start_number` INT default 0,
	`movie_type_id` INT UNSIGNED,
	`genres_id` INT UNSIGNED,
	`end_number` INT default 0,
	`last_sucess` INT default 0,
	`total_extractor` INT default 0,
	`created_date` DATETIME NOT NULL,
	`last_update` DATETIME NOT NULL,
	FOREIGN KEY (`job_type`) REFERENCES job_type(`id`) ,
	CONSTRAINT fk_movie_type_job_id FOREIGN KEY(`movie_type_id`) REFERENCES movie_type(`id`) ON DELETE NO ACTION,
	CONSTRAINT fk_genres_job_id FOREIGN KEY(`genres_id`) REFERENCES movie_genres(`id`) ON DELETE NO ACTION
);

INSERT INTO `job`(`job_name`,`start_date`,`no_of_days`,`job_type`,`created_date`,`last_update`) values ("Date Range Extractor",'2016-01-01',0,1,now(),now());
INSERT INTO `job`(`job_name`,`start_date`,`no_of_days`,`job_type`,`created_date`,`last_update`) values ("Parse",'2016-01-01',0,2,now(),now());
INSERT INTO `job`(`job_name`,`start_date`,`no_of_days`,`job_type`,`created_date`,`last_update`) values ("Incremental Extractpr",'2016-01-01',0,4,now(),now());
INSERT INTO `job`(`job_name`,`job_type`,`created_date`,`last_update`) values ("Movie type extractor ",3,now(),now());
INSERT INTO `job`(`job_name`,`job_type`,`created_date`,`last_update`) values ("Movie genresextractor ",5,now(),now());


CREATE TABLE IF NOT EXISTS `stats` (
 	`id` INT  AUTO_INCREMENT PRIMARY KEY,
	`job_id` int NOT NULL,
	`status` VARCHAR(200) NOT NULL,
	`total_try` INT ,
	`start` INT ,
	`end` INT ,
	`no_of_sucess` INT,
	`no_of_failed` INT,
	`no_of_retry` INT,
	`end_time`  DATETIME ,
	`start_time` DATETIME NOT NULL,
	`created_date` DATETIME NOT NULL,
	FOREIGN KEY (`job_id`) REFERENCES job(`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `log` (
 	`id` INT  AUTO_INCREMENT primary key, 
	`news_id` VARCHAR(200),
	`datetime` DATETIME NOT NULL,
	`error_type` VARCHAR(1000),
	`function_name` VARCHAR(1000),
	`file_path` VARCHAR(1000),
	`stat_id` INT NOT NULL,
	`message` VARCHAR(10000) NOT NULL,
	FOREIGN KEY (`stat_id`) REFERENCES stats(`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `proxy` (
 	`id` INT  AUTO_INCREMENT primary key, 
	`proxy_name` VARCHAR(200) NOT NULL,
	`proxy_id` VARCHAR(200) NOT NULL,
	`proxy_port` INT NOT NULL,
	`username` VARCHAR(200),
	`password` VARCHAR(200),
	`created_date` DATETIME NOT NULL); 