<%--
  Created by IntelliJ IDEA.
  User: ellie
  Date: 2021-08-10
  Time: 오후 9:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="">
    <label><h2><strong>작성글</strong></h2></label>
    <script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>
    <table class="boardtable" id="table1"  data-toggle="table"
           data-pagination="true" data-toolbar="#toolbar"
           data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
           data-page-list="[10]">
        <thead>
        <tr>
            <th data-field="board_id" data-sortable="true">번호</th>
            <th data-field="title" data-sortable="true">제목</th>
            <th data-field="last_modified" data-sortable="true">작성일</th>
            <th data-field="views" data-sortable="true">조회수</th>
        </tr>
        </thead>
    </table>
</div>
<script>
    $(document).ready(function(){
        callSetupTableView();
    })

    function callSetupTableView(){
        $('#table1').bootstrapTable('append',data1());
        $('#table1').bootstrapTable('refresh');
    }

    function data1(){
        var rows = [];
        var sequence = 1;
        for(var i = 0 ; i < notice_notes.length ; ++i){
            var value = notice_notes[i];
            rows.push({
                board_id: sequence,
                title: '<a href="bbs.kgu?major='+value.major+'&&num='+value.category+'&&mode=view&&id='+value.id+'">' + value.title + '</a>',
                last_modified: formatDate(value.last_modified),
                views: value.views
            });
            sequence++;
        }
        return rows;
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