<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-07
  Time: 오후 3:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String typeForMyPage = (String)session.getAttribute("type");
    String userForMyPage = (String)session.getAttribute("user");
%>
<div id="text"></div>
<div id="modify_button" class="d-grid gap-2 d-md-flex justify-content-md-end"></div>

<script>
    var user = <%=userForMyPage%>;
    var type = <%=typeForMyPage%>;
    var today = new Date();
    var reg_day = new Date(user.reg_date);
    var betweenDay = (today.getTime() - reg_day.getTime())/24/1000/60/60;
    $(document).ready(function(){
        setdata();
    })

    function setdata(){
        var a = '<div id="panel">';
        a += '<div id="panel2" class="row"><div>안녕하세요 '+user.name+'님, 오늘은 가입한 지 <span style="color : red;">'+ (parseInt(betweenDay)+1) +'</span>일째입니다.</div><hr>';
        a += '<div class="col-4 border-end">전화번호</div><div class="col-8">'+ user.phone+'</div>';
        a += '<div class="col-4 border-end">생년월일</div><div class="col-8">'+ user.birth+'</div>';
        a += '<div class="col-4 border-end">이메일</div><div class="col-8">'+ user.email+'</div>';
        a += '<div class="col-4 border-end">구분</div><div class="col-8">'+ user.type+'</div>';
        if(type.class_type == 'Student' || type.class_type == 'Professor'){
            a += '<div class="col-4 border-end">학과</div><div class="col-8">'+user.major+'</div>';
            a += '<div class="col-4 border-end">학번(교번)</div><div class="col-8">'+ user.per_id+'</div>';
            a += '<div class="col-4 border-end">학년</div><div class="col-8">'+ user.grade+'</div>';
            a += '<div class="col-4 border-end">상태</div><div class="col-8">'+ user.state+'</div>';
        }
        $('#text').empty();
        $('#text').append(a);
        $('#modify_button').empty();
        $('#modify_button').append('<button type="button" class="btn btn-outline-secondary" onclick="setModify()">수정</button>');
        $('#modify_button').append('<button type="button" class="btn btn-outline-secondary" onclick="deleteUser()">탈퇴</button>');
    }

    function setModify(){
        var a = '<div id="panel">';
        a += '<div id="panel2" class="row"><div>안녕하세요 '+user.name+'님, 오늘은 가입한 지 <span style="color : red;">'+ (parseInt(betweenDay)+1) +'</span>일째입니다.</div><hr>';
        a += '<div class="col-4 border-end">전화번호</div><div class="col-8"><input class="form-control" type="text" name = "phone" placeholder="변경할 번호를 입력해주세요" value="' + user.phone + '"></div>';
        a += '<div class="col-4 border-end">생년월일</div><div class="col-8"><input class="form-control" type="date" name="birth" value="' + formatDate(user.birth) + '"></div>';
        a += '<div class="col-4 border-end">이메일</div><div class="col-8"><input class="form-control" type="text" name = "email" placeholder="변경할 이메일을 입력해주세요" value="' + user.email + '"></div>';
        a += '<div class="col-4 border-end">구분</div><div class="col-8">'+ user.type+'</div>';
        if(type.class_type == 'Student' || type.class_type == 'Professor'){
            a += '<div class="col-4 border-end">학과</div><div class="col-8">'+user.major+'</div>';
            a += '<div class="col-4 border-end">학번(교번)</div><div class="col-8">'+ user.per_id+'</div>';
            a += '<div class="col-4 border-end">학년</div><div class="col-8">'+ user.grade+'</div>';
            a += '<div class="col-4 border-end">상태</div><div class="col-8">'+ user.state+'</div>';
        }
        $('#text').empty();
        $('#text').append(a);
        $('#modify_button').empty();
        $('#modify_button').append('<button type="button" class="btn btn-outline-secondary" onclick="refresh()">취소</button>');
        $('#modify_button').append('<button type="button" class="btn btn-outline-secondary" onclick="modify()">완료</button>');
    }

    function refresh(){ //수정하기를 취소하였을 때 화면 리로드
        window.location.reload();
    }

    function modify(){  //개인정보 수정
        var id = user.id;
        var phone = $('[name = phone]').val();
        var birth = $('[name = birth]').val();
        var email = $('[name = email]').val();

        var userdata = id+"-/-/-"+phone+"-/-/-"+birth+"-/-/-"+email;

        $.ajax({
            url:"ajax.kgu",
            type:"post",
            data :{
                req:"modifyuserdata",
                data:userdata
            },
            success : function(data){
                alert("수정이 완료 되었습니다.");
                window.location.reload();
            }
        })
    }

    function formatDate(date) { //날짜를 yyyy-mm-dd 형식으로 반환
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }

    function deleteUser(){ //자신의 데이터 삭제 (탈퇴기능)
        var id = user.id;
        var name = user.name;
        var check = confirm("[중요] 정말로 "+id+"["+name+"]를 삭제하시나요? 되돌릴 수 없습니다.");
        if (check) {
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post",
                data: {
                    req: "deleteUser",
                    data: id+"-/-/-"+name  //이중 검사용으로 DB를 두개 넘깁니다.
                },
                success: function (result) {
                    if(result!='fail'){
                        alert("해당 회원이 삭제되었습니다.");
                        window.location.href='logout.kgu';
                    }
                    else {
                        alert("삭제 권한이 없습니다.");
                    }
                }
            })
        }
    }
</script>