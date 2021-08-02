<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-05
  Time: 오후 6:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String google_name = (String)session.getAttribute("google_name");
    String google_email = (String)session.getAttribute("google_email");
    String getAllKguMajor = (String)request.getAttribute("getAllKguMajor");
    String getAllType = (String)request.getAttribute("getAllType");
%>
<html>
<head>
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0">
    <%--    Bootstrap--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <%--    jQuery--%>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <%--    Bootstrap Table--%>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css">
    <script src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>
    <script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>

    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/assets/css/bootstrap.css">
    <link rel="stylesheet" href="/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="/assets/css/app.css">
    <link rel="stylesheet" href="/assets/css/pages/auth.css">
    <style>
        .my-2 {

        }
    </style>
</head>
<body>
<div id="auth">

    <div class="row h-100">
        <div class="col-lg-5 col-12">
            <div id="auth-left">
                <div class="auth-logo">
                    <a href="index.html"><img src="/assets/images/logo/logo.png" alt="Logo"></a>
                </div>
                <h1 class="auth-title">회원가입</h1>
                <p class="auth-subtitle mb-5">추가 정보를 입력하고<br> 회원가입을 완료하세요.</p>

                <div>
                    <div class="form-group position-relative has-icon-left mb-4">
                        <input type="text" class="form-control form-control-xl" placeholder="이메일" id="email" value=<%=google_email%> readonly>
                        <div class="form-control-icon">
                            <i class="bi bi-envelope"></i>
                        </div>
                    </div>
                    <div class="form-group position-relative has-icon-left mb-4">
                        <input type="text" class="form-control form-control-xl" id="name"  placeholder="이름" value=<%=google_name%>>
                        <div class="form-control-icon">
                            <i class="bi bi-person"></i>
                        </div>
                    </div>

                    <div class="form-group position-relative has-icon-left mb-4">
                        <div class="form-group row align-items-center">
                            <div class="col-lg-10 col-9">
                                <input type="text" class="form-control" id="id" placeholder="학번(혹은 교번)" value="" required>
                            </div>
                            <div class="col-lg-2 col-3">
                                <button class="btn float-right btn-primary" onclick="checkID()">중복확인</button>
                            </div>
                            <span id="warningID"></span>
                            <div class="invalid-feedback">
                                학번을 입력해 주세요.
                            </div>
                        </div>
                    </div>

                    <div class="form-group position-relative has-icon-left mb-4">
                        <label for="gender" class="form-label">성별</label>
                        <div id="gender">
                            <div class="form-check">
                                <input id="male" name="gender" type="radio" class="form-check-input" value="남" checked required>
                                <label class="form-check-label" for="male">남</label>
                            </div>
                            <div class="form-check">
                                <input id="female" name="gender" type="radio" class="form-check-input" value="여" required>
                                <label class="form-check-label" for="female">여</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group position-relative has-icon-left mb-4">
                        <label for="birth">생년월일</label>
                        <div class="form-floating mb-3">
                            <input type="date" class="form-control" id="birth" placeholder="date">
                        </div>
                    </div>

                    <div class="form-group position-relative has-icon-left mb-4">
                        <label for="phone" class="form-label">전화번호</label>
                        <input type="text" class="form-control" id="phone" placeholder="-포함해서 적어주세요." required>
                        <div class="invalid-feedback">
                            전화번호를 입력해주세요.
                        </div>
                    </div>

                    <div class="form-group position-relative has-icon-left mb-4">
                        <div class="col-md-4">
                            <label for="hope_type" class="form-label">희망구분<span> (관리자 승인후 변경됩니다.)</span></label>
                            <select class="form-select" id="hope_type" required></select>
                            <div class="invalid-feedback">
                                희망구분을 선택해 주세요.
                            </div>
                        </div>

                        <div class="col-md-8">
                            <label for="major" class="form-label">학과</label>
                            <select class="form-select" id="major" required></select>
                            <div class="invalid-feedback">
                                학과를 선택해 주세요
                            </div>
                        </div>
                    </div>

                    <button class="btn btn-primary btn-block btn-lg shadow-lg mt-5" onclick="LetsRegisterGoogle()">Sign Up</button>
                </div>
                <div class="text-center mt-5 text-lg fs-4">
                    <p class='text-gray-600'>
                        Already have an account?
                        <a href="auth-login.html" class="font-bold">Log in</a>.
                    </p>
                </div>
            </div>
        </div>
        <div class="col-lg-7 d-none d-lg-block">
            <div id="auth-right">

            </div>
        </div>
    </div>
</div>

<br>
</body>
</html>
<script>

    $(document).ready(function(){
        makeTypeList();
        makeMajorList();
    })

    function makeMajorList(){
        var major = $('#major');
        var majorList=<%=getAllKguMajor%>;
        var text = '';
        for(var i=0;i<majorList.length;i++){
            text+='<option value="'+majorList[i].major+'">'+majorList[i].campus+' '+majorList[i].college+' '+majorList[i].major+'</option>';
        }
        text+='<option>기타</option>';
        major.append(text);
    }

    function makeTypeList(){
        var type = $('#hope_type');
        var typeList=<%=getAllType%>;
        var text = '';
        for(var i=0;i<typeList.length;i++){
            text+='<option>'+typeList[i].type_name+'</option>';
        }
        type.append(text);
    }
</script>

<script>
    var ischeckID = 0;

    function checkID() { //중복확인
        var id = $('#id').val();
        $.ajax({
            url: "ajax.kgu",
            type: "post",
            data: {
                req: "checkId",
                data: id
            },
            success: function (data) {
                var result = data;
                if (data == 'dup') {
                    ischeckID = 0;
                    $('#warningID').html('*중복된 ID입니다');
                    $('#warningID').css('color', 'red');
                    $('#warningID').css('font-size', '11px');
                    $('#warningID').css('margin-left', '10px');

                } else {
                    ischeckID = 1;
                    $('#warningID').html('*사용가능한 ID입니다');
                    $('#warningID').css('color', 'blue');
                    $('#warningID').css('font-size', '11px');
                    $('#warningID').css('margin-left', '10px');
                }
            }
        })
    }


    function LetsRegisterGoogle() { //여기서부터 작업
        if (ischeckID == 1) {
            var name = $('#name').val();
            var id = $('#id').val();
            var gender = $('input[name=gender]:checked').val();
            var birth = $('#birth').val();
            var phone = $('#phone').val();
            var hopetype = $('#hope_type').val();
            var major = $('#major').val();
            var perID = id;

            if (name != '' && gender != '' && birth != '' && phone != '') {
                var update = id+"-/-/-"+perID+"-/-/-"+name+"-/-/-"+gender+"-/-/-"+birth+"-/-/-"+hopetype+"-/-/-"+phone+"-/-/-"+major;

                $.ajax({
                    url: "ajax.kgu",
                    type: "post",
                    data: {
                        req: "registerGoogle",
                        data: update
                    },
                    success: function (data) {
                        if (data == 'success') {
                            swal.fire({
                                title : '회원가입 성공',
                                icon : 'success',
                                showConfirmButton: true
                            }).then(function (){
                                window.location.href='main.kgu';
                            });
                        } else

                        swal.fire({
                            title : '서버에러, 다음에 시도해주세요',
                            icon : 'error',
                            showConfirmButton: true
                        });
                    }
                })
            } else {
                swal.fire({
                    title : '빈칸을 입력해주세요',
                    icon : 'warning',
                    showConfirmButton: true
                });

            }
        } else
            swal.fire({
                title : '아이디 중복확인을 해주세요',
                icon : 'warning',
                showConfirmButton: true
            });
    }

</script>

