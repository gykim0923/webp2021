<%--
  Created by IntelliJ IDEA.
  User: ellie
  Date: 2021-08-10
  Time: 오후 9:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="">
    <label><h2><strong>작성 댓글</strong></h2></label>
    <script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>
    <table class="boardtable" id="table2"  data-toggle="table"
           data-pagination="true" data-toolbar="#toolbar"
           data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
           data-page-list="[10]">
        <thead>
        <tr>
            <th data-field="board_id" data-sortable="true">번호</th>
            <th data-field="title" data-sortable="true">글 제목</th>
            <th data-field="last_modified" data-sortable="true">작성일</th>
            <th data-field="views" data-sortable="true">조회수</th>
        </tr>
        </thead>
    </table>
</div>
<script>
    $(document).ready(function(){
        callSetupTableView2();
    })

    function callSetupTableView2(){
        $('#table2').bootstrapTable('append',data2());
        $('#table2').bootstrapTable('refresh');
    }

    function data2(){
        var rows = [];
        var sequence = 1;
        for(var i = 0 ; i < notice_comments.length ; ++i){
            var value = notice_comments[i];
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
</script>