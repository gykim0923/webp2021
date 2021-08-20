DROP DATABASE if EXISTS swaig ;
CREATE DATABASE swaig DEFAULT CHARACTER SET utf8mb4; 
USE swaig ;
CREATE TABLE example (
 `oid` INT(11) NOT NULL AUTO_INCREMENT,
 `title` VARCHAR(100) DEFAULT NULL,
 `content` VARCHAR(100) DEFAULT NULL,
 `date` DATE DEFAULT NULL, PRIMARY KEY (`oid`)
) ;
INSERT INTO example(oid, title, content, `date`) VALUES(1,'title1','content1','2021-06-26');
INSERT INTO example(title, content, `date`) VALUES('title2','content2','2021-06-27');
INSERT INTO example(title, content, `date`) VALUES('title3','content3','2021-06-28');
INSERT INTO example(title, content, `date`) VALUES('title4','내용내용내용','2021-06-28');

CREATE TABLE menu_tabs(
    `tab_id` INT(10) NOT NULL,
    `tab_title` VARCHAR(30) NOT NULL,
    `tab_level` INT(10) NOT NULL,
    `tab_img` VARCHAR(30) NOT NULL,
    `tab_url` VARCHAR(50) NOT NULL,
    `orderNum` INT(10) NOT NULL, PRIMARY KEY(`tab_id`)
);
INSERT INTO menu_tabs(tab_id, tab_title, tab_level, tab_img, tab_url, orderNum) VALUES('1', 'SWAIG 소개', '4', 'info-circle-fill', 'information.kgu', '1');
INSERT INTO menu_tabs(tab_id, tab_title, tab_level, tab_img, tab_url, orderNum) VALUES('2', 'SWAIG 알림', '4', 'bootstrap-fill', 'bbs.kgu', '2');
INSERT INTO menu_tabs(tab_id, tab_title, tab_level, tab_img, tab_url, orderNum) VALUES('3', '신청하기', '4', 'check-circle-fill', 'bbs.kgu', '3');
INSERT INTO menu_tabs(tab_id, tab_title, tab_level, tab_img, tab_url, orderNum) VALUES('4', '전공보기', '4', 'pencil-fill', '#', '4');
INSERT INTO menu_tabs(tab_id, tab_title, tab_level, tab_img, tab_url, orderNum) VALUES('5', '세부전공', '4', 'bookmark-star-fill', 'information.kgu', '5');


CREATE TABLE menu_pages(
    `page_id` INT(10) NOT NULL,
    `tab_id` INT(10) NOT NULL,
    `orderNum` INT(10) NOT NULL,
    `page_path` VARCHAR(50) NOT NULL,
    `page_title` VARCHAR(250) NOT NULL,
	  PRIMARY KEY(`page_id`)
);

INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('10', '1', '0', 'information.kgu', 'SWAIG소개');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('11', '1', '1', 'contact.kgu', '위치 및 연락처');

INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('20', '2', '0', 'bbs.kgu', '전체공지');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('21', '2', '1', 'bbs.kgu', 'SWAIG 공지');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('22', '2', '2', 'bbs.kgu', '수업공지');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('23', '2', '3', 'bbs.kgu', '취업공지');

INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('30', '3', '0', 'reg.kgu', '신청하기');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('31', '3', '1', 'bbs.kgu', '학과자료실');

INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('50', '5', '0', 'information.kgu', '전공소개');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('51', '5', '1', 'curriculum.kgu', '교육과정');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('52', '5', '2', 'professor.kgu', '교수진');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('53', '5', '3', 'bbs.kgu', '전공게시판');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('54', '5', '4', 'bbs.kgu', '자유게시판');

INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('60', '6', '0', 'mypage.kgu', '마이페이지');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('61', '6', '1', 'whatIDoPage.kgu', '활동내역');

INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('70', '7', '0', 'admin.kgu', '홈페이지관리');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('71', '7', '1', 'admin.kgu', '회원관리');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('72', '7', '2', 'admin.kgu', '메뉴관리');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('73', '7', '3', 'admin.kgu', '로그확인');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('74', '7', '4', 'admin.kgu', '엑셀관리');
INSERT INTO menu_pages(page_id,tab_id,orderNum,page_path,page_title) VALUE('75', '7', '5', 'admin.kgu', '비밀번호변경');

