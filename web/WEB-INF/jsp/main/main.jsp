<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-06-24
  Time: 오후 6:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String majorAllInfo = (String)request.getAttribute("majorAllInfo");
    String scheduleAllInfo = (String)request.getAttribute("scheduleAllInfo");
    String slider = (String)  request.getAttribute("slider");
    String major = (String)request.getAttribute("major");
    String num = (String)request.getAttribute("num");
%>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
    <title>Title</title>
    <style>
        .carousel-item {
            height: 32rem;
        }
        .container .major {
            margin-bottom: 1.5rem;
            text-align: center;
        }
    </style>
</head>
<%@include file="./header.jsp"%>
<body>
<main>
    <div class="container py-4">
        <div class="row align-items-md-stretch">
            <div class="col-lg-9 py-2" id="main1_left" >
                <div id="myCarousel" class="carousel slide  shadow rounded" data-bs-ride="carousel" style="margin-bottom : 0px;">
                    <div class="carousel-indicators" id="carouselButton">
                        <%--   슬라이더 사진 개수와 동일한 버트 만들어 줘야함 makecarouselCard에 있음--%>
                    </div>
                    <div class="carousel-inner rounded2" id="carouselCard">
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
                <div class=" h-100 p-5 bg-light border  shadow rounded">
                    <h2><strong>바로가기</strong></h2>
                    <button class="btn btn-dark" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBottom" aria-controls="offcanvasBottom">전공 홈페이지 바로가기</button>

                </div>
            </div>
        </div>



        <div class="row align-items-md-stretch">

            <div class="col-lg py-2" id="main2_left"  style="height : 400px;">
                <div class=" h-100 p-5 bg-light border shadow rounded">
                    <h2><strong>영역 1</strong></h2>
                    <hr>
                </div>
            </div>

            <div class="col-lg py-2" id="main2_center"  style="height : 400px;">
                <div class=" h-100 p-5 bg-light border shadow rounded">
                    <h2><strong>영역 2</strong></h2>
                    <hr>
                </div>
            </div>

            <div class="col-lg-3 py-2" id="main2_right" style="height : 400px;">
                <div class=" h-100 p-5 bg-light border shadow rounded">
                    <div class="row">
                        <h2><strong>일정</strong><i class="bi bi-plus col-sm-2 text-end" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="addSearchModal()"></i></h2>
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
                    </table>                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
<%@include file="./footer.jsp"%>
<div class="offcanvas offcanvas-bottom" tabindex="-1" id="offcanvasBottom" aria-labelledby="offcanvasBottomLabel" style="height: auto;">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasBottomLabel">전공 홈페이지로 이동하기</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body small">
        <div class="container">
            <div class="row" id="majorInfo">

            </div>
        </div>

    </div>
</div>
</html>

<script>
    $(document).ready(function(){
        makeMajorInfo();
        makeScheduleInfo();
        makeCarouselCard();
    })


    function makeCarouselCard(){ // 슬라이더 카드 만드는 함수
        var list = $('#carouselCard');
        var list2 =$('#carouselButton');
        var text = '';
        var text2 ='';
        var sliderList = <%=slider%>;

        if(sliderList.length==0){ // 데이터가 없을 시 디폴트 화면 구성
            text2 +='<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 0"></button>'
            text +='<div class="carousel-item active">';
            text +='<svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"></rect></svg>'
            text +='</div>';
        }

        for(var j=0; j<sliderList.length; j++){
            if(j==0)
                text2 +='<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="'+j+'" class="active" aria-current="true" aria-label="Slide '+j+'"></button>'
            else
                text2 +='<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="'+j+'" aria-current="true" aria-label="Slide '+j+'"></button>'
        }
        list2.append(text2);
        for (var i =0; i< sliderList.length; i++){

            if(i==0)
                text +='<div class="carousel-item active">'
            else
                text +='<div class="carousel-item">'
            text += '<img width="100%" height="100%" src = "'+sliderList[i].slider_img+'">'
            text += '</div>';
        }


        list.append(text);
    }


    function makeMajorInfo(){
        var majorAllInfo =<%=majorAllInfo%>;
        var info = $('#majorInfo');
        var text='';
        for(var i=0; i<majorAllInfo.length;i++){
            text+='<div class="col-lg major">'
                // +'<img src="/img/person.svg" style="height: 140px; width: 140px;">'

                // +'<svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 140x140" preserveAspectRatio="xMidYMid slice" focusable="false">'
                +'<img class="bd-placeholder-img rounded-circle" style="background-color: '+majorAllInfo[i].major_color1+'" weight="140" height="140" src="/img/logo/kgu_logo(500x500).png">'
                // +'<title>Placeholder</title>'
                // +'<rect width="100%" height="100%" fill="#777"/>'
                // +'<text x="50%" y="50%" fill="#777" dy=".3em">140x140</text>'
                // +'</svg>'
                +'<h2><strong>'+majorAllInfo[i].major_name+'</strong></h2>'
                // +'<p>Some representative placeholder content for the three columns of text below the carousel. This is the first column.</p>'
                +'<p><a class="btn btn-secondary" href="main.kgu?major='+majorAllInfo[i].major_id+'">전환하기</a></p>'
                +'</div>';
        }
        info.append(text);
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
            if(diffDay < 0)
                text += 'bd-callout-end';
            else if(diffDay < 10)
                text += 'bd-callout-warning';
            else
                text += 'bd-callout-info';
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