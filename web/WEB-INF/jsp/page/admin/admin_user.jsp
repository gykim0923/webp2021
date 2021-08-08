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
<script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>
<script src='js/sha256.js'></script>
<div>
    <div class="album">
        <div class="container">
            <table class="boardtable" id="table1"  data-toggle="table"
                   data-pagination="true" data-toolbar="#toolbar"
                   data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
                   data-page-list="[10]">
                <thead>
                <tr>
                    <th data-field="state" data-checkbox="true"></th>
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
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <button type="button" class="btn btn-secondary" onclick="modifyType()" data-bs-toggle="modal" data-bs-target="#modifyTypeModal">권한 수정</button>
            </div>
        </div>
    </div>
</div>

<!-- 회원 권한 수정 Modal -->
<div class="modal fade" id="modifyTypeModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modifyTypeLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" id="modifyTypeHeader"></div>
            <div class="modal-body" id = "modifyTypeBody"></div>
            <div class="modal-footer" id="modifyTypeFooter">
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
                action : '<button class="btn btn-secondary" type="button" onclick="deleteUser('+i+')">회원삭제</button>'+'<button class="btn btn-secondary" type="button" onclick="passwordReset('+i+')">PW초기화</button>'
            });
        }
        // alert(rows);
        return rows;
    }

    function deleteUser(i){
        var user = <%=getAllUser%>;
        var id = user[i].id;
        var name = user[i].name;
        var type = user[i].type;
        swal.fire({
            title: name+'회원을 삭제하시나요?',
            text: '다시 되돌릴 수 없습니다.',
            icon: 'warning',
            showConfirmButton: true,
            showCancelButton: true

        }).then((result) => {
            if (result.isConfirmed) {

                $.ajax({
                    url: "ajax.kgu", //AjaxAction에서
                    type: "post",
                    data: {
                        req: "deleteUser",
                        data: id+"-/-/-"+name+"-/-/-"+type  //이중 검사용으로 DB를 두개 넘깁니다.
                    },
                    success: function (data) { //성공 시
                        if (data == 'success') {

                            swal.fire({
                                title: '해당 회원이 삭제되었습니다.',
                                icon: 'success',
                                showConfirmButton: true

                            }).then(function () {
                                location.reload();
                            });
                        } else {
                            swal.fire({
                                title: '권한이 부족합니다.',
                                icon: 'warning',
                                showConfirmButton: true

                            });
                        }
                    }
                })
            }

        });

    }


    function passwordReset(i) {
        var makeUserAll = <%=getAllUser%>;
        var user = makeUserAll[i];
        var change = user.birth;

        swal.fire({
            title: user.name+'패스워드를 초기화 하시겠습니까?',
            text: '초기화 : 생년월일(생년월일이 없을 경우 1234)',
            icon: 'warning',
            showConfirmButton: true,
            showCancelButton: true

        }).then((result) => {
            if (result.isConfirmed) {

                if (change == "-")
                    change = "1234";
                else {
                    var a = change.split("-");
                    change = user.id + a[0].substring(2, 4) + "" + a[1] + "" + a[2];
                }
                $.ajax({
                    url: "ajax.kgu",
                    type: "post",
                    data: {
                        req: "modifyPwd",
                        data: user.id + "-/-/-" + SHA256(change)
                    },
                    success: function (data) {
                        if (data == "success")
                        swal.fire({
                            title : '패스워드가 초기화 되었습니다!',
                            icon : 'success',
                            showConfirmButton: true

                        }).then(function (){
                            location.reload();
                        });
                        else
                        swal.fire({
                            title : '서버에러',
                            text : '다음에 다시 시도해주세요',
                            icon : 'error',
                            showConfirmButton: true

                        });
                    }
                })
            }
        })
    }

    var $table = $('#table1');
    function modifyType(){
        var ids=$.map($table.bootstrapTable('getSelections'),function(row){
            return row.name + '(' + row.id + ')';
        });
        var types=$.map($table.bootstrapTable('getSelections'),function(row){
            return row.type;
        });
        if(types != null){
            var type=types[0];
            var size = types.length;
            for(var i = 0; i < size; i++){
                if(type != types[i]){
                    type = '여러 권한이 섞여있습니다.';
                    break;
                }
            }
            $('#modifyTypeHeader').html('<h5 class="modal-title" id="modifyTypeLabel">수정하기</h5><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>');
            $('#modifyTypeBody').html('<div class="form-group"><label for="InputType" style="display :inline-block">선택된 ID</label></div>'+
                '<div class="form-group mb-3">'+ids+' [총'+ids.length+'명]</div>'+
                '<div class="input-group mb-3"><span class="input-group-text" id=InputType">수정전 권한</span><input type="text" class="form-control" value="'+type+'" aria-label="Username" aria-describedby="basic-addon1" readonly></div>'+
                '<div class="input-group"><label class="input-group-text" for="modifyType">수정후 권한</label><select class="form-select" id="modifyType"><option selected>'+types[0]+
                '</option><option value="조교">조교</option><option value="교수">교수</option><option value="학부생">학부생</option></select></div>'+
                '<div class="col-xs-13 text-right"></div>');
            $('#modifyTypeFooter').html('<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button><button class="btn btn-default" onclick="updateType()">권한 수정</button>')
        }
    }

    function updateType(){
        var type = $('#modifyType').val();
        var ids=$.map($table.bootstrapTable('getSelections'),function(row){
            return row.id;
        });

        var id='';
        for(var i=0;i<ids.length;i++){
            id +=ids[i]+"-/-/-"
        }
        var modify= type+"-/-/-"+id;

            swal.fire({
                title: '사용자 권한을 '+type+'으로 수정하시겠습니까?',
                icon: 'warning',
                showConfirmButton: true,
                showCancelButton: true

            }).then((result) => {
                if (result.isConfirmed) {

                    $.ajax({
                        url: "ajax.kgu",
                        type: "post",
                        data: {
                            req: "modifyUserType",
                            data: modify
                        },
                        success: function (data) {
                            if (data == 'success') {
                                swal.fire({
                                    title: '수정되었습니다.',
                                    icon: 'success',
                                    showConfirmButton: true

                                }).then(function () {
                                    location.reload();
                                });
                            } else {
                                swal.fire({
                                    title: '권한이 부족합니다.',
                                    icon: 'error',
                                    showConfirmButton: true

                                });
                            }
                        }
                    });
                }
            })
    }
</script>