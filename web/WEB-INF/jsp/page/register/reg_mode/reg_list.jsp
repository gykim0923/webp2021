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
            <th data-field="for_who" data-sortable="false">대상</th>
            <th data-field="applicate" data-sortable="false">참여하기</th>
        </tr>
        </thead>
    </table>
</div>

<script>
    $(document).ready(function(){
        callSetupTableView();
    })
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
        if(regList!=null){
            for(var i=0;i<regList.length;i++){
                var reg=regList[i];
                var url = 'reg.kgu?major='+major+'&&num='+num+'&&mode=view'+'&&id='+reg.id;
                rows.push({
                    id: '<a href="'+url+'">'+reg.id+'</a>',
                    title: '<a href="'+url+'">'+reg.title+'</a>',
                    period: '<a href="'+url+'">'+formatDate(reg.starting_date)+'~'+formatDate(reg.closing_date)+'</a>',
                    applicants: '<a href="'+url+'">'+reg.applicant_count+'</a>',
                    for_who: '<a href="'+url+'">'+reg.for_who+'</a>',
                    applicate: '<a href="'+url+'">신청</a>'
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
