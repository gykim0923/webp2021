<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-15
  Time: 오후 2:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="">
  <label><h2><strong>전공 관리</strong></h2></label>
  <div>
    <!-- Button trigger modal -->
    <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeAddMajorModal()">전공 추가</button>
  </div>

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
        oid: major.oid,
        major_id: major.major_id,
        major_name: major.major_name,
        major_color1: major.major_color1,
        major_color2: major.major_color2,
        major_color3: major.major_color3,
        action : '<button class="btn btn-dark" type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeModifyMajorModal('+i+')">수정</button>'
      });
    }
    // alert(rows);
    return rows;
  }

  function makeModifyMajorModal(i){
    var header = '';
    header += '<h5 class="modal-title" id="staticBackdropLabel">수정하기</h5>';
    header += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';

    var body = '';
    body += '<div>전공 이름</div><input type="text" class="form-control" id="modify_major_name" name="new_table" value="" placeholder="major_name">'
            +'<div>전공 색상1</div><input type="color" class="form-control" id="modify_major_color1" name="new_table" value="" placeholder="major_color1">'
            +'<div>전공 색상2</div><input type="color" class="form-control" id="modify_major_color2" name="new_table" value="" placeholder="major_color2">'
            +'<div>전공 색상3</div><input type="color" class="form-control" id="modify_major_color3" name="new_table" value="" placeholder="major_color3">';

    var footer = '';
    footer += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>';  //<button type="button" class="btn btn-dark" data-dismiss="modal">Close</button>
    footer += '<button type="button" class="btn btn-secondary pull-right" data-dismiss="modal" aria-label="Close" onclick="modifyMajor('+i+')">완료</button>';

    header.html(header);
    body.html(body);
    footer.html(footer);
  }

  function modifyMajor(i){
    var major = <%=getAllMajor%>;
    var target_oid=major[i].oid;
    // var major_id=$('#modify_major_id').val();
    var major_name=$('#modify_major_name').val();
    var major_color1=$('#modify_major_color1').val();
    var major_color2=$('#modify_major_color2').val();
    var major_color3=$('#modify_major_color3').val();
    // var data=target_id+'-/-/-'+major_id+'-/-/-'+major_name+'-/-/-'+major_color1+'-/-/-'+major_color2+'-/-/-'+major_color3;
    var data=target_oid+'-/-/-'+major_name+'-/-/-'+major_color1+'-/-/-'+major_color2+'-/-/-'+major_color3;
    var check = confirm("전공 "+data+"를 수정하시겠습니까?");
    if (check) {
      $.ajax({
        url: "ajax.kgu", //AjaxAction에서
        type: "post", //post 방식으로
        data: {
          req: "modifyMajor", //이 메소드를 찾아서
          data: data //이 데이터를 파라미터로 넘겨줍니다.
        },
        success: function (data) { //성공 시
          if(data=='success'){
            alert("해당 전공이 수정되었습니다.");
            location.reload();
          }
          else{
            alert('권한이 부족합니다.');
          }
        }
      })
    }
  }

  function makeAddMajorModal(){
    var h = '';
    h += '<h5 class="modal-title" id="staticBackdropLabel">전공 추가하기</h5>';
    h += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';

    var b = '';
    b += '<div>전공 아이디 (영문/숫자 혼용 가능) <mark>한번 생성하신 아이디는 수정하실 수 없습니다.</mark></div>'
      + '<input type="text" class="form-control" id="add_major_id" name="new_table" value="" placeholder="major_id">'
      + '<div>전공 이름</div><input type="text" class="form-control" id="add_major_name" name="new_table" value="" placeholder="major_name">'
      + '<div>전공 색상1</div><input type="color" class="form-control" id="add_major_color1" name="new_table" value="" placeholder="major_color1">'
      + '<div>전공 색상2</div><input type="color" class="form-control" id="add_major_color2" name="new_table" value="" placeholder="major_color2">'
      + '<div>전공 색상3</div><input type="color" class="form-control" id="add_major_color3" name="new_table" value="" placeholder="major_color3">';

    var f = '';
    f += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>';  //<button type="button" class="btn btn-dark" data-dismiss="modal">Close</button>
    f += '<button type="button" class="btn btn-secondary" onclick="addMajor()">추가</button>';

    header.html(h);
    body.html(b);
    footer.html(f);
  }

  function addMajor(){
    var major_id=$('#add_major_id').val();
    var major_name=$('#add_major_name').val();
    var major_color1=$('#add_major_color1').val();
    var major_color2=$('#add_major_color2').val();
    var major_color3=$('#add_major_color3').val();
    var data=major_id+'-/-/-'+major_name+'-/-/-'+major_color1+'-/-/-'+major_color2+'-/-/-'+major_color3;
    var check = confirm("전공 "+data+"를 추가하시겠습니까?");
    if (check) {
      $.ajax({
        url: "ajax.kgu", //AjaxAction에서
        type: "post", //post 방식으로
        data: {
          req: "addMajor", //이 메소드를 찾아서
          data: data //이 데이터를 파라미터로 넘겨줍니다.
        },
        success: function (data) { //성공 시
          if(data=='success'){
            alert("해당 전공이 추가되었습니다.");
            location.reload();
          }
          else{
            alert('권한이 부족합니다.');
          }
        }
      })
    }
  }
</script>