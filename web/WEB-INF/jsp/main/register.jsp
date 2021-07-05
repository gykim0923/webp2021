<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-05
  Time: 오후 6:52
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
</head>
<body>
<div class="container">
    <main>
        <div id="title">
            <div><a href="Index"><img src="img/cs_logo.png"></a></div>
        </div>
        <div class="row g-5">
        <div class="col-md-7 col-lg-8">
            <h4 class="mb-3">회원 가입</h4>
            <div class="needs-validation" novalidate>
                <div class="row g-3">
                    <div class="col-sm-12">
                        <label for="id" class="form-label">학번(교번)</label>
                            <input type="text" class="form-control" id="id" placeholder="학번이나 교번을 입력해주세요." value="" required>
                        <div class="my-2"><button type="button" class="btn btn-primary">중복확인</button></div>
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

                    <div class="col-md-5">
                        <label for="sel1" class="form-label">희망구분<span> (관리자 승인후 변경됩니다.)</span></label>
                        <select class="form-select" id="sel1" required>
                            <option value="학부생">학부생</option>
                            <option>교수1</option>
                            <option>조교</option>
                        </select>
                        <div class="invalid-feedback">
                            희망구분을 선택해 주세요.
                        </div>
                    </div>

                    <div class="col-md-4">
                        <label for="sel2" class="form-label">학과</label>
                        <select class="form-select" id="sel2" required>
                            <option value="컴퓨터공학부">컴퓨터공학부</option>
                            <option>AI인공지능</option>
                        </select>
                        <div class="invalid-feedback">
                            학과를 선택해 주세요
                        </div>
                    </div>
                </div>
                <hr class ="my-4">
                <div class="w-100 btn btn-primary btn-lg" type="submit">가입하기</div>
            </div>
        </div>
        </div>
    </main>
    </div>
  <br>
</body>
</html>
<script>
    function checkID(){
        var id = $('#InputID').val();
        $.ajax({
            url:"ajax.do",
            type:"post",
            data:{
                req:"checkid",
                data: id
            },
            success:function(data){
                var result = data;
                if(data == 'dup'){
                    ischeckID = 0;
                    $('#warningID').html('*중복된 ID입니다');
                    $('#warningID').css('color', 'red');
                    $('#warningID').css('font-size', '11px');
                    $('#warningID').css('margin-left', '10px');

                }
                else{
                    ischeckID = 1;
                    $('#warningID').html('*사용가능한 ID입니다');
                    $('#warningID').css('color', 'blue');
                    $('#warningID').css('font-size', '11px');
                    $('#warningID').css('margin-left', '10px');
                }
            }
        })
    }
</script>