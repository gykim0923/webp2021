<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-15
  Time: 오후 2:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="">
  <%--일정 관리--%>
  <label><h2><strong>일정 관리</strong></h2></label>
  <table class="boardtable" id="table2"  data-toggle="table"
         data-pagination="true" data-toolbar="#toolbar"
         data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
         data-page-list="[10]">
    <thead>
    <tr>
      <th data-field="action">설정</th>
      <th data-field="date" data-sortable="true">date</th>
      <th data-field="content" data-sortable="true">content</th>
    </tr>
    </thead>
  </table>
  <div class="d-grid gap-2 d-md-flex justify-content-md-end"> <div class="col-md-10"></div>
    <button type="button" data-bs-toggle="modal" data-bs-target="#insertSchedule" class="btn btn-secondary" onclick="insertSch()">추가</button>
    <button type="button" class="btn btn-secondary" onclick="updateSch()">갱신</button>
  </div>
</div>
<!-- Modal -->
<div class="modal fade" id="insertSchedule" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="">일정관리</h5> <%--staticBackdropLabel--%>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="schModalbody"> <%--staticBackdropLabel--%>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-secondary" onclick="modalReset()">완료</button>
      </div>
    </div>
  </div>
</div>
<%--일정 추가 모달 끝--%>
