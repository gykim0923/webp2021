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

    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">관리하기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id = "myModalbody"></div>
                <%--                        <div class="modal-footer">--%>
                <%--                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>--%>
                <%--                            <button type="button" class="btn btn-primary">추가하기</button>--%>
                <%--                        </div>--%>
            </div>
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
                action : '<button class="btn btn-dark" type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="majorManager('+i+')">관리</button>'
            });
        }
        // alert(rows);
        return rows;
    }

    function majorManager(i){
        var list = $('#myModalbody');
        var a = '<label for="name" class="form-label">전공 이름</label><input type="text" class="form-control" id="name" placeholder="전공 이름을 입력해주세요">';
        a += '<button type="button" class="btn btn-dark" data-dismiss="modal">Close</button>'
        a += '<button type="button" class="btn btn-dark pull-right" data-dismiss="modal" aria-label="Close" onclick="foo()">완료</button>';
        list.html(a);
    }

</script>

