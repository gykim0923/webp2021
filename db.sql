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
