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
    <button type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop" class="btn btn-secondary" onclick="insertSch()">추가</button>
    <button type="button" class="btn btn-secondary" onclick="updateSch()">갱신</button>
  </div>
</div>
<!-- Modal -->
<%--<div class="modal fade" id="insertSchedule" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">--%>
<%--  <div class="modal-dialog">--%>
<%--    <div class="modal-content">--%>
<%--      <div class="modal-header">--%>
<%--        <h5 class="modal-title" id="">일정관리</h5> &lt;%&ndash;staticBackdropLabel&ndash;%&gt;--%>
<%--        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
<%--      </div>--%>
<%--      <div class="modal-body" id="schModalbody"> &lt;%&ndash;staticBackdropLabel&ndash;%&gt;--%>
<%--      </div>--%>
<%--      <div class="modal-footer">--%>
<%--        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>--%>
<%--        <button type="button" class="btn btn-secondary" onclick="modalReset()">완료</button>--%>
<%--      </div>--%>
<%--    </div>--%>
<%--  </div>--%>
<%--</div>--%>
<%--일정 추가 모달 끝--%>

<script>
  function tableData2(){
    var getSchedule = <%=getSchedule%>;
    var rows = [];
    for(var i=0;i<getSchedule.length;i++){
      var schedule=getSchedule[i];
      rows.push({
        id: schedule.id,
        date: schedule.date,
        content: schedule.content,
        action : '<button class="btn btn-dark" type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="modifySchedule('+i+')">수정</button>'
      });
    }
    return rows;
  }

  function modifySchedule(i){
    var getSchedule = <%=getSchedule%>;
    var schedule = getSchedule[i];
    alert(schedule.date +" "+schedule.content);

    var h = '';
    h += '<h5 class="modal-title" id="staticBackdropLabel">수정하기</h5>';
    h += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';

    var b = '';
    b += '<div><label for="InputDate">날짜</label><input class="form-control" id="InputDate" type="date" name="schDate" value="'+formatDate(schedule.date)+'"></div>';
    b += '<br><div><input class="form-control" id="content" value="'+schedule.content+'"></div>';

    var f = '';
    f += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>';
    f += '<button type="button" class="btn btn-secondary" onclick="modalReset()">완료</button>';

    header.html(h);
    body.html(b);
    footer.html(f);
  }

  function insertSch(){
    var h = '';
    h += '<h5 class="modal-title" id="">일정관리</h5>';
    h += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';

    var b = '';
    b += '<div><label for="InputDate">날짜</label><input class="form-control" id="InputDate" type="date" name="schDate" value="' + formatDate(new Date()) + '"></div>';
    b += '<br><div><input class="form-control" id="content" placeholder="내용을 입력해주세요"></div>';

    var f = '';
    f += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>';
    f += '<button type="button" class="btn btn-secondary" onclick="modalReset()">완료</button>';

    header.html(h);
    body.html(b);
    footer.html(f);
  }

  function formatDate(date) {
    var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
  }
</script>