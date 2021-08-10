<%--
  Created by IntelliJ IDEA.
  User: ellie
  Date: 2021-08-10
  Time: 오후 9:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="">
    <label><h2><strong>신청 내역</strong></h2></label>
    <script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>
    <table class="boardtable" id="table3"  data-toggle="table"
           data-pagination="true" data-toolbar="#toolbar"
           data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
           data-page-list="[10]">
        <thead>
        <tr>
            <th data-field="board_id" data-sortable="true">번호</th>
            <th data-field="title" data-sortable="true">제목</th>
            <th data-field="last_modified" data-sortable="true">기간</th>
        </tr>
        </thead>
    </table>
</div>
<script>
    $(document).ready(function(){
        callSetupTableView3();
    })

    function callSetupTableView3(){
        $('#table3').bootstrapTable('append',data3());
        $('#table3').bootstrapTable('refresh');
    }

    function data3(){
        var rows = [];
        for(var i = 0 ; i < answers_notes.length ; ++i){
            var value = answers_notes[i];
            console.log(value)
            rows.push({
                board_id : (i+1),
                title: '<a href="reg.kgu?major=main&&num=30&&mode=view&&id='+value.id+'">' + value.title + '</a>',
                last_modified : formatDate(value.starting_date) + '~' + formatDate(value.closing_date)
            });
        }
        return rows;
    }
</script>