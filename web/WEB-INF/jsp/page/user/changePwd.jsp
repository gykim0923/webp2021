<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-14
  Time: 오후 2:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String typeForMyPage = (String)session.getAttribute("type");
    String userForMyPage = (String)session.getAttribute("user");
%>
<script src='js/sha256.js'></script>
<script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>
<div id="content" class="row px-md-5 justify-content-md-center"></div>
<div id="change_btn" class="d-grid col-md-6 mx-auto"></div>

<script>
    var user = <%=userForMyPage%>;
    var type = <%=typeForMyPage%>;

    var pattern = [];
    var pattern1 = '0123456789';
    pattern2 = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    pattern3 = '!@#$%^&*()';
    pattern.push(pattern1);
    pattern.push(pattern2);
    pattern.push(pattern3);

    $(document).ready(function(){
        makeForm();
    });

    function makeForm(){
        var content = $('#content');
        var text = '';
        text += '<div class="input-group mb-3"><span class="input-group-text col-4">이름</span><input id="name" type="text" value="'+user.name+'" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" readonly></div>'
            + '<div class="input-group mb-3"><span class="input-group-text col-4">현재 비밀번호</span><input id="password" type="password" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"></div>'
            + '<div class="input-group mb-3"><span class="input-group-text col-4">새로운 비밀번호</span><input id="newPassword" type="password" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"></div>'
            + '<div class="input-group mb-3"><span class="input-group-text col-4">비밀번호 확인</span><input id="newPasswordCheck" type="password" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"></div>'
            + '<div class="col-8"><input type="hidden" name="password_hash" id="password_hash1" value="VALUE_NOT_EMPTY"></div>'
            + '<div class="col-8"><input type="hidden" name="password_hash2" id="password_hash2" value="VALUE_NOT_EMPTY"></div>'
            + '<div class="col-8"><input type="hidden" name="id" id="id" value="VALUE_NOT_EMPTY"></div>'
            + '<span id="warning" class="col-md-8 text-center">새로운 비밀번호는 8자 이상,영문,숫자,특수기호가 포함되어야 합니다</span><br><span id="warning" class="col-md-8 text-center">사용 가능한 특수문자 : !,@,#,$,%,^,&,*,(,)</span><br>'
        content.append(text);

        var button = $('#change_btn');
        button.append('<button type="button" class="btn btn-primary" onclick="change()">변경하기</button>');
    }

    function change(){ //비밀번호 변경하기 전 조건 확인
        if($('#password').val() != '' && $('#newPassword').val() != '' && $('#newPasswordCheck').val() != ''){ //빈 칸 있는지 확인
            var passwordSalt = user.id + $('#password').val();
            $('#password_hash1').val(SHA256(passwordSalt));
            var password = $('#password_hash1').val();
            var data = password + "-/-/-" + user.id;
            $.ajax({
                url:"ajax.kgu",
                type:"post",
                async : false,
                data:{
                    req:"checkPassword",
                    data:data
                },
                success:function(data){
                    if(data == 'true'){
                        if($('#newPasswordCheck').val() == $('#newPassword').val() && check()){ //바꿀 비밀번호가 확인 비밀번호와 일치하여 수정
                            var newPasswordSalt = $('#id').val() + $('#newPassword').val();
                            $('#password_hash2').val(SHA256(newPasswordSalt));
                            modify();
                        }
                        else if($('#newPassword').val() != $('#newPasswordCheck').val()){ // 바꿀 비밀번호가 확인 비밀번호와 일치하지 않아 수정 불가
                            $('#warning').text("비밀번호 확인이 정확하지 않습니다");
                            $('#warning').css("color", "red");
                        }
                        else if(!check()){ //새 비밀번호가 형식에 맞지 않아 수정 불가
                            $('#warning').text("새로운 비밀번호는 8자 이상,영문,숫자,특수기호가 포함되어야 합니다");
                            $('#warning').css("color", "red");
                        }
                    }
                    else{ //현재 비밀번호가 올바르지 않아 수정 불가
                        $('#warning').text("현재 비밀번호가 정확하지 않습니다.");
                        $('#warning').css("color", "red");

                    }
                }
            })
        }
        else{
            $('#warning').text("빈 칸을 입력해주세요.");
            alert($('#password').value() + " " + $('#newPassword').value()+" "+$('#newPasswordCheck').value())
            $('#warning').css("color", "red");
        }
    }

    function modify(){ //비밀번호 수정
        var forsha = user.id + $('#newPassword').val();
        var data = user.id + "-/-/-" + SHA256(forsha);
        $.ajax({
            url: "ajax.kgu",
            type: "post",
            data:{
                req:"modifyPwd",
                data:data
            },
            success:function(data){
                if (data == 'success') {

                    swal.fire({
                        title : '비밀번호 수정 완료',
                        icon : 'success',
                        showConfirmButton: true

                    }).then(function (){
                        location.href = "logout.kgu";
                    });

                } else
                swal.fire({
                    title : '서버에러',
                    text : '다음에 다시 시도해주세요',
                    icon : 'error',
                    showConfirmButton: true

                });
            }
        })
    }

    function check(){ //비밀번호 조건 확인
        var password = $('#newPassword').val();
        var isOK1 = 0;
        var isOK2 = 0;
        var isOK3 = 0;
        if (password.length < 8)
            return false;
        for(var i = 0; i < password.length ; ++i){
            if(pattern[0].indexOf(password[i]) >= 0) //숫자 포함
                isOK1 = 1;
            if(pattern[1].indexOf(password[i]) >= 0) //영문자 포함
                isOK2 = 1;
            if(pattern[2].indexOf(password[i]) >= 0) //특수문자 포함
                isOK3 = 1;
        }
        if(isOK1 == 1 && isOK2 == 1 && isOK3 == 1)
            return true;
        else
            return false;
    }
</script>
