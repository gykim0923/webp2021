<%--
  Created by IntelliJ IDEA.
  User: ellie
  Date: 2021-07-26
  Time: 오전 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getPageMenu = (String)request.getAttribute("getPageMenu");
    String tabmenulist = (String)request.getAttribute("tabmenulist");
%>
<div>
    <div class="album py-5 bg-light">
        <div class="container">
            <label><h2><strong>메뉴 관리</strong></h2></label>
            <table class="boardtable" id="table" data-toggle="table"
                   data-pagination="true"
                   data-toolbar="#toolbar" data-search="true"
                   data-side-pagination="true" data-click-to-select="true" data-height="460"
                   data-page-list="[10]">
                <thead>
                <tr>
                    <th data-field="index" data-sortable="true">번호</th>
                    <th data-field="page_title" data-sortable="true">이름</th>
                    <th data-field="type" data-sortable="true">타입</th>
                    <th data-field="tab_title" data-sortable="true">구분</th>
                    <th data-field="show_detail" data-sortable="true">상세보기</th>
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

    var menulist = <%=getPageMenu%>;
    var headermenulist = <%=tabmenulist%>;

    function callSetupTableView(){
        $('#table').bootstrapTable('append',data());
        $('#table').bootstrapTable('refresh');
    }

    function data(){
        var rows = [];
        var typeName="";
        var indexID=1;
        for(var i=0;i<menulist.length;i++){
            var value=menulist[i];
            if(value.tab_id<6){
                var headvalue=headermenulist[(value.tab_id-1)];
                    if(value.page_path=="information.kgu"){
                        typeName = "정보 페이지";
                    }
                    else if(value.page_path=="bbs.kgu"){
                        typeName = "공지사항 게시판";
                    }
                    else{
                        typeName = "ETC";
                    }
                    rows.push({
                        index: indexID,
                        page_title: value.page_title,
                        type: typeName,
                        tab_title: headvalue.tab_title,
                        show_detail: '<a data-toggle="modal" href="#">상세보기</a>'
                    });
                    indexID++;
            }
        }
        return rows;
    }
</script>