<%--
  Created by IntelliJ IDEA.
  User: ellie
  Date: 2021-07-22
  Time: 오후 1:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getAllUser = (String) request.getAttribute("getAllUser");
%>

    <div>
        <div class="album">
            <div class="container">
                <label><h2><strong>사용자 관리</strong></h2></label>
<%--                <fieldset>--%>
<%--                    <div class="col-xs-3">수정 필드(일괄 수정)</div>--%>
<%--                    <label class="checkbox-inline"><input type="checkbox"--%>
<%--                                                          name="modify" value="type">구분</label> <label--%>
<%--                        class="checkbox-inline"><input type="checkbox"--%>
<%--                                                       name="modify" value="grade">학년</label> <label--%>
<%--                        class="checkbox-inline"><input type="checkbox"--%>
<%--                                                       name="modify" value="per_id">학번</label> <label--%>
<%--                        class="checkbox-inline"><input type="checkbox"--%>
<%--                                                       name="modify" value="major">학과</label> <label--%>
<%--                        class="checkbox-inline"><input type="checkbox"--%>
<%--                                                       name="modify" value="state">학적상태</label>--%>
<%--                </fieldset>--%>
                <table class="boardtable" id="table" data-toggle="table"
                       data-pagination="true"
                       data-toolbar="#toolbar" data-search="true"
                       data-side-pagination="true" data-click-to-select="true" data-height="460"
                       data-page-list="[10]">
                    <thead>
                    <tr>
                        <th data-field="id" data-sortable="true">ID</th>
                        <th data-field="per_id" data-sortable="true">학번</th>
                        <th data-field="type" data-sortable="true">타입</th>
                        <th data-field="name" data-sortable="true">이름</th>
                        <th data-field="birth" data-sortable="true">생년월일</th>
                        <th data-field="hope_type" data-sortable="true">희망구분</th>
                        <th data-field="reg_date" data-sortable="true">가입일자</th>
                        <th data-field="major" data-sortable="true">전공</th>
                        <th data-field="sub_major" data-sortable="true">부전공</th>
                        <th data-field="grade" data-sortable="true">학년</th>
                        <th data-field="state" data-sortable="true">학적상태</th>
                    </tr>
                    </thead>
                </table>
<%--                <div class="col-md-6">--%>
<%--                    <input type="file" name="uploadFile" id="uploadFile"accept=".xls, .xlsx">--%>
<%--                </div>--%>
                <a href="excel.kgu?writeorread=write" class="btn btn-primary col-md-2">Excel로 보내기</a>
<%--                <a href="#myModal" data-toggle="modal" onclick="insertexcelreader()" class="btn btn-default col-md-2">일괄 추가</a>--%>
<%--                <a href="#myModal2" data-toggle="modal" onclick="modifyexcelreader()" class="btn btn-default col-md-2">일괄 수정</a>--%>
            </div>
        </div>
    </div>

<div id="shadow">
    <div id="blur"></div>
