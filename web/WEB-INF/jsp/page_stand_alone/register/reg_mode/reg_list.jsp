<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-26
  Time: 오후 7:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getRegList = (String) request.getAttribute("getRegList");
%>
<div>

    <table class="boardtable" id="table1"  data-toggle="table"
           data-pagination="true" data-toolbar="#toolbar"
           data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="600"
           data-page-list="[10]">
        <thead>
        <tr>
            <th data-field="id" data-sortable="false">번호</th>
            <th data-field="title" data-sortable="false">제목</th>
            <th data-field="period" data-sortable="false">기간</th>
            <th data-field="applicants" data-sortable="false">참여수</th>
            <th data-field="level" data-sortable="false">대상</th>
            <th data-field="applicate" data-sortable="false">참여하기</th>
        </tr>
        </thead>
    </table>
</div>
<div id="write_button"></div>

<script>
    $(document).ready(function(){
        callSetupTableView();
        makeWriteButton();
    })
    var user = <%=user%>
    var major = <%=major%>;
    var num = <%=num%>;
    var type = <%=type%>;
    function callSetupTableView(){
        $('#table1').bootstrapTable('load',tableData());
        // $('#table1').bootstrapTable('append',data());
        $('#table1').bootstrapTable('refresh');
    }
    function makeWriteButton(){
        var button = $('#write_button')
        if (type.for_header == '관리자' || type.for_header == '교수'){
            var text = '<a href = "reg.kgu?major=' + major + '&&num=' + num + '&&mode=write"><div class="btn btn-secondary">글쓰기</div></a>';
            button.append(text);
        }
    }
    function tableData(){
        var regList = <%=getRegList%>;
        var rows = [];
        var lvlText='';
        var can = '';
        var today = new Date();
        if(regList!=null){
            for(var i=0;i<regList.length;i++){
                var reg=regList[i];
                var url = 'reg.kgu?major='+major+'&&num='+num+'&&mode=view'+'&&id='+reg.id;
                var start = new Date(reg.starting_date).getTime();
                var close = new Date(reg.closing_date).getTime() + 1000*60*60*24;
                var today = new Date().getTime();
                var buttonText = '';
                if(user != null && reg.writer_id == user.id){
                    lvlText = '<a href="'+url+'">'+reg.title+'</a>';
                    can = '작성자';
                }
                else if(reg.level.indexOf(type.for_header) >= 0 || type.for_header == '관리자'){
                    lvlText = '<a href="'+url+'">'+reg.title+'</a>';
                    can = '○';
                }
                else{
                    lvlText = '<span>' + reg.title + '<span/>';
                    can = 'ⅹ';
                }
                if(start <= today && today <= close && (reg.level.indexOf(type.for_header) >= 0 || type.for_header == '관리자' || (reg.for_who == 1 && type.for_header == '교수')))
                    buttonText = '<a href="'+url+'" type="button" class="btn btn-primary">참가</a>';
                else if(close <= today)
                    buttonText = '<button type="button" class="btn btn-secondary" disabled>만료</button>';
                else if(start > today)
                    buttonText = '<button type="button" class="btn btn-warning" disabled>대기</button>';
                else
                    buttonText = '<button type="button" class="btn btn-danger" disabled>불가</button>';
                if(can == 'ⅹ' && type.for_header =='기타'){
                    rows.push({
                        id: '<span>'+reg.id+'</span>',
                        title: lvlText,
                        period: '<span>'+formatDate(reg.starting_date)+'</span><span>~</span><span>'+formatDate(reg.closing_date)+'</span>',
                        applicants: '<span>'+reg.applicant_count+'명</span>',
                        level: can,
                        applicate: buttonText
                    });
                }
                else {
                    rows.push({
                        id: '<a href="' + url + '">' + reg.id + '</a>',
                        title: lvlText,
                        period: '<a href="' + url + '">' + formatDate(reg.starting_date) + '~' + formatDate(reg.closing_date) + '</a>',
                        applicants: '<a href="' + url + '">' + reg.applicant_count + '명</a>',
                        level: can,
                        applicate: buttonText
                    });
                }
            }
        }
        return rows;
    }

    function formatDate(date) {  //주어진 날짜를 yyyy-mm-dd 형식으로 반환해주는 함수
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }
</script>

<style>

    .boardtable > thead > tr > th, .boardtable > tbody > tr > td{
        overflow:hidden;
        text-overflow:ellipsis;
        white-space:nowrap;
        text-align: center;
        border-right : none;
        border-left : none;
        height: 40px;
        max-height: 40px;
        min-height: 40px;
    }
    .boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
        min-width: 56px;
        max-width: 56px;
        width: 56px;
    }
    /*.boardtable > thead > tr > th:nth-child(3), .boardtable > tbody > tr > td:nth-child(3) {*/
    /*    min-width: 75px;*/
    /*    max-width: 75px;*/
    /*    width: 75px;*/
    /*}*/
    .boardtable > thead > tr > th:nth-child(4), .boardtable > tbody > tr > td:nth-child(4) {
        min-width: 110px;
        max-width:110px;
        width: 110px;
    }

    .boardtable > thead > tr > th:nth-child(5), .boardtable > tbody > tr > td:nth-child(5) {
        min-width: 75px;
        max-width: 75px;
        width: 75px;
    }

</style>
