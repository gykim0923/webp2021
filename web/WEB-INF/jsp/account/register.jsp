<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-05
  Time: 오후 6:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String img_login_logo = "img/cs_logo.png";
    String main_url = "main.kgu";
%>
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
</head>
<body>
<div class="container">
    <main>
        <div class="row justify-content-md-center">
            <div class="col-md-4 col-lg-6">
                <a href="<%=main_url%>">
                    <img src="<%=img_login_logo%>" class="img-fluid">
                </a>
            </div>
        </div>
        <div class="row justify-content-md-center"><!--class="row g-5"-->
        <div class="col-lg-8">
            <h4 class="mb-3">회원 가입</h4>
            <div class="needs-validation" novalidate>
                <div class="row g-3">
                    <div class="">
                        <label for="id" class="form-label">학번(교번)</label>
                        <div class="row align-items-md-stretch">
                            <div class="col-10">
                                <input type="text" class="form-control" id="id" placeholder="학번이나 교번을 입력해주세요." value="" required>
                            </div>
                            <div class="col-2">
                                <button type="button" class="btn btn-primary">중복확인</button>
                            </div>
                        </div>
                        <div class="invalid-feedback">
                          학번을 입력해 주세요.
                        </div>
                    </div>

                    <div class="col-12">
                        <label for="pwd" class="form-label">비밀번호(가능한 특수문자: !,@,#,$,%,^,&,*,(,))</label>
                        <div class="input-group has-validation">
                            <input type="text" class="form-control" id="pwd" placeholder="8 글자 이상으로 해주세요." required>
                            <div class="invalid-feedback">
                                비밀번호를 입력해주세요
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <label for="pwdCheck" class="form-label">비밀번호 확인</label>
                        <div class="input-group has-validation">
                            <input type="text" class="form-control" id="pwdCheck" placeholder="똑같이 입력해주세요." required>
                            <div class="invalid-feedback">
                                비밀번호를 확인해 주세요.
                            </div>
                        </div>
                    </div>

                    <div class="col-12">
                        <label for="name" class="form-label">이름</label>
                        <input type="email" class="form-control" id="name" placeholder="이름을 입력해주세요">
                        <div class="invalid-feedback">
                          이름을 입력해주세요
                        </div>
                    </div>
                    <%--<h4 class="mb-3">성별</h4> --%>

                    <div class="my-3">
                        <label for="gender" class="form-label">성별</label>
                        <div id="gender">
                            <div class="form-check">
                                <input id="male" name="paymentMethod" type="radio" class="form-check-input" checked required>
                                <label class="form-check-label" for="male">남</label>
                            </div>
                            <div class="form-check">
                                <input id="female" name="paymentMethod" type="radio" class="form-check-input" required>
                                <label class="form-check-label" for="female">여</label>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <label for="birth">생년월일<span> (비밀번호 초기시 생년월일로 초기화됩니다.)</span></label>
                        <div class="form-floating mb-3">
                            <input type="date" class="form-control" id="birth" placeholder="date">
                        </div>
                    </div>

                    <div class="col-12">
                        <label for="email" class="form-label">E-mail</label>
                        <input type="email" class="form-control" id="email" placeholder="이메일을 입력해주세요.">
                        <div class="invalid-feedback">
                            이메일을 입력해주세요.
                        </div>
                    </div>

                    <div class="col-12">
                        <label for="phone" class="form-label">전화번호</label>
                        <input type="text" class="form-control" id="phone" placeholder="-포함해서 적어주세요." required>
                        <div class="invalid-feedback">
                            전화번호를 입력해주세요.
                        </div>
                    </div>

                    <div class="col-md-8">
                        <label for="type" class="form-label">희망구분<span> (관리자 승인후 변경됩니다.)</span></label>
                        <select class="form-select" id="type" required>
                            <option value="학부생">학부생</option>
                            <option>교수1</option>
                            <option>조교</option>
                        </select>
                        <div class="invalid-feedback">
                            희망구분을 선택해 주세요.
                        </div>
                    </div>

                    <div class="col-md-4">
                        <label for="major" class="form-label">학과</label>
                        <select class="form-select" id="major" required>
                            <option value="컴퓨터공학부">컴퓨터공학부</option>
                            <option>AI인공지능</option>
                        </select>
                        <div class="invalid-feedback">
                            학과를 선택해 주세요
                        </div>
                    </div>
                </div>
                <hr class ="my-4">
                <div class="w-100 btn btn-primary btn-lg" type="submit" onclick="LetsRegisterBig">가입하기</div>
            </div>
        </div>
        </div>
    </main>
    </div>
  <br>
</body>
</html>
<script>
    // var ischeckID = 0;
    // var ischeckPassword = 0;
    // var isSafePassword = 0;
    // var pattern = [];
    // var pattern1 = '0123456789';
    // pattern2 = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    // pattern3 = '!@#$%^&*()';
    // pattern.push(pattern1);
    // pattern.push(pattern2);
    // pattern.push(pattern3);
    //
    // function checkPattern(password){
    //     isSafePassword = 0 ;
    //     var isOK1 = 0;
    //     var isOK2 = 0;
    //     var isOK3 = 0;
    //     for(var i = 0; i < password.length ; ++i){
    //         if(pattern[0].indexOf(password[i]) >= 0)
    //             isOK1 = 1;
    //         if(pattern[1].indexOf(password[i]) >= 0)
    //             isOK2 = 1;
    //         if(pattern[2].indexOf(password[i]) >= 0)
    //             isOK3 = 1;
    //     }
    //     if(isOK1 == 1 && isOK2 == 1 && isOK3 == 1)
    //         isSafePassword = 1 ;
    // }
    // function checkID(){
    //     var id = $('#InputID').val();
    //     $.ajax({
    //         url:"ajax.do",
    //         type:"post",
    //         data:{
    //             req:"checkid",
    //             data: id
    //         },
    //         success:function(data){
    //             var result = data;
    //             if(data == 'dup'){
    //                 ischeckID = 0;
    //                 $('#warningID').html('*중복된 ID입니다');
    //                 $('#warningID').css('color', 'red');
    //                 $('#warningID').css('font-size', '11px');
    //                 $('#warningID').css('margin-left', '10px');
    //
    //             }
    //             else{
    //                 ischeckID = 1;
    //                 $('#warningID').html('*사용가능한 ID입니다');
    //                 $('#warningID').css('color', 'blue');
    //                 $('#warningID').css('font-size', '11px');
    //                 $('#warningID').css('margin-left', '10px');
    //             }
    //         }
    //     })
    // }
    // function checkPassword(){
    //     checkPattern($('#InputPassword').val());
    //     if($('#InputPassword').val().length < 8 || isSafePassword != 1){
    //         ischeckPassword = 0;
    //         $('#warningPassword').html('8자 이상, 영문과 숫자, 특수문자의 조합');
    //         $('#warningPassword').css('color', 'red');
    //         $('#warningPassword').css('font-size', '11px');
    //         $('#warningPassword').css('margin-left', '10px');
    //     }
    //     else if($('#InputPassword').val() == $('#InputPasswordCheck').val()){
    //         ischeckPassword = 1;
    //         $('#warningPassword').html('비밀번호가 일치합니다');
    //         $('#warningPassword').css('color', 'blue');
    //         $('#warningPassword').css('font-size', '11px');
    //         $('#warningPassword').css('margin-left', '10px');
    //     }
    //     else{
    //         ischeckPassword = 0;
    //         $('#warningPassword').html('비밀번호가 일치하지 않습니다');
    //         $('#warningPassword').css('color', 'red');
    //         $('#warningPassword').css('font-size', '11px');
    //         $('#warningPassword').css('margin-left', '10px');
    //     }
    // }
    // function LetsRegisterBig(){
    //     if(ischeckID == 1){
    //         if(ischeckPassword == 1){
    //             var id =$('#InputID').val();
    //             var password = $('#InputPassword').val();
    //             var forsha = id+password;
    //             var name = $('#InputName').val();
    //             var gender = $('input[name=gender]:checked').val();
    //             var birth = $('#InputBirth').val();
    //             var email = $('#InputEmail').val();
    //             var phone = $('#InputPhone').val();
    //             var type = $('#InputType').val();
    //             var major = $('#InputMajor').val();
    //             var perID = id;
    //             var why = $('#InputWhy').val();
    //             if(name!='' && gender!='' && birth!='' && email!='' && phone!='' && major !='' && perID != ''){
    //                 var update = id+"-/-/-"+SHA256(forsha)+"-/-/-"+name+"-/-/-"+gender+"-/-/-"+birth+"-/-/-"+email+"-/-/-"+phone+"-/-/-"+type+"-/-/-"+major+"-/-/-"+perID;
    //                 $.ajax({
    //                     url:"ajax.do",
    //                     type:"post",
    //                     data:{
    //                         req:"registerbigid",
    //                         data: update
    //                     },
    //                     success:function(data){
    //                         if(data == 'success'){
    //                             $('#information').html('회원가입 완료');
    //                             var inputPanel = $('#inputPanel');
    //                             inputPanel.empty();
    //                             var a = '';
    //                             a += '<div style = "font : 12px; margin-left : 35px;">구분은 관리자 승인 후 변경됩니다</div>';
    //                             a += '<a href="loginpage.do" class="loginBtn" style = "text-decoration: none; text-align : center; margin : 25px 25px"><div id="login_btn">로그인하기</div></a>';
    //                             inputPanel.html(a);
    //                         }
    //                         else
    //                             alert('SERVER ERROR, Please try again later');
    //                     }
    //                 })
    //             }
    //             else{
    //                 alert("빈칸을 채워주세요");
    //             }
    //         }
    //         else{
    //             alert("비밀번호를 일치시켜주세요.");
    //         }
    //     }
    //     else
    //         alert("아이디 중복확인을 해주세요");
    // }
    function regist(){
                    var id =$('#id').val();
                    var password = $('#pwd').val();
                    var forsha = id+password;
                    var name = $('#name').val();
                    var gender = $('input[name=gender]:checked').val();
                    var birth = $('#birth').val();
                    var email = $('#email').val();
                    var phone = $('#phone').val();
                    var type = $('#type').val();
                    var major = $('#major').val();
                    var perID = id;

        if(name!='' && gender!='' && birth!='' && email!='' && phone!='' && major !='' && perID != ''){
                            var update = id+"-/-/-"+SHA256(forsha)+"-/-/-"+name+"-/-/-"+gender+"-/-/-"+birth+"-/-/-"+email+"-/-/-"+phone+"-/-/-"+type+"-/-/-"+major+"-/-/-"+perID;
                            $.ajax({
                                url:"ajax.do",
                                type:"post",
                                data:{
                                    req:"registerbigid",
                                    data: update
                                },
                                success:function(data){
                                    if(data == 'success'){
                                        alert("회원가입 성공");
                                    }
                                    else
                                        alert('SERVER ERROR, Please try again later');
                                }
                            })
                        }
                        else{
                            alert("빈칸을 채워주세요");
                        }
    }
</script>