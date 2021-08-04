<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-26
  Time: 오후 2:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getAllLog = (String) request.getAttribute("getAllLog");
%>

<div>
    <div class="album py-5 bg-light">
        <div class="container">
            <label><h2><strong>사용자 관리</strong></h2></label>
            <table class="boardtable" id="table" data-toggle="table"
                   data-pagination="true"
                   data-toolbar="#toolbar" data-search="true"
                   data-side-pagination="true" data-click-to-select="true" data-height="700"
                   data-page-list="[50]">
                <thead>
                <tr>
                    <th data-field="id" data-sortable="true">id</th>
                    <th data-field="log_time" data-sortable="true">접속시간</th>
                    <th data-field="per_id" data-sortable="true">아이디</th>
                    <th data-field="name" data-sortable="true">이름</th>
                    <th data-field="type" data-sortable="true">타입</th>
                    <th data-field="log_type" data-sortable="true">로그종류</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>

<script>
    $(document).ready(function(){
        callSetupTableView();
        deleteLog();
    })
    var $table = $('#table');
    // var $remove = $('#remove');
    var allLog = <%=getAllLog%>;

    function callSetupTableView(){
        $table.bootstrapTable('load',data());
        $table.bootstrapTable('refresh');
    }

    function deleteLog(){
        $.ajax({
            url: "ajax.kgu",
            type: "post",
            data: {
                req: "delete_log"
            }
        });
    }

    function data() {
        var rows = [];
        var size = allLog.length
        for (var i = 0; i < size; i++) {
            var log = allLog[i];
            //var date = formatData(log.log_time);
            rows.push({
                id : log.id,
                log_time : log.log_time,
                per_id : log.user_id,
                type : log.user_type,
                name : log.user_name,
                log_type : log.log_type,
            });
        }
        return rows;
    }

    function formatData(date) {
        var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
            + d.getDate(), year = d.getFullYear();

        if (month.length < 2)
            month = '0' + month;
        if (day.length < 2)
            day = '0' + day;

        return [ year, month, day ].join('-');
    }
</script>