</div>
<%--<!-- Modal -->--%>
<%--<div class="modal fade" id="myModal" role="dialog">--%>
<%--    <div class="modal-dialog">--%>
<%--        <!-- Modal content-->--%>
<%--        <div class="modal-content">--%>
<%--            <div class="modal-header">--%>
<%--                <button type="button" class="close" data-dismiss="modal"--%>
<%--                        aria-label="Close">--%>
<%--                    <span aria-hidden="true">&times;</span>--%>
<%--                </button>--%>
<%--                <h4 class="modal-title">USER</h4>--%>
<%--            </div>--%>
<%--            <div id="howmany"></div>--%>
<%--            <div class="modal-body" id="myModalbody">--%>
<%--                <table id="insert_excel" data-toggle="table" data-height="299">--%>
<%--                    <thead>--%>
<%--                    <tr>--%>
<%--                        <th data-field="id" data-sortable="true">id</th>--%>
<%--                        <th data-field="per_id" data-sortable="true">학번</th>--%>
<%--                        <th data-field="type" data-sortable="true">타입</th>--%>
<%--                        <th data-field="name" data-sortable="true">이름</th>--%>
<%--                        <th data-field="birth" data-sortable="true">생년월일</th>--%>
<%--                        <th data-field="major" data-sortable="true">전공</th>--%>
<%--                        <th data-field="grade" data-sortable="true">학년</th>--%>
<%--                        <th data-field="state" data-sortable="true">학적상태</th>--%>
<%--                    </tr>--%>
<%--                    </thead>--%>
<%--                </table>--%>
<%--            </div>--%>
<%--            <div class="modal-footer" id="footer"></div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<!-- Modal -->--%>
<%--<div class="modal fade" id="myModal2" role="dialog">--%>
<%--    <div class="modal-dialog">--%>
<%--        <!-- Modal content-->--%>
<%--        <div class="modal-content">--%>
<%--            <div class="modal-header">--%>
<%--                <button type="button" class="close" data-dismiss="modal"--%>
<%--                        aria-label="Close">--%>
<%--                    <span aria-hidden="true">&times;</span>--%>
<%--                </button>--%>
<%--                <h4 class="modal-title">USER</h4>--%>
<%--            </div>--%>
<%--            <div id="howmany2"></div>--%>
<%--            <div class="modal-body" id="myModalbody2">--%>
<%--                <table id="modify_excel" data-toggle="table" data-height="299">--%>
<%--                    <thead>--%>
<%--                    <tr>--%>
<%--                        <th data-field="id" data-sortable="true">id</th>--%>
<%--                        <th data-field="type" data-sortable="true">타입</th>--%>
<%--                        <th data-field="per_id" data-sortable="true">학번</th>--%>
<%--                        <th data-field="grade" data-sortable="true">학년</th>--%>
<%--                        <th data-field="major" data-sortable="true">학과</th>--%>
<%--                        <th data-field="state" data-sortable="true">학적상태</th>--%>
<%--                        <th data-field="typebefore" data-sortable="true">타입(전)</th>--%>
<%--                        <th data-field="per_idbefore" data-sortable="true">학번(전)</th>--%>
<%--                        <th data-field="gradebefore" data-sortable="true">학년(전)</th>--%>
<%--                        <th data-field="majorbefore" data-sortable="true">전공(전)</th>--%>
<%--                        <th data-field="statebefore" data-sortable="true">학적상태(전)</th>--%>
<%--                    </tr>--%>
<%--                    </thead>--%>
<%--                </table>--%>
<%--            </div>--%>
<%--            <div class="modal-footer" id="footer2"></div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<script>
    $(document).ready(function(){
        callSetupTableView();
    })
    var $table = $('#table');
    var $remove = $('#remove');
    var alluser =<%=getAllUser%>;

    function callSetupTableView(){
        $('#table').bootstrapTable('load',data());
        $('#table').bootstrapTable('refresh');
    }

    function data() {
        var rows = [];
        for (var i = 0; i < alluser.length; i++) {
            var user = alluser[i];
            var date = formatData(user.reg_date);
            rows.push({
                id : user.id,
                per_id : user.per_id,
                type : user.type,
                name : user.name,
                birth : user.birth,
                hope_type : user.hope_type,
                reg_date : date,
                major : user.major,
                sub_major : user.sub_major,
                grade : user.grade,
                state : user.state,
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
    // function deleteuser(id) {
    //     var user = alluser[id];
    //     var check = confirm(user.name + "[" + user.id + "]를 정말 삭제하시겠습니까?");
    //     if (check) {
    //         $.ajax({
    //             url : "ajax.kgu",
    //             type : "post",
    //             data : {
    //                 req : "deleteuser",
    //                 data : alluser[i].id
    //             },
    //             success : function(data) {
    //
    //                 alert("삭제되었습니다.");
    //             }
    //         })
    //
    //     }
    // }
    //
    // function insertexcelreader() {
    //     alert("파일 추가하셔야 수정 가능합니다!!");
    //     var address=uploadexcel();
    //     $.ajax({
    //         url : "excel.kgu",
    //         type : "post",
    //         data : {
    //             writeorread : "read",
    //             type : "user",
    //             address : address
    //         },
    //         dataType : "json",
    //         success : function(data) {
    //             var modal = $('#myModalbody');
    //             var howmany = $('#howmany');
    //
    //             var a = '<h3> 총 ' + (data.length)
    //                 + '명의 회원이 등록될 예정입니다.</h3>';
    //             howmany.html(a);
    //             var table2 = $('#insert_excel');
    //
    //             var footer = $('#footer');
    //             footer
    //                 .html('<button id="addbutton" type="button" class="btn btn-default" style = "margin : 1px;">일괄 추가</button>');
    //             $('#addbutton').attr('onclick', 'insertuser()');
    //             table2.bootstrapTable('load', insertdata(data));
    //             table2.bootstrapTable('refresh');
    //         }
    //     })
    // }
    //
    // function insertuser() {
    //     var address = uploadexcel();
    //     $.ajax({
    //         url : "ajax.kgu",
    //         type : "post",
    //         data : {
    //             req : "insertexceluser",
    //             data : "true",
    //             address : address
    //         },
    //         success : function(data) {
    //             alert(data + "명의 회원이 등록되었습니다.");
    //             location.reload();
    //         }
    //     })
    // }
    //
    // function insertdata(data) {
    //     var rows = [];
    //
    //     for (var i = 0; i < data.length; i++) {
    //         var user = data[i];
    //         rows.push({
    //             id : user.id,
    //             per_id : user.per_id,
    //             type : user.type,
    //             name : user.name,
    //             birth : user.birth,
    //             major : user.major,
    //             sub_major : user.sub_major,
    //             grade : user.grade,
    //             state : user.state,
    //         });
    //     }
    //     return rows;
    // }
    //
    // function modifyexcelreader() {
    //     alert("파일 추가하셔야 수정 가능합니다!!(수정 필드도 선택하셔야합니다 ID 칼럼필수)");
    //     var address = uploadexcel();
    //     var values = document.getElementsByName("modify");
    //     var modify = '';
    //     for (var i = 0; i < values.length; i++)
    //         if (values[i].checked) {
    //             modify += values[i].value + "-/-/-";
    //         }
    //
    //     $.ajax({
    //         url : "excel.kgu",
    //         type : "post",
    //         data : {
    //             writeorread : "read",
    //             type : "user",
    //             data : modify,
    //             address : address
    //         },
    //         dataType : "json",
    //         success : function(data) {
    //             var modal = $('#myModalbody2');
    //             var howmany = $('#howmany2');
    //             var a = '<h3> 총 ' + (data.length)
    //                 + '명의 회원이 수정될 예정입니다.</h3>';
    //             howmany.html(a);
    //             var table2 = $('#modify_excel');
    //             var footer = $('#footer2');
    //             footer.html('<button id="addbutton" type="button" class="btn btn-default" style = "margin : 1px;">일괄 수정</button>');
    //             $('#addbutton').attr('onclick', 'modifyexceluser()');
    //             table2.bootstrapTable('load', modifydata(data));
    //             table2.bootstrapTable('refresh');
    //         }
    //     })
    // }
    //
    // function modifydata(data) {
    //     var rows = [];
    //
    //     for (var i = 0; i < data.length; i++) {
    //         var user = data[i];
    //         rows.push({
    //             id : user.id,
    //             type : user.type,
    //             per_id :user.per_id,
    //             grade : user.grade,
    //             major : user.major,
    //             sub_major : user.sub_major,
    //             state : user.state,
    //             typebefore : user.typebefore,
    //             per_idbefore : user.per_idbefore,
    //             gradebefore : user.gradebefore,
    //             majorbefore : user.majorbefore,
    //             sub_majorbefore : user.sub_majorbefore,
    //             statebefore : user.statebefore
    //         });
    //     }
    //     return rows;
    // }
    //
    // function modifyexceluser(){
    //     var address = uploadexcel();
    //     var values = document.getElementsByName("modify");
    //     var modify = '';
    //     for (var i = 0; i < values.length; i++)
    //         if (values[i].checked) {
    //             modify += values[i].value + "-/-/-";
    //         }
    //     $.ajax({
    //         url : "ajax.kgu",
    //         type : "post",
    //         data : {
    //             req : "modifyexceluser",
    //             data : modify,
    //             address : address
    //         },
    //         success : function(data) {
    //             alert(data + "명의 회원이 수정되었습니다.");
    //             location.reload();
    //         }
    //     })
    // }
    //
    // function uploadexcel(){
    //     var formData = new FormData();
    //     var address="";
    //     formData.append("excelfile",$('input[name=uploadFile]')[0].files[0]);
    //     $.ajax({
    //         url : "insertExcel.kgu",
    //         type : "post",
    //         async:false,
    //         data : formData,
    //         processData : false,
    //         contentType : false,
    //         success : function(data){//데이터는 주소
    //             address =data;
    //         }
    //     })
    //     return address;
    // }
</script>
