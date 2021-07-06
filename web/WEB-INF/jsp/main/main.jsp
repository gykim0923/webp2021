<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-06-24
  Time: 오후 6:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .carousel-item {
            height: 32rem;
        }
    </style>
</head>
<%@include file="./header.jsp"%>
<body>
<main>
    <div class="container py-4">
        <div class="row align-items-md-stretch">
            <div class="col-lg-9 py-2">
                <div id="myCarousel" class="carousel slide"
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
            <div class="col-lg-3 py-2">
                <div class=" h-100 p-5 bg-light border">
                    <h2><strong>바로가기</strong></h2>
                </div>
            </div>
        </div>



        <div class="row align-items-md-stretch">

            <div class="col-lg py-2">
                <div class=" h-100 p-5 bg-light border">
                    <h2><strong>영역 1</strong></h2>
                    <hr>
                </div>
            </div>

            <div class="col-lg py-2">
                <div class=" h-100 p-5 bg-light border">
                    <h2><strong>영역 2</strong></h2>
                    <hr>
                </div>
            </div>

            <div class="col-lg-3 py-2">
                <div class=" h-100 p-5 bg-light border">
                    <h2><strong>일정</strong></h2>
                </div>
            </div>
        </div>
    </div>
</main>
main 페이지의 내용<br>
<a href="tutorial.kgu?tutorial=main">연습 페이지로 이동하기</a>
</body>
</html>
