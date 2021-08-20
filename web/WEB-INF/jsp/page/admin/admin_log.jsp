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
    String getOSInfo = (String) request.getAttribute("getOSInfo");
    String getMemoryInfo = (String) request.getAttribute("getMemoryInfo");
    String getAllLog = (String) request.getAttribute("getAllLog");
%>

<div>
    <div class="text-danger text-end mb-3">이 페이지는 가로 길이 800px 이상의 화면에서 최적화 되어있습니다.</div>
    <div class="album">
        <div class="container">
            <label><h2><strong>서버 상태</strong></h2></label>
            <div class="mb-5" id="serverStatus"></div>
            <label class="mt-5"><h2><strong>로그 관리</strong></h2></label>
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
        getOSInfo();
        getMemoryInfo();
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


    var serverStatus = $('#serverStatus');
    function getOSInfo(){
        var text = '';
        var getOSInfo = <%=getOSInfo%>;
        text+='';
        text+='<div class="py-4"><div><h4>● 서버 정보</h4></div>'
            +'<div>운영체제 : '+getOSInfo[0].name+'</div>'
            +'<div>아키텍쳐 : '+getOSInfo[0].arch+'</div>'
            +'<div>가용 프로세서 수 : '+getOSInfo[0].core+'</div>'
            +'<div>실시간 CPU 사용량 : '+getOSInfo[0].load+'%</div>'
            +'<h6 class="text-end text-danger">실시간 CPU 사용량은 페이지 로드 시점의 사용량을 나타냅니다.</h6>'
            +'</div>'
        serverStatus.append(text);
    }
    function getMemoryInfo() {
        var text = '';
        var getMemoryInfo = <%=getMemoryInfo%>;
        var heap = getMemoryInfo[0].heapMemory.split('.')[0];
        var nonHeap = getMemoryInfo[0].nonHeapMemory.split('.')[0];
        var total = getMemoryInfo[0].total;
        var free = getMemoryInfo[0].free;
        var used = total-free;
        var memoryPercent = parseInt(parseInt(used) /parseInt(total) * 100);
        text+='<div class="py-4"><div><h4>● 메모리 상태</h4></div>'
            +'<div>heap 메모리 : '+heap+'MB | non-heap 메모리 : '+nonHeap+'MB</div>'
        text+='<div class="progress progress-warning mt-3 mb-2">'
            + '<div class="progress-bar progress-label" role="progressbar" style="width: '+memoryPercent+'%" aria-valuenow="'+memoryPercent+'" aria-valuemin="0" aria-valuemax="100"></div>'
            + '</div>'
            + '<div class="mb-3 text-end">전체 '+ total + 'MB | 사용 : '+ used + 'MB | 잔여 : '+ free + 'MB</div>'
            +'<h6 class="text-end text-danger">서버 메모리는 서버에서 자동으로 관리하고 있으나, 단기간 내에 과도한 요청이 들어오는 경우 메모리가 가득 차게 되어 서버가 다운됩니다.</h6>'
            +'</div>'
        serverStatus.append(text);
    }
    function getSpaceInfo(){
        var text = '';
        var getSpaceInfo = <%=getSpaceInfo%>;
        text+='<div class="py-4"><div><h4>● 디스크 용량</h4></div>';
        for (var i = 0 ; i<getSpaceInfo.length; i++){
            var total = getSpaceInfo[i].total.split('.')[0];
            var used = getSpaceInfo[i].used.split('.')[0];
            var free = getSpaceInfo[i].free.split('.')[0];
            var memoryPercent = parseInt(parseInt(used) /parseInt(total) * 100);
            text+='<div class="px-3"><h5>디스크 드라이브 (' + getSpaceInfo[i].disk + ')</h5></div>'
            text+='<div class="progress progress-primary mt-3 mb-2">'
                + '<div class="progress-bar progress-label" role="progressbar" style="width: '+memoryPercent+'%" aria-valuenow="'+memoryPercent+'" aria-valuemin="0" aria-valuemax="100"></div>'
                + '</div>'
                + '<div class="mb-3 text-end">전체 '+ total + 'GB | 사용 : '+ used + 'GB | 잔여 : '+ free + 'GB</div>'
        }
        text+='<h6 class="text-end text-danger">서버 용량이 부족한 경우 반드시 관리자에게 알려주세요.</h6>'
            +'</div>'
        serverStatus.append(text);
    }

</script>