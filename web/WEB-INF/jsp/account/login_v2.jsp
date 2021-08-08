<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-26
  Time: 오후 6:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String majorInfo = (String) request.getAttribute("majorInfo");
%>
<!DOCTYPE html>
<html>
<%--<head>--%>

<%--    &lt;%&ndash;    Bootstrap Table&ndash;%&gt;--%>
<%--    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css">--%>
<%--    <script src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>--%>

<%--    <style>--%>
<%--        .font1, font2{--%>
<%--            font-family: HY견고딕;--%>
<%--        }--%>
<%--        .font2{--%>
<%--            color:dimgray;--%>
<%--        }--%>
<%--        .logo{--%>
<%--            margin:0;--%>
<%--        }--%>
<%--        .col-5{--%>
<%--            padding:0;--%>
<%--        }--%>
<%--        .col-7{--%>
<%--            padding:0;--%>
<%--        }--%>
<%--    </style>--%>
<%--    <!-- Custom styles for this template -->--%>
<%--    <link href="css/login.css" rel="stylesheet">--%>
<%--</head>--%>
<%--<body class="text-center">--%>
<%--<main class="form-signin">--%>
<%--    <div>--%>



<%--        <h1 class="h3 mb-3 fw-normal">구글 통합 로그인</h1>--%>
<%--        <div>학교 구글 계정(kyonggi.ac.kr)으로 로그인해주세요.</div>--%>

<%--    </div>--%>
<%--</main>--%>
<%--</body>--%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0">

    <title>로그인 페이지 v2</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/assets/css/bootstrap.css">
    <link rel="stylesheet" href="/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="/assets/css/app.css">
    <link rel="stylesheet" href="/assets/css/pages/auth.css">
    <link rel="stylesheet" href="/assets/vendors/sweetalert2/sweetalert2.min.css">


    <script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>


    <!-- content에 자신의 OAuth2.0 클라이언트ID를 넣습니다. -->
    <meta name ="google-signin-client_id" content="961716324050-r6i9dib682nsqjotloum1igkvf1jm0og.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>

    <%--    jQuery--%>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<div id="auth">

    <div class="row h-100">
        <div class="col-lg-5 col-12">
            <div id="auth-left">
                <div class="auth-logo">
                    <div class="row py-5">
<%--                        <div class="col-5">--%>
<%--                            <img class="img-fluid" onclick="window.location.href='main.kgu';" src="/img/logo/kgu_logo(500x300).png"/>--%>
<%--                        </div>--%>
<%--                        <div class="col-7">--%>
<%--                            <div class="py-2">--%>
<%--                                <div class = "font1">--%>
<%--                                    <a href="main.kgu"><p class="h2 logo text-dark"><strong>경기대학교</strong></p></a>--%>
<%--                                </div>--%>
<%--                                <div class = "font2">--%>
<%--                                    <a href="main.kgu"><p class="h5 text-dark"><strong id="majorTitle"></strong></p></a>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                    </div>
                </div>
                <h1 class="auth-title">GOOGLE LOGIN</h1>
                <p class="auth-subtitle mb-5">이 사이트는 경기대학교 구글 계정(@kyonggi.ac.kr)으로 로그인이 가능합니다.</p>


                <%--        구글 로그인 버튼 --%>
                <div class="g-signin2 d-flex justify-content-center" data-onsuccess="onSignIn"></div>

                <div class="text-center mt-5 text-lg fs-4">
                    <a href="https://sites.google.com/kyonggi.ac.kr/help/" class="font-bold"><span>학교 구글 계정이 없으신가요? </span></a>
                </div>
            </div>
        </div>
        <div class="col-lg-7 d-none d-lg-block">
            <div id="auth-right">

            </div>
        </div>
    </div>

</div>
</body>
</html>

<script>
    $(document).ready(function(){
        makeMajorTitle();
    })
    function makeMajorTitle(){
        var majorInfo =<%=majorInfo%>;
        var title = $('#majorTitle');
        title.append(majorInfo[0].major_name);
    }

    function onSignIn(googleUser) {
        var id_token = googleUser.getAuthResponse().id_token;
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'google_login.kgu');
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function() {
            console.log('Signed in as: ' + xhr.responseText);
            if(xhr.responseText=='success'){
                swal.fire({
                    title : '로그인 성공',
                    icon : 'success',
                    showConfirmButton: false,
                    timer: 1500
                }).then(function (){
                    window.location.href='main.kgu';
                });
            }
            else if(xhr.responseText=='success_but_wrong_email'){
                Swal.fire({
                    icon: 'error',
                    title: '이메일 변경 감지',
                    text: 'DB에 계정이 존재하지만, 이메일 변경이 감지되어 로그인을 불허합니다.',
                    footer: '<a href="">Why do I have this issue?</a>'
                })
            }
            else if (xhr.responseText=='register'){
                swal.fire({
                    title : '회원가입',
                    text : '구글 로그인에 성공했지만 홈페이지 DB에 회원정보가 존재하지 않습니다. 회원가입 페이지로 이동합니다.',
                    icon : 'warning',
                    button : '확인'
                }).then(function (){
                    window.location.href='register_v2.kgu';
                });
            }
            else if (xhr.responseText=='failure'){
                Swal.fire({
                    icon: 'error',
                    title: '잘못된 토큰 값 요청',
                    text: '잘못된 토큰 값을 요청하였습니다.',
                    footer: '<a href="">Why do I have this issue?</a>'
                })
            }
        };
        xhr.send('idtoken=' + id_token);
    }
</script>