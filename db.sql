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
INSERT INTO major(major_id,major_name,major_location,major_contact) VALUE('major1','문화재관리학융합전공','수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288');
INSERT INTO major(major_id,major_name,major_location,major_contact) VALUE('major2','형사사법학융합전공','수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288');
-- INSERT INTO major(major_id,major_name,major_location,major_contact) VALUE('major3','심리상담융합전공','수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288');
-- INSERT INTO major(major_id,major_name,major_location,major_contact) VALUE('major4','관광스포츠산업융합전공','수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288');
-- INSERT INTO major(major_id,major_name,major_location,major_contact) VALUE('major5','창업합전공','수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288');
-- INSERT INTO major(major_id,major_name,major_location,major_contact) VALUE('major6','커뮤니티공공안전융합전공','수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288');
-- INSERT INTO major(major_id,major_name,major_location,major_contact) VALUE('major7','융합데이터공학융합전공','수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288');
-- INSERT INTO major(major_id,major_name,major_location,major_contact) VALUE('major8','미디어융합콘텐츠융합전공','수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288');
-- INSERT INTO major(major_id,major_name,major_location,major_contact) VALUE('major9','AI경영융합전공','수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288');
-- INSERT INTO major(major_id,major_name,major_location,major_contact) VALUE('major10','스마트AI융합전공','수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288');
-- INSERT INTO major(major_id,major_name,major_location,major_contact) VALUE('major11','미디어융합콘텐츠융합전공 트랙','수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288');
-- INSERT INTO major(major_id,major_name,major_location,major_contact) VALUE('major12','융합데이터공학융합전공트랙융합전공','수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288');

