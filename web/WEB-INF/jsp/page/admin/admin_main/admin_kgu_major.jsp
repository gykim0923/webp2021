<%--
  Created by IntelliJ IDEA.
  User: ellie
  Date: 2021-08-04
  Time: 오전 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="">
    <label><h2><strong>본전공 관리</strong></h2></label>
    <script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>
    <table class="boardtable" id="table4"  data-toggle="table"
           data-pagination="true" data-toolbar="#toolbar"
           data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
           data-page-list="[10]">
        <thead>
        <tr>
            <th data-field="action">설정</th>
            <th data-field="campus" data-sortable="true">캠퍼스</th>
            <th data-field="college" data-sortable="true">대학</th>
            <th data-field="major" data-sortable="true">학과</th>
        </tr>
        </thead>
    </table>
</div>
<div>
    <!-- Button trigger modal -->
    <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeAddKguMajorModal()">본전공 추가</button>
</div>
<script>
    $(document).ready(function(){
        callSetupTableView4();
    })
    function callSetupTableView4(){
        $('#table4').bootstrapTable('load',tableData4());
        $('#table4').bootstrapTable('refresh');
    }

    function tableData4(){
        var makeAllKguMajor = <%=getAllKGUMajor%>;
        var rows = [];
        for(var i=0;i<makeAllKguMajor.length;i++){
            var kgu_major=makeAllKguMajor[i];
            rows.push({
                campus: kgu_major.campus,
                college: kgu_major.college,
                major: kgu_major.major,
                action : '<button class="btn btn-dark" type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeModifyKguMajorModal('+i+')">수정</button>'
            });
        }
        // alert(rows);
        return rows;
    }

    function makeModifyKguMajorModal(i){ //연동 필요
        var major = <%=getAllKGUMajor%>;

        var modal_header = '';
        modal_header += '<h5 class="modal-title" id="staticBackdropLabel">수정하기</h5>';
        modal_header += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';

        var modal_body = '';
        modal_body += '<div>캠퍼스</div><input type="text" class="form-control" id="campus" name="new_table" value="'+(major[i].campus)+'" placeholder="campus">'
            +'<div>대학</div><input type="text" class="form-control" id="college" name="new_table" value="'+(major[i].college)+'" placeholder="college">'
            +'<div>학과</div><input type="text" class="form-control" id="major" name="new_table" value="'+(major[i].major)+'" placeholder="major">';

        var modal_footer = '';
        modal_footer += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" onclick="deleteKguMajor('+i+')">본전공삭제</button>';
        modal_footer += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>';  //<button type="button" class="btn btn-dark" data-dismiss="modal">Close</button>
        modal_footer += '<button type="button" class="btn btn-secondary pull-right" data-dismiss="modal" aria-label="Close" onclick="modifyKguMajor('+i+')">완료</button>';


        header.html(modal_header);
        body.html(modal_body);
        footer.html(modal_footer);
    }

    function modifyKguMajor(i){
        var campus=$('#campus').val();
        var college=$('#college').val();
        var kguMajor=$('#major').val();
        var data = kguMajor+'-/-/-'+campus+'-/-/-'+college+'-/-/-'+(i+1);

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "modifyKguMajor", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if(data=='success'){
                    swal.fire({
                        title : '수정되었습니다.',
                        icon : 'success',
                        showConfirmButton: true

                    }).then(function (){
                        location.reload();
                    });
                }
                else{
                    swal.fire({
                        title : '권한이 부족합니다.',
                        icon : 'warning',
                        showConfirmButton: true

                    });
                }
            }
        })
    }


    function makeAddKguMajorModal(){
        var modal_header = '';
        modal_header += '<h5 class="modal-title" id="staticBackdropLabel">본전공 추가하기</h5>';
        modal_header += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';

        var modal_body = '';
        modal_body += '<div>캠퍼스</div><input type="text" class="form-control" id="add_campus" name="new_table" value="" placeholder="캠퍼스이름을 입력해주세요">'
            + '<div>대학</div><input type="text" class="form-control" id="add_college" name="new_table" value="" placeholder="대학을 입력해주세요">'
            + '<div>학과</div><input type="text" class="form-control" id="add_major" name="new_table" value="" placeholder="학과이름을 입력해주세요">';

        var modal_footer = '';
        modal_footer += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>';  //<button type="button" class="btn btn-dark" data-dismiss="modal">Close</button>
        modal_footer += '<button type="button" class="btn btn-secondary" onclick="addKguMajor()">추가</button>';

        header.html(modal_header);
        body.html(modal_body);
        footer.html(modal_footer);
    }

    function addKguMajor(){
        var campus=$('#add_campus').val();
        var college=$('#add_college').val();
        var kgumajor = $('#add_major').val();
        var data= campus +'-/-/-'+college+'-/-/-'+kgumajor;

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "addKguMajor", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if(data=='success'){
                    swal.fire({
                        title : '해당 전공이 추가되었습니다.',
                        icon : 'success',
                        showConfirmButton: true
                    }).then(function (){
                        location.reload();
                    });
                }

                else{
                    swal.fire({
                        title : '권한이 부족합니다.',
                        icon : 'warning',
                        showConfirmButton: true

                    });
                }
            }
        })
    }

    function deleteKguMajor(i){
        var check = confirm("정말 삭제하시겠습니까?");
        var kgumajor = $('#major').val();
        if(check){
            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "delete_kgu_major",
                    data : kgumajor
                },
                success : function(data) {
                    if(data == 'fail'){
                        alert('fail');
                        return;
                    }
                    alert("삭제가 완료되었습니다");
                    location.reload();
                }
            });
        }
    }

</script>