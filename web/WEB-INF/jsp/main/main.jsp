<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-06-24
  Time: 오후 6:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
     * for Main.jsp
     * */
    String scheduleAllInfo = (String) request.getAttribute("scheduleAllInfo");
    String slider = (String) request.getAttribute("slider");
    String favorite_menu = (String) request.getAttribute("favorite_menu");
    String bbs21 = (String) request.getAttribute("bbs21");
    String bbs22 = (String) request.getAttribute("bbs22");
    String bbs23 = (String) request.getAttribute("bbs23");
    String bbs31 = (String) request.getAttribute("bbs31");
    String registerAllInfo = (String) request.getAttribute("registerAllInfo");
%>
<!DOCTYPE html>
<html>
<%@include file="common_settings.jsp" %>
<body>
<%--<div class="collapse collapse-horizontal" id="collapseWidthExample">--%>
<%--    <%@include file="aside_v3.jsp" %>--%>
<%--</div>--%>
<%--<div id="app">--%>

<%@include file="aside_v3.jsp" %>
<div id="main" class='layout-navbar'>
    <%@include file="header_v3.jsp" %>
    <div id="main-content">
        <div class="page-heading">
            <%--Main 영역 start--%>

            <main class="">
                <%--                    container start--%>
                <div class="container">
                    <div class="row align-items-md-stretch">
                        <div class="col-12 mb-3">
                            <div class="h1 header_title">
                                <div class="title_logo px-3">
                                    <img src="/img/logo/kgu_logo(500x300).png" height="100" width="auto">
                                </div>
                                <div class="title_text">
                                    <div>
                                        <div class="d-sm-inline d-block">경기대학교</div>
                                        <div class="d-sm-inline d-none">소프트웨어중심대학</div>
                                    </div>
                                    <div id="headerTitle"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <strong>주의!</strong> 아직 개발 중인 홈페이지입니다.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <div class="row align-items-md-stretch">
                        <%--                            left side start--%>
                        <div class="col-xxl-9" id="main1_left">
                            <div class="py-2 col-12">
                                <%--                                    carousel start--%>
                                <div id="myCarousel" class="h-100 carousel slide card border border-primary"
                                     data-bs-ride="carousel" style="margin-bottom : 0px; height:399px;">
                                    <div class="carousel-indicators" id="carouselButton">
                                        <%--   슬라이더 사진 개수와 동일한 버트 만들어 줘야함 makecarouselCard에 있음--%>
                                    </div>
                                    <div class="carousel-inner h-100 " id="carouselCard">
                                        <%--     makecarouselCard에 있음--%>
                                    </div>
                                    <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel"
                                            data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="#myCarousel"
                                            data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>
                                <%--                                    carousel end--%>
                            </div>
                            <%--                                bbs and reg start--%>
                            <div class="row">
                                <div class="col-xl-6 py-2 " id="main2_left">
                                    <div class=" p-3 card border border-primary m-0" style="height : 493px;">
                                        <div class="">
                                            <div class="mb-2 d-flex justify-content-between border-bottom">
                                                <div class="nav nav-tabs " id="nav-tab" role="tablist">
                                                    <button class="nav-link active" id="nav-21-tab"
                                                            data-bs-toggle="tab" data-bs-target="#nav-21"
                                                            type="button" role="tab" aria-controls="nav-home"
                                                            aria-selected="true"
                                                            onclick="clickBBS('more_link1', 21)"></button>
                                                    <button class="nav-link" id="nav-22-tab" data-bs-toggle="tab"
                                                            data-bs-target="#nav-22" type="button" role="tab"
                                                            aria-controls="nav-profile" aria-selected="false"
                                                            onclick="clickBBS('more_link1', 22)"></button>
                                                    <button class="nav-link" id="nav-23-tab" data-bs-toggle="tab"
                                                            data-bs-target="#nav-23" type="button" role="tab"
                                                            aria-controls="nav-contact" aria-selected="false"
                                                            onclick="clickBBS('more_link1', 23)"></button>
                                                </div>
                                                <div class="morebtn">
                                                    <div class="py-2">
                                                        <a id="more_link1" href="bbs.kgu?major=main&num=21" data-bs-toggle="tooltip" data-bs-placement="top" title="더보기"><i class="bi bi-plus-lg"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-content" id="nav-tabContent">
                                            <div class="tab-pane fade show active" id="nav-21" role="tabpanel"
                                                 aria-labelledby="nav-21-tab"></div>
                                            <div class="tab-pane fade" id="nav-22" role="tabpanel"
                                                 aria-labelledby="nav-22-tab"></div>
                                            <div class="tab-pane fade" id="nav-23" role="tabpanel"
                                                 aria-labelledby="nav-23-tab"></div>
                                        </div>

                                    </div>
                                </div>

                                <div class="col-xl-6 py-2 " id="main2_center">
                                    <div class=" p-3 border border-primary card m-0" style="height : 493px;">
                                        <div>
                                            <div class="mb-2 d-flex justify-content-between border-bottom">
                                                <div class="nav nav-tabs" id="nav-tab2" role="tablist">
                                                    <button class="nav-link active" id="nav-30-tab"
                                                            data-bs-toggle="tab" data-bs-target="#nav-30"
                                                            type="button" role="tab" aria-controls="nav-home"
                                                            aria-selected="true"
                                                            onclick="clickNoticeReg('more_link2', 30)"></button>
                                                    <button class="nav-link" id="nav-31-tab" data-bs-toggle="tab"
                                                            data-bs-target="#nav-31" type="button" role="tab"
                                                            aria-controls="nav-profile" aria-selected="false"
                                                            onclick="clickBBS('more_link2', 31)"></button>
                                                </div>
                                                <div class="morebtn">
                                                    <div class="py-2">
                                                        <a id="more_link2" href="reg.kgu?major=main&num=30" data-bs-toggle="tooltip" data-bs-placement="top"  title="더보기"><i class="bi bi-plus-lg"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-content" id="nav-tabContent2">
                                            <div class="tab-pane fade show active" id="nav-30" role="tabpanel"
                                                 aria-labelledby="nav-30-tab"></div>
                                            <div class="tab-pane fade" id="nav-31" role="tabpanel"
                                                 aria-labelledby="nav-31-tab"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%-- bbs and reg end--%>
                        </div>
                        <%--                            left side end--%>


                        <%--                            right side start--%>
                        <div class="col-xxl-3" id="main1_right">
                            <div class="row">
                                <div class="py-2 col-xxl-12 col-sm-6">
                                    <div class=" h-100 border border-primary card m-0" id="favorite_menu" style=""></div>
                                </div>
                                <div class="py-2 col-xxl-12 col-sm-6">
                                    <div class=" p-3 border border-primary card m-0" style="height : 493px;">
                                        <div class="mb-2 d-flex justify-content-between border-bottom">
                                            <div class="nav nav-tabs" role="tablist">
                                                <button class="nav-link active"><strong>주요 일정</strong></button>
                                            </div>
                                            <div class="morebtn">
                                                <div class="py-2">
                                                    <a data-bs-toggle="tooltip" data-bs-placement="top"  title="일정 보기">
                                                        <i class="bi bi-plus-lg col-sm-2 text-end" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="addSearchModal()"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-content" id="schContent" style=""></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--                            left side end--%>
                    </div>

                </div>
                <%--                    container end--%>

                <!-- search schedule Modal -->
                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">주요 일정</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body" id="modalBody">
                                <table class="boardtable" id="schTable" data-toggle="table"
                                       data-pagination="true" data-toolbar="#toolbar"
                                       data-search="true" data-side-pagination="true" data-click-to-select="true"
                                       data-page-list="[10]">
                                    <thead>
                                    <tr>
                                        <th data-field="date" data-sortable="true">날짜</th>
                                        <th data-field="content" data-sortable="true">내용</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <%--Main end--%>
        </div>
        <%@include file="footer.jsp" %>
    </div>
