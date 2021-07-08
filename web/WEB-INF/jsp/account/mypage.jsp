<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-07
  Time: 오후 3:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <div class=" h-100 p-5 bg-light border">
          <h4>마이페이지</h4>
        </div>
      </div>
    </div>

    <div class="row align-items-md-stretch">

      <div class="col-lg-3 py-2">
        <div class=" h-100 py-5 px-3 bg-light border text-center" id="page_menu">
<%--          <h2><strong>소메뉴 리스트</strong></h2>--%>
          <hr>
        </div>
      </div>

      <div class="col-lg-9 py-2">
        <div class=" h-100 p-5 bg-light border">
          <h2><strong>회원정보</strong></h2>
          <hr>
          <div class="row">
            <div id="text"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</main>
</body>
</html>
