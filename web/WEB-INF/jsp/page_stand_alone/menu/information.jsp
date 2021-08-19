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
<script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>

<div class="container py-4" id="information_content"></div>
<div class="text-end" id="modify_button"></div>
<script>

    $(document).ready(function(){
        makeInformation();
    })

    var typeForInformation = <%=typeForInformation%>;
    var information = <%=information%>;
    function makeInformation() {
        var data = $('#information_content');
        if(information!=null){
            var text = '';

            text+=information.content;

            if(typeForInformation.for_header=='관리자'){
                var button = $('#modify_button');
                button.append('<button class="btn btn-primary" onclick="modify()">수정</button>');
            }

            data.append(text);
        }

    }

    function modify(){
        var modify_button = $('#modify_button');
        var a='';
        modify_button.empty();
        a+='<textarea id="editor">'+information.content+'</textarea>';
        a+='<div id="write_post" class="my-4 col-xs-13 text-right d-flex justify-content-between">'
        a+='<button type="button" class="btn btn-secondary" style = "margin : 2px;" onclick="back()">뒤로</button>'
        a+='<button type="button" class="btn btn-primary" style = "margin : 2px;" onclick="modifyText()">수정</button>';
        a+='</div>';
        $('#information_content').html(a);
        CKEDITOR.replace('editor', {
            allowedContent: true,
            height: 500,
            'filebrowserUploadUrl': 'Uploader'
        });
    }

    function back(){
         swal.fire({
            title : '뒤로가기',
            text : '수정한 글과 파일들은 저장되지 않습니다!',
            icon : 'error',
            showConfirmButton: true
            }).then(function () {
                 window.location.href = 'information.kgu?major=main&&num=10';
            });
    }
    function modifyText(){
        var content = CKEDITOR.instances.editor.getData();
        var modify=information.id+"-/-/-"+information.major+"-/-/-"+content;

        $.ajax({
            url: 'ajax.kgu',
            type : 'post',
            data :{
                req : "modifyText",
                data : modify
            },
            dataType:"json",
            success : function(data){
                if(data != 'fail'){
                    swal.fire({
                        title : '수정이 완료되었습니다.',
                        icon : 'success',
                        showConfirmButton: true

                    }).then(function (){
                        location.reload();
                    });
                }
                else
                    swal.fire({
                        title : '서버에러',
                        text : '다음에 다시 시도해주세요',
                        icon : 'error',
                        showConfirmButton: true
                    });
            }
        })
    }


</script>

<style>
    #information_content img {
        max-width:100%;
        width: 100% !important;
        height: auto !important;
        object-fit:cover;
    }
</style>