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
    String jsp = (String) request.getAttribute("jsp");
    /**
     * [일부] 페이지 메뉴 제어
     * */
    String pageMenu = (String) request.getAttribute("pageMenu");
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@include file="../main/header.jsp" %>
<main class="bg-light">
    <div class="container py-4">

        <div class="row align-items-md-stretch">
            <div class="col-lg-12 py-2">
                <div class=" h-100 p-5 bg-light border shadow rounded" id="page_title"></div>
            </div>
        </div>

        <div class="row align-items-md-stretch">

            <div class="col-xxl-2 col-lg-3 py-2">
                <div class=" h-100 p-5 bg-light border shadow rounded" id="page_menu"></div>
            </div>

            <div class="col-xxl-10 col-lg-9 py-2">
                <div class=" h-100 p-5 bg-light border shadow rounded">
                    <c:choose>
                        <%--            menu--%>
                        <c:when test="${jsp == '\"contact\"'}">
                            <%@include file="/WEB-INF/jsp/page/menu/contact.jsp" %>
                        </c:when>
                        <c:when test="${jsp == '\"information\"'}">
                            <%@include file="/WEB-INF/jsp/page/menu/information.jsp" %>
                        </c:when>
                        <c:when test="${jsp == '\"curriculum\"'}">
                            <%@include file="/WEB-INF/jsp/page/menu/curriculum.jsp" %>
                        </c:when>
                        <c:when test="${jsp == '\"club\"'}">
                            <%@include file="/WEB-INF/jsp/page/menu/club.jsp" %>
                        </c:when>
                        <c:when test="${jsp == '\"professor\"'}">
                            <%@include file="/WEB-INF/jsp/page/menu/professor.jsp" %>
                        </c:when>

                        <%--            bbs--%>
                        <c:when test="${jsp == '\"bbs_list\"' || jsp == '\"bbs_view\"' || jsp == '\"bbs_write\"' || jsp == '\"bbs_modify\"'}">
                            <%@include file="/WEB-INF/jsp/page/bbs/bbs.jsp" %>
                        </c:when>

                        <%--            admin--%>
                        <c:when test="${jsp == '\"admin_main\"'}">
                            <%@include file="/WEB-INF/jsp/page/admin/admin_main.jsp" %>
                        </c:when>
                        <c:when test="${jsp == '\"admin_user\"'}">
                            <%@include file="/WEB-INF/jsp/page/admin/admin_user.jsp" %>
                        </c:when>
                        <c:when test="${jsp == '\"admin_excel\"'}">
                            <%@include file="/WEB-INF/jsp/page/admin/admin_excel.jsp" %>
                        </c:when>

                        <%--            user--%>
                        <c:when test="${jsp == '\"mypage\"'}">
                            <%@include file="/WEB-INF/jsp/page/user/mypage.jsp" %>
                        </c:when>
                        <c:when test="${jsp == '\"changePwd\"'}">
                            <%@include file="/WEB-INF/jsp/page/user/changePwd.jsp" %>
                        </c:when>
                        <c:when test="${jsp == '\"whatIDo\"'}">
                            <%@include file="/WEB-INF/jsp/page/user/whatIDo.jsp" %>
                        </c:when>
                        <c:otherwise>
                            <div>잘못된 jsp 변수가 넘어왔습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>


    </div>
</main>
</body>
<%@include file="../main/footer.jsp" %>
</html>
<script>
    $(document).ready(function () { //본문 제어
        makePageTitle();
        makePageMenu();
    })

    function makePageTitle() {
        var num = <%=num%>;
        var list = $('#page_title');
        var pageMenu = <%=pageMenu%>;
        var page_title = '';
        for (var i = 0; i < pageMenu.length; i++) {
            if (pageMenu[i].page_id == num) {
                page_title = pageMenu[i].page_title;
                break;
            }
        }
        var text = '<h2><i class="bi bi-info-circle-fill"></i><strong>  ' + page_title + '</strong></h2>';
        list.append(text);
    }

    function makePageMenu() {
        var list = $('#page_menu');
        var text = '';
        var pageMenu = <%=pageMenu%>;
        var major =<%=major%>;
        for (var i = 0; i < pageMenu.length; i++) {
            text += '<div><span class="deco_dot">●</span><a href="' + pageMenu[i].page_path + '?major=' + major + '&&num=' + pageMenu[i].page_id + '">' + pageMenu[i].page_title + '</div>';
        }
        list.append(text);
    }
</script>