</div>
<script src="/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<%--<script src="/assets/js/bootstrap.bundle.min.js"></script>--%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="/assets/js/main.js"></script>
<%--<script>--%>

<%--</script>--%>
</body>

</html>


<script>

    $(document).ready(function () {
        makeHeaderTitle(); //Header Title 제작

        makeFavoriteMenu();
        makeScheduleInfo();
        makeCarouselCard();
        makeNoticeBBS();
        makeNoticeReg();
    })

    function makeHeaderTitle() {
        var majorAllInfo =<%=majorAllInfo%>;
        var title = $('#headerTitle');
        title.append(majorAllInfo[0].major_name);
    }

    function makeNoticeReg() {
        var nav30 = $('#nav-30');
        var nav31 = $('#nav-31');
        var registerAllInfo = <%=registerAllInfo%>;
        var bbs31 =<%=bbs31%>;
        var type = <%=type%>;

        var text30 = '<ul class="list-group">';
        if (registerAllInfo != null) {
            for (var i = 0; i < registerAllInfo.length; i++) {
                if (i == 9) {
                    break;
                }
                var url30 = '';
                if (type.for_header=='기타'){
                    url30 = '';
                }
                else {
                    url30 = 'reg.kgu?major=main&num=30&mode=view&id=' + registerAllInfo[i].id;
                }
                text30 += '<li class="py-2 px-0 border-0 list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                    + '<a href="' + url30 + '"><span class="index_post_link">' + registerAllInfo[i].title + '</span></a>'
                    + '<a href="' + url30 + '"><span class="index_post_time">' + formatDate(registerAllInfo[i].last_modified) + '</span></a>'
                    + '</li>';
            }
            text30 += '</ul>';
        }
        nav30.append(text30);

        var text31 = '<ul class="list-group">';
        if (bbs31 != null) {
            for (var i = 0; i < bbs31.length; i++) {
                if (i == 9) {
                    break;
                }
                var url31 = 'bbs.kgu?major=main&num=31&mode=view&id=' + bbs31[i].id;
                text31 += '<li class="py-2 px-0 border-0 list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                    + '<a href="' + url31 + '"><span class="index_post_link">' + bbs31[i].title + '</span></a>'
                    + '<a href="' + url31 + '"><span class="index_post_time">' + formatDate(bbs31[i].last_modified) + '</span></a>'
                    + '</li>';
            }
            text31 += '</ul>';
        }
        nav31.append(text31);

        var menuPageList = <%=menuPageList%>;
        var nav30tab = $('#nav-30-tab');
        var nav31tab = $('#nav-31-tab');
        for (var i = 0; i < menuPageList.length; i++) {
            if (menuPageList[i].page_id == '30') {
                nav30tab.append('<strong>' + menuPageList[i].page_title + '</strong>');
            }
            if (menuPageList[i].page_id == '31') {
                nav31tab.append('<strong>' + menuPageList[i].page_title + '</strong>');
            }
        }
    }

    function clickBBS(id, i) {
        var link_id = id;
        document.getElementById(link_id).setAttribute('href', 'bbs.kgu?major=main&num=' + i + '');
    }

    function clickNoticeReg(id, i) {
        var link_id = id;
        document.getElementById(link_id).setAttribute('href', 'reg.kgu?major=main&num=' + i + '');
    }

    function makeNoticeBBS() {
        var bbs21 =<%=bbs21%>;
        if (bbs21 != null) {
            var notice21 = $('#nav-21');
            var text21 = '<ul class="list-group">';
            for (var i = 0; i < bbs21.length; i++) {
                if (i == 9) {
                    break;
                }
                var url21 = 'bbs.kgu?major=main&num=21&mode=view&id=' + bbs21[i].id;
                text21 += '<li class="py-2 px-0 border-0 list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                    + '<a href="' + url21 + '"><span class="index_post_link">' + bbs21[i].title + '</span></a>'
                    + '<a href="' + url21 + '"><span class="index_post_time">' + formatDate(bbs21[i].last_modified) + '</span></a>'
                    + '</li>';

            }
            text21 += '</ul>';
            notice21.append(text21);
        }
        var bbs22 =<%=bbs22%>;
        if (bbs22 != null) {
            var notice22 = $('#nav-22');
            var text22 = '<ul class="list-group">';
            for (var i = 0; i < bbs22.length; i++) {
                if (i == 9) {
                    break;
                }
                var url22 = 'bbs.kgu?major=main&num=22&mode=view&id=' + bbs22[i].id;
                text22 += '<li class="py-2 px-0 border-0 list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                    + '<a href="' + url22 + '"><span class="index_post_link">' + bbs22[i].title + '</span></a>'
                    + '<a href="' + url22 + '"><span class="index_post_time">' + formatDate(bbs22[i].last_modified) + '</span></a>'
                    + '</li>';
            }
            text22 += '</ul>';
            notice22.append(text22);
        }
        var bbs23 =<%=bbs23%>;
        if (bbs23 != null) {
            var notice23 = $('#nav-23');
            var text23 = '<ul class="list-group">';
            for (var i = 0; i < bbs23.length; i++) {
                if (i == 9) {
                    break;
                }
                var url23 = 'bbs.kgu?major=main&num=23&mode=view&id=' + bbs23[i].id;
                text23 += '<li class="py-2 px-0 border-0 list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                    + '<a href="' + url23 + '"><span class="index_post_link">' + bbs23[i].title + '</span></a>'
                    + '<a href="' + url23 + '"><span class="index_post_time">' + formatDate(bbs23[i].last_modified) + '</span></a>'
                    + '</li>';
            }
            text23 += '</ul>';
            notice23.append(text23);
        }

        var menuPageList = <%=menuPageList%>;
        var nav21tab = $('#nav-21-tab');
        var nav22tab = $('#nav-22-tab');
        var nav23tab = $('#nav-23-tab');
        var tab_name_21 = '';
        var tab_name_22 = '';
        var tab_name_23 = '';

        if (menuPageList != null) {
            for (var i = 0; i < menuPageList.length; i++) {
                if (menuPageList[i].page_id == '21') {
                    tab_name_21 = menuPageList[i].page_title;
                    nav21tab.append('<strong>' + tab_name_21 + '</strong>');
                }
                if (menuPageList[i].page_id == '22') {
                    tab_name_22 = menuPageList[i].page_title;
                    nav22tab.append('<strong>' + tab_name_22 + '</strong>');
                }
                if (menuPageList[i].page_id == '23') {
                    tab_name_23 = menuPageList[i].page_title;
                    nav23tab.append('<strong>' + tab_name_23 + '</strong>');
                    break;
                }
            }
        }
    }

    function makeFavoriteMenu() {
        var menu = $('#favorite_menu');
        var favorite_menu = <%=favorite_menu%>;
        var text = '';
        for (var i = 0; i < favorite_menu.length; i++) {
            text += '<a href="' + favorite_menu[i].url + '" class="list-group-item list-group-item-action py-4 lh-tight">'
                + '<div class="d-flex w-100 align-items-center justify-content-between">'
                + '<p class="h3 m-0">' + favorite_menu[i].name + '</p>'
                + '<i class="h3 m-0 bi-stack"></i>'
                + '</div>'
                + '</a>';
        }
        menu.append(text);
    }

    function makeCarouselCard() { // 슬라이더 카드 만드는 함수
        var list = $('#carouselCard');
        var list2 = $('#carouselButton');
        var text = '';
        var text2 = '';
        var sliderList = <%=slider%>;

        if (sliderList.length == 0) { // 데이터가 없을 시 디폴트 화면 구성
            text2 += '<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 0"></button>'
            text += '<div class="h-100 carousel-item active">';
            text += '<svg class="carousel-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"></rect></svg>'
            text += '<div class="container"> <div class="carousel-caption"> <h1 class="text-white">등록된 대문이 없습니다.</h1> <p>관리자 모드에서 대문을 추가해주시기 바랍니다.</p> </div> </div>'
            text += '</div>';
        }

        for (var j = 0; j < sliderList.length; j++) {
            if (j == 0) {
                text2 += '<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="' + j + '" class="active" aria-current="true" aria-label="Slide ' + j + '"></button>'
            } else {
                text2 += '<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="' + j + '" aria-current="true" aria-label="Slide ' + j + '"></button>'
            }
        }
        list2.append(text2);
        for (var i = 0; i < sliderList.length; i++) {

            if (i == 0) {
                text += '<div class="carousel-item active">'
            } else {
                text += '<div class="carousel-item">'
            }
            text += '<img class="carousel-img" width="100%" height="100%" src = "' + sliderList[i].slider_img + '">'
            text += '</div>';
        }


        list.append(text);
    }


    function makeScheduleInfo() {
        var scheduleAllInfo = <%=scheduleAllInfo%>;
        var schedule = $('#schContent');
        var text = '';
        for (var i = 0; i < scheduleAllInfo.length; i++) {
            if (i == 7) {
                break;
            }
            var date = new Date(scheduleAllInfo[i].date);
            text += '<div class="list-group-item list-group-item-action py-3 lh-tight border-top-0 border-start-0 border-end-0">'
                // +'<div class="d-flex w-100 align-items-center justify-content-between">'
                + '<div class="d-flex w-100">'
                + '<div class="border-end pe-2">' + formatDate2(date) + '</div>'
                + '<div class="border-start ps-2 short_schedule">' + scheduleAllInfo[i].content + '</div>'
                // +'<p class="h6 m-0">'+formatDate2(date)+' | '+scheduleAllInfo[i].content+'</p>'
                + '</div>'
                + '</div>';
        }
        schedule.html(text);
    }

    function formatDate2(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate();
        const WEEKDAY = ['일', '월', '화', '수', '목', '금', '토'];
        let week = WEEKDAY[d.getDay()];

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;
        var date = [month, day].join('.');

        return date + '(' + week + ')';
    }

    function formatDate(date) {  //주어진 날짜를 yyyy-mm-dd 형식으로 반환해주는 함수
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }

    function addSearchModal() {
        var scheduleAllInfo = <%=scheduleAllInfo%>;
        var rows = [];
        var size = scheduleAllInfo.length;
        for (var i = 0; i < size; i++) {
            var schedule = scheduleAllInfo[i];
            rows.push({
                id: schedule.id,
                date: formatDate(schedule.date),
                content: schedule.content
            });
        }
        $('#schTable').bootstrapTable('load', rows);
    }

