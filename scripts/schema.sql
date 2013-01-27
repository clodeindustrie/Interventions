--  -*- coding: utf-8 -*-
-- CREATE DATABASE `dev_ficheTechnique`;

-- use dev_ficheTechnique;

CREATE TABLE `roles` (
       `id`    SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
       `nom` VARCHAR(15) NOT NULL,
       PRIMARY KEY (`id`)
) engine=innodb DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

CREATE TABLE `statuts` (
       `id`    SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
       `nom` VARCHAR(15) NOT NULL,
       PRIMARY KEY (`id`)
) engine=innodb DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

CREATE TABLE `agents` (
       `id`    SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
       `role_id` SMALLINT UNSIGNED NOT NULL,
       `nom`  VARCHAR(100) NOT NULL,
       `email`  VARCHAR(255) NOT NULL,
       `hashed_password`  VARCHAR(255) NOT NULL,
       `salt`  VARCHAR(255) NOT NULL,
       `created_at` TIMESTAMP NOT NULL DEFAULT NOW(),
       PRIMARY KEY (`id`),
       INDEX (`email`)
) engine=innodb DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

insert into `roles` (`nom`) values('Admin'), ('Responsable'), ('Agent'), ('Technicien');
insert into `statuts` (`nom`) values('Traitement'), ('Approuvée'), ('Rejetée'), ('Exécutée');

CREATE TABLE `addresses` (
       `id`    SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
       `addresse` VARCHAR(400) NOT NULL,
       PRIMARY KEY (`id`)
) ENGINE=InnoDb DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

CREATE TABLE `fiches` (
       `id`    SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
       `addresse_id` SMALLINT UNSIGNED NOT NULL,
       `demandeur_id` SMALLINT UNSIGNED NOT NULL,
       `executant_id` SMALLINT UNSIGNED ,
       `statut_id` SMALLINT UNSIGNED NOT NULL default 1,
       `famille`  VARCHAR(255) NOT NULL,
       `sujet`  VARCHAR(255) NOT NULL,
       `contenue` VARCHAR(1000) NOT NULL,
       `observations` VARCHAR(1000),
       `travaux` VARCHAR(1000),
       `created_at` TIMESTAMP NOT NULL DEFAULT NOW(),
       `done_at` TIMESTAMP NULL,
       `priority` VARCHAR(1) NOT NULL DEFAULT 'U',
       PRIMARY KEY (`id`),
       FOREIGN KEY (`addresse_id`)
       	       REFERENCES `addresses` (`id`),
       FOREIGN KEY (`demandeur_id`)
       	       REFERENCES `agents` (`id`),
       FOREIGN KEY (`executant_id`)
       	       REFERENCES `agents` (`id`)
) ENGINE=InnoDb DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

