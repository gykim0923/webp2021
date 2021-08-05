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
%>
<script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>
<div>
  <div class="h2" id="view_title"></div>
  <hr>
  <div class="container">
    <div class="row">
      <div class=" col-xl-7 col-4" id="view_writer"></div>
      <div class=" col-xl-2 col-3" id="view_count"><span>조회수:</span></div>
      <div class=" col-xl-3 col-5" id="view_lastModified"><span>작성일:</span></div>
    </div>
  </div>
  <hr>
  <div id="view_content"></div>
  <hr>
  <c:if test="${bbs_type =='\"free\"' && user.type != null}">
    <div id="view_likes">
      <i class="bi bi-hand-thumbs-up" onclick="liked()"></i>
    </div>
  </c:if>

<c:if test="${bbs_type !='\"application\"'}">
<%--    댓글리스트--%>
    <div>
      <div class="list-group">
        <a href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3" aria-current="true">
          <img src="https://github.com/twbs.png" alt="twbs" width="32" height="32" class="rounded-circle flex-shrink-0">
          <div class="d-flex gap-2 w-100 justify-content-between">
            <div>
              <h6 class="mb-0">List group item heading</h6>
              <p class="mb-0 opacity-75">Some placeholder content in a paragraph.</p>
            </div>
            <small class="opacity-50 text-nowrap">now</small>
          </div>
        </a>
        <a href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3" aria-current="true">
          <img src="https://github.com/twbs.png" alt="twbs" width="32" height="32" class="rounded-circle flex-shrink-0">
          <div class="d-flex gap-2 w-100 justify-content-between">
            <div>
              <h6 class="mb-0">Another title here</h6>
              <p class="mb-0 opacity-75">Some placeholder content in a paragraph that goes a little longer so it wraps to a new line.</p>
            </div>
            <small class="opacity-50 text-nowrap">3d</small>
          </div>
        </a>
        <a href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3" aria-current="true">
          <img src="https://github.com/twbs.png" alt="twbs" width="32" height="32" class="rounded-circle flex-shrink-0">
          <div class="d-flex gap-2 w-100 justify-content-between">
            <div>
              <h6 class="mb-0">Third heading</h6>
              <p class="mb-0 opacity-75">Some placeholder content in a paragraph.</p>
            </div>
            <small class="opacity-50 text-nowrap">1w</small>
          </div>
        </a>
      </div>
      <table class="commnetstable" id="table1"  data-toggle="table"
             data-pagination="true" data-toolbar="#toolbar"
             data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
             data-page-list="[10]">
        <thead>
        <tr>
          <th data-field="writer_name" data-sortable="true">이름</th>
          <th data-field="comment" data-sortable="true">댓글</th>
          <th data-field="comment_date" data-sortable="true">등록일자</th>
          <th data-field="action">설정</th>
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
</c:if>

  <!-- Modal -->
  <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header" id="myModalHeader">
          <%--                    <h5 class="modal-title" id="staticBackdropLabel">수정하기</h5>--%>
          <%--                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
        </div>
        <div class="modal-body" id = "myModalBody"></div>
        <div class="modal-footer" id="myModalFooter">
          <%--                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>--%>
          <%--                        <button type="button" class="btn btn-primary">추가하기</button>--%>
        </div>
      </div>
    </div>
  </div>

  <script>

    var header = $('#myModalHeader');
    var body = $('#myModalBody');
    var footer = $('#myModalFooter');

  </script>
