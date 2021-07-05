DROP DATABASE if EXISTS swaig ;
CREATE DATABASE swaig DEFAULT CHARACTER SET UTF8; 
USE swaig ;
CREATE TABLE Example (
 `oid` INT(11) NOT NULL AUTO_INCREMENT,
 `title` VARCHAR(100) DEFAULT NULL,
 `content` VARCHAR(100) DEFAULT NULL,
 `date` DATE DEFAULT NULL, PRIMARY KEY (`oid`)
) ;
INSERT INTO Example(oid, title, content, `date`) VALUES(1,'title1','content1','2021-06-26');
INSERT INTO Example(title, content, `date`) VALUES('title2','content2','2021-06-27');
INSERT INTO Example(title, content, `date`) VALUES('title3','content3','2021-06-28');
INSERT INTO Example(title, content, `date`) VALUES('title4','내용내용내용','2021-06-28');

CREATE TABLE menu_tabs(
    `tab_id` INT(10) NOT NULL,
    `tab_title` VARCHAR(30) NOT NULL,
    `tab_level` INT(10) NOT NULL,
    `tab_img` VARCHAR(30) NOT NULL,
    `tab_url` VARCHAR(50) NOT NULL,
    `orderNum` INT(10) NOT NULL, PRIMARY KEY(`tab_id`)
);
INSERT INTO menu_tabs(tab_id, tab_title, tab_level, tab_img, tab_url, orderNum) VALUES('1', '학과소개', '4', 'img/common/logo.png', 'information.kgu', '1');
INSERT INTO menu_tabs(tab_id, tab_title, tab_level, tab_img, tab_url, orderNum) VALUES('2', '교육활동', '4', 'img/common/logo.png', 'curriculum.kgu', '2');

CREATE TABLE menu_pages(
    `page_id` INT(10) NOT NULL,
    `page_path` VARCHAR(50) NOT NULL,
    `page_title` VARCHAR(250) NOT NULL,
    `tab_id` INT(10) NOT NULL,
    `max_level` INT(10) NOT NULL DEFAULT '9',
    `orderNum` INT(10) NOT NULL,
    `min_level` INT(10)  NOT NULL DEFAULT '0', PRIMARY KEY(`page_id`)
);

INSERT INTO menu_pages(page_id,page_path,page_title,tab_id,max_level,orderNum,min_level) VALUE('1', 'information.kgu', '학과소개', '1', '11', '1', '0');
INSERT INTO menu_pages(page_id,page_path,page_title,tab_id,max_level,orderNum,min_level) VALUE('2', 'curriculum.kgu', '교육과정', '2', '11', '1', '0');

CREATE TABLE usertype(
    `type_name` varchar(45) NOT NULL,
    `class_type` VARCHAR(45) NOT NULL,
    `board_level` int NOT NULL,
    `for_header` varchar(45) NOT NULL,
     PRIMARY KEY(`type_name`)
);

INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('Admin', '관리자', '0', '관리자');

CREATE TABLE user(
    `id` VARCHAR(45) NOT NULL,
    `password` VARCHAR(100) NOT NULL DEFAULT '-',
    `name` VARCHAR(45) NOT NULL DEFAULT '-',
    `gender` VARCHAR(10) NOT NULL DEFAULT '-',
    `birth` VARCHAR(45) NOT NULL DEFAULT '-',
    `type` VARCHAR(45) NOT NULL DEFAULT '-',
    `email` VARCHAR(100) NOT NULL DEFAULT '-',
    `phone` VARCHAR(45) NOT NULL DEFAULT '-',
    `last_login` DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00',
    `hope_type` VARCHAR(45) NOT NULL DEFAULT '-',
    `reg_date` DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00',
    `major` VARCHAR(45) NOT NULL DEFAULT '-',
    `per_id` VARCHAR(45) NOT NULL DEFAULT '-',
    `grade` VARCHAR(10) NOT NULL DEFAULT '-',
    `state` VARCHAR(10) NOT NULL DEFAULT '-',
    `myhomeid` VARCHAR(45) NOT NULL DEFAULT '-',
    PRIMARY KEY (`id`)
);