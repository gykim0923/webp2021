<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-06
  Time: 오후 5:53
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
        <div class=" h-100 p-5 bg-light border shadow rounded" id="page_title"></div>
      </div>
    </div>

    <div class="row align-items-md-stretch">

      <div class="col-lg-2 py-2">
        <div class=" h-100 p-5 bg-light border shadow rounded"  id="page_menu"></div>
      </div>

      <div class="col-lg-10 py-2">
        <div class=" h-100 p-5 bg-light border shadow rounded">
          <h2><strong>본문</strong></h2>
          <hr>
        </div>
      </div>

    </div>


  </div>
</main>
</body>
</html>
