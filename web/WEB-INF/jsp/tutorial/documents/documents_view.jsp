<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-07
  Time: 오후 2:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String document=(String)request.getAttribute("document");
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@include file="../common/tutorial_header.jsp"%>

<main>
    <%@include file="../common/tutorial_section.jsp"%>
    <%=document%>
</main>

</body>
</html>
