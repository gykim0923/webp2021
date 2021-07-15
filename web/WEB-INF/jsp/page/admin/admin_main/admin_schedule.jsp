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

<script>
  function tableData2(){
    var getSchedule = <%=getSchedule%>;
    var rows = [];
    for(var i=0;i<getSchedule.length;i++){
      var schedule=getSchedule[i];
      rows.push({
        id: schedule.id,
        date: formatDate(schedule.date),
        content: schedule.content,
        action : '<button class="btn btn-dark" type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="modifyScheduleModal('+i+')">수정</button> ' +
                '<button class="btn btn-dark" type="button" onclick="deleteSchedule('+i+')">삭제</button>'
      });
    }
    return rows;
  }

  function modifyScheduleModal(i){
    var getSchedule = <%=getSchedule%>;
    var schedule = getSchedule[i];
    alert(schedule.date +" "+schedule.content);

    var h = '';
    h += '<h5 class="modal-title" id="staticBackdropLabel">수정하기</h5>';
    h += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';

    var b = '';
    b += '<div><label for="newSchDate">날짜</label><input class="form-control" id="newSchDate" type="date" name="newSchDate" value="'+formatDate(schedule.date)+'"></div>';
    b += '<br><div><input class="form-control" id="newSchContent" name="newSchContent" value="'+schedule.content+'"></div>';

    var f = '';
    f += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>';
    f += '<button type="button" class="btn btn-secondary" onclick="modifySchedule('+i+')">완료</button>';

    header.html(h);
    body.html(b);
    footer.html(f);
  }

  function modifySchedule(i){
    var getSchedule = <%=getSchedule%>;
    var schedule = getSchedule[i];
    var schedule_id = schedule.id;
    var schedule_date = $('[name = newSchDate]').val();
    var schedule_content = $('[name = newSchContent]').val();

    var data=schedule_id+'-/-/-'+schedule_date+'-/-/-'+schedule_content;
    var check = confirm("일정 "+data+"를 수정하시겠습니까?");
    if (check) {
      $.ajax({
        url: "ajax.kgu", //AjaxAction에서
        type: "post", //post 방식으로
        data: {
          req: "modifySchedule", //이 메소드를 찾아서
          data: data //이 데이터를 파라미터로 넘겨줍니다.
        },
        success: function (data) { //성공 시
          if(data=='success'){
            alert("해당 일정이 수정되었습니다.");
            location.reload();
          }
          else{
            alert('권한이 부족합니다.');
          }
        }
      })
    }
  }

  function insertSch(){
    var h = '';
    h += '<h5 class="modal-title" id="">일정관리</h5>';
    h += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';

    var b = '';
    b += '<div><label for="InputDate">날짜</label><input class="form-control" id="InputDate" type="date" name="schDate" value="' + formatDate(new Date()) + '"></div>';
    b += '<br><div><input class="form-control" id="schContent" name="schContent" placeholder="내용을 입력해주세요"></div>';

    var f = '';
    f += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>';
    f += '<button type="button" class="btn btn-secondary" onclick="addSchedule()">완료</button>';

    header.html(h);
    body.html(b);
    footer.html(f);
  }

  function addSchedule(){
    var schedule_date = $('[name = schDate]').val();
    var schedule_content = $('[name = schContent]').val();

    var data = schedule_date+'-/-/-'+schedule_content;
    var check = confirm("일정 "+data+"를 추가하시겠습니까?");
    if (check) {
      $.ajax({
        url: "ajax.kgu", //AjaxAction에서
        type: "post", //post 방식으로
        data: {
          req: "addSchedule", //이 메소드를 찾아서
          data: data //이 데이터를 파라미터로 넘겨줍니다.
        },
        success: function (data) { //성공 시
          if(data=='success'){
            alert("해당 일정이 추가되었습니다.");
            location.reload();
          }
          else{
            alert('권한이 부족합니다.');
          }
        }
      })
    }
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

  function updateSch(){
    $.ajax({
      url:"ajax.kgu",
      type:"post",
      data : {
        req : "updateSchedule",
      },
      success : function(data){
        if(data=='success'){
          alert("일정 갱신이 완료되었습니다.");
          location.reload();
        }
        else{
          alert('권한이 부족합니다.');
        }
      }
    })
  }

  function deleteSchedule(i){
    var getSchedule = <%=getSchedule%>;
    var schedule = getSchedule[i];
    var schedule_id = schedule.id;
    var schedule_date = schedule.date;
    var schedule_content = schedule.content;
    var data = schedule_id+'-/-/-'+schedule_date+'-/-/-'+schedule_content;

    var check = confirm("일정 "+data+"를 삭제하시겠습니까?");
    if (check) {
      $.ajax({
        url: "ajax.kgu", //AjaxAction에서
        type: "post", //post 방식으로
        data: {
          req: "deleteSchedule", //이 메소드를 찾아서
          data: data //이 데이터를 파라미터로 넘겨줍니다.
        },
        success: function (data) { //성공 시
          if(data=='success'){
            alert("해당 일정이 삭제되었습니다.");
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