<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-15
  Time: 오후 2:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
</style>
<div class="">
  <label><h2><strong>부전공 관리 (홈페이지 하위 전공 관련)</strong></h2></label>
  <script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>
  <table class="boardtable" id="table1"  data-toggle="table"
         data-pagination="true" data-toolbar="#toolbar"
         data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
         data-page-list="[10]">
    <thead>
    <tr>
      <th data-field="action">설정</th>
      <th data-field="major_id" data-sortable="true">전공아이디</th>
      <th data-field="major_name" data-sortable="true">전공이름</th>
      <th data-field="major_location" data-sortable="true">학과위치</th>
      <th data-field="major_contact" data-sortable="true">학과연락처</th>
    </tr>
    </thead>
  </table>
</div>
<div class="py-2 d-flex justify-content-end">
  <!-- Button trigger modal -->
  <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeAddMajorModal()">전공 추가</button>
</div>
<script>
  $(document).ready(function(){
    callSetupTableView1();
  })
  function callSetupTableView1(){
    $('#table1').bootstrapTable('load',tableData1());
    $('#table1').bootstrapTable('refresh');
  }

  function tableData1(){
    var makeAllMajor = <%=getAllMajor%>;
    var rows = [];
    for(var i=0;i<makeAllMajor.length;i++){
      var major=makeAllMajor[i];
      rows.push({
        major_id: major.major_id,
        major_name: major.major_name,
        major_location: major.major_location,
        major_contact: major.major_contact,
        action : '<button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeModifyMajorModal('+i+')">수정</button><br><button type="button" class="btn btn-danger" data-bs-dismiss="modal" onclick="deleteMajor('+i+')">삭제</button></div>'
      });
    }
    // alert(rows);
    return rows;
  }

  function makeModifyMajorModal(i){ //연동 필요
    var major = <%=getAllMajor%>;
    // var major = getMajor[i];
    // var major_id = major.major_id;
    // var major_name = major.major_name;
    // var major_location = major.major_location;
    // var major_contact = major.major_contact;

    var modal_header = '';
    modal_header += '<h5 class="modal-title" id="staticBackdropLabel">수정하기</h5>';
    modal_header += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';

    var modal_body = '';
    modal_body += '<div>전공이름</div><input type="text" class="form-control" id="modify_major_name" name="new_table" value="'+(major[i].major_name)+'" placeholder="major_name">'
            +'<div>학과위치</div><input type="text" class="form-control" id="major_location" name="new_table" value="'+(major[i].major_location)+'" placeholder="major_loction">'
            +'<div>학과연락처</div><input type="text" class="form-control" id="major_contact" name="new_table" value="'+(major[i].major_contact)+'" placeholder="major_contact">';

    var modal_footer = '';
    modal_footer += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>';  //<button type="button" class="btn btn-dark" data-dismiss="modal">Close</button>
    modal_footer += '<button type="button" class="btn btn-primary pull-right" data-dismiss="modal" aria-label="Close" onclick="modifyMajor('+i+')">완료</button>';

    header.html(modal_header);
    body.html(modal_body);
    footer.html(modal_footer);
  }

  function modifyMajor(i){
    var major = <%=getAllMajor%>;
    var target_oid=major[i].oid;
    // var major_id=$('#modify_major_id').val();
    var major_name=$('#modify_major_name').val();
    var major_location=$('#major_location').val();
    var major_contact=$('#major_contact').val();
    var data=target_oid+'-/-/-'+major_name+'-/-/-'+major_location+'-/-/-'+major_contact;


      $.ajax({
        url: "ajax.kgu", //AjaxAction에서
        type: "post", //post 방식으로
        data: {
          req: "modifyMajor", //이 메소드를 찾아서
          data: data //이 데이터를 파라미터로 넘겨줍니다.
        },
        success: function (data) { //성공 시
          if(data=='success'){
            swal.fire({
              title : '해당 전공이 수정되었습니다.',
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


  function makeAddMajorModal(){
    var modal_header = '';
    modal_header += '<h5 class="modal-title" id="staticBackdropLabel">전공 추가하기</h5>';
    modal_header += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';

    var modal_body = '';
    modal_body += '<div>전공 아이디 (영문/숫자 혼용 가능) </div><mark>한번 생성하신 아이디는 수정하실 수 없습니다.</mark></div></div>'
      + '<input type="text" class="form-control" id="add_major_id" name="new_table" value="" placeholder="전공아이디를 입력해주세요">'
      + '<div>전공이름</div><input type="text" class="form-control" id="add_major_name" name="new_table" value="" placeholder="전공이름을 입력해주세요">'
      + '<div>학과위치</div><input type="text" class="form-control" id="add_major_location" name="new_table" value="" placeholder="학과위치를 입력해주세요">'
      + '<div>학과연락처</div><input type="text" class="form-control" id="add_major_contact" name="new_table" value="" placeholder="학과연락처를 입력해주세요">';

    var modal_footer = '';
    modal_footer += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>';  //<button type="button" class="btn btn-dark" data-dismiss="modal">Close</button>
    modal_footer += '<button type="button" class="btn btn-success" onclick="addMajor()">추가</button>';

    header.html(modal_header);
    body.html(modal_body);
    footer.html(modal_footer);
  }

  function addMajor(){
    var major_id=$('#add_major_id').val();
    var major_name=$('#add_major_name').val();
    var major_location=$('#add_major_location').val();
    var major_contact=$('#add_major_contact').val();
    var data=major_id+'-/-/-'+major_name+'-/-/-'+major_location+'-/-/-'+major_contact;

      $.ajax({
          url: "ajax.kgu", //AjaxAction에서
          type: "post", //post 방식으로
          data: {
            req: "addMajor", //이 메소드를 찾아서
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
                title : '아이디가 중복됩니다.',
                icon : 'warning',
                showConfirmButton: true
              });
            }
          }
        })
    }

  function deleteMajor(i){
    var major = <%=getAllMajor%>;

    if(major[i].major_id == 'main') {
      swal.fire({
        title: 'main은 삭제할 수 없습니다.',
        icon: 'warning',
        showConfirmButton: true
      });
    } else{
      var target_id=major[i].major_id;
      swal.fire({
        title: "정말 삭제하시겠습니까?",
        icon: 'warning',
        showConfirmButton: true,
        showCancelButton: true
      }).then((result) => {
        if (result.isConfirmed) {
        $.ajax({
          url: "ajax.kgu",
          type: "post",
          data: {
            req: "delete_major",
            data: target_id
          },
          success: function (data) {
            if (data == 'fail') {
              alert('fail');
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
  }
</script>