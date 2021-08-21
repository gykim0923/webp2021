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
        <div class="col-xxl-5 col-12">
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
                <div class="text-center mt-5 text-lg h4">
                    <a href="https://sites.google.com/kyonggi.ac.kr/help/"
                       class="font-bold"><span>학교 구글 계정이 없으신가요? </span></a><br>
                    <!-- Button trigger for scrollbar modal -->
                    <a class="font-bold" data-bs-toggle="modal" href="#exampleModalToggle" role="button">로그인에 문제가
                        있어요.</a>
                </div>
            </div>
        </div>
        <div class="col-xxl-7 d-none d-lg-block">
            <div id="auth-right"></div>
        </div>
    </div>
</div>

<!--scrollbar Modal start-->
<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
     tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalToggleLabel">주요 오류 원인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <h5>403 에러가 떠요.</h5><br>
                <p>구글 보안정책 상 학교 계정(ex. @kyonggi.ac.kr)이 아닌 구글 계정(ex. @gmail.com)으로는 로그인이 불가능 합니다.</p><br><br>
                <h5>로그인 버튼을 눌러도 반응이 없어요.</h5><br>
                <p>Chrome 이외의 환경에서 오류가 발생할 수 있으며, 쿠키가 허용되지 않는 환경(ex. 크롬 시크릿 모드, 일부 모바일 어플의 내장 브라우저 등)에서는 로그인이 불가능합니다. 크롬 시크릿 모드에서 로그인을 허용하시려면 크롬 설정 - 쿠키 및 기타 사이트 데이터에서 쿠키를 허용해주셔야 로그인이 가능합니다.</p><br><br>
                <h5>이메일 변경이 감지 됐대요.</h5><br>
                <p>이 사이트에 회원 가입 이후, 구글에서 이메일을 임의로 변경하는 경우 로그인을 허용하지 않습니다. 이메일 주소를 원복하거나 계정 삭제 후 재가입 하셔야 합니다. (1인 1계정 원칙)</p><br><br>
                <h5>잘못된 토큰 값 요청이래요.</h5><br>
                <p>구글 서버로 부터 브라우저로 전달받은 1회성 토큰을 이용하여 구글 서버에 진위 여부를 검증하는 단계에서 오류가 발생하는 경우 입니다. 브라우저의 캐시비우기 등을 한 이후, 재시도 바랍니다. 이후에도 해결이 되지 않는다면 관리자에게 연락 바랍니다.</p><br><br>
            </div>
        </div>
    </div>
</div>
<!--scrollbar Modal end-->
</body>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</html>

<script>
    //뒤로가기로 로그인 페이지 접근할 수 없도록 막음
    window.history.forward();
    function noBack() {
        window.history.forward();
    }

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
        var text = '';
        if (mode == 'check') {
            text = '<button class="btn btn-secondary" type="button" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>DB 조회 중 ...</button>';
        } else if (mode == 'success') {
            text = '<button class="btn btn-success" type="button" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>인증 성공</button>';
        } else if (mode == 'success_but_wrong_email') {
            text = '<button class="btn btn-warning" type="button" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>계정정보 변경감지</button>';
        } else if (mode == 'register') {
            text = '<button class="btn btn-primary" type="button" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>인증 성공</button>';
        } else if (mode == 'failure') {
            text = '<button class="btn btn-danger" type="button" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>인증 실패</button>';
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
                    html: '구글 로그인에 성공했지만 홈페이지에<br> 회원정보가 존재하지 않습니다.<br> 회원가입 페이지로 이동합니다.',
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
                    footer: '<a href="">관리자에게 문의 바랍니다.</a>'
                })
            }
        };
        xhr.send('idtoken=' + id_token);
    }
</script>