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
  String jsp=(String)request.getAttribute("jsp");
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

      <div class="col-lg-2 py-2">
        <div class=" h-100 p-5 bg-light border shadow rounded"  id="page_menu"></div>
      </div>

      <div class="col-lg-10 py-2">
        <div class=" h-100 p-5 bg-light border shadow rounded">
          <c:if test="${jsp == '\"information\"'}">
            <%@include file="/WEB-INF/jsp/page/information.jsp"%>
          </c:if>
          <c:if test="${jsp == '\"admin_main\"'}">
            <%@include file="/WEB-INF/jsp/admin/admin_main.jsp"%>
          </c:if>
          <c:if test="${jsp == '\"admin_user\"'}">
            <%@include file="/WEB-INF/jsp/admin/admin_user.jsp"%>
          </c:if>
          <c:if test="${jsp == '\"mypage\"'}">
            <%@include file="/WEB-INF/jsp/account/mypage.jsp"%>
          </c:if>
        </div>
      </div>

    </div>


  </div>
</main>
</body>
</html>