CREATE TABLE usertype(
    `type_name` varchar(45) NOT NULL,
    `class_type` VARCHAR(45) NOT NULL,
    `board_level` int NOT NULL,
    `for_header` varchar(45) NOT NULL,
     PRIMARY KEY(`type_name`)
);

INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('홈페이지관리자', 'Admin', '0', '관리자');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('교수', 'Professor', '1', '교수');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('조교', 'Professor', '1', '조교');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('학부생', 'Student', '2', '학생');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('학부모', 'Etc', '3', '기타');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('입학예정자', 'Etc', '3', '기타');
INSERT INTO usertype(type_name,class_type,board_level,for_header) VALUE('기타', 'Etc', '3', '기타');


CREATE TABLE user(
	`google_id` VARCHAR(100) DEFAULT NULL,
	`google_img` VARCHAR(100) DEFAULT NULL,
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
    `sub_major` VARCHAR (200) NOT NULL DEFAULT '-',
    `per_id` VARCHAR(45) NOT NULL DEFAULT '-',
    `grade` VARCHAR(10) NOT NULL DEFAULT '-',
    `state` VARCHAR(10) NOT NULL DEFAULT '-',
    PRIMARY KEY (`id`)
);

INSERT INTO user(google_id,id,password,name,gender,birth,type,email,phone,last_login,hope_type,reg_date,major,per_id,grade,state) VALUE('102261805363448965606','201713919', '6ab7108f5c8ab980a584f1e2b98b2991b087af4907864575e6905edf2b759ae8', '윤주현', '남', '1996-03-25', '학부생', 'gabrielyoon7@kyonggi.ac.kr','010-0000-0001','2021-07-05','-','2021-07-05','main','201713919','-','-');
INSERT INTO user(id,password,name,gender,birth,type,email,phone,last_login,hope_type,reg_date,major,per_id,grade,state) VALUE('admin', '112b16f5f7b04cecda94c345900574686e5ed35803e2b7e9702fa4b46810a2d4', '관리자테스트', '-', '2021-01-01', '홈페이지관리자', 'admin@kyonggi.ac.kr','010-0000-0000','2021-07-05','-','2021-07-05','main','-','-','-');
INSERT INTO user(id,password,name,gender,birth,type,email,phone,last_login,hope_type,reg_date,major,per_id,grade,state) VALUE('swaigmgr', '91255949a2784860dff169dfc6d99e760c59e0090413b0c31f5a8042c3d434f2', '관리자', '-', '2021-01-01', '홈페이지관리자', 'admin@kyonggi.ac.kr','010-0000-0000','2021-07-05','-','2021-07-05','main','-','-','-');
INSERT INTO user(id,password,name,gender,birth,type,email,phone,last_login,hope_type,reg_date,major,per_id,grade,state) VALUE('professor', '1f9d870484301db50342aa184bd9f3f891195090030ad56cbbc9d0f0b996a567', '교수테스트', '-', '2021-01-01', '교수', 'professor@kyonggi.ac.kr','010-0000-0000','2021-07-05','-','2021-07-05','main','-','-','-');
INSERT INTO user(id,password,name,gender,birth,type,email,phone,last_login,hope_type,reg_date,major,per_id,grade,state) VALUE('202100000', '9f50515645763c0b8704f8114c81da0fddd2b4bdc9240de158e905884d8cb840', '학생테스트', '-', '2021-01-01', '학부생', 'student@test.com','010-0000-0001','2021-07-05','-','2021-07-05','main','201713919','-','-');
INSERT INTO user(id,password,name,gender,birth,type,email,phone,last_login,hope_type,reg_date,major,per_id,grade,state) VALUE('etc', '7bbe475cfc8390cb8c2ca19de371e1a3b5ab88ef39760d7ce0da003a59773a14', '기타테스트', '-', '2021-01-01', '기타', 'etc@test.com','010-0000-0001','2021-07-05','-','2021-07-05','main','201713919','-','-');



