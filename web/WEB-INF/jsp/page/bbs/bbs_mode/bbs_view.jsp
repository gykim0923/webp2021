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
%>
<div>
  <div id="view_content"></div>
  <hr>
  <div id="view_comments"></div>
  <hr>
  <div>
    <div id="list_button"></div>
    <div id="modify_button"></div>
    <div id="delete_button"></div>
  </div>
</div>

<script>

  $(document).ready(function(){
    makeViewContent();
    makeViewButtons();
  })
  var major = <%=major%>;
  var num = <%=num%>;
  var id = <%=id%>;

  function makeViewContent() {
    var content = $('#view_content');
    var getBBS = <%=getBBS%>;
    content.append(getBBS.text);
  }

  function makeViewButtons() {
    var list_button = $('#list_button');
    var listUrl = 'bbs.kgu?major='+major+'&&num='+num+'&&mode=list';
    var modifyUrl = 'bbs.kgu?major='+major+'&&num='+num+'&&mode=modify&&id='+id;
    var text = '';
    text+='<a href="'+listUrl+'"><div class="btn btn-secondary">목록</div></a>'
            + '<a href="'+modifyUrl+'"><div class="btn btn-secondary">수정</div></a>'
            + '<a onclick="deleteBbs()"><div class="btn btn-secondary">삭제</div></a>'
    list_button.append(text);
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