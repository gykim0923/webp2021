<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-03
  Time: 오후 12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%
    String error = (String) request.getAttribute("error");
%>
<html>
<head>
    <title>ERROR PAGE</title>
    <%--    Bootstrap--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <%--    jQuery--%>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <%--    Bootstrap Table--%>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css">
    <script src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>
</head>
<body>
<div class="container col-xxl-8 px-4 py-5">
    <div class="row align-items-center flex-lg-row-reverse g-5 py-5"> <%--align-items-center flex-lg-row-reverse--%>
        <div class="col-12 col-lg-5 px-5">
            <img src="/img/logo/kgu_mascot.png" class="d-block mx-lg-auto img-fluid" alt="Bootstrap Themes" width="700" height="500" loading="lazy">
        </div>
        <div class="col-lg-7">
            <h1 class="display-5 fw-bold lh-1 mb-3 text-center">오류가 발생했습니다.</h1>
            <p class="lead text-center">오류로 인해 접속이 제한됩니다. </p>
            <p id="errorMessage" class="lead text-center">사유 : <%=error%></p>
            <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                <button type="button" class="btn btn-primary btn-lg px-4 me-md-2" onclick="window.open('main.kgu')">홈으로 돌아가기</button>
<%--                <button type="button" class="btn btn-outline-secondary btn-lg px-4">Default</button>--%>
            </div>
        </div>
    </div>
</div>
</body>
</html>

<script>

</script>