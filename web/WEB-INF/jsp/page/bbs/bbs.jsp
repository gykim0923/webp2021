<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-19
  Time: 오후 5:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String mode = (String) request.getAttribute("mode");
%>
<div>
  <c:choose>
    <%--            mode--%>
    <c:when test="${mode == '\"list\"'}">
      <%@include file="/WEB-INF/jsp/page/bbs/bbs_mode/bbs_list.jsp"%>
    </c:when>
    <%--            mode--%>
    <c:when test="${mode == '\"view\"'}">
      <%@include file="/WEB-INF/jsp/page/bbs/bbs_mode/bbs_view.jsp"%>
    </c:when>
    <%--            mode--%>
    <c:when test="${mode == '\"write\"'}">
      <%@include file="/WEB-INF/jsp/page/bbs/bbs_mode/bbs_write.jsp"%>
    </c:when>
    <%--            mode--%>
    <c:when test="${mode == '\"modify\"'}">
      <%@include file="/WEB-INF/jsp/page/bbs/bbs_mode/bbs_modify.jsp"%>
    </c:when>
    <c:otherwise>
      <div>잘못된 mode 변수가 넘어왔습니다.</div>
    </c:otherwise>
  </c:choose>



</div>