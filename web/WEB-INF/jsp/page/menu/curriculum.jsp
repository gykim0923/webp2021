<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-13
  Time: 오후 2:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String typeForCurriculum = (String)session.getAttribute("type");
    String curriculum = (String)request.getAttribute("curriculum");  //커리큘럼 내용
    String getCurriculums = (String)request.getAttribute("getCurriculums");  //해당 전공 연도별 커리큘럼 사진
%>
<div id="curriculum_content"></div>
<div id="modify_button" class="d-grid gap-2 d-md-flex justify-content-md-end"></div>
<div id="curriculum_btn"></div>
<div id="curriculum_view"></div>
<!-- 커리큘럼 추가, 수정 Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" id="curriculumModalHeader">
            </div>
            <div class="modal-body" id = "curriculumModalBody"></div>
            <div class="modal-footer" id="curriculumModalFooter">
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function(){
        makeInformation();
    })

    var typeForCurriculum = <%=typeForCurriculum%>;
    var curriculum = <%=curriculum%>;
    var curriculumList = <%=getCurriculums%>;
    var modalHeader = $('#curriculumModalHeader');
    var modalBody = $('#curriculumModalBody');
    var modalFooter = $('#curriculumModalFooter');

    function makeInformation() {
        var data = $('#curriculum_content');
        var text = '';
        var yearButton = $('#curriculum_btn');

        text+='<p>'+curriculum.content+'</p>';

        if(typeForCurriculum.for_header=='관리자'){
            var button = $('#modify_button');
            button.append('<button type="button" class="btn btn-outline-secondary" onclick="modify()">수정</button>'
                        +'<button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="addCurriculum()">추가</button>');
        }

        var yearCount = curriculumList.length;
        for(var i = 0; i<yearCount; i++){
            yearButton.append('<button type="button" class="btn btn-outline-secondary me-2" onclick="viewImages('+i+')">'+curriculumList[i].year+'년 교육과정</button>');
        }

        viewImages(yearCount-1);

        data.append(text);
    }

    function modify(){  //커리큘럼 수정 화면 띄움
        var modify_button = $('#modify_button');
        var a='';
        modify_button.empty();
        a+='<textarea id="editor">'+curriculum.content+'</textarea>';
        a+='<div id="write_post" class="d-grid gap-2 d-md-flex justify-content-md-end"><button type="button" class="btn btn-outline-secondary" onclick="modifyText()">수정</button>';
        a+='<button type="button" class="btn btn-outline-secondary" onclick="back()">뒤로</button></div></div>';
        $('#curriculum_content').html(a);
        CKEDITOR.replace('editor', {
            allowedContent: true,
            height: 500,
            'filebrowserUploadUrl': 'Uploader'
        });
    }

    function back(){  //수정하기를 취소하였을 때 원래 페이지가 나오도록함
        var a='';
        a+=curriculum.content;
        $('#curriculum_content').html(a);
        var b='<div id="write_post" class="col-xs-13 text-right" style = "margin : 2px;"><button type="button" class="btn btn-outline-secondary" onclick="modify()">수정</button></div>';
        $('#modify_button').html(b);
    }

    function modifyText(){  //커리큘럼 내용 수정
        var content = CKEDITOR.instances.editor.getData();
        var modify=curriculum.id+"-/-/-"+curriculum.major+"-/-/-"+content;

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
                    alert("수정완료");
                    window.location.reload();
                }
                else
                    alert('SERVER ERROR, Please try again later');
            }
        })
    }

    function viewImages(num){  //버튼으로 선택한 연도의 교육과정 이미지를 띄움
        var list = $('#curriculum_view');
        list.empty();
        list.append('<div>'+curriculumList[num].year+'년도 교육과정</div>'
            +'<img src="'+curriculumList[num].curriculum_img+'" id="curriculum_'+curriculumList[num].year+'" class="img-fluid">'
            +'<div>'+curriculumList[num].year+'년도 교육과정 이수체계도</div>'
            +'<img src="'+curriculumList[num].edu_img+'" id="edu_'+curriculumList[num].year+'" class="img-fluid">'
            +'<div class="d-grid gap-2 d-md-flex justify-content-md-end">'
            +'<button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="modifyCurriculum('+num+')">수정</button>'
            +'<button type="button" class="btn btn-outline-secondary" onclick="deleteCurriculum('+num+')">삭제</button></div>');
    }

    function addCurriculum(){
        var major = <%=major%>;
        modalHeader.html('<h5 class="modal-title" id="staticBackdropLabel">추가하기</h5>'
            +'<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>');
        modalBody.html('<div class="row g-3"><div class="col-md-6"><label for="major" class="form-label">전공</label><input class="form-control" id="major" value="'+major+'" readonly></div>'
            +'<div class="col-md-6"><label for="year" class="form-label">연도</label><input class="form-control" id="year" placeholder="ex)2021"></div>'
            +'<div class="col-12"><label for="curriculumFile" class="form-label">커리큘럼 이미지</label><div class="input-group mb-3"><input type="file" class="form-control" id="curriculumFile"><label class="input-group-text" for="curriculumFile">Upload</label></div></div>'
            +'<div class="col-12"><label for="eduFile" class="form-label">이수체계도 이미지</label><div class="input-group mb-3"><input type="file" class="form-control" id="eduFile"><label class="input-group-text" for="eduFile">Upload</label></div></div>');
        modalFooter.html('<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button><button type="button" class="btn btn-primary">추가하기</button>');
    }

    function modifyCurriculum(num){
        var major = <%=major%>;
        modalHeader.html('<h5 class="modal-title" id="staticBackdropLabel">수정하기</h5>'
                        +'<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>');
        modalBody.html('<div class="row g-3"><div class="col-md-6"><label for="major" class="form-label">전공</label><input class="form-control" id="major" value="'+major+'" readonly></div>'
                    +'<div class="col-md-6"><label for="year" class="form-label">연도</label><input class="form-control" id="year" value="'+curriculumList[num].year+'년도" readonly></div>'
                    +'<div class="col-12"><label for="curriculumFile" class="form-label">커리큘럼 이미지</label><div class="input-group mb-3"><input type="file" class="form-control" id="curriculumFile"><label class="input-group-text" for="curriculumFile">Upload</label></div></div>'
                    +'<div class="col-12"><label for="eduFile" class="form-label">이수체계도 이미지</label><div class="input-group mb-3"><input type="file" class="form-control" id="eduFile"><label class="input-group-text" for="eduFile">Upload</label></div></div>');
        modalFooter.html('<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button><button type="button" class="btn btn-primary">수정하기</button>');
}

function deleteCurriculum(){

}
</script>
