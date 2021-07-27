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
           data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
           data-page-list="[10]">
        <thead>
        <tr>
            <th data-field="id" data-sortable="true">번호</th>
            <th data-field="title" data-sortable="true">제목</th>
            <th data-field="period" data-sortable="true">기간</th>
            <th data-field="applicants" data-sortable="true">참여수</th>
            <th data-field="level" data-sortable="false">대상</th>
            <th data-field="applicate" data-sortable="false">참여하기</th>
        </tr>
        </thead>
    </table>
</div>

<script>
    $(document).ready(function(){
        callSetupTableView();
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
                if(reg.writer_id == user.id){
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
                if(start <= today && today <= close && (reg.level.indexOf(type.for_header) >= 0 || type.for_header == '관리자'))
                    buttonText = '<button type="button" class="btn btn-primary">참가</button>';
                else if(close <= today)
                    buttonText = '<button type="button" class="btn btn-secondary" disabled>만료</button>';
                else if(start > today)
                    buttonText = '<button type="button" class="btn btn-secondary" disabled>대기</button>';
                else
                    buttonText = '<button type="button" class="btn btn-secondary" disabled>불가</button>';
                rows.push({
                    id: '<a href="'+url+'">'+reg.id+'</a>',
                    title: lvlText,
                    period: '<a href="'+url+'">'+formatDate(reg.starting_date)+'~'+formatDate(reg.closing_date)+'</a>',
                    applicants: '<a href="'+url+'">'+reg.applicant_count+'명</a>',
                    level: can,
                    applicate: buttonText
                });
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
