<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-07
  Time: 오전 8:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getAllUser = (String)request.getAttribute("getAllUser");
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
                    <th data-field="id" data-sortable="true">id</th>
                    <th data-field="name" data-sortable="true">name</th>
                    <th data-field="birth" data-sortable="true">birth</th>
                    <th data-field="email" data-sortable="true">email</th>
                    <th data-field="phone" data-sortable="true">phone</th>
                    <th data-field="type" data-sortable="true">type</th>
                    <th data-field="hope_type" data-sortable="true">hope_type</th>
                    <th data-field="myhomeid" data-sortable="true">myhomeid</th>
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
        var makeUserAll = <%=getAllUser%>;
        var rows = [];
        for(var i=0;i<makeUserAll.length;i++){
            var user=makeUserAll[i];
            rows.push({
                id: user.id,
                name: user.name,
                birth: user.birth,
                email: user.email,
                phone: user.phone,
                type: user.type,
                hope_type: user.hope_type,
                myhomeid: user.myhomeid,
                action : '<button class="btn btn-secondary" type="button" onclick="deleteUser('+i+')">회원삭제</button>'
            });
        }
        // alert(rows);
        return rows;
    }

    function deleteUser(i){
        var user = <%=getAllUser%>;
        var id = user[i].id;
        var name = user[i].name;
        var check = confirm("[중요] 정말로 "+id+"["+name+"]를 삭제하시나요? 되돌릴 수 없습니다.");
        if (check) {
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post",
                data: {
                    req: "deleteUser",
                    data: id+"-/-/-"+name  //이중 검사용으로 DB를 두개 넘깁니다.
                },
                success: function (result) {
                    if(result!='fail'){
                        alert("해당 회원이 삭제되었습니다.");
                        window.location.reload();
                    }
                    else {
                        alert("삭제 권한이 없습니다.");
                    }
                }
            })
        }
    }
</script>