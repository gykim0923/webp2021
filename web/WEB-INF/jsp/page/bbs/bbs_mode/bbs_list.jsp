<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-19
  Time: 오후 6:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getBBS = (String) request.getAttribute("getBBS");
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

<script>
    $(document).ready(function(){
        callSetupTableView();
    })

    function callSetupTableView(){
        $('#table1').bootstrapTable('load',tableData());
        // $('#table1').bootstrapTable('append',data());
        $('#table1').bootstrapTable('refresh');
    }
    function tableData(){
        var bbsList = <%=getBBS%>;
        var rows = [];
        if(bbsList!=null){
            for(var i=0;i<bbsList.length;i++){
                var bbs=bbsList[i];
                rows.push({
                    id: bbs.id,
                    title: bbs.title,
                    writer_name: bbs.writer_name,
                    last_modified: bbs.last_modified,
                    views: bbs.views
                });
            }
        }
        return rows;
    }
</script>