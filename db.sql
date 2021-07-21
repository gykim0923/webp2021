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
INSERT INTO menu_tabs(tab_id, tab_title, tab_level, tab_img, tab_url, orderNum) VALUES('3', '구성원', '4', 'img/common/logo.png', 'professor.kgu', '3');
INSERT INTO menu_tabs(tab_id, tab_title, tab_level, tab_img, tab_url, orderNum) VALUES('4', '학과알림', '4', 'img/common/logo.png', 'bbs.kgu', '4');
INSERT INTO menu_tabs(tab_id, tab_title, tab_level, tab_img, tab_url, orderNum) VALUES('5', '신청하기', '4', 'img/common/logo.png', 'notice_article_list.kgu', '5');
INSERT INTO menu_tabs(tab_id, tab_title, tab_level, tab_img, tab_url, orderNum) VALUES('6', '웹진', '4', 'img/common/logo.png', 'webzine_list.kgu', '6');
INSERT INTO menu_tabs(tab_id, tab_title, tab_level, tab_img, tab_url, orderNum) VALUES('7', '전공게시판', '4', 'img/common/logo.png', 'notice_article_list.kgu', '7');

CREATE TABLE menu_pages(
    `page_id` INT(10) NOT NULL,
    `tab_id` INT(10) NOT NULL,
    `orderNum` INT(10) NOT NULL,
    `page_path` VARCHAR(50) NOT NULL,
    `page_title` VARCHAR(250) NOT NULL,
    `max_level` INT(10) NOT NULL DEFAULT '9',
    `min_level` INT(10)  NOT NULL DEFAULT '0', PRIMARY KEY(`page_id`)
);

INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('10', '1', '0', 'information.kgu', '학과소개', '11',  '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('11', '1', '1', 'information.kgu', '연혁', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('12', '1', '2', 'information.kgu', '교육환경', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('13', '1', '3', 'information.kgu', '교육목표', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('20', '2', '0', 'curriculum.kgu', '교육과정',  '11',  '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('21', '2', '1', 'information.kgu', '학습활동',  '11',  '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('22', '2', '2', 'club.kgu', '동아리 소개', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('30', '3', '0', 'professor.kgu', '교수진', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('31', '3', '1', 'laboratory.kgu', '연구실', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('40', '4', '0', 'bbs.kgu', '전체공지', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('41', '4', '1', 'bbs.kgu', '학과공지', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('42', '4', '2', 'bbs.kgu', '수업공지', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('43', '4', '3', 'bbs.kgu', '취업공지', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('50', '5', '0', 'bbs.kgu', '신청하기', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('51', '5', '1', 'bbs.kgu', '학과자료실', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('60', '6', '0', 'bbs.kgu', '학과소식', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('61', '6', '1', 'bbs.kgu', '우수작품전', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('62', '6', '2', 'bbs.kgu', '칼럼', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('70', '7', '0', 'bbs.kgu', '전공게시판', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('71', '7', '1', 'gallery_board_list.kgu', '갤러리', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('80', '8', '0', 'mypage.kgu', '마이페이지', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('81', '8', '1', 'changePwd.kgu', '비밀번호변경', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('82', '8', '2', 'whatIDoPage.kgu', '활동내역', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('90', '9', '0', 'admin.kgu', '홈페이지관리', '11', '0');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title,max_level,min_level) VALUE('91', '9', '1', 'admin.kgu', '회원관리', '11', '0');

CREATE TABLE usertype(
    `type_name` varchar(45) NOT NULL,
    `class_type` VARCHAR(45) NOT NULL,
    `board_level` int NOT NULL,
    `for_header` varchar(45) NOT NULL,
     PRIMARY KEY(`type_name`)
);

INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('홈페이지관리자', 'Admin', '0', '관리자');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('교수', 'Professor', '1', '교수');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('대학원생', 'Student', '2', '학생');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('학부생', 'Student', '2', '학생');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('복전생', 'Student', '2', '학생');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('타과생', 'Student', '2', '학생');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('학부모', 'Etc', '3', '기타');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('조교', 'Student', '2', '학생');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('입학예정자', 'Etc', '3', '기타');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('기타', 'Etc', '3', '기타');


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

INSERT INTO user(id,password,name,gender,birth,type,email,phone,last_login,hope_type,reg_date,major,per_id,grade,state,myhomeid) VALUE('201713919', '6ab7108f5c8ab980a584f1e2b98b2991b087af4907864575e6905edf2b759ae8', '윤주현', '남', '1996-03-25', '학부생', 'test1@test.com','010-0000-0001','2021-07-05','-','2021-07-05','main','201713919','-','-','-');
INSERT INTO user(id,password,name,gender,birth,type,email,phone,last_login,hope_type,reg_date,major,per_id,grade,state,myhomeid) VALUE('admin', '112b16f5f7b04cecda94c345900574686e5ed35803e2b7e9702fa4b46810a2d4', '관리자테스트', '-', '2021-01-01', '홈페이지관리자', 'admin@kyonggi.ac.kr','010-0000-0000','2021-07-05','-','2021-07-05','main','-','-','-','-');
INSERT INTO user(id,password,name,gender,birth,type,email,phone,last_login,hope_type,reg_date,major,per_id,grade,state,myhomeid) VALUE('professor', '1f9d870484301db50342aa184bd9f3f891195090030ad56cbbc9d0f0b996a567', '교수테스트', '-', '2021-01-01', '교수', 'professor@kyonggi.ac.kr','010-0000-0000','2021-07-05','-','2021-07-05','main','-','-','-','-');
INSERT INTO user(id,password,name,gender,birth,type,email,phone,last_login,hope_type,reg_date,major,per_id,grade,state,myhomeid) VALUE('202100000', '9f50515645763c0b8704f8114c81da0fddd2b4bdc9240de158e905884d8cb840', '학생테스트', '-', '2021-01-01', '학부생', 'student@test.com','010-0000-0001','2021-07-05','-','2021-07-05','main','201713919','-','-','-');
INSERT INTO user(id,password,name,gender,birth,type,email,phone,last_login,hope_type,reg_date,major,per_id,grade,state,myhomeid) VALUE('etc', '7bbe475cfc8390cb8c2ca19de371e1a3b5ab88ef39760d7ce0da003a59773a14', '기타테스트', '-', '2021-01-01', '기타', 'etc@test.com','010-0000-0001','2021-07-05','-','2021-07-05','main','201713919','-','-','-');



CREATE TABLE major(
    `oid` int(50) NOT NULL AUTO_INCREMENT,
    `major_id` VARCHAR(50) NOT NULL,
    `major_name` VARCHAR(100) NOT NULL,
    `major_color1` VARCHAR(100) NOT NULL,
    `major_color2` VARCHAR(100) NOT NULL,
    `major_color3` VARCHAR(100) NOT NULL,
     PRIMARY KEY (`oid`)
);

INSERT INTO major(oid,major_id,major_name,major_color1,major_color2,major_color3) VALUE('1','main','K-WITH 융합교육원','#000000','#000000','#000000');
INSERT INTO major(major_id,major_name,major_color1,major_color2,major_color3) VALUE('major1','전공1','#000000','#000000','#000000');

CREATE TABLE documents(
                      `oid` int(50) NOT NULL AUTO_INCREMENT,
                      `title` VARCHAR(250) NOT NULL,
                      `contents` TEXT NOT NULL,
                      PRIMARY KEY (`oid`)
);

INSERT INTO documents(oid, title, contents) VALUE('0','메인페이지','게시글내용');

CREATE TABLE text(
    `id` int(50) NOT NULL,
    `major` VARCHAR(50) NOT NULL,
    `content` TEXT NOT NULL,
    PRIMARY KEY(`id`,`major`)
);
INSERT INTO text(id, major, content) VALUE('10','main','10-main');
INSERT INTO text(id, major, content) VALUE('10','major1','10-major1');
INSERT INTO text(id, major, content) VALUE('11','main','11-main');
INSERT INTO text(id, major, content) VALUE('11','major1','11-major1');
INSERT INTO text(id, major, content) VALUE('12','main','12-main');
INSERT INTO text(id, major, content) VALUE('12','major1','12-major1');
INSERT INTO text(id, major, content) VALUE('13','main','13-main');
INSERT INTO text(id, major, content) VALUE('13','major1','13-major1');
INSERT INTO text(id, major, content) VALUE('20','main','20-main');
INSERT INTO text(id, major, content) VALUE('20','major1','20-major1');
INSERT INTO text(id, major, content) VALUE('21','main','21-main');
INSERT INTO text(id, major, content) VALUE('21','major1','21-major1');


CREATE TABLE professor(
    `id` int(50) NOT NULL AUTO_INCREMENT,
    `prof_img` VARCHAR (100) NOT NULL,
    `prof_name` VARCHAR (100) NOT NULL,
    `prof_email` VARCHAR (100) NOT NULL,
    `prof_lecture` VARCHAR (200) NOT NULL,
    `prof_location` VARCHAR (100) NOT NULL,
    `prof_call` VARCHAR (100) NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO professor(id, prof_img,prof_name, prof_email,prof_lecture,prof_location,prof_call) VALUE(1,'img/professor/professor1.jpeg','권기현','khkwon@kyonggi.ac.kr','이산수학','8209호',' 031-249-9666');
INSERT INTO professor(id, prof_img,prof_name, prof_email,prof_lecture,prof_location,prof_call) VALUE(2,'img/professor/syskgcsprofessor1.jpeg','권기현','khkwon@kyonggi.ac.kr','이산수학','8209호',' 031-249-9666');

CREATE TABLE club(
                     `id` INT(50)  NOT NULL AUTO_INCREMENT,
                     `club_name` VARCHAR (45)  NOT NULL,
                     `club_content` text  NOT NULL,
                     `club_address` text,
                         PRIMARY KEY (`id`)
);

INSERT INTO club(id, club_name, club_content, club_address) VALUE('0','구글','<p>구글 동아리ㅏ</p>','https://www.google.com');
INSERT INTO club(club_name, club_content, club_address) VALUE('네이버','<p>네이버 동아리</p>','https://www.naver.com');

CREATE TABLE laboratory(
    `id` int(50) NOT NULL AUTO_INCREMENT,
    `lab_img` VARCHAR (100) NOT NULL,
    `lab_name` VARCHAR (100) NOT NULL,
    `lab_location` VARCHAR (100) NOT NULL,
    `lab_homepage` VARCHAR (200) NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO laboratory(id, lab_img,lab_name, lab_location, lab_homepage) VALUE (0,'#','테스트 연구실1','8501','http://rtos.kyonggi.ac.kr/rtos/home.jsp');
INSERT INTO laboratory(lab_img,lab_name, lab_location, lab_homepage) VALUE ('#','테스트 연구실2','8502','http://rtos.kyonggi.ac.kr/rtos/home.jsp');
INSERT INTO laboratory(lab_img,lab_name, lab_location, lab_homepage) VALUE ('#','테스트 연구실3','8502','http://rtos.kyonggi.ac.kr/rtos/home.jsp');

CREATE TABLE curriculum(
    `major` VARCHAR(50) NOT NULL,
    `year` INT(10) NOT NULL,
    `curriculum_img` VARCHAR(100) NOT NULL,
    `edu_img` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`major`, `year`)
);

INSERT INTO curriculum(major, year, curriculum_img, edu_img) VALUE('main',2020,'/img/cs_logo.png','#');
INSERT INTO curriculum(major, year, curriculum_img, edu_img) VALUE('main',2021,'#','/img/cs_logo.png');
INSERT INTO curriculum(major, year, curriculum_img, edu_img) VALUE('major1',2021,'/img/cs_logo.png','#');


CREATE TABLE schedule(
                           `id` INT(10) NOT NULL AUTO_INCREMENT,
                           `date` DATETIME NOT NULL,
                           `content` VARCHAR(100) NOT NULL,
                           PRIMARY KEY (`id`)
);
INSERT INTO schedule(id, date, content) VALUE ('0', '2021-08-01', '프로젝트 마감');

CREATE TABLE uploadedFile(
                       `id` INT(10) NOT NULL AUTO_INCREMENT,
                       `user_id` VARCHAR(100) NOT NULL,
                       `uploadFile` VARCHAR(100) NOT NULL,
                       `newFileName` VARCHAR(100) NOT NULL,
                       `upload_time` DATE NOT NULL,
                       `savePath` VARCHAR(100)  NOT NULL,
                       `path` VARCHAR(100)  NOT NULL,
                       PRIMARY KEY (`id`)
);

CREATE TABLE slider(
    `id` INT(10) NOT NULL AUTO_INCREMENT,
    `slider_img` VARCHAR(100) DEFAULT NULL,
    `slider_major` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE developer(
    `id` INT(10) NOT NULL AUTO_INCREMENT,
    `team_name` VARCHAR(50) NOT NULL,
    `members` VARCHAR(100) NOT NULL,
    `start_date` VARCHAR(50) NOT NULL,
    `end_date` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`)
);
INSERT INTO developer(id, team_name, members, start_date, end_date) VALUE (1, '웹 6기', '17학번 윤주현---19학번 김가영 박선애 박소영 박의진', '2021-07-05', '2021-08-31');

CREATE TABLE location(
    `id` INT(10) NOT NULL,
    `address` VARCHAR(200) NOT NULL,
    `contact_num` VARCHAR(100) NOT NULL,
    `content` VARCHAR(500) NOT NULL, PRIMARY KEY(`id`)
);
INSERT INTO location(id, address, contact_num, content) VALUE ('0', '(16227) 경기도 수원시 영통구 광교산로 154-42 육영관 8304호', ' 031-249-9670 (FAX : 031-249-9673)','hi');

CREATE TABLE bbs(
    `id` INT(10) NOT NULL AUTO_INCREMENT,
    `major` VARCHAR(50) NOT NULL,
    `writer_id` VARCHAR(50) NOT NULL,
    `writer_name` VARCHAR(50) NOT NULL,
    `title` VARCHAR(200) NOT NULL,
    `category` INT(10) NOT NULL,
    `views` INT(10) DEFAULT 0,
    `level` INT(10) DEFAULT 0,
    `last_modified` DATE NOT NULL,
    `text` TEXT NOT NULL,
    `coments_count` INT(10) DEFAULT 0 ,
    `likes` INT(10) DEFAULT 0,
    PRIMARY KEY(`id`)
);

INSERT INTO bbs(id, major, writer_id, writer_name, title, category, last_modified, text) VALUE('0', 'main','admin','관리자','제목1',41,'2021-01-01','<p>컨텐츠내용1</p>');
INSERT INTO bbs(major, writer_id, writer_name, title, category, last_modified, text) VALUE('main','admin','관리자','제목2',42,'2021-01-01','<p>컨텐츠내2용</p>');

CREATE TABLE comment(
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `writer_id` VARCHAR(50) NOT NULL,
  `writer_name` VARCHAR (50) NOT NULL,
  `comment` VARCHAR(200) NOT NULL,
  `comment_date` DATE NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO comment(id, writer_id,writer_name, comment,comment_date) VALUE ('0','amin','관리자','이것은 test 댓글 입니다.','2021-01-01');