<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-26
  Time: 오후 6:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer miss = (Integer) session.getAttribute("miss");
    String majorInfo = (String) request.getAttribute("majorInfo");
%>
<html>
<head>
    <!-- content에 자신의 OAuth2.0 클라이언트ID를 넣습니다. -->
    <meta name ="google-signin-client_id" content="961716324050-r6i9dib682nsqjotloum1igkvf1jm0og.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>

    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0">
    <%--    Bootstrap--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <%--    jQuery--%>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <%--    Bootstrap Table--%>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css">
    <script src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>

    <style>
        .font1, font2{
            font-family: HY견고딕;
        }
        .font2{
            color:dimgray;
        }
        .logo{
            margin:0;
        }
        .col-5{
            padding:0;
        }
        .col-7{
            padding:0;
        }
    </style>
    <!-- Custom styles for this template -->
    <link href="css/login.css" rel="stylesheet">
</head>
<body class="text-center">
<main class="form-signin">
    <div>
        <div class="row py-5">
            <div class="col-5">
                <img class="img-fluid" onclick="window.location.href='main.kgu';" src="/img/logo/kgu_logo(500x300).png"/>
            </div>
            <div class="col-7">
                <div class="py-2">
                    <div class = "font1">
                        <a href="main.kgu"><p class="h2 logo text-dark"><strong>경기대학교</strong></p></a>
                    </div>
                    <div class = "font2">
                        <a href="main.kgu"><p class="h5 text-dark"><strong id="majorTitle"></strong></p></a>
                    </div>
                </div>
            </div>
        </div>


        <h1 class="h3 mb-3 fw-normal">구글 통합 로그인</h1>
        <div>학교 구글 계정(kyonggi.ac.kr)으로 로그인해주세요.</div>
        <%--        구글 로그인 버튼 --%>
        <div class="g-signin2" data-onsuccess="onSignIn"></div>

<%--        <a href="#" onclick="signOut();">Sign out</a>--%>
<%--        <script>--%>
<%--            function signOut() {--%>
<%--                var auth2 = gapi.auth2.getAuthInstance();--%>
<%--                auth2.signOut().then(function () {--%>
<%--                    console.log('User signed out.');--%>
<%--                });--%>
<%--            }--%>
<%--        </script>--%>

        <script>
            function onSignIn(googleUser) {
                var id_token = googleUser.getAuthResponse().id_token;
                var xhr = new XMLHttpRequest();
                xhr.open('POST', 'google_login.kgu');
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.onload = function() {
                    console.log('Signed in as: ' + xhr.responseText);
                    if(xhr.responseText=='success'){
                        alert('로그인 성공');
                        window.location.href='main.kgu';
                    }
                    else if(xhr.responseText=='success_but_wrong_email'){
                        alert('DB에 계정이 존재하지만, 이메일 변경이 감지되어 로그인을 불허합니다.');
                    }
                    else if (xhr.responseText=='register'){
                        alert('구글 로그인에 성공했지만 DB에 회원정보가 존재하지 않습니다. 회원가입으로 이동합니다.');
                        window.location.href='register_v2.kgu';
                    }
                    else if (xhr.responseText=='failure'){
                        alert('잘못된 토큰 값을 요청하였습니다.');
                    }
                };
                xhr.send('idtoken=' + id_token);
            }
        </script>
    </div>
</main>
</body>
</html>
