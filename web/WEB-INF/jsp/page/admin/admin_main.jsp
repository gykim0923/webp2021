<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-07
  Time: 오전 8:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getAllMajor = (String)request.getAttribute("getAllMajor");
%>
<div>
    <div class="album py-5 bg-light">
        <div class="container">
            <table class="boardtable" id="table1"  data-toggle="table"
                   data-pagination="true" data-toolbar="#toolbar"
                   data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
                   data-page-list="[10]">
                <thead>
                <tr>
                    <th data-field="action">설정</th>
                    <th data-field="oid" data-sortable="true">oid</th>
                    <th data-field="major_id" data-sortable="true">major_id</th>
                    <th data-field="major_name" data-sortable="true">major_name</th>
                    <th data-field="major_color1" data-sortable="true">major_color1</th>
                    <th data-field="major_color2" data-sortable="true">major_color2</th>
                    <th data-field="major_color3" data-sortable="true">major_color3</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
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
        var makeAllMajor = <%=getAllMajor%>;
        var rows = [];
        for(var i=0;i<makeAllMajor.length;i++){
            var major=makeAllMajor[i];
            rows.push({
                oid: major.oid,
                major_id: major.major_id,
                major_name: major.major_name,
                major_color1: major.major_color1,
                major_color2: major.major_color2,
                major_color3: major.major_color3,
                action : '<button class="btn btn-danger" type="button" onclick="foo('+i+')">버튼튼</button>'
            });
        }
        // alert(rows);
        return rows;
    }
</script>