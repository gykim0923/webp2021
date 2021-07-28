<%@ page import="kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO" %>
<%@ page import="kr.ac.kyonggi.swaig.handler.dao.user.UserDAO" %><%--
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
    <script src='js/sha256.js'></script>
    <style>
        .my-2 {

        }
    </style>
</head>
<body>
<div class="container">
    <main>
        <div class="row justify-content-md-center">
            <div class="col-lg-8">
                <div class="row">
                    구글 회원가입
                </div>
            </div>
        </div>
        <div class="row justify-content-md-center" id="registerReset"><!--class="row g-5"-->
            <div class="col-lg-8">
                <h4 class="mb-3">회원 가입</h4>
                <div class="needs-validation" novalidate>
                    <div class="row g-3">

                        <div class="col-12">
                            <label for="name" class="form-label">이름(반드시 한글로 작성)</label>
                            <input type="name" class="form-control" id="name" placeholder="이름을 입력해주세요" value=<%=google_name%>>
                            <div class="invalid-feedback">
                                이름을 입력해주세요
                            </div>
                        </div>

                        <div class="col-12">
                            <label for="email" class="form-label">E-mail</label>
                            <input type="email" class="form-control" id="email" placeholder="이메일을 입력해주세요." value=<%=google_email%> readonly>
                            <div class="invalid-feedback">
                                이메일을 입력해주세요.
                            </div>
                        </div>

                        <div class="col-12">
                            <label for="id" class="form-label">학번(교번)</label><span id="warningID"></span>
                            <div class="row align-items-md-stretch">
                                <div class="col-10">
                                    <input type="text" class="form-control" id="id" placeholder="학번이나 교번을 입력해주세요." value="" required>
                                </div>
                                <div class="col-2 text-end">
                                    <button class="btn float-right btn-primary" onclick="checkID()">중복확인</button>
                                </div>
                            </div>
                            <div class="invalid-feedback">
                                학번을 입력해 주세요.
                            </div>
                        </div>

                        <div class="my-3">
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
                        <div class="col-12">
                            <label for="birth">생년월일</label>
                            <div class="form-floating mb-3">
                                <input type="date" class="form-control" id="birth" placeholder="date">
                            </div>
                        </div>

                        <div class="col-12">
                            <label for="phone" class="form-label">전화번호</label>
                            <input type="text" class="form-control" id="phone" placeholder="-포함해서 적어주세요." required>
                            <div class="invalid-feedback">
                                전화번호를 입력해주세요.
                            </div>
                        </div>

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
                    <hr class="my-4">
                    <div class="w-100 btn btn-primary btn-lg" type="submit" onclick="LetsRegisterGoogle()">가입하기</div>
                </div>
            </div>
        </div>
    </main>
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
                alert(update);
                $.ajax({
                    url: "ajax.kgu",
                    type: "post",
                    data: {
                        req: "registerGoogle",
                        data: update
                    },
                    success: function (data) {
                        if (data == 'success') {
                            alert("회원가입 성공");
                            window.location.href = "main.kgu";

                        } else
                            alert('SERVER ERROR, Please try again later');
                    }
                })
            } else {
                alert("빈칸을 채워주세요");
            }
        } else
            alert("아이디 중복확인을 해주세요");
    }

</script>