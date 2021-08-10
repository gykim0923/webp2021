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
    /**
     * [공통] url 제어
     * */
    String major = (String) request.getAttribute("major");
    String num = (String) request.getAttribute("num");

    /**
     * [공통] 헤더 제어
     * */
    String menuTabList = (String) request.getAttribute("menuTabList");
    String menuPageList = (String) request.getAttribute("menuPageList");
    String majorInfo = (String) request.getAttribute("majorInfo");
    String majorAllInfo = (String) request.getAttribute("majorAllInfo");

    /**
     * [공통] 로그인 정보 제어
     * */
    String user = (String) session.getAttribute("user");
    String type = (String) session.getAttribute("type");

%>
<%
    /**
     * 이 페이지는 page.jsp의 확장 버전으로 페이지 메뉴가 없다는 점이 특징입니다.
     * 페이지 메뉴가 없는 이유는 이 페이지들은 어딘가에 연관되어있지 않고 독립적인 페이지이기 떄문입니다.
     * 즉, Header나 Admin처럼 비슷한 메뉴끼리 묶여있지 않는 페이지들은 페이지 메뉴가 필요없기에 이 레이아웃 사용이 더욱 자연스럽습니다.
     * page와 근본적으로 같은 역할을 하고 있지만, 레이아웃이 약간 달라 스탠드얼론(Stand-Alone)이라는 이름을 붙였습니다.
     * page.jsp와 다르게 페이지 메뉴가 없고, 대신 페이지 타이틀을 직접 받아와야 합니다.
     *
     * 참고로 이 페이지는 원래 비주류 레이아웃이었는데, 테마를 입히는 과정에서 주로 사용되는 레이아웃이 되었습니다.
     * */

    String jsp=(String)request.getAttribute("jsp");
    String pageMenu = (String) request.getAttribute("pageMenu");
    String pageTitle=(String)request.getAttribute("pageTitle");
%>
<html>
<%@include file="/WEB-INF/jsp/main/common_settings.jsp"%>
<body>
<div id="app">
    <%@include file="/WEB-INF/jsp/main/aside_v2.jsp"%>
    <div id="main" class='layout-navbar'>
        <%@include file="/WEB-INF/jsp/main/header_v3.jsp"%>
        <div id="main-content">

            <div class="page-heading">
                <main class="">
                    <div class="container py-4">

                        <div class="row align-items-md-stretch">
                            <div class="col-lg-12 py-2">
                                <div class=" h-100 p-5 m-0 border border-primary card" id="page_title"></div>
                            </div>
                        </div>

                        <div class="row align-items-md-stretch">

                            <div class="col-lg-12 py-2">
                                <div class=" h-100 p-xxl-5 p-xl-4 p-3 m-0 border border-primary card">
                                    <c:choose>
                                        <%--            menu--%>
                                        <c:when test="${jsp == '\"information\"'}">
                                            <%@include file="/WEB-INF/jsp/page_stand_alone/menu/information.jsp" %>
                                        </c:when>
                                        <c:when test="${jsp == '\"contact\"'}">
                                            <%@include file="/WEB-INF/jsp/page_stand_alone/menu/contact.jsp" %>
                                        </c:when>
                                        <c:when test="${jsp == '\"curriculum\"'}">
                                            <%@include file="/WEB-INF/jsp/page_stand_alone/menu/curriculum.jsp" %>
                                        </c:when>
                                        <c:when test="${jsp == '\"club\"'}">
                                            <%@include file="/WEB-INF/jsp/page_stand_alone/menu/club.jsp" %>
                                        </c:when>
                                        <c:when test="${jsp == '\"professor\"'}">
                                            <%@include file="/WEB-INF/jsp/page_stand_alone/menu/professor.jsp" %>
                                        </c:when>

                                        <%--            bbs--%>
                                        <c:when test="${jsp == '\"bbs_list\"' || jsp == '\"bbs_view\"' || jsp == '\"bbs_write\"' || jsp == '\"bbs_modify\"'}">
                                            <%@include file="/WEB-INF/jsp/page_stand_alone/bbs/bbs.jsp" %>
                                        </c:when>
                                        <%--            registerBbs--%>
                                        <c:when test="${jsp == '\"reg_list\"' || jsp == '\"reg_view\"' || jsp == '\"reg_write\"' || jsp == '\"reg_modify\"'}">
<%--                                           <%System.out.println("페이지스탠드어론");%>--%>
                                            <%@include file="/WEB-INF/jsp/page_stand_alone/register/register.jsp" %>
                                        </c:when>

                                        <%--              etc--%>
                                        <c:when test="${jsp == '\"madeby\"'}">
                                            <%@include file="/WEB-INF/jsp/page_stand_alone/main/madeby.jsp"%>
                                        </c:when>
                                        <c:when test="${jsp == '\"sitemap\"'}">
                                            <%@include file="/WEB-INF/jsp/page_stand_alone/main/sitemap.jsp"%>
                                        </c:when>
                                        <c:when test="${jsp == '\"location\"'}">
                                            <%@include file="/WEB-INF/jsp/page_stand_alone/main/location.jsp"%>
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
            </div>
            <%@include file="/WEB-INF/jsp/main/footer.jsp"%>
        </div>
    </div>
</div>
<script src="/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/assets/js/bootstrap.bundle.min.js"></script>
<script src="/assets/js/main.js"></script>
</body>

</html>
<script>
    $(document).ready(function () { //본문 제어
        makePageTitle();
    })

    function makePageTitle() {
        var num = <%=num%>;
        var major = <%=major%>;
        var majorInfo = <%=majorInfo%>;
        var list = $('#page_title');
        var pageMenu = <%=pageMenu%>;
        var page_title = '';
        var majorTitle='';
        var text='';
        for (var i = 0; i < pageMenu.length; i++) {
            if (pageMenu[i].page_id == num) {
                page_title = pageMenu[i].page_title;
                break;
            }
        }
        if(page_title!=''){
            if(major=='main'){
                text = '<h2><i class="bi bi-info-circle-fill"></i><strong>  '+ page_title + '</strong></h2>';
            }
            else {
                for (var j = 0 ; j < majorInfo.length; j++){
                    if(majorInfo[j].major_id==major){
                        majorTitle = majorInfo[j].major_name;
                        break;
                    }
                }
                text = '<h2><i class="bi bi-info-circle-fill"></i><strong>  '+majorTitle+' : ' + page_title + '</strong></h2>';
            }
            list.append(text);
        }
    }

</script>

