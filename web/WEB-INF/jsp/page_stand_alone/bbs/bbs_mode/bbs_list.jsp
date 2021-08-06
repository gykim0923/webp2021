<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-19
  Time: 오후 6:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getBBSList = (String) request.getAttribute("getBBSList");
%>
<div>

    <table class="boardtable" id="table1"  data-toggle="table"
           data-pagination="true" data-toolbar="#toolbar"
           data-search="true" data-side-pagination="true" data-click-to-select="true"
           data-page-size="10"
           data-page-list="[10,20,30]">
        <thead>
        <tr>
            <th data-field="id" data-sortable="false">번호</th>
            <th data-field="title" data-sortable="false">제목</th>
            <th data-field="writer_name" data-sortable="false">글쓴이</th>
            <th data-field="last_modified" data-sortable="false">작성일</th>
            <th data-field="views" data-sortable="false">조회수</th>
<%--            <th data-field="likes" data-sortable="true">추천</th>--%>
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

    function formatDate(date) {  //주어진 날짜를 yyyy-mm-dd 형식으로 반환해주는 함수
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }

    var major = <%=major%>;
    var num = <%=num%>;
    var type = <%=type%>;
    function callSetupTableView(){
        $('#table1').bootstrapTable('load',tableData());
        // $('#table1').bootstrapTable('append',data());
        $('#table1').bootstrapTable('refresh');
    }
    function tableData(){
        var bbsList = <%=getBBSList%>;
        var rows = [];
        if(bbsList!=null){
            for(var i=0;i<bbsList.length;i++){
                var bbs=bbsList[i];
                var url = 'bbs.kgu?major='+major+'&&num='+num+'&&mode=view'+'&&id='+bbs.id;
                rows.push({
                    id: '<a href="'+url+'">'+bbs.id+'</a>',
                    title: '<a href="'+url+'">'+bbs.title+'</a>',
                    writer_name: '<a href="'+url+'">'+bbs.writer_name+'</a>',
                    last_modified: '<a href="'+url+'">'+formatDate(bbs.last_modified)+'</a>',
                    views: '<a href="'+url+'">'+bbs.views+'</a>',
                });
            }
        }
        return rows;
    }

    function makeWriteButton(){
        var button =$('#write_button');
        var bbsnum;
        for(var i=54; i<60; i++){
            bbsnum=i;
            if(num==bbsnum){
                if (type.board_level == 0 || type.board_level == 1) {
                    var text = '<a href = "bbs.kgu?major=' + major + '&&num=' + num + '&&mode=write"><div class="btn btn-secondary">글쓰기</div></a>';
                    button.append(text);
                }
            }
        }
        if(num == "21" || num == "22" || num == "23" || num == "30" || num=="31" || num=="52" || num=="53") {
            if (type.board_level == 0 || type.board_level == 1) {
                var text = '<a href = "bbs.kgu?major=' + major + '&&num=' + num + '&&mode=write"><div class="btn btn-secondary">글쓰기</div></a>';
                button.append(text);
            }
        }
    }
</script>