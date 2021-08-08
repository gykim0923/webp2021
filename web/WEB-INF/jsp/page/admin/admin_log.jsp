<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-26
  Time: 오후 2:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getSpaceInfo = (String) request.getAttribute("getSpaceInfo");
    String getAllLog = (String) request.getAttribute("getAllLog");
%>

<div>
    <div class="album">
        <div class="container">
            <label><h2><strong>서버 상태</strong></h2></label>
            <div id="serverStatus"></div>
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
        getSpaceInfo();
    })
    var $table = $('#table');
    // var $remove = $('#remove');
    var allLog = <%=getAllLog%>;

    function callSetupTableView(){
        $table.bootstrapTable('load',data());
        $table.bootstrapTable('refresh');
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

    function getSpaceInfo(){
        var text = '';
        var serverStatus = $('#serverStatus');
        var getSpaceInfo = <%=getSpaceInfo%>;
        for (var i = 0 ; i<getSpaceInfo.length; i++){
            var total = getSpaceInfo[i].total.split('.')[0];
            var used = getSpaceInfo[i].used.split('.')[0];
            var free = getSpaceInfo[i].free.split('.')[0];
            var memoryPercent = parseInt(parseInt(used) /parseInt(total) * 100);
            text+='<div>getSpaceInfo[i].disk : '+getSpaceInfo[i].disk + '</div>'
            text+='<div class="progress progress-primary  mb-4">'
                + '<div class="progress-bar progress-label" role="progressbar" style="width: '+memoryPercent+'%" aria-valuenow="'+memoryPercent+'" aria-valuemin="0" aria-valuemax="100"></div>'
                + '</div>'
            text+='<div>getSpaceInfo[i].total : '+ total + 'GB</div>'
            text+='<div>getSpaceInfo[i].used : '+ used + 'GB</div>'
            text+='<div>getSpaceInfo[i].free : '+ free + 'GB</div>'
        }
        serverStatus.append(text);
    }
</script>