CREATE TABLE major(
    `oid` int(50) NOT NULL AUTO_INCREMENT,
    `major_id` VARCHAR(50) NOT NULL,
    `major_name` VARCHAR(100) NOT NULL,
    `major_location` VARCHAR(100) NOT NULL,
    `major_contact` VARCHAR(100) NOT NULL,
     PRIMARY KEY (`oid`)
);

INSERT INTO major(oid,major_id,major_name,major_location,major_contact) VALUE('1','main','융합교육원 SWAIG','수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288');

CREATE TABLE text(
    `id` int(50) NOT NULL,
    `major` VARCHAR(50) NOT NULL,
    `content` TEXT NOT NULL,
    PRIMARY KEY(`id`,`major`)
);
 
CREATE TABLE professor(
    `id` int(50) NOT NULL AUTO_INCREMENT,
    `prof_major` VARCHAR(100) NOT NULL,
    `prof_img` VARCHAR (100) NOT NULL,
    `prof_name` VARCHAR (100) NOT NULL,
    `prof_email` VARCHAR (100) NOT NULL,
    `prof_lecture` VARCHAR (200) NOT NULL,
    `prof_location` VARCHAR (100) NOT NULL,
    `prof_call` VARCHAR (100) NOT NULL,
    `prof_color` VARCHAR (100) NOT NULL DEFAULT '#777777',
    PRIMARY KEY (`id`)
);

CREATE TABLE curriculum(
    `major` VARCHAR(50) NOT NULL,
    `year` INT(10) NOT NULL,
    `curriculum_img` VARCHAR(100) NOT NULL,
    `edu_img` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`major`, `year`)
);

CREATE TABLE schedule(
	   `id` INT(10) NOT NULL AUTO_INCREMENT,
	   `date` DATETIME NOT NULL,
	   `content` VARCHAR(100) NOT NULL,
	   PRIMARY KEY (`id`)
);

CREATE TABLE uploaded_file(
	  `id` INT(10) NOT NULL AUTO_INCREMENT,
	  `user_id` VARCHAR(100) NOT NULL,
	  `uploadFile` VARCHAR(100) NOT NULL,
	  `newFileName` VARCHAR(100) NOT NULL,
	  `upload_time` DATE NOT NULL,
	  `savePath` VARCHAR(100)  NOT NULL,
	  `folder` VARCHAR(100)  NOT NULL,
	  `uploaded` VARCHAR(10) NOT NULL DEFAULT 'false',
	  PRIMARY KEY (`id`)
);

