<%--
  Created by IntelliJ IDEA.
  User: ellie
  Date: 2021-08-10
  Time: 오후 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="">
    <label><h2><strong>추천한 글</strong></h2></label>
    <script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>
    <table class="boardtable" id="table4"  data-toggle="table"
           data-pagination="true" data-toolbar="#toolbar"
           data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
           data-page-list="[10]">
        <thead>
        <tr>
            <th data-field="board_id" data-sortable="true">번호</th>
            <th data-field="title" data-sortable="true">제목</th>
            <th data-field="last_modified" data-sortable="true">작성일</th>
            <th data-field="views" data-sortable="true">추천수</th>
        </tr>
        </thead>
    </table>
</div>
<script>
    $(document).ready(function(){
        callSetupTableView4();
    })

    function callSetupTableView4(){
        $('#table4').bootstrapTable('append',data4());
        $('#table4').bootstrapTable('refresh');
    }

    function data4(){
        var rows = [];
        for(var i = 0 ; i < likeNotes.length ; ++i){
            var value = likeNotes[i];

            rows.push({
                board_id: (i+1),
                title: '<a href="bbs.kgu?major='+value.major+'&&num='+value.category+'&&mode=view&&id='+value.id+'">' + value.title + '</a>',
                last_modified : formatDate(value.last_modified),
                views : value.likes
            });

        }
        return rows;
    }
</script>
