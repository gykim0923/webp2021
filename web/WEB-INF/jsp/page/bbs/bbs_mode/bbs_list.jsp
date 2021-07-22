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
           data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
           data-page-list="[10]">
        <thead>
        <tr>
            <th data-field="id" data-sortable="true">id</th>
            <th data-field="title" data-sortable="true">title</th>
            <th data-field="writer_name" data-sortable="true">writer_name</th>
            <th data-field="last_modified" data-sortable="true">last_modified</th>
            <th data-field="views" data-sortable="true">views</th>
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
                    last_modified: '<a href="'+url+'">'+bbs.last_modified+'</a>',
                    views: '<a href="'+url+'">'+bbs.views+'</a>'
                });
            }
        }
        return rows;
    }

    function makeWriteButton(){
        var button =$('#write_button');
        if(num == "20" || num == "21" || num == "22" || num == "23") {
            if (type.board_level == 0 || type.board_level == 1) {
                var text = '<a href = "bbs.kgu?major=' + major + '&&num=' + num + '&&mode=write"><div class="btn btn-secondary">글쓰기</div></a>';
                button.append(text);
            }
        }
    }
</script>