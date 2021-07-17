<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-17
  Time: 오후 4:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String image = (String) request.getAttribute("image");
%>
<html>
<head>
    <title>이미지 뷰어</title>
</head>
<body>
<img src=<%=image%>>
</body>
</html>
