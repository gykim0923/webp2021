<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-13
  Time: 오후 2:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String typeForInformation = (String)session.getAttribute("type");
    String curriculum = (String)request.getAttribute("curriculum");
    String getCurriculums = (String)request.getAttribute("getCurriculums");
%>
<div id="curriculum_content"></div>
<div id="modify_button"></div>
<div id="curriculum_btn"></div>
<div id="curriculum_view"></div>

<script>
    $(document).ready(function(){
        makeInformation();
    })

    var typeForInformation = <%=typeForInformation%>;
    var curriculum = <%=curriculum%>;
    var curriculumList = <%=getCurriculums%>

    function makeInformation() {
        var data = $('#curriculum_content');
        var text = '';
        var yearButton = $('#curriculum_btn');

        text+='<p>'+curriculum.content+'</p>';

        if(typeForInformation.for_header=='관리자'){
            var button = $('#modify_button');
            button.append('<button onclick="modify()">수정</button>');
        }

        var yearCount = curriculumList.length;
        for(var i = 0; i<yearCount; i++){
            yearButton.append('<button type="button" class="btn btn-outline-secondary me-2" onclick="viewImages('+i+')">'+curriculumList[i].year+'년 교육과정</button>');
        }

        viewImages(yearCount-1);

        data.append(text);
    }

    function modify(){
        var modify_button = $('#modify_button');
        var a='';
        modify_button.empty();
        a+='<textarea id="editor">'+curriculum.content+'</textarea>';
        a+='<div id="write_post" class="col-xs-13 text-right"><button type="button" class="btn btn-default" style = "margin : 2px;" onclick="modifyInfo()">수정</button>';
        a+='<button type="button" class="btn btn-default" style = "margin : 2px;" onclick="back()">뒤로</button></div></div>';
        $('#curriculum_content').html(a);
        CKEDITOR.replace('editor', {
            allowedContent: true,
            height: 500,
            'filebrowserUploadUrl': 'Uploader'
        });
    }

    function back(){
        var a='';
        a+=curriculum.content;
        $('#curriculum_content').html(a);
        var b='<div id="write_post" class="col-xs-13 text-right" style = "margin : 2px;"><button type="button" class="btn btn-default" onclick="modify()">수정</button></div>';
        $('#modify_button').html(b);
    }

    function modifyInfo(){
        var content = CKEDITOR.instances.editor.getData();
        var modify=curriculum.id+"-/-/-"+curriculum.major+"-/-/-"+content;

        $.ajax({
            url: 'ajax.kgu',
            type : 'post',
            data :{
                req : "modifyInfo",
                data : modify
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

    function viewImages(num){
        var list = $('#curriculum_view');
        list.empty();
        list.append('<div>'+curriculumList[num].year+'년도 교육과정</div>'
            +'<img src="'+curriculumList[num].curriculum_img+'" id="curriculum_'+curriculumList[num].year+'" class="img-fluid">'
            +'<div>'+curriculumList[num].year+'년도 교육과정 이수체계도</div>'
            +'<img src="'+curriculumList[num].edu_img+'" id="edu_'+curriculumList[num].year+'" class="img-fluid">');
    }
</script>
