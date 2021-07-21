<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-21
  Time: 오전 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--ckeditor가 나와야 하는 자리--%>
ckeditor
<%--버튼이 나와야 하는 자리--%>
<c:choose>
    <c:when test="${jsp == '\"bbs_write\"'}">
        제출 버튼
    </c:when>
    <c:when test="${jsp == '\"bbs_modify\"'}">
        수정 버튼
    </c:when>
</c:choose>