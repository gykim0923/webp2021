<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-15
  Time: 오후 3:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getLocation = (String)request.getAttribute("getLocation");
%>
<style>
    #map{
        height: 600px;
    }
    #way{
        max-width:100%;
        height:auto;
    }
    .bi-telephone{
        width: 100px;
    }
</style>
<div class="row">
    <div class="col-12 py-5">
        <h3><strong><i class="bi bi-telephone"></i>&nbsp주소 및 연락처</strong></h3><br>
        <div id="contact"></div>
    </div>
    <hr>
    <div class="col-12 py-5">
        <h3><strong><i class="bi bi-compass"></i>&nbsp오시는 길</strong></h3><br>
        <div id="campus"><h4><strong>수원캠퍼스</strong></h4></div><br>
        <div id="map"></div>
        <script>
            function initMap() {
                var map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: 37.3007218, lng: 127.0392770},
                    zoom: 16
                });
                var marker = new google.maps.Marker({
                    position: {lat: 37.3007218, lng: 127.0392770},
                    map: map
                });
            }
        </script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBqeRrYz4_XJFY_vA9aqDbIiuU_Zs5odVA&callback=initMap"
                async defer></script>
        <div id="way"></div>
    </div>
</div>
<script>
    $(document).ready(function(){
        content();
        contact();
    })

    function contact(){
        var list = $('#contact');
        var location = <%=getLocation%>;
        var text = '';
        text += '<h4 id="loc"><strong> 주소 : '+location[0].address+'</strong></h4><br>'
            +'<h4 id="loc"><strong> 연락처 : '+location[0].contact_num+'</strong></h4>'
        <c:if test="${type.for_header == '관리자'}">
            text+='<button class="btn btn-secondary mx-1" onclick="makeModifyContact()">수정</button>';
        </c:if>
        list.append(text);
    }
    function content(){
        var location = <%=getLocation%>;
        var list = $('#way');
        var text = '';
        text += '<h4><strong><div>'+location[0].content+'</div></strong></h4>'
            <c:if test="${type.for_header == '관리자'}">
                text+='<button class="btn btn-secondary mx-1" onclick="makeModifyContent()">수정</button>'
            </c:if>
        list.append(text);
    }
    function makeModifyContent(){
        var location = <%=getLocation%>;
        var modify_button = $('#way');
        var a='';
        modify_button.empty();
        a+='<div><textarea id="editorContent" name="modify_content">'+location[0].content+'</textarea></div>';
        a += '<button type="button" class="btn btn-dark pull-right my-2" data-dismiss="modal" aria-label="Close" onclick="modifyContent()">수정</button>';
        $('#way').html(a);
        CKEDITOR.replace('editorContent', {
            allowedContent: true,
            height: 400,
            'filebrowserUploadUrl': 'Uploader'
        });
    }
    function makeModifyContact(){
        var list = $('#contact');
        var location = <%=getLocation%>;
        var a ='';
        a+= '<div>주소</div><input type="text" class="form-control" id="modify_address" name="modify_address" value="'+location[0].address+'" placeholder="주소">'
        a+='<div>연락처</div><input type="text" class="form-control" id="modify_contact_num" name="modify_contact_num" value="'+location[0].contact_num+'" placeholder="연락처">'
        a+='<div><form style="display : inline-block" name="fileform" id="fileform" action="" method="post" enctype="multipart/form-data">'
        a += '<button type="button" class="btn btn-dark pull-right my-2" data-dismiss="modal" aria-label="Close" onclick="modifyContact()">수정</button>';
        list.html(a);
    }
    function modifyContact(){
        var location = <%=getLocation%>;
        var id = location[0].id;
        var address = $('input[name=modify_address]').val();
        var contact_num = $('input[name=modify_contact_num]').val();
        // var content=CKEDITOR.instances.editorContent.getData();
        var content = location[0].content;
        var update = id + "-/-/-" + address + "-/-/-" + contact_num + "-/-/-" + content;

        var check = confirm("정말 수정하시겠습니까?");
        if(check){
            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "modifyLoc",
                    data : update
                },
                dataType : "json",
                success : function(data){
                    if(data != 'fail'){
                        alert("수정완료");
                        window.location.reload();
                    }
                    else
                        alert('SERVER ERROR, Please try again later');
                }
            })
        }
    }
    function modifyContent(){
        var location = <%=getLocation%>;
        var id = location[0].id;
        var address = location[0].address;
        var contact_num = location[0].contact_num;
        var content=CKEDITOR.instances.editorContent.getData();
        var update = id + "-/-/-" + address + "-/-/-" + contact_num + "-/-/-" + content;

        var check = confirm("정말 수정하시겠습니까?");
        if(check){
            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "modifyLoc",
                    data : update
                },
                dataType : "json",
                success : function(data){
                    if(data != 'fail'){
                        alert("수정완료");
                        window.location.reload();
                    }
                    else
                        alert('SERVER ERROR, Please try again later');
                }
            })
        }
    }
</script>