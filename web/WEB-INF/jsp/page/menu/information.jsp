<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-06
  Time: 오후 5:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String typeForInformation = (String)session.getAttribute("type");
    String information = (String)request.getAttribute("information");
%>

<div id="information_content"></div>
<div id="modify_button"></div>
<script>

    $(document).ready(function(){
        makeInformation();
    })

    var typeForInformation = <%=typeForInformation%>;
    var information = <%=information%>;
    function makeInformation() {
        var data = $('#information_content');
        var text = '';

        text+=information.content;

        if(typeForInformation.for_header=='관리자'){
            var button = $('#modify_button');
            button.append('<button onclick="modify()">수정</button>');
        }

        data.append(text);
    }

    function modify(){
        var modify_button = $('#modify_button');
        var a='';
        modify_button.empty();
        a+='<textarea id="editor">'+information.content+'</textarea>';
        a+='<div id="write_post" class="col-xs-13 text-right"><button type="button" class="btn btn-default" style = "margin : 2px;" onclick="modifyInfo()">수정</button>';
        a+='<button type="button" class="btn btn-default" style = "margin : 2px;" onclick="back()">뒤로</button></div></div>';
        $('#information_content').html(a);
        CKEDITOR.replace('editor', {
            allowedContent: true,
            height: 500,
            'filebrowserUploadUrl': 'Uploader'
        });
    }

</script>