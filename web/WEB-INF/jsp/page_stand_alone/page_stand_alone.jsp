<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-09
  Time: 오후 4:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    /**
     * 이 페이지는 page.jsp의 확장 버전으로 페이지 메뉴가 없다는 점이 특징입니다.
     * 페이지 메뉴가 없는 이유는 이 페이지들은 어딘가에 연관되어있지 않고 독립적인 페이지이기 떄문입니다.
     * 즉, Header나 Admin처럼 비슷한 메뉴끼리 묶여있지 않는 페이지들은 페이지 메뉴가 필요없기에 이 레이아웃 사용이 더욱 자연스럽습니다.
     * page와 근본적으로 같은 역할을 하고 있지만, 레이아웃이 약간 달라 스탠드얼론(Stand-Alone)이라는 이름을 붙였습니다.
     * page.jsp와 다르게 페이지 메뉴가 없고, 대신 페이지 타이틀을 직접 받아와야 합니다.
     * */

  String jsp=(String)request.getAttribute("jsp");
  String pageTitle=(String)request.getAttribute("pageTitle");
%>
<html>
<head>
  <title>Title</title>
</head>
<body>
<%@include file="../main/header.jsp"%>
<main>
  <div class="container py-4">

    <div class="row align-items-md-stretch">
      <div class="col-lg-12 py-2">
        <div class=" h-100 p-5 bg-light border shadow rounded" id="page_title"></div>
      </div>
    </div>

    <div class="row align-items-md-stretch">

      <div class="col-lg-12 py-2">
        <div class=" h-100 p-5 bg-light border shadow rounded">
          <c:choose>
              <c:when test="${jsp == '\"madeby\"'}">
                  <%@include file="/WEB-INF/jsp/page_stand_alone/main/madeby.jsp"%>
              </c:when>
              <c:when test="${jsp == '\"sitemap\"'}">
                  <%@include file="/WEB-INF/jsp/page_stand_alone/main/sitemap.jsp"%>
              </c:when>
              <c:when test="${jsp == '\"location\"'}">
                  <%@include file="/WEB-INF/jsp/page_stand_alone/main/location.jsp"%>
              </c:when>

            <c:otherwise>
              <div>잘못된 jsp 변수가 넘어왔습니다.</div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

    </div>


  </div>
</main>
</body>
<%@include file="../main/footer.jsp"%>

</html>
<script>
    $(document).ready(function(){ //본문 제어
        makePageTitle();
    })

    function makePageTitle() {
        var list = $('#page_title');
        var pageTitle = <%=pageTitle%>;
        var text='<h2><i class="bi bi-info-circle-fill"></i><strong>  '+pageTitle+'</strong></h2>';
        list.append(text);
    }


</script>