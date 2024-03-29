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
    String getAllMajor = (String)request.getAttribute("getAllMajor");
%>
<div>
    <h3>회원정보</h3>
    <div class="container my-2" id="text"></div>
</div>

<div id="modify_button" class="d-grid gap-2 d-md-flex justify-content-md-end"></div>

<script>
    var user = <%=userForMyPage%>;
    var type = <%=typeForMyPage%>;
    var today = new Date();
    var reg_day = new Date(user.reg_date);
    // var betweenDay = (today.getTime() - reg_day.getTime())/24/1000/60/60;
    var betweenDay = (today.getTime() - reg_day.getTime())/(24 * 60 * 60 * 1000);

    console.log(today.getTime())
    console.log(reg_day.getTime())

    $(document).ready(function(){
        setdata();
    })

    function setdata(){
        var a ='<div class="row" id="panel">';
        a +='<div class="py-lg-5 py-4 col-lg-4 d-flex justify-content-center" id="panel1"><img src="'+user.google_img+'" onerror="this.src=\'http://placehold.it/200x200\'" style="height: 200px" class="rounded-circle img-responsive my-lg-5"></div>';
        a +='<div class="py-4 col-lg-8">'
        a += '<div id="panel2" class="row"><div>안녕하세요 '+user.name+'님, 오늘은 가입한 지 <span style="color : red;">'+ (parseInt(betweenDay)+1) +'</span>일째입니다.</div><hr>';
        a += '<div class="col-4 border-end py-2">전화번호</div><div class="col-8 py-2">'+ user.phone+'</div>';
        a += '<div class="col-4 border-end py-2">생년월일</div><div class="col-8 py-2">'+ user.birth+'</div>';
        a += '<div class="col-4 border-end py-2">이메일</div><div class="col-8 py-2">'+ user.email+'</div>';
        a += '<div class="col-4 border-end py-2">구분</div><div class="col-8 py-2">'+ user.type+'</div>';
        if(type.class_type == 'Student' || type.class_type == 'Professor'){
            a += '<div class="col-4 border-end py-2">학과</div><div class="col-8 py-2">'+user.major+'</div>';
            a += '<div class="col-4 border-end py-2">학번(교번)</div><div class="col-8 py-2">'+ user.per_id+'</div>';
            a += '<div class="col-4 border-end py-2">학년</div><div class="col-8 py-2">'+ user.grade+'</div>';
            a += '<div class="col-4 border-end py-2">부전공</div><div class="col-8 py-2">'+ user.sub_major+'</div>';
            a += '<div class="col-4 border-end py-2">상태</div><div class="col-8 py-2">'+ user.state+'</div>';
        }
        a +='</div>'
        $('#text').empty();
        $('#text').append(a);
        $('#modify_button').empty();
        $('#modify_button').append('<button type="button" class="btn btn-outline-danger" onclick="deleteUser()">탈퇴</button>');
        $('#modify_button').append('<button type="button" class="btn btn-outline-primary" onclick="setModify()">수정</button>');
    }

    function setModify(){
        var getAllMajor=<%=getAllMajor%>;
        var text_sub_major = '';
        var text_grade = '';
        var text_state = '';

        var a = '<div id="panel">';
        a += '<div id="panel2" class="row"><div>안녕하세요 '+user.name+'님, 오늘은 가입한 지 <span style="color : red;">'+ (parseInt(betweenDay)+1) +'</span>일째입니다.</div><hr>';
        a += '<div class="col-4 border-end py-2">전화번호</div><div class="col-8 py-2"><input class="form-control" type="text" name = "phone" placeholder="변경할 번호를 입력해주세요" value="' + user.phone + '"></div>';
        a += '<div class="col-4 border-end py-2">생년월일</div><div class="col-8 py-2"><input class="form-control" type="date" name="birth" value="' + formatDate(user.birth) + '"></div>';
        a += '<div class="col-4 border-end py-2">이메일</div><div class="col-8 py-2"><input class="form-control" type="text" name = "email" readonly placeholder="변경할 이메일을 입력해주세요" value="' + user.email + '"></div>';
        a += '<div class="col-4 border-end py-2">구분</div><div class="col-8 py-2">'+ user.type+'</div>';
        if(type.class_type == 'Student' || type.class_type == 'Professor'){
            a += '<div class="col-4 border-end py-2">학과</div><div class="col-8 py-2">'+user.major+'</div>';
            a += '<div class="col-4 border-end py-2">학번(교번)</div><div class="col-8 py-2">'+ user.per_id+'</div>';
            a += '<div class="col-4 border-end py-2">학년</div><div class="col-8 py-2" id="grade_select"></div>';
            a += '<div class="col-4 border-end py-2">부전공</div><div class="col-8 py-2" id="sub_major_select"></div>';
            a += '<div class="col-4 border-end py-2">상태</div><div class="col-8 py-2" id="state_select"></div>';
        }
        $('#text').empty();
        $('#text').append(a);


        // 학년 선택
        text_grade+='<div><select class="form-select" aria-label="Default select example" data-value='+user.grade+'>';
        // text_grade+='<option selected>'+user.grade+'</option>';
        text_grade+='<option name="grade" value="1학년">1학년</option>';
        text_grade+='<option name="grade" value="2학년">2학년</option>';
        text_grade+='<option name="grade" value="3학년">3학년</option>';
        text_grade+='<option name="grade" value="4학년">4학년</option>';
        text_grade+='<option name="grade" value="초과학년">초과</option>';
        text_grade+='</select></div>'
        $('#grade_select').append(text_grade);

        // 부전공 선택
        for(var i=0; i<getAllMajor.length; i++){
            if(getAllMajor[i].major_name !== getAllMajor[0].major_name) {
                text_sub_major += '<div id="sub_major"><input class="form-check-input" name="checkbox" id="checkbox' + i + '" type="checkbox" value="' + (i + 1) + '"/>' + getAllMajor[i].major_name + '</div>';
            }
        }

        $('#sub_major_select').append(text_sub_major);

        var usersub_major = user.sub_major.split("<br>");

        console.log(usersub_major)

        for(var j=0; j<usersub_major.length; j++){
            for(var i=0; i<getAllMajor.length; i++) {
                    if (getAllMajor[i].major_name == usersub_major[j]) {
                        $('#checkbox'+i).prop('checked', true);
                    }
            }
        }


        // 상태 선택
        text_state+='<div><select class="form-select" aria-label="Default select example">';
        text_state+='<option name="state" value="재학">재학</option>';
        text_state+='<option name="state" value="휴학">휴학</option>';
        text_state+='<option name="state" value="퇴학">퇴학</option>';
        text_state+='<option name="state" value="졸업">졸업</option>';
        text_state+='</select></div>'
        $('#state_select').append(text_state);

        $('#modify_button').empty();
        $('#modify_button').append('<button type="button" class="btn btn-outline-danger" onclick="refresh()">취소</button>');
        $('#modify_button').append('<button type="button" class="btn btn-outline-primary" onclick="modify()">완료</button>');

    }

    function refresh(){ //수정하기를 취소하였을 때 화면 리로드
        window.location.reload();
    }

    function modifySubMajor(){
        var getAllMajor=<%=getAllMajor%>;
        var id = user.id;
        var checkboxValues = [];
        var count=0;
        for(var i=0; i<getAllMajor.length; i++){
            if($('#checkbox'+i).is(":checked")==true){
                count++;
            }
        }
        console.log(count)
        if(count == 0){
            checkboxValues.push('부전공 없음');
            console.log(checkboxValues);
        } else {
            $("input[name='checkbox']:checked").each(function() {
                checkboxValues.push($(this).val());
            });
        }

        var userdata = id+"-/-/-"+checkboxValues;

        $.ajax({
            url:"ajax.kgu",
            type:"post",
            data :{
                req:"modifySubMajor",
                data:userdata
            },
            success : function(data){
                swal.fire({
                    title : '수정이 완료되었습니다.',
                    icon : 'success',
                    showConfirmButton: true

                }).then(function (){
                    location.reload();
                });
            }
        })
    }

    function modify(){  //개인정보 수정
        var id = user.id;
        var phone = $('[name = phone]').val();
        var birth = $('[name = birth]').val();
        var email = $('[name = email]').val();
        // var grade = $('[name = grade]').val();
        // var state = $('[name = state]').val();
        var grade = $('[name = grade]:selected').val();
        var state = $('[name = state]:selected').val();

        modifySubMajor();

        var userdata = id+"-/-/-"+phone+"-/-/-"+birth+"-/-/-"+email+"-/-/-"+grade+"-/-/-"+state;

        $.ajax({
            url:"ajax.kgu",
            type:"post",
            data :{
                req:"modifyuserdata",
                data:userdata
            },
            success : function(data){
                swal.fire({
                    title : '수정이 완료되었습니다.',
                    icon : 'success',
                    showConfirmButton: true

                }).then(function (){
                    location.reload();
                });
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

    function deleteUser() { //자신의 데이터 삭제 (탈퇴기능)
        var id = user.id;
        var name = user.name;
        var type = user.type;
        swal.fire({
            title: '정말로 탈퇴하시나요?',
            text: '다시 되돌릴 수 없습니다.',
            icon: 'warning',
            showConfirmButton: true,
            showCancelButton: true
        }).then((result) => {
            if (result.isConfirmed) {

                $.ajax({
                    url: "ajax.kgu", //AjaxAction에서
                    type: "post",
                    data: {
                        req: "deleteUser",
                        data: id + "-/-/-" + name + "-/-/-" + type  //이중 검사용으로 DB를 두개 넘깁니다.
                    },
                    success: function (result) {
                        if (result != 'fail') {

                            swal.fire({
                                title : '탈퇴되었습니다.',
                                icon : 'success',
                                showConfirmButton: true

                            }).then(function (){
                                location.href = "logout.kgu";
                            });
                        } else {
                            swal.fire({
                                title : '권한이 부족합니다.',
                                icon : 'error',
                                showConfirmButton: true

                            });
                        }
                    }
                })
            }
        })
    }

    // function deleteSubMajor() {
    //     var id = user.id;
    //     swal.fire({
    //         title: '정말로 초기화하시나요?',
    //         icon: 'warning',
    //         showConfirmButton: true,
    //         showCancelButton: true
    //
    //     }).then((result) => {
    //         if (result.isConfirmed) {
    //             $.ajax({
    //                 url: "ajax.kgu",
    //                 type: "post",
    //                 data: {
    //                     req: "delete_sub_major",
    //                     data: id
    //                 },
    //                 success: function (data) {
    //                     if (data == 'fail') {
    //                         swal.fire({
    //                             title: '실패.',
    //                             icon: 'warning',
    //                             showConfirmButton: true
    //                         });
    //                         return;
    //                     }
    //                     swal.fire({
    //                         title: '초기화가 완료되었습니다.',
    //                         icon: 'success',
    //                         showConfirmButton: true
    //
    //                     });
    //                 }
    //             });
    //         }
    //     })
    // }

</script>