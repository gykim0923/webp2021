<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-06-24
  Time: 오후 5:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title></title>
  </head>
  <body>

  </body>
  <script>
    /**
     * [윤주현]
     * 웹 서버가 처음으로 열려고 시도하는 페이지입니다.
     * 이 페이지가 처음으로 열리는 이유는 web.xml에서 welcom-file 설정이 이걸로 되어있기도 하고,
     * 원래 다른 환경에서도 톰캣이 처음 실행 하려는게 index.jsp입니다.
     * 일단 main.kgu를 요청하게 해놨습니다. (.kgu는 Controller클래스에 의해 web/WEB-INF/class.properties에서 찾습니다.)
     */
    window.location.href = 'main.kgu';
  </script>
</html>
