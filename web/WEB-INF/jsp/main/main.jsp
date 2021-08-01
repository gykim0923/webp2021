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
    String scheduleAllInfo = (String)request.getAttribute("scheduleAllInfo");
    String slider = (String)  request.getAttribute("slider");
    String favorite_menu = (String) request.getAttribute("favorite_menu");
    String bbs21 = (String) request.getAttribute("bbs21");
    String bbs22 = (String) request.getAttribute("bbs22");
    String bbs23 = (String) request.getAttribute("bbs23");
    String registerAllInfo = (String) request.getAttribute("registerAllInfo");
%>
<!DOCTYPE html>
<html>
<%@include file="common_settings.jsp"%>
<body>
<div id="app">
    <%@include file="aside_v2.jsp"%>
    <div id="main" class='layout-navbar'>
        <%@include file="header_v3.jsp"%>
        <div id="main-content">

            <div class="page-heading">
                <%--Main start--%>
                <%--                여기서 부터 main 복붙--%>
                <main class="">
                    <div class="container">
                        <div class="row align-items-md-stretch">
                            <div class="col-lg-9 py-2" id="main1_left" >
                                <div id="myCarousel" class="h-100 carousel slide card" data-bs-ride="carousel" style="margin-bottom : 0px;">
                                    <div class="carousel-indicators" id="carouselButton">
                                        <%--   슬라이더 사진 개수와 동일한 버트 만들어 줘야함 makecarouselCard에 있음--%>
                                    </div>
                                    <div class="carousel-inner h-100 " id="carouselCard">
                                        <%--     makecarouselCard에 있음--%>
                                    </div>
                                    <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-lg-3 py-2" id="main1_right">
                                <div class=" h-100 border card" id="favorite_menu"></div>
                            </div>
                        </div>



                        <div class="row align-items-md-stretch">

                            <div class="col-lg py-2" id="main2_left"  style="height : 400px;">
                                <div class=" h-100 p-xxl-5 p-lg-4 p-3 border card">
                                    <div>
                                        <div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
                                            <button class="nav-link active" id="nav-21-tab" data-bs-toggle="tab" data-bs-target="#nav-21" type="button" role="tab" aria-controls="nav-home" aria-selected="true"></button>
                                            <button class="nav-link" id="nav-22-tab" data-bs-toggle="tab" data-bs-target="#nav-22" type="button" role="tab" aria-controls="nav-profile" aria-selected="false"></button>
                                            <button class="nav-link" id="nav-23-tab" data-bs-toggle="tab" data-bs-target="#nav-23" type="button" role="tab" aria-controls="nav-contact" aria-selected="false"></button>
                                        </div>
                                    </div>
                                    <div class="tab-content" id="nav-tabContent">
                                        <div class="tab-pane fade show active" id="nav-21" role="tabpanel" aria-labelledby="nav-21-tab"></div>
                                        <div class="tab-pane fade" id="nav-22" role="tabpanel" aria-labelledby="nav-22-tab"></div>
                                        <div class="tab-pane fade" id="nav-23" role="tabpanel" aria-labelledby="nav-23-tab"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg py-2" id="main2_center"  style="height : 400px;">
                                <div class=" h-100 p-xxl-5 p-lg-4 p-3 border card">
                                    <div>
                                        <div class="nav nav-tabs mb-3" id="nav-tab2" role="tablist">
                                            <button class="nav-link active" id="nav-30-tab" data-bs-toggle="tab" data-bs-target="#nav-30" type="button" role="tab" aria-controls="nav-home" aria-selected="true"></button>
                                            <button class="nav-link" id="nav-31-tab" data-bs-toggle="tab" data-bs-target="#nav-31" type="button" role="tab" aria-controls="nav-profile" aria-selected="false"></button>
                                        </div>
                                    </div>
                                    <div class="tab-content" id="nav-tabContent2">
                                        <div class="tab-pane fade show active" id="nav-30" role="tabpanel" aria-labelledby="nav-30-tab"></div>
                                        <div class="tab-pane fade" id="nav-31" role="tabpanel" aria-labelledby="nav-31-tab"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-3 py-2" id="main2_right" style="height : 400px;">
                                <div class=" h-100 p-xxl-5 p-lg-4 p-3 border card">
                                    <div class="">
                                        <strong>일정</strong><i class="bi bi-plus col-sm-2 text-end" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="addSearchModal()"></i>
                                    </div>
                                    <div class="" id="schContent"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- search schedule Modal -->
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">주요 일정</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body" id="modalBody">
                                    <table class="boardtable" id="schTable"  data-toggle="table"
                                           data-pagination="true" data-toolbar="#toolbar"
                                           data-search="true" data-side-pagination="true" data-click-to-select="true" data-page-list="[10]">
                                        <thead>
                                        <tr>
                                            <th data-field="date" data-sortable="true">date</th>
                                            <th data-field="content" data-sortable="true">content</th>
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
<%@include file="footer.jsp"%>
<%--            <footer>--%>
<%--                <div class="footer clearfix mb-0 text-muted">--%>
<%--                    <div class="float-start">--%>
<%--                        <p>2021 &copy; asdasdad</p>--%>
<%--                    </div>--%>
<%--                    <div class="float-end">--%>
<%--                        <p>ddddddddd</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </footer>--%>
        </div>
    </div>
