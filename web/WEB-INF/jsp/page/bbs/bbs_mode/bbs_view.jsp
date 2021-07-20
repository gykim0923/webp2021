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

  function makeViewContent() {
    var content = $('#view_content');
    var getBBS = <%=getBBS%>;
    content.append(getBBS.text);
  }

  function makeViewButtons() {
    var list_button = $('#list_button');
    var url = 'bbs.kgu?major='+major+'&&num='+num+'&&mode=list';
    var text = '';
    text+='<a href="'+url+'"><div class="btn btn-secondary">목록</div></a>'
    list_button.append(text);
  }
</script>