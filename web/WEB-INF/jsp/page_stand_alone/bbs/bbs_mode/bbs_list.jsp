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
           data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="600"
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
<div class="text-end" id="write_button"></div>

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
        for(var i=1; i<10; i++){
            var bbsnum2 = "2"+i
            if(num==bbsnum || num==bbsnum2){
                if (type.board_level == 0 || type.board_level == 1) {
                    var text = '<a href = "bbs.kgu?major=' + major + '&&num=' + num + '&&mode=write" class="btn btn-success mt-3">글쓰기</a>';
                    button.append(text);
                }
            }
        }

        if(num=="31") {
            if (type.board_level == 0 || type.board_level == 1) {
                var text = '<a href = "bbs.kgu?major=' + major + '&&num=' + num + '&&mode=write" class="btn btn-success mt-3">글쓰기</a>';
                button.append(text);
            }
        }
        else if(num=="53"){
            if(type.board_level < 3){
                var text = '<a href = "bbs.kgu?major=' + major + '&&num=' + num + '&&mode=write" class="btn btn-success mt-3">글쓰기</a>';
                button.append(text);
            }
        } else if(num=="50" || num=="51" || num=="52"|| num=="54"|| num=="55"|| num=="56"|| num=="57"|| num=="58"|| num=="59"){
            if (type.board_level == 0 || type.board_level == 1) {
                var text = '<a href = "bbs.kgu?major=' + major + '&&num=' + num + '&&mode=write" class="btn btn-success mt-3">글쓰기</a>';
                button.append(text);
            }
        }
    }
</script>

<style>
    .fixed-table-border, .fixed-table-container{
        border: 0 !important;
    }
    .boardtable > thead > tr > th, .boardtable > tbody > tr > td{
        overflow:hidden;
        text-overflow:ellipsis;
        white-space:nowrap;
        text-align: center;
        border-right : none;
        border-left : none;
        height: 40px;
        max-height: 40px;
        min-height: 40px;
    }
    .boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
        min-width: 56px;
        max-width: 56px;
        width: 56px;
    }
    .boardtable > thead > tr > th:nth-child(3), .boardtable > tbody > tr > td:nth-child(3) {
        min-width: 75px;
        max-width: 75px;
        width: 75px;
    }
    .boardtable > thead > tr > th:nth-child(4), .boardtable > tbody > tr > td:nth-child(4) {
        min-width: 110px;
        max-width:110px;
        width: 110px;
    }

    .boardtable > thead > tr > th:nth-child(5), .boardtable > tbody > tr > td:nth-child(5) {
        min-width: 75px;
        max-width: 75px;
        width: 75px;
    }

    @media (min-width: 50px) {
        th:nth-of-type(3) { display: none; }
        td:nth-of-type(3) { display: none; }
        th:nth-of-type(4) { display: none; }
        td:nth-of-type(4) { display: none; }
        th:nth-of-type(5) { display: none; }
        td:nth-of-type(5) { display: none; }
    }
    @media (min-width: 280px) {
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            max-width: 100px;
        }
    }
    @media (min-width: 320px) {
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            max-width: 100px;
        }
    }
    @media (min-width: 360px) {
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            max-width: 100px;
        }
    }
    @media (min-width: 400px) {
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            max-width: 100px;
        }
    }
    @media (min-width: 450px) {
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            max-width: 100px;
        }

    }
    @media (min-width: 576px) {
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            max-width: 100px;
        }
        th:nth-of-type(4) { display: table-cell; }
        td:nth-of-type(4) { display: table-cell; }
    }
    @media (min-width: 768px) {
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            max-width: 320px;
        }
        th:nth-of-type(1) { display: table-cell; }
        td:nth-of-type(1) { display: table-cell; }
        th:nth-of-type(2) { display: table-cell; }
        td:nth-of-type(2) { display: table-cell; }
        th:nth-of-type(3) { display: table-cell; }
        td:nth-of-type(3) { display: table-cell; }
        th:nth-of-type(5) { display: table-cell; }
        td:nth-of-type(5) { display: table-cell; }
    }
    @media (min-width: 992px) {
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            max-width: 560px;
        }
    }
    @media (min-width: 1200px) {
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            max-width: 480px;
        }
    }
    @media (min-width: 1400px) {
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            max-width: 630px;
        }
    }
    @media (min-width: 1600px) {
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            max-width: 840px;
        }
    }

</style>
