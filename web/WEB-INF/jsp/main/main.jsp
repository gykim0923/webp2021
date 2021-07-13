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
%>
<html>
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
            <div class="col-lg-9 py-2" id="main1_left">
                <div id="myCarousel" class="carousel slide  shadow rounded"
                     data-bs-ride="carousel" style="margin-bottom : 0px;">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true"
                                aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
                    </div>
                    <div class="carousel-inner rounded2">
                        <div class="carousel-item active">
                            <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg"
                                 aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
                                <rect width="100%" height="100%" fill="#777" />
                            </svg>
<%--                            <img class="img-responsive center-block" src="../img/main1.jpg">--%>
                            <div class="container">
                                <div class="carousel-caption text-start">
                                    <h1>Title</h1>
                                    <p>content</p>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg"
                                 aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
                                <rect width="100%" height="100%" fill="#777" />
                            </svg>
<%--                            <img class="bd-placeholder-img" src="../img/main2.jpg">--%>
                            <div class="container">
                                <div class="carousel-caption">
                                    <h1>Title</h1>
                                    <p>content</p>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg"
                                 aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
                                <rect width="100%" height="100%" fill="#777" />
                            </svg>
<%--                            <img class="bd-placeholder-img" src="../img/main3.jpg">--%>
                            <div class="container">
                                <div class="carousel-caption text-end">
                                    <h1>Title</h1>
                                    <p>content</p>
                                </div>
                            </div>
                        </div>
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
                    <h2><strong>일정</strong></h2>
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
    })

    function makeMajorInfo(){
        var majorAllInfo =<%=majorAllInfo%>;
        var info = $('#majorInfo');
        var text='';
        for(var i=0; i<majorAllInfo.length;i++){
            text+='<div class="col-lg major">'
                +'<svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 140x140" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#777"/><text x="50%" y="50%" fill="#777" dy=".3em">140x140</text></svg>'
                +'<h2>'+majorAllInfo[i].major_name+'</h2>'
                +'<p>Some representative placeholder content for the three columns of text below the carousel. This is the first column.</p>'
                +'<p><a class="btn btn-secondary" href="main.kgu?major='+majorAllInfo[i].major_id+'">이동하기</a></p>'
                +'</div>';
        }
        info.append(text);
    }
</script>





