<%--
  Created by IntelliJ IDEA.
  User: gykim
  Date: 2021-07-05
  Time: 오후 6:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer miss = (Integer) session.getAttribute("miss");
    String majorInfo = (String) request.getAttribute("majorInfo");
%>
<html>
<head>
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0">
    <%--    Bootstrap--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <%--    jQuery--%>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <%--    Bootstrap Table--%>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css">
    <script src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>

        <%--        암호화--%>
        <script src="js/sha256.js"></script>

        <script>
            function letsSubmit() {
                if($('#id').val() != '' && $('#password').val() != ''){
                    doSha();
                    $('#login_form').submit();
                }
                else{
                    alert("빈 칸을 입력해주세요");
                }
            }

            function doSha(){
                var forsha = $('#id').val() + $('#password').val();
                $('#password_hash').val(SHA256(forsha));
            }
        </script>

<%--<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">--%>


<style>

    .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
    }
    @media (min-width: 768px) {
        .bd-placeholder-img-lg {
            font-size: 3.5rem;
        }
    }
    .cs_logo{
        margin-bottom: 20px;
    }
    /*.btn{*/
    /*    display: flex;*/
    /*}*/
    /*.btn-primary{*/
    /*    align-items: center;*/
    /*    text-align: center;*/
    /*}*/
    .font1,font2{
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
    .a{
        height: 130px ; display: table-cell; vertical-align: middle;
    }





</style>


<!-- Custom styles for this template -->
<link href="css/login.css" rel="stylesheet">
</head>
<body class="text-center">

<main class="form-signin">
    <form method="POST" action="login.kgu" id="login_form">

        <div class="row py-5">
            <div class="col-5">
                <img class="img-fluid" onclick="window.location.href='main.kgu';" src="/img/logo/kgu_logo(500x300).png"/>
            </div>
            <div class="col-7">
                <div class="py-2">
                    <div class = "font1">
                        <a href="main.kgu"><p class="h2 logo"><strong>경기대학교</strong></p></a>
                    </div>
                    <div class = "font2">
                        <a href="main.kgu"><p class="h5"><strong id="majorTitle"></strong></p></a>
                    </div>
                </div>
            </div>
        </div>


        <h1 class="h3 mb-3 fw-normal">로그인</h1>

        <div class="form-floating">
            <input type="text" class="form-control" name="id" id="id" placeholder="아이디를 입력하세요">
            <label for="id">아이디</label>
            <input type="submit" onclick="letsSubmit()" style="display:none">
        </div>
        <div class="form-floating">
            <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호를 입력하세요">
            <label for="password">비밀번호</label>
            <input type="hidden" name="password_hash" id="password_hash" class="iText" value="VALUE_NOT_EMPTY">
        </div>

        <div class="checkbox mb-3">
            <label>
                <p>
                    <span id="wrong_password">초기 비밀번호는 생년월일(6자리)입니다.</span>
                </p>
                <a href="register.kgu">
                    <div>아직 회원가입을 안하셨나요?</div>
                </a>
            </label>
        </div>
        <div style="width: 100%">
            <a href="#" class="w-100 btn btn-lg btn-primary text-center" onclick="letsSubmit()" style = "text-decoration: none;">로그인</a>
        </div>
    </form>
</main>



</body>

<script>

    $(document).ready(function(){
        makeMajorTitle();
    })
    function makeMajorTitle(){
        var majorInfo =<%=majorInfo%>;
        var title = $('#majorTitle');
        title.append(majorInfo[0].major_name);
    }

    var panel = $('#wrong_password');
    var miss = <%=miss%>;
    if(miss > 0){
        panel.text('잘못된 아이디, 혹은 비밀번호입니다 (' + miss + '회)');
        panel.css({'color' : 'red', 'font-weight' : 'bold', 'font-size' : '20px'});
    }


</script>
</html>