</script>

<style>

    @media (min-width: 0px) {
        .index_post_link {
            width: 50px;
        }
    }

    @media (min-width: 280px) {
        .index_post_link {
            width: 100px;
        }
    }

    @media (min-width: 320px) {
        .index_post_link {
            width: 150px;
        }
    }

    @media (min-width: 360px) {
        .index_post_link {
            width: 200px;
        }
    }

    @media (min-width: 400px) {
        .index_post_link {
            width: 250px;
        }
    }

    @media (min-width: 450px) {
        .index_post_link {
            width: 300px;
        }
    }

    @media (min-width: 576px) {
        .index_post_link {
            width: 390px;
        }
    }

    @media (min-width: 768px) {
        .index_post_link {
            width: 560px;
        }
    }

    @media (min-width: 992px) {
        .index_post_link {
            width: 800px;
        }
    }

    @media (min-width: 1200px) {
        .index_post_link {
            width: 280px;
        }
    }

    @media (min-width: 1400px) {
        .carousel-img {
            height: 495px;
        }

        .index_post_link {
            width: 262px;
        }
    }

    @media (min-width: 1600px) {
        .index_post_link {
            width: 337px;
        }
        .title_logo, .title_text{
            float: left;
        }
    }

    @media (max-width: 1600px) {
        .header_title {
            text-align: center;
        }
        .title_logo, .title_text{
            float: none;
        }
        .title_logo{
            display: none;
        }
    }


    .index_post_link {
        color: grey;
        /*width: 270px;*/
        display: inline-block;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .index_post_time {
        min-width: 92px;
    }

    .short_schedule {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        text-align: center;
        border-right: none;
        border-left: none;
    }

</style>