CREATE TABLE slider(
    `id` INT(10) NOT NULL AUTO_INCREMENT,
    `slider_img` VARCHAR(100) DEFAULT NULL,
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

CREATE TABLE location(
    `id` INT(10) NOT NULL,
    `address` VARCHAR(200) NOT NULL,
    `contact_num` VARCHAR(100) NOT NULL,
    `content` VARCHAR(500) NOT NULL, PRIMARY KEY(`id`)
);
INSERT INTO location(id, address, contact_num, content) VALUE ('0', 'K-WITH 융합교육원 수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288','수정바랍니다.');

CREATE TABLE bbs(
    `id` INT(10) NOT NULL AUTO_INCREMENT,
    `major` VARCHAR(50) NOT NULL,
    `writer_id` VARCHAR(50) NOT NULL,
    `writer_name` VARCHAR(50) NOT NULL,
    `title` VARCHAR(200) NOT NULL,
    `category` INT(10) NOT NULL,
    `views` INT(10) DEFAULT 0,
    `level` INT(10) DEFAULT 0,
    `last_modified` DATETIME NOT NULL,
    `text` TEXT NOT NULL,
    `comments_count` INT(10) DEFAULT 0 ,
    `likes` INT(10) DEFAULT 0,
    `already_like` varchar(3000) NOT NULL DEFAULT '',
    PRIMARY KEY(`id`)
);

CREATE TABLE comment(
	  `id` INT(10) NOT NULL AUTO_INCREMENT,
	  `writer_id` VARCHAR(50) NOT NULL,
	  `writer_name` VARCHAR (50) NOT NULL,
	  `comment` VARCHAR(200) NOT NULL,
	  `comment_date` DATETIME NOT NULL,
	  `bbs_id` INT(10) NOT NULL,
	  PRIMARY KEY (`id`)
);

CREATE TABLE kgu_major(
    `id` INT(10) NOT NULL AUTO_INCREMENT,
    `campus` VARCHAR(50) NOT NULL ,
    `college` VARCHAR(100) NOT NULL ,
    `major` VARCHAR(100)NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO kgu_major(id, campus, college, major) VALUE (1,'수원캠퍼스', '진성애교양대학', '교직학부 교육학전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (2,'수원캠퍼스', '진성애교양대학', 'ROTC');

INSERT INTO kgu_major(id, campus, college, major) VALUE (3,'수원캠퍼스', '인문대학', '유아교육과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (4,'수원캠퍼스', '인문대학', '국어국문학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (5,'수원캠퍼스', '인문대학', '영어영문학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (6,'수원캠퍼스', '인문대학', '중어중문학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (7,'수원캠퍼스', '인문대학', '사학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (8,'수원캠퍼스', '인문대학', '문헌정보학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (9,'수원캠퍼스', '인문대학', '문예창작학과');

INSERT INTO kgu_major(id, campus, college, major) VALUE (10,'수원캠퍼스', '예술체육대학', '서양화.미술경영학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (11,'수원캠퍼스', '예술체육대학', '한국화.서예학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (12,'수원캠퍼스', '예술체육대학', '입체조형학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (13,'수원캠퍼스', '예술체육대학', '디자인비즈학부 시각정보디자인전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (14,'수원캠퍼스', '예술체육대학', '디자인비즈학부 산업디자인전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (15,'수원캠퍼스', '예술체육대학', '디자인비즈학부 장신구.금속디자인전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (16,'수원캠퍼스', '예술체육대학', 'FineArts학부');
INSERT INTO kgu_major(id, campus, college, major) VALUE (17,'수원캠퍼스', '예술체육대학', '스포츠과학부 스포츠건강과학전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (18,'수원캠퍼스', '예술체육대학', '스포츠과학부 레저스포츠전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (19,'수원캠퍼스', '예술체육대학', '스포츠과학부 스포츠산업경영전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (20,'수원캠퍼스', '예술체육대학', '스포츠과학부 스포츠레저산업전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (21,'수원캠퍼스', '예술체육대학', '시큐리티매니지먼트학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (22,'수원캠퍼스', '예술체육대학', '체육학과');

INSERT INTO kgu_major(id, campus, college, major) VALUE (23,'수원캠퍼스', '지식정보서비스대학', '법학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (24,'수원캠퍼스', '지식정보서비스대학', '행정학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (25,'수원캠퍼스', '지식정보서비스대학', '경찰행정학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (26,'수원캠퍼스', '지식정보서비스대학', '휴먼서비스학부 사회복지전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (27,'수원캠퍼스', '지식정보서비스대학', '휴먼서비스학부 교정보호전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (28,'수원캠퍼스', '지식정보서비스대학', '휴먼서비스학부 청소년전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (29,'수원캠퍼스', '지식정보서비스대학', '국제관계학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (30,'수원캠퍼스', '지식정보서비스대학', '경제학부 경제전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (31,'수원캠퍼스', '지식정보서비스대학', '경제학부 응용통계전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (32,'수원캠퍼스', '지식정보서비스대학', '지식재산학과');

INSERT INTO kgu_major(id, campus, college, major) VALUE (33,'수원캠퍼스', '사회과학대학', '공공안전학부');
INSERT INTO kgu_major(id, campus, college, major) VALUE (34,'수원캠퍼스', '사회과학대학', '공공인재학부');
INSERT INTO kgu_major(id, campus, college, major) VALUE (35,'수원캠퍼스', '사회과학대학', '경제학부');

INSERT INTO kgu_major(id, campus, college, major) VALUE (36,'수원캠퍼스', '소프트웨어경영대학', 'K-WITH 융합교육원 관광스포츠산업융합전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (37,'수원캠퍼스', '소프트웨어경영대학', 'K-WITH 융합교육원 창업융합전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (38,'수원캠퍼스', '소프트웨어경영대학', 'K-WITH 융합교육원 융합데이터공학전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (39,'수원캠퍼스', '소프트웨어경영대학', 'K-WITH 융합교육원 커뮤니티안전회복융합전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (40,'수원캠퍼스', '소프트웨어경영대학', 'AI컴퓨터공학부 컴퓨터공학전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (41,'수원캠퍼스', '소프트웨어경영대학', 'AI컴퓨터공학부 인공지능전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (42,'수원캠퍼스', '소프트웨어경영대학', '경영학부');
INSERT INTO kgu_major(id, campus, college, major) VALUE (43,'수원캠퍼스', '소프트웨어경영대학', '회계세무.경영정보학부 경영정보전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (44,'수원캠퍼스', '소프트웨어경영대학', '회계세무.경영정보학부 회계세무전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (45,'수원캠퍼스', '소프트웨어경영대학', '국제산업정보학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (46,'수원캠퍼스', '소프트웨어경영대학', '경영학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (47,'수원캠퍼스', '소프트웨어경영대학', '컴퓨터공학부');
INSERT INTO kgu_major(id, campus, college, major) VALUE (48,'수원캠퍼스', '소프트웨어경영대학', '산업경영공학과');

INSERT INTO kgu_major(id, campus, college, major) VALUE (49,'수원캠퍼스', '융합과학대학', '수학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (50,'수원캠퍼스', '융합과학대학', '전자물리학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (51,'수원캠퍼스', '융합과학대학', '나노공학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (52,'수원캠퍼스', '융합과학대학', '화학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (53,'수원캠퍼스', '융합과학대학', '바이오융합학부 생명과학전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (54,'수원캠퍼스', '융합과학대학', '바이오융합학부 식품생물공학전공');

INSERT INTO kgu_major(id, campus, college, major) VALUE (55,'수원캠퍼스', '창의공과대학', '토목공학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (56,'수원캠퍼스', '창의공과대학', '건축학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (57,'수원캠퍼스', '창의공과대학', '건축공학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (58,'수원캠퍼스', '창의공과대학', '도시.교통공학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (59,'수원캠퍼스', '창의공과대학', '전자공학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (60,'수원캠퍼스', '창의공과대학', '기계시스템공학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (61,'수원캠퍼스', '창의공과대학', '신소재공학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (62,'수원캠퍼스', '창의공과대학', '환경에너지공학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (63,'수원캠퍼스', '창의공과대학', '화학공학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (64,'수원캠퍼스', '창의공과대학', '융합에너지시스템공학부');
INSERT INTO kgu_major(id, campus, college, major) VALUE (65,'수원캠퍼스', '창의공과대학', '스마트시티공학부');
INSERT INTO kgu_major(id, campus, college, major) VALUE (66,'수원캠퍼스', '창의공과대학', '기계시스템공학부');
INSERT INTO kgu_major(id, campus, college, major) VALUE (67,'수원캠퍼스', '창의공과대학', '융합에너지시스템공학부');

INSERT INTO kgu_major(id, campus, college, major) VALUE (68,'수원캠퍼스(야간)', '창의공과대학', '건축공학과(계약학과)');
INSERT INTO kgu_major(id, campus, college, major) VALUE (69,'수원캠퍼스(야간)', '창의공과대학', '건축안전공학과(계약학과)');

INSERT INTO kgu_major(id, campus, college, major) VALUE (70,'서울캠퍼스', '진성애교양대학', '교직학부 교육학전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (71,'서울캠퍼스', '소프트웨어경영대학', 'K-WITH 융합교육원 미디어융합콘텐츠전공');
INSERT INTO kgu_major(id, campus, college, major) VALUE (72,'서울캠퍼스', '관광문화대학', '관광경영학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (73,'서울캠퍼스', '관광문화대학', '관광개발학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (74,'서울캠퍼스', '관광문화대학', '호텔경영학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (75,'서울캠퍼스', '관광문화대학', '외식.조리학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (76,'서울캠퍼스', '관광문화대학', '관광이벤트학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (77,'서울캠퍼스', '관광문화대학', '연기학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (78,'서울캠퍼스', '관광문화대학', '애니메이션영상학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (79,'서울캠퍼스', '관광문화대학', '애니메이션학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (80,'서울캠퍼스', '관광문화대학', '실용음악학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (81,'서울캠퍼스', '관광문화대학', '미디어영상학과');
INSERT INTO kgu_major(id, campus, college, major) VALUE (82,'서울캠퍼스', '관광문화대학', '관광학부 ');



CREATE TABLE favorite_menu(
     `id` INT(10) NOT NULL AUTO_INCREMENT,
     `name` VARCHAR(100) NOT NULL ,
     `url` VARCHAR(100)NOT NULL,
     PRIMARY KEY (`id`)
);
INSERT INTO favorite_menu(id, name, url) VALUE ('0', '경기대학교', 'http://www.kyonggi.ac.kr/KyonggiUp.kgu');
INSERT INTO favorite_menu(name, url) VALUE ('성적확인', 'https://grade.kyonggi.ac.kr/');
INSERT INTO favorite_menu(name, url) VALUE ('수강신청', 'http://sugang.kyonggi.ac.kr/');
INSERT INTO favorite_menu(name, url) VALUE ('KUTIS', 'https://kutis.kyonggi.ac.kr/webkutis/view/indexWeb.jsp');
INSERT INTO favorite_menu(name, url) VALUE ('LMS', 'https://lms.kyonggi.ac.kr/login.php');
INSERT INTO favorite_menu(name, url) VALUE ('융합교육원', 'https://sites.google.com/kyonggi.ac.kr/k-with');

CREATE TABLE bbs_file(
    `id` INT NOT NULL ,
    `major` varchar(100) null,
    `bbs_id` Int(10) not null,
    `original_FileName` varchar(200) not null,
    `real_FileName` varchar(200) not null,
    PRIMARY KEY (`id`)
);

CREATE TABLE log(
    `id` INT Auto_Increment,
    `user_id` VARCHAR(20) NOT NULL ,
    `user_name` VARCHAR(50) NOT NULL ,
    `user_type` VARCHAR(50) NOT NULL ,
    `log_time` DATETIME NOT NULL ,
    `log_type` VARCHAR(50) NOT NULL ,
    PRIMARY KEY (`id`)
);

CREATE TABLE bbs_reg_answer(

    `id` INT Auto_Increment,
    `reg_id` INT(10) NOT NULL,
    `question_num` INT(10) NOT null,
    `answer` varchar(200) not null,
    `writer_name` varchar(100) not null,
    `writer_id` varchar(100) not null,
    `writer_grade` varchar(100) not null,
    `writer_type` varchar(100) not null,
    `writer_perId` varchar(100) null,
    PRIMARY KEY (`id`)

);

CREATE TABLE bbs_reg_answer_file(
    `id` INT Auto_Increment,
    `reg_id` INT(10) NOT NULL,
    `original_FileName` varchar(300) not null,
    `real_FileName` varchar(300) not null,
    `writer_id` varchar(100) not null,
    PRIMARY KEY(`id`)
);

CREATE TABLE bbs_reg_question(
    `id` INT Auto_Increment,
    `reg_id` INT(10) NOT NULL,
    `question_num` int(10) not null,
    `question_content` varchar(600) not null,
    `question_type` TINYINT(3) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE bbs_reg_writer_file(
    `id` INT NOT NULL ,
    `reg_id` Int(10) not null,
    `original_FileName` varchar(200) not null,
    `real_FileName` varchar(200) not null,
    PRIMARY KEY (`id`)
);


CREATE TABLE bbs_reg(
      `id` INT(10) NOT NULL AUTO_INCREMENT,
      `writer_id` VARCHAR(50) NOT NULL,
      `writer_name` VARCHAR(50) NOT NULL,
      `title` VARCHAR(200) DEFAULT '제목없음',
      `views` INT(10) DEFAULT 0,
      `last_modified` DATETIME NOT NULL ,
      `text` TEXT NOT NULL,
      `starting_date` DATETIME NOT NULL ,
      `closing_date` DATETIME NOT NULL ,
      `level` VARCHAR(50) NOT NULL ,
      `for_who` INT NOT NULL ,
      `applicant_count` INT(10) DEFAULT 0,
      PRIMARY KEY(`id`)
);