CREATE TABLE text(
    `id` int(50) NOT NULL,
    `major` VARCHAR(50) NOT NULL,
    `content` TEXT NOT NULL,
    PRIMARY KEY(`id`,`major`)
);
INSERT INTO text(id, major, content) VALUE('10','main','<ul>
	<li>융합전공은?</li>
</ul>

<p>2개 이상의 학과(부) 또는 전공을 융합하여 제공되는 다전공 교육과정중 하나로 학생들에게 다양한 교육기회를 제공하고, 실용성 강화를 통한 교육 경쟁력 제고로 사회에서 요구하는 인재상 실현 및 교육, 신학문, 신지식 창출을 통한 연구 중심 대학 기반 구축을 위한 제도이다.</p>

<ul>
	<li>&nbsp;경기대학교 K-WITH융합교육원은 4차 산업혁명의 시대적 흐름과 유망 분야 인재양성 강화를 위해 2021년 3월에 설립되었습니다. K-WITH융합교육원의 K의 의미는 우리 대학 경기대의 이니셜인 K, 경 기도의 K, 더 나아가서 대한민국의 K를 뜻합니다. 이는 우리 대학이 표방하는 경기도를 대표하는 대학 을 넘어 우리나라를 대표하는 대학으로 성장하고 더 나아가 전 세계 교육의 트렌드를 선도하고 국가 경 쟁력에 이바지하기 위한 노력으로 K 대학으로서의 목표를 달성하고자 하는 의지를 나타낸 것입니다. 이와 함께 &#39;K-WITH&#39; 는 지속성장을 의미하는 &#39;Keep up with Growth&#39; 의 의미를 함축하는 것으로 대 학 구성원들이 경기대와 지속성장을 함께 누리기를 바라는 희망을 나타낸 것입니다. 이러한 배경으로 탄생한 K-WITH 융합교육원은 융합전공 교육과정 편성과 개편, 교수학습지원을 위한 지원 업무를 적 극적으로 추진하고자 합니다. 본 K-WITH융합교육원은 우리 경기대학교의 비전인 &#39;글로벌 역량을 갖춘 융&middot;복합 인재 양성 대학&#39; 달 성 정진에 발맞추어 효율적인 융합교육과정의 개발과 지원, 교수능력 개발과 학습능력 개발을 위한 연 구와 지원에 정성을 다하도록 하겠습니다. 교수님들과 학생들의 지속적인 관심과 격려를 부탁드립니다. 감사합니다.</li>
</ul>

');
INSERT INTO text(id, major, content) VALUE('50','main','50-main');
-- 
-- INSERT INTO text(id, major, content) VALUE('50','major1','<p>▣ 문화재관리학융합전공(Management of Cultural Properties)</p>
-- 
-- <p>- 참여학과: 건축학과, 문헌정보학과, 사학과, 미술경영전공</p>
-- 
-- <p>- 이수학점: 42학점</p>
-- <p>- 학위명: 문화재학사</p>
-- <p>&nbsp;</p>
-- 
-- <p>▣ 교육목표</p>
-- 
-- <p>- 문화재에 대한 애정과 관심을 고취시키고 이론과 실제를 겸비한 인재양성 문화재관리를 위한 종합적이고 체계적인 지식과 실무능력을 갖춘 전문가 양성</p>
-- <p>&nbsp;</p>
-- <p>▣ 취업분야</p>
-- <p>- 문화재 행정직 및 학예직 공무원 - 문화재 전시 및 문화교육 분야 전문가 - 문화재관리 및 문화경영 분야 단체 및 기업 담당자</p>
-- 
-- 
-- ');
-- INSERT INTO text(id, major, content) VALUE('50','major2','<p>▣ 형사사법학융합전공(Criminal Justice)</p>
-- 
-- <p>- 참여학과: 공공안전학부, 범죄교정전공, 경찰행정전공, 시큐리티매니지먼트학과</p>
-- 
-- <p>- 이수학점: 42학점</p>
-- <p>- 학위명: 법학사</p>
-- <p>&nbsp;</p>
-- 
-- <p>▣ 교육목표</p>
-- 
-- <p>- 현대사회의 범죄 원인 분석과 대책마련에 필요한 기본지식 함양 - 실무지식 습득을 통한 범죄 위험에 효과적으로 대처할 수 있는 전문인력 양성</p>
-- <p>&nbsp;</p>
-- <p>▣ 취업분야</p>
-- <p>- 문화재 행정직 및 학예직 공무원 - 문화재 전시 및 문화교육 분야 전문가 - 문화재관리 및 문화경영 분야 단체 및 기업 담당자</p>
-- ');
-- INSERT INTO text(id, major, content) VALUE('50','major3','<p>▣ 형사사법학융합전공(Criminal Justice)</p>
-- 
-- <p>- 참여학과: 공공안전학부, 범죄교정전공, 경찰행정전공, 시큐리티매니지먼트학과</p>
-- 
-- <p>- 이수학점: 42학점</p>
-- <p>- 학위명: 법학사</p>
-- <p>&nbsp;</p>
-- 
-- <p>▣ 교육목표</p>
-- 
-- <p>- 현대사회의 범죄 원인 분석과 대책마련에 필요한 기본지식 함양 - 실무지식 습득을 통한 범죄 위험에 효과적으로 대처할 수 있는 전문인력 양성</p>
-- <p>&nbsp;</p>
-- <p>▣ 취업분야</p>
-- <p>- 문화재 행정직 및 학예직 공무원 - 문화재 전시 및 문화교육 분야 전문가 - 문화재관리 및 문화경영 분야 단체 및 기업 담당자</p>
-- ');
-- 
-- INSERT INTO text(id, major, content) VALUE('51','main','51-main');
-- INSERT INTO text(id, major, content) VALUE('51','major1','51-major1');
-- 
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

-- INSERT INTO professor(id, prof_img,prof_name, prof_email,prof_lecture,prof_location,prof_call) VALUE(1,'img/professor/professor1.jpeg','권기현','khkwon@kyonggi.ac.kr','이산수학','8209호',' 031-249-9666');
-- INSERT INTO professor(id, prof_img,prof_name, prof_email,prof_lecture,prof_location,prof_call) VALUE(2,'img/professor/professor1.jpeg','권기현','khkwon@kyonggi.ac.kr','이산수학','8209호',' 031-249-9666');

CREATE TABLE curriculum(
    `major` VARCHAR(50) NOT NULL,
    `year` INT(10) NOT NULL,
    `curriculum_img` VARCHAR(100) NOT NULL,
    `edu_img` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`major`, `year`)
);

-- INSERT INTO curriculum(major, year, curriculum_img, edu_img) VALUE('main',2020,'/img/cs_logo.png','#');
-- INSERT INTO curriculum(major, year, curriculum_img, edu_img) VALUE('main',2021,'#','/img/cs_logo.png');
-- INSERT INTO curriculum(major, year, curriculum_img, edu_img) VALUE('major1',2021,'/img/cs_logo.png','#');


CREATE TABLE schedule(
                           `id` INT(10) NOT NULL AUTO_INCREMENT,
                           `date` DATETIME NOT NULL,
                           `content` VARCHAR(100) NOT NULL,
                           PRIMARY KEY (`id`)
);
-- INSERT INTO schedule(id, date, content) VALUE ('0', '2021-08-01', '프로젝트 마감');

CREATE TABLE uploadedFile(
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
-- INSERT INTO developer(id, team_name, members, start_date, end_date) VALUE (1, '웹 6기', '17학번 윤주현---19학번 김가영 박선애 박소영 박의진', '2021-07-05', '2021-08-31');

CREATE TABLE location(
    `id` INT(10) NOT NULL,
    `address` VARCHAR(200) NOT NULL,
    `contact_num` VARCHAR(100) NOT NULL,
    `content` VARCHAR(500) NOT NULL, PRIMARY KEY(`id`)
);
INSERT INTO location(id, address, contact_num, content) VALUE ('0', 'K-WITH 융합교육원 수원캠퍼스 예지관(4강의동) 4002호', '031-249-9288','hi');

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

-- INSERT INTO bbs(id, major, writer_id, writer_name, title, category, last_modified, text) VALUE('0', 'main','admin','관리자','제목1',21,'2021-01-01','<p>컨텐츠내용1</p>');
-- INSERT INTO bbs(major, writer_id, writer_name, title, category, last_modified, text) VALUE('main','admin','관리자','제목2',22,'2021-01-01','<p>컨텐츠내2용</p>');
-- INSERT INTO bbs(major, writer_id, writer_name, title, category, last_modified, text) VALUE('main','admin','관리자','제목3',23,'2021-01-01','<p>컨텐츠내용3</p>');
-- INSERT INTO bbs(major, writer_id, writer_name, title, category, last_modified, text) VALUE('main','admin','관리자','제목22332',21,'2021-01-01','<p>컨텐츠내2용4</p>');
-- INSERT INTO bbs(major, writer_id, writer_name, title, category, last_modified, text) VALUE('main','admin','관리자','제목2323232',21,'2021-01-01','<p>컨텐츠내2용5</p>');
-- INSERT INTO bbs(major, writer_id, writer_name, title, category, last_modified, text) VALUE('main','admin','관리자','제목23232',23,'2021-01-01','<p>컨텐츠내2용6</p>');
-- INSERT INTO bbs(major, writer_id, writer_name, title, category, last_modified, text) VALUE('main','admin','관리자','제목4552',21,'2021-01-01','<p>컨텐츠내2용7</p>');
-- INSERT INTO bbs(major, writer_id, writer_name, title, category, last_modified, text) VALUE('main','admin','관리자','44444',31,'2021-01-01','<p>컨텐츠내2용7</p>');


CREATE TABLE comment(
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `writer_id` VARCHAR(50) NOT NULL,
  `writer_name` VARCHAR (50) NOT NULL,
  `comment` VARCHAR(200) NOT NULL,
  `comment_date` DATETIME NOT NULL,
  `bbs_id` INT(10) NOT NULL,
  PRIMARY KEY (`id`)
);

-- INSERT INTO comment(id, writer_id,writer_name, comment,comment_date,bbs_id) VALUE ('1','admin','관리자','이것은 test 댓글 입니다.','2021-01-01','1');

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

-- INSERT INTO log(id, user_id, user_name, user_type,log_time, log_type) VALUE ('1', 'admin', '관리자테스트','홈페이지관리자','2020-08-04 12:39:40','로그인');
-- INSERT INTO log(id, user_id, user_name, user_type,log_time, log_type) VALUE ('2', 'admin', '관리자테스트','홈페이지관리자','2020-08-11 12:39:40','로그인');
-- INSERT INTO log(id, user_id, user_name, user_type,log_time, log_type) VALUE ('3', 'admin', '관리자테스트','홈페이지관리자','2020-08-12 12:39:40','로그인');
-- INSERT INTO log(id, user_id, user_name, user_type,log_time, log_type) VALUE ('4', 'admin', '관리자테스트','홈페이지관리자','2021-07-02 12:39:40','로그인');
-- INSERT INTO log(id, user_id, user_name, user_type,log_time, log_type) VALUE ('5', 'admin', '관리자테스트','홈페이지관리자','2021-07-04 12:39:40','로그인');
-- INSERT INTO log(id, user_id, user_name, user_type,log_time, log_type) VALUE ('6', 'admin', '관리자테스트','홈페이지관리자','2021-08-04 12:39:40','로그인');




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

CREATE TABLE bbs_reg_answerFile(
    `id` INT Auto_Increment,
    `reg_id` INT(10) NOT NULL,
    `original_FileName` varchar(300) not null,
    `real_FileName` varchar(300) not null,
    `writer_id` varchar(100) not null,
    PRIMARY KEY(`id`)
);

CREATE TABLE bbs_regQuestion(
    `id` INT Auto_Increment,
    `reg_id` INT(10) NOT NULL,
    `question_num` int(10) not null,
    `question_content` varchar(600) not null,
    `question_type` TINYINT(3) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE bbs_reg_WriterFile(
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

-- INSERT INTO bbs_reg(id,writer_id,writer_name,title,last_modified,text,starting_date,closing_date,level,for_who) VALUE (1,'admin','관리자','test','2021-07-05','testtest','2021-07-05','2021-08-05','학생',0);
-- INSERT INTO bbs_reg(writer_id,writer_name,title,last_modified,text,starting_date,closing_date,level,for_who) VALUE ('admin','관리자','test','2021-07-05','test123','2021-07-05','2021-07-15','학생',1);