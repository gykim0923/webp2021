<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-26
  Time: 오후 7:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    /**
     * BBS 공통 설정
     * */
    System.out.println("jsp:"+jsp);
    String id = (String) request.getAttribute("id");
%>
<c:choose>
    <c:when test="${jsp == '\"reg_list\"'}">
        <%@include file="/WEB-INF/jsp/page_stand_alone/register/reg_mode/reg_list.jsp" %>
    </c:when>
    <c:when test="${jsp == '\"reg_view\"'}">
        <%@include file="/WEB-INF/jsp/page_stand_alone/register/reg_mode/reg_view.jsp" %>
    </c:when>
    <c:when test="${jsp == '\"reg_write\"' || jsp == '\"reg_modify\"'}">
        <%System.out.println("!!!!!!!!!!!!!!!!");%>
        <%@include file="/WEB-INF/jsp/page_stand_alone/register/reg_mode/reg_upload.jsp" %>
    </c:when>
</c:choose>
