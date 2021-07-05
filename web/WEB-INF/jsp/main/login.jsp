<%--
  Created by IntelliJ IDEA.
  User: gykim
  Date: 2021-07-05
  Time: 오후 6:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <%--    Bootstrap--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <%--    jQuery--%>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <%--    Bootstrap Table--%>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css">
    <script src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>

<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">


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
    .btn{
        display: flex;
    }
    .btn-primary{
        align-items: center;
        text-align: center;
    }
</style>


<!-- Custom styles for this template -->
<link href="css/login.css" rel="stylesheet">
</head>
<body class="text-center">

<main class="form-signin">
    <form>
        <img class="cs_logo" src="img/cs_logo.png" alt="" width="300" height=75>
        <h1 class="h3 mb-3 fw-normal">로그인</h1>

        <div class="form-floating">
            <input type="email" class="form-control" id="floatingInput" placeholder="name@example.com">
            <label for="floatingInput">아이디</label>
        </div>
        <div class="form-floating">
            <input type="password" class="form-control" id="floatingPassword" placeholder="Password">
            <label for="floatingPassword">비밀번호</label>
        </div>

        <div class="checkbox mb-3">
            <label>
                <input type="checkbox" value="remember-me"> Remember me
            </label>
        </div>
        <div class="btn">
            <a href="main.kgu" class="w-100 btn btn-lg btn-primary" onclick="letsSubmit()" style = "text-decoration: none;">
                <div class="login_btn">
                    로그인
                </div>
            </a>
            <a href="register.kgu" class="w-100 btn btn-lg btn-primary" style = "text-decoration:none;">
                <div class="login_btn">
                    회원가입
                </div>
            </a>
        </div>
    </form>
</main>



</body>
</html>
