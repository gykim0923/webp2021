<%--
  Created by IntelliJ IDEA.
  User: ellie
  Date: 2021-07-13
  Time: 오후 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String typeForInformation = (String)session.getAttribute("type");
    String getClub = (String)request.getAttribute("getClub");
//    String club = (String)request.getAttribute("club");
%>
<div id="club_content">
    <ul id="clubList"></ul>
    <div id="add_button" class="post_button"></div>
</div>


<script>
    $(document).ready(function(){
        makeClub();
    })
    var typeForInformation = <%=typeForInformation%>;
    var club = <%=getClub%>

    function makeClub(){
        var content=$('#club_content');
        var text =''
        var clubList=$('#clubList');
        var button=$('#add_button');

        for(var i=0; i<club.length; i++){
            clubList.append('<div id="club'+club[i].id+'">'
                +'<li><div id="clubname'+club[i].id+'" class="contenttitle2">'+club[i].clubname+'</div>'
                +'<div id="clubcontent_'+club[i].id+'">'+club[i].clubcontent+'</div>'
                +'<div id="clubaddr'+club[i].id+'">홈페이지 : <a href="'+club[i].clubaddr+'">'+club[i].clubaddr+'</a></div></li>');
            if(typeForInformation.for_header=='관리자'){
                clubList.append('<button onclick="modifyClub('+i+')">수정</button>');
                clubList.append('<button onclick="deleteclub(club['+i+'].id)">삭제</div><br>');
            }
            +'<br>';
        }
        if(typeForInformation.for_header=='관리자') {
            button.append('<button onclick="insertclub()">동아리 추가</button>');
        }
        content.append(text);
    }

    function modifyClub(i){
        var modify_button = $('#clubList');
        var addclub_button = $('#add_button')
        var a='';
        modify_button.empty();
        addclub_button.empty();
        a+='<div id="editorName">동아리 이름 : <input type="text" name="clubname" value="'+club[i].clubname+'"></div>';
        a+='<textarea id="editorContent">'+club[i].clubcontent+'</textarea>';
        a+='<div id="editoraddr">홈페이지 : <input type="text" name="clubaddr" value="'+club[i].clubaddr+'"></div>';
        a+='<button id="write_post" onclick="modifyText(club['+i+'].id)">수정</button>';
        a+='<button type="button" onclick="window.location.reload()">뒤로</button></div></div>';
        $('#clubList').html(a);
        CKEDITOR.replace('editorContent', {
            allowedContent: true,
            height: 400,
            'filebrowserUploadUrl': 'Uploader'
        });
    }

    function deleteclub(id){
        $.ajax({
            url:"ajax.kgu",
            type:"post",
            data :{
                req:"deleteclub",
                data:id
            },
            success : function(data){
                if(data != 'fail'){
                    alert("삭제완료");
                    window.location.reload();
                }
                else
                    alert('SERVER ERROR, Please try again later');
            }
        })
    }

    function modifyText(id){
        var name = $('[name=clubname]').val();
        var content=CKEDITOR.instances["editorContent"].getData();
        var address = $('[name=clubaddr]').val();
        var insert =id+"-/-/-"+name+"-/-/-"+content+"-/-/-"+address;

        $.ajax({
            url: 'ajax.kgu',
            type : 'post',
            data :{
                req : "modifyclub",
                data : insert
            },
            dataType:"json",
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

    function insertclub(){
        var a='';
        a +='<form name="clubinsert">';
        a +='<input type="text" class="form-control" name="addclubname" placeholder="동아리 이름을 입력하세요">';
        a +='<textarea name="addclubcontent" id="addeditor" required></textarea>';
        a +='<input type="text" class="form-control" name="addclubaddr" placeholder="동아리 주소를 입력하세요">';
        a +='<button class="post_button" id="post_submit" onclick="addclub()">추가</button>';
        a +='</div></form>';
        $('#add_button').css('margin-top','8px')
        $('#add_button').html(a);
        CKEDITOR.replace("addeditor",{
            allowedContent : true,
            height : 400
        });
    }
    function addclub(){
        var name = $('[name=addclubname]').val();
        var content=CKEDITOR.instances.addeditor.getData();
        var address = $('[name=addclubaddr]').val();
        var insert = name+"-/-/-"+content+"-/-/-"+address;

        $.ajax({
            url: 'ajax.kgu',
            type : 'post',
            data :{
                req : "insertclub",
                data : insert
            },
            dataType:"json",
            success : function(data){
                if(data != 'fail'){
                    alert("추가 완료");
                    window.location.reload();
                }
                else
                    alert('SERVER ERROR, Please try again later');
            }
        });
    }

</script>
