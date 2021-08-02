<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-20
  Time: 오후 7:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  /**
   * BBS 공통 설정
   * */
  String id = (String) request.getAttribute("id");
%>
<c:choose>
  <c:when test="${jsp == '\"bbs_list\"'}">
    <%@include file="/WEB-INF/jsp/page_stand_alone/bbs/bbs_mode/bbs_list.jsp" %>
  </c:when>
  <c:when test="${jsp == '\"bbs_view\"'}">
    <%@include file="/WEB-INF/jsp/page_stand_alone/bbs/bbs_mode/bbs_view.jsp" %>
  </c:when>
  <c:when test="${jsp == '\"bbs_write\"' || jsp == '\"bbs_modify\"'}">
    <%@include file="/WEB-INF/jsp/page_stand_alone/bbs/bbs_mode/bbs_upload.jsp" %>
  </c:when>
</c:choose>