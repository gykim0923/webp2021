<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-26
  Time: 오후 7:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getReg = (String) request.getAttribute("getReg");
%>
<div>
    <div class="h2" id="view_title"></div>
    <hr>
    <div class="row" id="view_info"></div>
    <hr>
    <div id="view_content"></div>
    <hr>
    <div>신청하기 폼은 여기에서 뜰 예정</div>
</div>
<div class="mt-3 d-grid gap-2 d-md-flex justify-content-md-end" id="list_button"></div>

<script>

    $(document).ready(function(){
        makeViewTitle();
        makeViewInfo();
        makeViewContent();
        makeViewButtons();
    })
    var major = <%=major%>;
    var num = <%=num%>;
    var id = <%=id%>;
    var type = <%=type%>;
    var user = <%=user%>;

    function formatDate(date) {  //주어진 날짜를 yyyy-mm-dd 형식으로 반환해주는 함수
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }

    var getReg = <%=getReg%>;
    function makeViewTitle() {
        var content = $('#view_title');
        content.append(getReg.title);
    }
    function makeViewInfo(){
        var content = $('#view_info');
        content.append('<div class="col">'+getReg.writer_name+'</div><div class="col-md-auto">참여자 수 : '+getReg.applicant_count+'</div><div class="col-md-auto">참여기간 : '+formatDate(getReg.starting_date)+'~'+formatDate(getReg.closing_date)+'</div>');
    }
    function makeViewContent() {
        var content = $('#view_content');
        content.append(getReg.text);
    }

    function makeViewButtons() {
        var list_button = $('#list_button');
        var listUrl = 'reg.kgu?major='+major+'&&num='+num+'&&mode=list';
        var modifyUrl = 'reg.kgu?major='+major+'&&num='+num+'&&mode=modify&&id='+id;
        var text = '';
        if(type.board_level == 0 || type.board_level == 1){
            text += '<a href="'+modifyUrl+'"><div class="btn btn-secondary">수정</div></a>'
                + '<a onclick="deleteBbs()"><div class="btn btn-secondary">삭제</div></a>'
                + '<a onclick="deleteBbs()"><div class="btn btn-secondary">엑셀</div></a>'
        }
        text+='<a href="'+listUrl+'"><div class="btn btn-secondary">목록</div></a>'
        list_button.append(text);
    }

    function deleteBbs(){
        var id = getReg.id;
        var title = getReg.title;
        var writer_id = getReg.writer_id;
        var writer_name = getReg.writer_name;
        var applicant_count = getReg.applicant_count;
        var starting_date = getReg.starting_date;
        var closing_date = getReg.closing_date;
        var data = id+"-/-/-"+major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+applicant_count+"-/-/-"+starting_date+"-/-/-"+closing_date;

        var check = confirm(data+"를 삭제하시겠습니까?");
        if (check) {
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post", //post 방식으로
                data: {
                    req: "deleteReg", //이 메소드를 찾아서
                    data: data //이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (data) { //성공 시
                    if(data=='success'){
                        alert("해당 내용이 삭제되었습니다.");
                        window.location.href = 'reg.kgu?major=' + major + '&&num=' + num + '&&mode=list';
                    }
                    else{
                        alert('권한이 부족합니다.');
                    }
                }
            })
        }
    }
</script>