<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-15
  Time: 오후 2:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getSlider = (String) request.getAttribute("getSlider");
%>
<div class="py-5">
    <%--대문 관리--%>

    <label><h2><strong>대문 관리</strong></h2></label>
        <div>
            <table class="boardtable" id="table3"  data-toggle="table"
                   data-pagination="true" data-toolbar="#toolbar"
                   data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
                   data-page-list="[10]">
                <thead>
                <tr>
                    <th data-field="action">설정</th>
                    <th data-field="real_name">real_name</th>
                    <th data-field="original_name">original_name</th>
                </tr>
                </thead>
            </table>
        </div>

        <div><button class="btn btn-secondary" onclick="uploadfile()"><i class="bi bi-upload"></i> 업로드</button></div>
</div>

<script>
    $(document).ready(function(){
        callSetupTableView3();
    })
    function callSetupTableView3(){
        $('#table3').bootstrapTable('load',tableData3());
        $('#table3').bootstrapTable('refresh');
    }
    function tableData3(){
        var getSlider = <%=getSlider%>;
        var rows = [];
        for(var i=0;i<getSlider.length;i++){
            var slider=getSlider[i];
            rows.push({
                id: slider.id,
                real_name: slider.real_name,
                original_name: slider.original_name,
                action : '<button class="btn btn-dark" type="button" onclick="deleteSlider('+i+')">삭제</button>';
            });
        }
        return rows;
    }

</script>