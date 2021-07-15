<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-07
  Time: 오전 8:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getAllMajor = (String)request.getAttribute("getAllMajor");
    String getSchedule = (String)request.getAttribute("getSchedule");
%>
<div>
    <div class="album py-5 bg-light">
        <div class="container">
<%--            전공 관리--%>
            <%@include file="/WEB-INF/jsp/page/admin/admin_main/admin_major.jsp"%>
            <hr>
<%--                일정 관리 --%>
            <%@include file="/WEB-INF/jsp/page/admin/admin_main/admin_schedule.jsp"%>
            <hr>
<%--                대문 관리--%>
            <%@include file="/WEB-INF/jsp/page/admin/admin_main/admin_slider.jsp"%>
            <hr>
        </div>
    </div>
</div>

    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">수정하기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id = "myModalbody"></div>
                <%--                        <div class="modal-footer">--%>
                <%--                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>--%>
                <%--                            <button type="button" class="btn btn-primary">추가하기</button>--%>
                <%--                        </div>--%>
            </div>
        </div>
    </div>

</div>

<script>
    $(document).ready(function(){
        callSetupTableView();
    })

    function callSetupTableView(){
        $('#table1').bootstrapTable('load',tableData1());
        // $('#table1').bootstrapTable('append',data());
        $('#table1').bootstrapTable('refresh');

        $('#table2').bootstrapTable('load',tableData2());
        // $('#table1').bootstrapTable('append',data());
        $('#table2').bootstrapTable('refresh');

    }
    function tableData1(){
        var makeAllMajor = <%=getAllMajor%>;
        var rows = [];
        for(var i=0;i<makeAllMajor.length;i++){
            var major=makeAllMajor[i];
            rows.push({
                oid: major.oid,
                major_id: major.major_id,
                major_name: major.major_name,
                major_color1: major.major_color1,
                major_color2: major.major_color2,
                major_color3: major.major_color3,
                action : '<button class="btn btn-dark" type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeModifyMajorModal('+i+')">수정</button>'
            });
        }
        // alert(rows);
        return rows;
    }

    function makeModifyMajorModal(i){
        var list = $('#myModalbody');
        var a ='';
        // a+= '<div>전공 아이디 (영문)</div><input type="text" class="form-control" id="modify_major_id" name="new_table" value="" placeholder="major_id">'
        a+='<div>전공 이름</div><input type="text" class="form-control" id="modify_major_name" name="new_table" value="" placeholder="major_name">'
            +'<div>전공 색상1</div><input type="color" class="form-control" id="modify_major_color1" name="new_table" value="" placeholder="major_color1">'
            +'<div>전공 색상2</div><input type="color" class="form-control" id="modify_major_color2" name="new_table" value="" placeholder="major_color2">'
            +'<div>전공 색상3</div><input type="color" class="form-control" id="modify_major_color3" name="new_table" value="" placeholder="major_color3">'
            a += '<button type="button" class="btn btn-dark" data-dismiss="modal">Close</button>'
            a += '<button type="button" class="btn btn-dark pull-right" data-dismiss="modal" aria-label="Close" onclick="modifyMajor('+i+')">완료</button>';
            list.html(a);
    }

    function modifyMajor(i){
        var major = <%=getAllMajor%>;
        var target_oid=major[i].oid;
        // var major_id=$('#modify_major_id').val();
        var major_name=$('#modify_major_name').val();
        var major_color1=$('#modify_major_color1').val();
        var major_color2=$('#modify_major_color2').val();
        var major_color3=$('#modify_major_color3').val();
        // var data=target_id+'-/-/-'+major_id+'-/-/-'+major_name+'-/-/-'+major_color1+'-/-/-'+major_color2+'-/-/-'+major_color3;
        var data=target_oid+'-/-/-'+major_name+'-/-/-'+major_color1+'-/-/-'+major_color2+'-/-/-'+major_color3;
        var check = confirm("전공 "+data+"를 수정하시겠습니까?");
        if (check) {
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post", //post 방식으로
                data: {
                    req: "modifyMajor", //이 메소드를 찾아서
                    data: data //이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (data) { //성공 시
                    if(data=='success'){
                        alert("해당 전공이 수정되었습니다.");
                        location.reload();
                    }
                    else{
                        alert('권한이 부족합니다.');
                    }
                }
            })
        }
    }

    function addMajor(){
        var major_id=$('#add_major_id').val();
        var major_name=$('#add_major_name').val();
        var major_color1=$('#add_major_color1').val();
        var major_color2=$('#add_major_color2').val();
        var major_color3=$('#add_major_color3').val();
        var data=major_id+'-/-/-'+major_name+'-/-/-'+major_color1+'-/-/-'+major_color2+'-/-/-'+major_color3;
        var check = confirm("전공 "+data+"를 추가하시겠습니까?");
        if (check) {
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post", //post 방식으로
                data: {
                    req: "addMajor", //이 메소드를 찾아서
                    data: data //이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (data) { //성공 시
                    if(data=='success'){
                        alert("해당 전공이 추가되었습니다.");
                        location.reload();
                    }
                    else{
                        alert('권한이 부족합니다.');
                    }
                }
            })
        }
    }

    function tableData2(){
        var getSchedule = <%=getSchedule%>;
        var rows = [];
        for(var i=0;i<getSchedule.length;i++){
            var schedule=getSchedule[i];
            rows.push({
                id: schedule.id,
                date: schedule.date,
                content: schedule.content,
                action : '<button class="btn btn-dark" type="button" data-bs-toggle="modal" data-bs-target="#insertSchedule" onclick="modifySchedule('+i+')">수정</button>'
            });
        }
        return rows;
    }

    function modifySchedule(i){
        var getSchedule = <%=getSchedule%>;
        var schedule = getSchedule[i];
        alert(schedule.date +" "+schedule.content);
        var list = $('#schModalbody');
        var a = '';
        a += '<div><label for="InputDate">날짜</label><input class="form-control" id="InputDate" type="date" name="schDate" value="'+formatDate(schedule.date)+'"></div>';
        a += '<br><div><input class="form-control" id="content" value="'+schedule.content+'"></div><br/>';
        list.html(a);
    }

    function insertSch(){
        var list = $('#schModalbody');
        var a = '';
        a += '<div><label for="InputDate">날짜</label><input class="form-control" id="InputDate" type="date" name="schDate" value="' + formatDate(new Date()) + '"></div>';
        a += '<br><div><input class="form-control" id="content" placeholder="내용을 입력해주세요"></div>';
        list.html(a);
    }

    function formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }
</script>

