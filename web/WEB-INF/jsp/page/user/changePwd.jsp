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

    function change(){
        if($('#password').val() != '' && $('#newPassword').val() != '' && $('#newPasswordCheck').val() != ''){
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
                        if($('#newPasswordCheck').val() == $('#newPassword').val() && check()){
                            var newPasswordSalt = $('#id').val() + $('#newPassword').val();
                            $('#password_hash2').val(SHA256(newPasswordSalt));
                            modify();
                        }
                        else if($('#newPassword').val() != $('#newPasswordCheck').val()){
                            $('#warning').text("비밀번호 확인이 정확하지 않습니다");
                            $('#warning').css("color", "red");
                        }
                        else if(!check()){
                            $('#warning').text("새로운 비밀번호는 8자 이상,영문,숫자,특수기호가 포함되어야 합니다");
                            $('#warning').css("color", "red");
                        }
                    }
                    else{
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

    function modify(){
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
                    alert("비밀번호 수정 완료");
                    window.location.href = "logout.kgu";

                } else
                    alert('SERVER ERROR, Please try again later');
            }
        })
    }

    function check(){
        var password = $('#newPassword').val();
        var isOK1 = 0;
        var isOK2 = 0;
        var isOK3 = 0;
        for(var i = 0; i < password.length ; ++i){
            if(pattern[0].indexOf(password[i]) >= 0)
                isOK1 = 1;
            if(pattern[1].indexOf(password[i]) >= 0)
                isOK2 = 1;
            if(pattern[2].indexOf(password[i]) >= 0)
                isOK3 = 1;
        }
        if(isOK1 == 1 && isOK2 == 1 && isOK3 == 1)
            return true;
        else
            return false;
    }
</script>
