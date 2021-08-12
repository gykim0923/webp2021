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
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, height=device-height, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0">

    <title>로그인 페이지 v2</title>
    <link rel="stylesheet" href="/assets/css/bootstrap.css">
    <link rel="stylesheet" href="/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="/assets/css/app.css">
    <link rel="stylesheet" href="/assets/css/pages/auth.css">
    <link rel="stylesheet" href="/assets/vendors/sweetalert2/sweetalert2.min.css">


    <script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>


    <!-- content에 자신의 OAuth2.0 클라이언트ID를 넣습니다. -->
    <meta name="google-signin-client_id"
          content="961716324050-r6i9dib682nsqjotloum1igkvf1jm0og.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>

    <%--    jQuery--%>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<div id="auth">

    <div class="row h-100">
        <div class="col-lg-5 col-12">
            <div id="auth-left">
                <div class="auth-logo">
                    <div class="row py-5"></div>
                </div>
                <h1 class="auth-title">GOOGLE LOGIN</h1>
                <p class="auth-subtitle mb-5">이 사이트는 경기대학교 구글 계정(@kyonggi.ac.kr)으로 로그인이 가능합니다.</p>
                <%--        구글 로그인 버튼 --%>
                <div class="g-signin2 d-flex justify-content-center" data-onsuccess="onSignIn"></div>
                <%--구글 로그인 버튼 끝--%>
<%--                로딩 버튼--%>
                <div class="py-3 d-flex justify-content-center" id="loading"></div>
<%--                로딩 버튼 끝--%>
                <div class="text-center mt-5 text-lg fs-4">
                    <a href="https://sites.google.com/kyonggi.ac.kr/help/" class="font-bold"><span>학교 구글 계정이 없으신가요? </span></a><br>
                    <!-- Button trigger for scrollbar modal -->
                    <button type="button" class="btn font-bold" data-bs-toggle="modal"
                            data-bs-target="#exampleModalLong">
                        로그인 에러가 나요.
                    </button>
                </div>
            </div>
        </div>
        <div class="col-lg-7 d-none d-lg-block">
            <div id="auth-right"></div>
        </div>
    </div>
</div>

<!--scrollbar Modal start-->
<div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">자주 발생하는 에러</h5>
                <button type="button" class="close" data-bs-dismiss="modal"
                        aria-label="Close">
                    <i data-feather="x"></i>
                </button>
            </div>
            <div class="modal-body">
                <h5>dd</h5><br>
                <p>구글 보안정책 상 학교 계정이 아닌 구글 계정(ex. gmail)으로는 로그인이 불가능 합니다. Chrome 이외의 환경에서 오류가 발생할 수 있으며, 쿠키가 허용되지 않는 환경(ex. 크롬 시크릿 모드, 일부 모바일 어플의 내장 브라우저 등)에서는 로그인이 불가능합니다.</p>
            </div>
        </div>
    </div>
</div>
<!--scrollbar Modal end-->

</body>
</html>

<script>
    $(document).ready(function () {
        makeMajorTitle();
    })

    function makeMajorTitle() {
        var majorInfo =<%=majorInfo%>;
        var title = $('#majorTitle');
        title.append(majorInfo[0].major_name);
    }

    function makeLoadingButton(mode) {
        var button = $('#loading');
        var text='';
        if(mode=='check'){
            text='<button class="btn btn-secondary" type="button" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>DB 조회 중 ...</button>';
        }
        else if(mode=='success'){
            text='<button class="btn btn-success" type="button" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>인증 성공</button>';
        }
        else if(mode=='success_but_wrong_email'){
            text='<button class="btn btn-warning" type="button" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>계정정보 변경감지</button>';
        }
        else if(mode=='register'){
            text='<button class="btn btn-primary" type="button" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>인증 성공</button>';
        }
        else if(mode=='failure'){
            text='<button class="btn btn-danger" type="button" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>인증 실패</button>';
        }
        button.html(text);
    }

    function onSignIn(googleUser) {
        makeLoadingButton('check');
        var id_token = googleUser.getAuthResponse().id_token;
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'google_login.kgu');
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function () {
            // console.log('Signed in as: ' + xhr.responseText);
            makeLoadingButton(xhr.responseText);
            if (xhr.responseText == 'success') {
                swal.fire({
                    title: '로그인 성공',
                    icon: 'success',
                    showConfirmButton: false,
                    timer: 1500
                }).then(function () {
                    window.location.href = 'main.kgu';
                });
            } else if (xhr.responseText == 'success_but_wrong_email') {
                Swal.fire({
                    icon: 'error',
                    title: '이메일 변경 감지',
                    text: 'DB에 계정이 존재하지만, 이메일 변경이 감지되어 로그인을 불허합니다.',
                    footer: '<a href="">Why do I have this issue?</a>'
                })
            } else if (xhr.responseText == 'register') {
                swal.fire({
                    title: '회원가입',
                    text: '구글 로그인에 성공했지만 홈페이지 DB에 회원정보가 존재하지 않습니다. 회원가입 페이지로 이동합니다.',
                    icon: 'warning',
                    button: '확인'
                }).then(function () {
                    window.location.href = 'register_v2.kgu';
                });
            } else if (xhr.responseText == 'failure') {
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