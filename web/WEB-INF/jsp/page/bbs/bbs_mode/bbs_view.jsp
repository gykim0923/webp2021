<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-19
  Time: 오후 6:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String getBBS = (String) request.getAttribute("getBBS");
  String getComment = (String) request.getAttribute("getComments");
  String userForBbs_view = (String)session.getAttribute("user");
%>
<div>
  <div class="h2" id="view_title"></div>
  <hr>
  <div id="view_content"></div>
  <hr>
  <c:if test="${user.type != null}">
    <div id="view_likes">
      <i class="bi bi-hand-thumbs-up" onclick="liked()"></i>
    </div>
  </c:if>

<%--    댓글리스트--%>
    <div>
      <table class="commnetstable" id="table1"  data-toggle="table"
             data-pagination="true" data-toolbar="#toolbar"
             data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
             data-page-list="[10]">
        <thead>
        <tr>
          <th data-field="writer_name" data-sortable="true">이름</th>
          <th data-field="comment" data-sortable="true">댓글</th>
          <th data-field="comment_date" data-sortable="true">등록일자</th>
        </tr>
        </thead>
      </table>
    </div>

<%--  댓글 입력 창--%>
  <c:if test="${user != null}">
    <hr>
    <div class="my-2">댓글</div>
    <div class="input-group mb-3">
    <input type="text" class="form-control" id="commentInput" placeholder="comment" aria-label="comment" aria-describedby="button-addon2">
    <div class="input-group-append">
    <button class="btn btn-outline-secondary" type="button" id="commentButton" onClick="insertComment()"> 쓰기 </button>
    </div></div>
  </c:if>

  <hr>
  <div>
    <div id="list_button"></div>
    <div id="modify_button"></div>
    <div id="delete_button"></div>
  </div>
</div>

<script>

  $(document).ready(function(){
    makeViewTitle();
    makeViewContent();
    makeViewButtons();
    callSetupCommentView();
    // makeCommentButton();
  })
  var major = <%=major%>;
  var num = <%=num%>;
  var id = <%=id%>;
  var type = <%=type%>;
  var user = <%=userForBbs_view%>;
  function callSetupCommentView(){
      $('#table1').bootstrapTable('load',tableData());
      // $('#table1').bootstrapTable('append',data());
      $('#table1').bootstrapTable('refresh');
  }

  function formatDate(date) {  //주어진 날짜를 yyyy-mm-dd 형식으로 반환해주는 함수
    var d = new Date(date),
    month = '' + (d.getMonth() + 1),
   day = '' + d.getDate(),
   year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
  }

  function insertComment(){
    var comment = $('#commentInput').val();
    var user_id = user.id;
    var user_name = user.name;
    var comment_date = formatDate(new Date());
    var data = user_id+"-/-/-"+user_name+"-/-/-"+comment+"-/-/-"+comment_date+"-/-/-"+id;
      $.ajax({
        url: "ajax.kgu", //AjaxAction에서
        type: "post", //post 방식으로
        data: {
          req: "insertComment", //이 메소드를 찾아서
          data: data //이 데이터를 파라미터로 넘겨줍니다.
        },
        success: function (data) { //성공 시
            location.reload();
        }
      })
  }

  function tableData(){
      var commentsList = <%=getComment%>;
      var rows = [];
      if(commentsList != null){
          for(var i=0;i< commentsList.length;i++){
              var comment = commentsList[i];
              rows.push({
                  writer_name: comment.writer_name,
                  comment: comment.comment,
                  comment_date: comment.comment_date,
              });
          }
      }
      return rows;
  }
  var getBBS = <%=getBBS%>;
  function makeViewTitle() {
    var content = $('#view_title');
    content.append(getBBS.title);
  }
  function makeViewContent() {
    var content = $('#view_content');
    content.append(getBBS.text);
  }

  function makeViewButtons() {
    var list_button = $('#list_button');
    var listUrl = 'bbs.kgu?major='+major+'&&num='+num+'&&mode=list';
    var modifyUrl = 'bbs.kgu?major='+major+'&&num='+num+'&&mode=modify&&id='+id;
    var text = '';
    text+='<a href="'+listUrl+'"><div class="btn btn-secondary">목록</div></a>'
    if(num == "20" || num == "21" || num == "22" || num == "23"){
      if(type.board_level == 0 || type.board_level == 1){
        text += '<a href="'+modifyUrl+'"><div class="btn btn-secondary">수정</div></a>'
                + '<a onclick="deleteBbs()"><div class="btn btn-secondary">삭제</div></a>'
      }
    }
    list_button.append(text);
  }

  function liked(){
    var data = <%=getBBS%>.id;
    var view_likes = $('#view_likes');
    var text = '';


    $.ajax({
      url : 'ajax.kgu',
      type : 'post',
      data : {
        req : 'likeBoard',
        data : data
      },
      success : function(data){
        if(data == 'success'){
          text+='<i class="bi bi-hand-thumbs-up-fill"></i>'
          view_likes.html(text)
          alert('추천 성공');
          location.reload();
        }else if(data == 'already'){
          alert('이미 추천한 글입니다');
        }else{
          alert('SERVER ERROR, Please try again later...');
        }
      }
    });
  }


  function deleteBbs(){
    var getBBS = <%=getBBS%>;
    var id = getBBS.id;
    var title = getBBS.title;
    var writer_id = getBBS.writer_id;
    var writer_name = getBBS.writer_name;
    var last_modified = getBBS.last_modified;
    var data = id+"-/-/-"+major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+last_modified;

    var check = confirm(data+"를 삭제하시겠습니까?");
    if (check) {
      $.ajax({
        url: "ajax.kgu", //AjaxAction에서
        type: "post", //post 방식으로
        data: {
          req: "deleteBbs", //이 메소드를 찾아서
          data: data //이 데이터를 파라미터로 넘겨줍니다.
        },
        success: function (data) { //성공 시
          if(data=='success'){
            alert("해당 내용이 삭제되었습니다.");
            window.location.href = 'bbs.kgu?major=' + major + '&&num=' + num + '&&mode=list';
          }
          else{
            alert('권한이 부족합니다.');
          }
        }
      })
    }
  }
</script>


