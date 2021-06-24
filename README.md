SWAIG 프로젝트(가제)
=============
경기대학교 AI컴퓨터공학부 웹서버 프로젝트 (cshome 6기)

[홈페이지에서 확인하기(미오픈)](http://swaig.kyonggi.ac.kr)

>경기대학교 AI컴퓨터공학부
> >이은정 지도교수님
* * *
## SWAIG Developers
### cs home 6기 (2021 여름방학)
- 윤주현(201713919)
  >github@gabrielyoon7
- 김가영(201912021)
  > github@gykim0923
- 박선애(201912067)
  > github@SeonaePark
- 박소영(201912069)
  > github@soyoung125
- 박의진(201912072)
  > github@jinny-park
* * *
## History
- 2021.06.24
  - [윤주현] 기본 프로젝트 핵심 코드 이식 및 작성, 각종 버전 Update 및 플랫폼 변경 (JavaEE6 -> JavaEE8, mysql -> mariaDB10.5, bootstrap4.0 -> bootstrap5.0), readme 작성, 프로젝트 github에 공개 (교수님 허락 받음.)
- 2021.06.23
  - [전 체] 프로젝트 인수 인계

* * *
## Rules of Project development
- 본인이 뭐 했는지 readme에 꼼꼼하게 업데이트 할 것. (문서화 안하면 내년에 시달릴 수 있음. + 추적이 필요함)
- Github 사용 시 Pull 먼저 하기
- 쓸 데 없는 파일 절대로 Push하지 않습니다. 제발!!  
- 주석과 Commit 메시지 꼼꼼히 적기
- 변수명은 최대한 자세하게 적기
- 변수를 최대한 글자처리 하기
- 모르거나 막히면 토의 하기
- 일단 수정해보기 (잘 안되면 Rollback 기능으로 되돌리면 됨)
- 🚫🚫🚫🚫 절대로 덤프된 db.sql 공유하지 않기(개인정보 유출 가능성 있음. 추후 서버 컴퓨터로부터 덤프된 sql 사용 시 별도로 관리 요망) 🚫🚫🚫🚫
- 🚫 절대로 학과 로그인 관련 아이디 공유하지 않기(개인정보 유출 가능성 있음. 프로젝트를 위해 임시로 사용하는 db는 괜찮음) 🚫

* * *
## Project Structure
* .idea
  > IntelliJ 관련 설정. 컴퓨터마다 환경이 달라질 수 있습니다.
  > >❌❌❌절대로 Github에 전송하지 마세요.❌❌❌
* lib
  > 자바 프로젝트에서 사용 하는 외부 라이브러리(*.jar)를 모아 놓은 폴더입니다. 특정 클래스를 사용하려면 해당 라이브러리가 필요하며, 추가되는 경우 이 폴더에 등록해줘야 합니다.
* out
  >  컴파일 시 생성되는 임시 폴더로, 이 폴더를 기반으로 프로그램을 실행하게 됩니다. 예를들어 실행 후, 파일을 첨부하는 경우 이 폴더에 저장이 됩니다. run 할때마다 out 폴더가 새롭게 생성됩니다.
  > > ❌❌❌절대로 Github에 전송하지 마세요.❌❌❌
* ### src
  >  Web Server를 담당합니다. Java로 작성합니다.
  * kr.ac.kyonggi.swaig
    * common
      > 이 프로젝트의 뼈대를 잡고 있는 클래스들입니다. 절대로 수정하지 말아주세요.
      > >수정 시 반드시 수정 사유를 공유할 것
      * controller
        > 요청으로 인해 실행되는 클래스인 Controller가 들어있습니다. Tomcat과 직접 통신합니다. 또, Action Interface가 들어있어 Controller를 조금 더 쉽게 다룰 수 있도록 돕습니다.
      * filter
      * index
      * sql
        > sql 로그인을 대신 해주는 Config클래스가 있습니다.
    * handler
      > 이 패키지는 저희가 100% 구현해야하는 부분입니다.
      * action
        > Controller 클래스로부터 실행이 되는 Action 클래스들이 모여있습니다.
        ```java
        //action 코드 예시
        public class TestAction implements Action {
            @Override
            public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
                Gson gson = new Gson();
                request.setAttribute("getSomething", gson.toJson(TestDAO.getInstance().getSomething(1)));
                return "RequestDispatcher:test.jsp";
            }
        }
        ```
      * dao
        > 쿼리문을 직접 작성하는 클래스들 입니다.
        > > DBUtils 라이브러리를 사용하며, mariaDB와 직접 통신합니다.
           ```java
           //DAO클래스 예시
           public class TestDAO {
               public static TestDAO it;
               public static TestDAO getInstance() { //인스턴스 생성
                   if (it == null)
                        it = new TestDAO();
                   return it;
               }
           //테스트 메소드
           public ArrayList<TestDTO> getSomething(int num) {
               ArrayList<TestDTO> result = null;
               List<Map<String, Object>> list = null;
               Connection conn = Config.getInstance().sqlLogin();
               try {
               QueryRunner queryRunner = new QueryRunner();
               list = queryRunner.query(conn, "SELECT * FROM customer WHERE oid=?", new MapListHandler(), num);
               } catch (SQLException e) {
               e.printStackTrace();
               } finally {
               DbUtils.closeQuietly(conn);
               }
               Gson gson = new Gson();
               result = gson.fromJson(gson.toJson(list), new TypeToken<List<TestDTO>>() {
               }.getType());
               return result;
               }
           }
           ```
        * DTO
          > mariaDB로 부터 받은 DB를 자바 클래스에 태우기 위한 클래스입니다.
          > > DB 테이블 하나 당 DTO 한 개가 존재한다고 생각하시면 편합니다.
          ```java
          public class TestDTO {
              private String oid;
              private String name;
              private String phoneNumber;
              public String getOid() {return oid;}
              public void setOid(String oid) {this.oid = oid;}
              public String getName() {return name;}
              public void setName(String name) {this.name = name;}
              public String getPhoneNumber() {return phoneNumber; }
              public void setPhoneNumber(String phoneNumber) {this.phoneNumber = phoneNumber;}
          }
          ```


* ### web
  > View를 담당합니다. JSP로 작성합니다.
  * css
    > JSP에서 사용 할 css를 모아놓은 폴더입니다. (부트스트랩 5.0 넣어둠)
  * js
    > JSP에서 사용 할 js를 모아놓은 폴더입니다.(부트스트랩 5.0, JQuery 넣어둠)
  * WEB-INF
    * jsp
      > JSP에서 *.kgu 형식으로 된 domain클래스를 요청합니다.
      > > *.kgu 형식의 경로는 class.properties에서 찾을 수 있습니다.
      
      > 앞선 Action 클래스에서 정의된 DB를 받아와서 JS로 가공한 후, HTML에 삽입합니다.
      ```html
      //앞선 설정으로 setAttribute 된 자바 변수를 JSP에서 받는 예시 (JQuery와 JSP문법을 사용하여 데이터를 가공한 후, id에 넘겨서 삽입함.)
      <script> 
      $(document).ready(function(){
          makeinfo1();
      })
      function makeinfo1(){
          var data = <%=getSomething%>;
          var list = $('#testDataPrinter');
          var text = '';
          text+= '<div>'+'oid : '+data[0].oid+'/ name : '+data[0].name+'/ phoneNumber : '+data[0].phoneNumber+'</div>';
          list.append(text);
      }
      </script>
      ```
    * lib
      > 웹에서 사용할 라이브러리를 넣습니다.
* * *
## How To Deploy
- 프로젝트 생성 방법 (나중에 비슷한 방법으로 새 프로젝트로 독립하고 싶은 경우 참고)
  > https://leirbag.tistory.com/80
- 프로젝트 실행 방법
  > https://leirbag.tistory.com/81
- mariaDB 설치 방법
  > https://leirbag.tistory.com/46
  - db 적용 방법
    > https://leirbag.tistory.com/47
  - 컴파일러에서 db 오류 발생 시
    > https://leirbag.tistory.com/48
* * *
## Tools
- IntelliJ Ultimate 2021.1
- Tomcat 9.0.48
  > 현 시점의 Tomcat 10에서는 javax를 지원하지 않아 업데이트하면 안됩니다. server api를 인식하지 못하는 문제가 있음.
- JSP
- MariaDB 10.5
  > mysql과 다르게 대소문자를 확실히 지켜야 합니다.
- DBUtils  
- Java EE8
- Bootstrap 5.0
- JQuery
- Ajax
* * *
## References
- JSP와 Servlet(서블릿) 비교
  > https://m.blog.naver.com/acornedu/221128616501
* * *