</div>
<script src="/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/assets/js/bootstrap.bundle.min.js"></script>
<script src="/assets/js/main.js"></script>
</body>

</html>


<script>

    $(document).ready(function(){
        makeFavoriteMenu();
        makeScheduleInfo();
        makeCarouselCard();
        makeNoticeBBS();
        makeNoticeReg();
    })
    function makeNoticeReg(){
        var nav30 = $('#nav-30');
        var nav31 = $('#nav-31');
        var registerAllInfo = <%=registerAllInfo%>;
        for(var i=0;i<registerAllInfo.length;i++){
            var urlReg = 'reg.kgu?major=main&num=30&mode=view&id='+registerAllInfo[i].id;
            nav30.append('<li class="list-group-item"><a href="'+urlReg+'">'+registerAllInfo[i].title+'</a></li>')
        }
        // for(var i=0;i<registerAllInfo.length;i++){ 자료실
        //     var urlReg = 'reg.kgu?major=main&num=30&mode=view&id='+registerAllInfo[i].id;
        //     nav30.append('<li class="list-group-item"><a href="'+urlReg+'">'+registerAllInfo[i].title+'</a></li>')
        // }

        var menuPageList = <%=menuPageList%>;
        var nav30tab = $('#nav-30-tab');
        var nav31tab = $('#nav-31-tab');
        for (var i = 0 ; i < menuPageList.length; i++){
            if(menuPageList[i].page_id == '30'){
                nav30tab.append(menuPageList[i].page_title);
            }
            if(menuPageList[i].page_id == '31'){
                nav31tab.append(menuPageList[i].page_title);
            }
        }
    }
    function makeNoticeBBS() {
        var notice21 = $('#nav-21');
        var notice22 = $('#nav-22');
        var notice23 = $('#nav-23');
        var bbs21=<%=bbs21%>;
        var bbs22=<%=bbs22%>;
        var bbs23=<%=bbs23%>;
        var text21='<ul class="list-group">';
        var text22='<ul class="list-group">';
        var text23='<ul class="list-group">';
        for (var i=0; i<bbs21.length; i++){
            var url21 = 'bbs.kgu?major=main&num=21&mode=view&id='+bbs21[i].id;
            text21+='<li class="border-0 list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                +'<a href="'+url21+'"><span>'+bbs21[i].title+'</span></a>'
                +'<a href="'+url21+'"><span>'+bbs21[i].last_modified+'</span></a>'
                +'</li></ul>';
        }
        for (var i=0; i<bbs22.length; i++){
            var url22 = 'bbs.kgu?major=main&num=22&mode=view&id='+bbs22[i].id;
            text22+='<li class="border-0 list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                +'<a href="'+url22+'"><span>'+bbs22[i].title+'</span></a>'
                +'<a href="'+url22+'"><span>'+bbs22[i].last_modified+'</span></a>'
                +'</li></ul>';
        }
        for (var i=0; i<bbs23.length; i++){
            var url23 = 'bbs.kgu?major=main&num=23&mode=view&id='+bbs23[i].id;
            text23+='<li class="border-0 list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                +'<a href="'+url23+'"><span>'+bbs23[i].title+'</span></a>'
                +'<a href="'+url23+'"><span>'+bbs23[i].last_modified+'</span></a>'
                +'</li></ul>';
        }
        notice21.append(text21);
        notice22.append(text22);
        notice23.append(text23);

        var menuPageList = <%=menuPageList%>;
        var nav21tab = $('#nav-21-tab');
        var nav22tab = $('#nav-22-tab');
        var nav23tab = $('#nav-23-tab');
        var tab_name_21 = '';
        var tab_name_22 = '';
        var tab_name_23 = '';
        for (var i = 0 ; i < menuPageList.length; i++){
            if(menuPageList[i].page_id == '21'){
                tab_name_21=menuPageList[i].page_title;
                nav21tab.append(tab_name_21);
            }
            if(menuPageList[i].page_id == '22'){
                tab_name_22=menuPageList[i].page_title;
                nav22tab.append(tab_name_22);
            }
            if(menuPageList[i].page_id == '23'){
                tab_name_23=menuPageList[i].page_title;
                nav23tab.append(tab_name_23);
                break;
            }
        }
    }

    function makeFavoriteMenu() {
        var menu = $('#favorite_menu');
        var favorite_menu = <%=favorite_menu%>;
        var text='';
        for (var i=0;i<favorite_menu.length;i++){
            text+='<a href="'+favorite_menu[i].url+'" class="list-group-item list-group-item-action py-3 lh-tight">'
                +'<div class="d-flex w-100 align-items-center justify-content-between">'
                +'<p class="h3 m-0">'+favorite_menu[i].name+'</p>'
                +'<i class="h3 m-0 bi-stack"></i>'
                +'</div>'
                +'</a>';
        }
        menu.append(text);
    }
    function makeCarouselCard(){ // 슬라이더 카드 만드는 함수
        var list = $('#carouselCard');
        var list2 =$('#carouselButton');
        var text = '';
        var text2 ='';
        var sliderList = <%=slider%>;

        if(sliderList.length==0){ // 데이터가 없을 시 디폴트 화면 구성
            text2 +='<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 0"></button>'
            text +='<div class="h-100 carousel-item active">';
            text +='<svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"></rect></svg>'
            text +='<div class="container"> <div class="carousel-caption"> <h1>등록된 대문이 없습니다.</h1> <p>관리자 모드에서 대문을 추가해주시기 바랍니다.</p> </div> </div>'
            text +='</div>';
        }

        for(var j=0; j<sliderList.length; j++){
            if(j==0){
                text2 +='<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="'+j+'" class="active" aria-current="true" aria-label="Slide '+j+'"></button>'
            }
            else{
                text2 +='<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="'+j+'" aria-current="true" aria-label="Slide '+j+'"></button>'
            }
        }
        list2.append(text2);
        for (var i =0; i< sliderList.length; i++){

            if(i==0){
                text +='<div class="carousel-item active">'
            }
            else{
                text +='<div class="carousel-item">'
            }
            text += '<img width="100%" height="100%" src = "'+sliderList[i].slider_img+'">'
            text += '</div>';
        }


        list.append(text);
    }


    function makeScheduleInfo(){
        var scheduleAllInfo = <%=scheduleAllInfo%>;
        var schedule = $('#schContent');
        var text='';
        var size = scheduleAllInfo.length;
        var today = new Date();
        for(var i = 0; i < size; i++){
            var date = new Date(scheduleAllInfo[i].date);
            text += '<div class="bd-callout ';
            var diffDay = (date.getTime() - today.getTime()) / (24 * 60 * 60 * 1000);
            if(diffDay < 0){
                text += 'bd-callout-end';
            }
            else if(diffDay < 10){
                text += 'bd-callout-warning';
            }
            else{
                text += 'bd-callout-info';
            }
            text +=' row"><div class="border-end col-xxl-5 col-lg-12 col-sm-5"><strong>'+formatDate(date)+'</strong></div><div class="border-end col-xxl-7 col-lg-12 col-sm-7">'+scheduleAllInfo[i].content+'</div></div>';
        }
        schedule.html(text);
    }

    function formatDate(date) {
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

    function addSearchModal(){
        var scheduleAllInfo = <%=scheduleAllInfo%>;
        var rows = [];
        var size = scheduleAllInfo.length;
        for(var i=0;i<size;i++){
            var schedule=scheduleAllInfo[i];
            rows.push({
                id: schedule.id,
                date: formatDate(schedule.date),
                content: schedule.content
            });
        }
        $('#schTable').bootstrapTable('load',rows);
    }

</script>

<style>
    .bd-callout {
        margin-top: 1rem;
        margin-bottom: 1rem;
        border: 1px solid #e9ecef;
        border-left-width: .25rem;
        border-radius: .25rem;
        padding-top: 0.5rem;
        padding-bottom: 0.5rem;
    }

    .bd-callout-info {
        border-left-color: #5bc0de;
    }

    .bd-callout-warning {
        border-left-color: #f0ad4e;
    }

    .bd-callout-end {
        border-left-color: #7d8285;
    }
</style>