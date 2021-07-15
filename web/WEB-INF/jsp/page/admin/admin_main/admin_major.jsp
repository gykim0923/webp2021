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
    <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#staticBackdrop1">전공 추가</button>

    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop1" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel1" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel1">전공 추가하기</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body" id="modalReset">
            <div>전공 아이디 (영문/숫자 혼용 가능) <mark>한번 생성하신 아이디는 수정하실 수 없습니다.</mark></div>
            <input type="text" class="form-control" id="add_major_id" name="new_table" value="" placeholder="major_id">
            <div>전공 이름</div>
            <input type="text" class="form-control" id="add_major_name" name="new_table" value="" placeholder="major_name">
            <div>전공 색상1</div>
            <input type="color" class="form-control" id="add_major_color1" name="new_table" value="" placeholder="major_color1">
            <div>전공 색상2</div>
            <input type="color" class="form-control" id="add_major_color2" name="new_table" value="" placeholder="major_color2">
            <div>전공 색상3</div>
            <input type="color" class="form-control" id="add_major_color3" name="new_table" value="" placeholder="major_color3">

          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            <button type="button" class="btn btn-primary" onclick="addMajor()">추가</button>
          </div>
        </div>
      </div>
    </div>
    <%--modal end--%>
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