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
<script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>
<div>
    <div class="text-danger text-end mb-3">이 페이지는 가로 길이 800px 이상의 화면에서 최적화 되어있습니다.</div>
    <div class="album">
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
                    <th data-field="show_detail" data-sortable="true" data-bs-toggle="modal" data-bs-target="#menuModal">설정</th>
                </tr>
                </thead>
            </table>
            <div class="py-2 d-flex justify-content-end"></div>
                <div id="inoutbtn">
                    <button class="btn btn-success mx-2" data-bs-toggle="modal" data-bs-target="#staticBackdrop2" onclick="insertMenu()">메뉴 추가</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">메뉴 이름 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id = "myModalbody"></div>
        </div>
    </div>
</div>

<div class="modal fade" id="staticBackdrop2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel2">메뉴 추가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id = "insertModalbody"></div>
            <div class="modal-body" id = "insertModalbody2"></div>
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
                        typeName = "공지사항/게시판";
                    }
                    else{
                        typeName = "ETC";
                    }
                    rows.push({
                        index: indexID,
                        page_title: value.page_title,
                        type: typeName,
                        tab_title: headvalue.tab_title,
                        show_detail: '<button class="btn btn-primary mx-2" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="detailModal('+i+')">수정</button>&nbsp<button type="button" class="btn btn-danger" data-dismiss="modal" aria-label="Close" onclick="deleteProModal('+menulist[i].page_id+')">삭제</button>'
                    });
                    indexID++;
            }
        }
        return rows;
    }

    function detailModal(i) {
        var list = $('#myModalbody');
        var a = '';
        a+='<div class="form-group"><span>메뉴 이름 </span><input style="display : inline-block; width:200px;" type="text" class="form-control" name = "title" value="'+(menulist[i].page_title)+'"></div><br>';

        a += '<button type="button" class="btn btn-primary pull-right my-2" data-dismiss="modal" aria-label="Close" onclick="modifyProModal('+menulist[i].page_id+')">완료</button>';
        list.html(a);
    }

    function modifyProModal(id){
        var name = $('[name=title]').val();
        if(name.length>=25){
            swal.fire({
                title : '이름이 너무 깁니다!',
                icon : 'warning',
                showConfirmButton: true

            });
            return;
        }
        if(name.length==0){
            swal.fire({
                title : '이름을 한 글자 이상 입력해주세요.',
                icon : 'warning',
                showConfirmButton: true

            });

            return;
        }

        var update = name + "-/-/-" + id;


            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "modify_menu",
                    data : update
                },
                success : function(data) {
                    if(data == 'fail'){

                        swal.fire({
                            title : '하나 밖에 존재하지 않는 메뉴에요. 아껴주세요.',
                            icon : 'warning',
                            showConfirmButton: true

                        });
                        return;
                    }
                    swal.fire({
                        title : '수정이 완료되었습니다.',
                        icon : 'success',
                        showConfirmButton: true

                    }).then(function (){
                        location.reload();
                    });
                }
            });
        }


    function deleteProModal(id) {
        swal.fire({
            title: '정말로 삭제하시나요?',
            text: '다시 되돌릴 수 없습니다.',
            icon: 'warning',
            showConfirmButton: true,
            showCancelButton: true

        }).then((result) => {
            if (result.isConfirmed) {

                $.ajax({
                    url: "ajax.kgu",
                    type: "post",
                    data: {
                        req: "delete_menu",
                        data: id
                    },
                    success: function (data) {
                        if (data == 'fail') {

                            swal.fire({
                                title: '하나 밖에 존재하지 않는 메뉴에요. 아껴주세요.',
                                icon: 'warning',
                                showConfirmButton: true

                            });
                            return;
                        }

                        swal.fire({
                            title: '삭제가 완료되었습니다.',
                            icon: 'success',
                            showConfirmButton: true

                        }).then(function () {
                            location.reload();
                        });
                    }
                });
            }
        })
    }

    //     var check = confirm("정말 삭제하시겠습니까?");
    //     if(check){
    //         $.ajax({
    //             url : "ajax.kgu",
    //             type : "post",
    //             data : {
    //                 req : "delete_menu",
    //                 data : id
    //             },
    //             success : function(data) {
    //                 if(data == 'fail'){
    //
    //                     swal.fire({
    //                         title : '하나 밖에 존재하지 않는 메뉴에요. 아껴주세요.',
    //                         icon : 'warning',
    //                         showConfirmButton: true
    //
    //                     });
    //                     return;
    //                 }
    //
    //                 swal.fire({
    //                     title : '삭제가 완료되었습니다.',
    //                     icon : 'success',
    //                     showConfirmButton: true
    //
    //                 }).then(function (){
    //                     location.reload();
    //                 });
    //             }
    //         });
    //     }
    // }

    function insertMenu(){
        var list = $('#insertModalbody');
        var a = '';
        a += '<div class="form-group"><span>메뉴 타입 :</span><select onchange="selectType()" style="display : inline-block; width:200px;" class="form-control" name="menutype">'
        a += '<option value="default">선택해주세요</option><option value="static">소개</option><option value="bbs">공지</option>'
        a += '<option value="independent">세부전공 메뉴</option>';
        a += '</div><br>'

        list.html(a);
    }

    function selectType(){
        var list=$('#insertModalbody2');
        list.empty();
        var val = $('[name=menutype]').val();
        var a = '';
        if(val=='static'){
            a += '<div class="form-group"><span>메뉴 이름 </span><input style="display : inline-block; width:200px;" type="text" class="form-control" name = "title"></div><br>'
            a+='<button type="button" class="btn btn-success pull-right my-2" data-dismiss="modal" aria-label="Close" onclick="insertMenuFinish()">완료</button>';
            list.html(a);
        }else if(val=='independent'){
        a += '<div class="form-group"><span>메뉴 이름 </span><input style="display : inline-block; width:200px;" type="text" class="form-control" name = "title"></div><br>'
        a+='<button type="button" class="btn btn-success pull-right my-2" data-dismiss="modal" aria-label="Close" onclick="insertIndependent()">완료</button>';
        list.html(a);
     }else if(val=='bbs') {
            a += '<div class="form-group"><span>메뉴 이름 </span><input style="display : inline-block; width:200px;" type="text" class="form-control" name = "title"></div><br>'
            a += '<button type="button" class="btn btn-success pull-right my-2" data-dismiss="modal" aria-label="Close" onclick="insertBBSFinish()">완료</button>';
            list.html(a);
        }
    }

    function insertMenuFinish(){
        var name = $('[name=title]').val();
        if(name.length>=25){

            swal.fire({
                title : '이름이 너무 깁니다!',
                icon : 'warning',
                showConfirmButton: true

            });
            return;
        }
        if(name.length==0){

            swal.fire({
                title : '이름을 입력해주세요.',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        var insert = name;

            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "insert_menu",
                    data : insert
                },
                success : function(data) {

                    swal.fire({
                        title : '추가가 완료되었습니다.',
                        icon : 'success',
                        showConfirmButton: true

                    }).then(function (){
                        location.reload();
                    });
                }
            });
        }


    function insertBBSFinish(){
        var name = $('[name=title]').val();
        if(name.length>=25){

            swal.fire({
                title : '이름이 너무 깁니다!',
                icon : 'warning',
                showConfirmButton: true
            });

            return;
        }
        if(name.length==0){

            swal.fire({
                title : '이름을 입력해주세요.',
                icon : 'warning',
                showConfirmButton: true
            });

            return;
        }
        var insert = name;

            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "insert_notice_menu",
                    data : insert
                },
                success : function(data) {
                    swal.fire({
                        title : '추가가 완료되었습니다.',
                        icon : 'success',
                        showConfirmButton: true

                    }).then(function (){
                        location.reload();
                    });
                }
            });
        }


    function insertIndependent(){
        var name = $('[name=title]').val();
        if(name.length>=25){

            swal.fire({
                title : '이름이 너무 깁니다!',
                icon : 'warning',
                showConfirmButton: true

            });
            return;
        }
        if(name.length==0){

            swal.fire({
                title : '이름을 입력해주세요.',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        var insert = name;

        $.ajax({
            url : "ajax.kgu",
            type : "post",
            data : {
                req : "insert_independent",
                data : insert
            },
            success : function(data) {

                swal.fire({
                    title : '추가가 완료되었습니다.',
                    icon : 'success',
                    showConfirmButton: true

                }).then(function (){
                    location.reload();
                });
            }
        });
    }

</script>