<script>

  $(document).ready(function(){
    makeViewTitle();
    makeViewContent();
    makeViewWriter();
    makeViewCount();
    makeViewLastModified();
    makeViewButtons();
    callSetupCommentView();
    // makeCommentButton();
  })
  var major = <%=major%>;
  var num = <%=num%>;
  var id = <%=id%>;
  var type = <%=type%>;
  var user = <%=user%>;
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
            var text='';
            if(user!=null){
              if(user.type =='홈페이지관리자'){
                text = '<button class="btn btn-dark mx-1" type="button" onclick="deleteComment('+i+')">삭제</button>'
              }
              if(user.id == commentsList[i].writer_id){
                text ='<button class="btn btn-dark mx-1" type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeModifyCommentModal('+i+')">수정</button><button class="btn btn-dark mx-1" type="button"  onclick="deleteComment('+i+')">삭제</button>'
              }
            }
            rows.push({
                writer_name: comment.writer_name,
                comment: comment.comment,
                comment_date: comment.comment_date,
                action : text
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

  function makeViewWriter(){
    var content = $('#view_writer');
    content.append(getBBS.writer_name);
  }
  function makeViewCount(){
    var content = $('#view_count');
    content.append(getBBS.views);
  }
  function makeViewLastModified(){
    var content = $('#view_lastModified');
    var date = formatDate(getBBS.last_modified);
    content.append(date);
  }

  function deleteComment(i){
    var commentsList = <%=getComment%>;
    var data = commentsList[i].id;
    swal.fire({
      title: '댓글을 삭제하시겠습니까?',
      icon: 'warning',
      showConfirmButton: true,
      showCancelButton: true

    }).then((result) => {
      if (result.isConfirmed) {
        $.ajax({
          url: "ajax.kgu", //AjaxAction에서
          type: "post", //post 방식으로
          data: {
            req: "deleteComment", //이 메소드를 찾아서
            data: data //이 데이터를 파라미터로 넘겨줍니다.
          },
          success: function (data) { //성공 시
            if (data == 'success')
              location.reload();
          }
        })
      }
    })
  }

  function modifyComment(i){
    var commentsList = <%=getComment%>;
    var commentId = commentsList[i].id;
    var comment_date = formatDate(new Date());
    var modifiedComment = $('#modifyComment').val();
    var data = modifiedComment+'-/-/-'+comment_date+'-/-/-'+commentId;
      $.ajax({
        url: "ajax.kgu", //AjaxAction에서
        type: "post", //post 방식으로
        data: {
          req: "modifyComment", //이 메소드를 찾아서
          data: data //이 데이터를 파라미터로 넘겨줍니다.
        },
        success: function (data) { //성공 시
          if (data == 'success') {
            location.reload();
          }
        }
      })
  }


  function makeModifyCommentModal(i){
    var commentsList = <%=getComment%>;
    var modal_header = '';
    modal_header += '<h5 class="modal-title" id="staticBackdropLabel">수정하기</h5>';
    modal_header += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';

    var modal_body = '';
    modal_body += '<div>댓글</div><input type="text" class="form-control" id="modifyComment" name="new_table" value="'+commentsList[i].comment+'" placeholder="comment">';

    var modal_footer = '';
    modal_footer += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>';
    modal_footer += '<button type="button" class="btn btn-secondary pull-right" data-dismiss="modal" aria-label="Close" onclick="modifyComment('+i+')">완료</button>';

    header.html(modal_header);
    body.html(modal_body);
    footer.html(modal_footer);
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

  function liked() {
    var data =
    <%=getBBS%>.
    id;
    var view_likes = $('#view_likes');
    var text = '';


    $.ajax({
      url: 'ajax.kgu',
      type: 'post',
      data: {
        req: 'likeBoard',
        data: data
      },
      success: function (data) {
        if (data == 'success') {
          text += '<i class="bi bi-hand-thumbs-up-fill"></i>'
          view_likes.html(text)
          swal.fire({
            title: '추천 성공!',
            icon: 'success',
            showConfirmButton: true

          }).then(function () {
            location.reload();
          });
        } else if (data == 'already') {
          swal.fire({
            title: '이미 추천한 글입니다.',
            icon: 'warning',
            showConfirmButton: true

          });
        } else {
          swal.fire({
            title: '서버에러',
            text: '다음에 다시 시도해주세요',
            icon: 'error',
            showConfirmButton: true

          });
        }
      }
    });
  }


  function deleteBbs() {
    var getBBS = <%=getBBS%>;
    var id = getBBS.id;
    var title = getBBS.title;
    var writer_id = getBBS.writer_id;
    var writer_name = getBBS.writer_name;
    var last_modified = getBBS.last_modified;
    var data = id + "-/-/-" + major + "-/-/-" + writer_id + "-/-/-" + writer_name + "-/-/-" + title + "-/-/-" + num + "-/-/-" + last_modified;

    swal.fire({
      title: '정말로 삭제하시나요?',
      text: '다시 되돌릴 수 없습니다.',
      icon: 'warning',
      showConfirmButton: true,
      showCancelButton: true

    }).then((result) => {
      if (result.isConfirmed) {

        $.ajax({
          url: "ajax.kgu", //AjaxAction에서
          type: "post", //post 방식으로
          data: {
            req: "deleteBbs", //이 메소드를 찾아서
            data: data //이 데이터를 파라미터로 넘겨줍니다.
          },
          success: function (data) { //성공 시
            if (data == 'success') {
              swal.fire({
                title : '해당 내용이 삭제되었습니다.',
                icon : 'success',
                showConfirmButton: true

              }).then(function (){
                location.href = 'bbs.kgu?major=' + major + '&&num=' + num + '&&mode=list';
              });
            } else {
              swal.fire({
                title : '권한이 부족합니다.',
                icon : 'error',
                showConfirmButton: true

              });
            }
          }
        })
      }
    })
  }
</script>


