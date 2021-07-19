<%--
  Created by IntelliJ IDEA.
  User: jinny
  Date: 2021-07-14
  Time: 오전 12:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String typeForLab = (String)session.getAttribute("type");
    String getLaboratoryList = (String)request.getAttribute("getLaboratoryList");
%>

<style>
    .team-boxed {
    color:#313437;
}

.team-boxed p {
    color:#7d8285;
}

.team-boxed h2 {
    font-weight:bold;
    margin-bottom:40px;
    padding-top:40px;
    color:inherit;
}

@media (max-width:767px) {
    .team-boxed h2 {
        margin-bottom:25px;
        padding-top:25px;
        font-size:24px;
    }
}

.team-boxed .intro {
    font-size:16px;
    max-width:500px;
    margin:0 auto;
}

.team-boxed .intro p {
    margin-bottom:0;
}

.team-boxed .people {
    padding:50px 0;
}

.team-boxed .item {
    text-align:center;
}

.team-boxed .item .box {
    text-align:center;
    padding:30px;
    background-color:#fff;
    margin-bottom:30px;
}

.team-boxed .item .name {
    font-weight:bold;
    margin-top:28px;
    margin-bottom:8px;
    color:inherit;
}

.team-boxed .item .title {
    text-transform:uppercase;
    font-weight:bold;
    color:#d0d0d0;
    letter-spacing:2px;
    font-size:13px;
}

.team-boxed .item .description {
    font-size:15px;
    margin-top:15px;
    margin-bottom:20px;
}

.team-boxed .item img {
    max-width: 160px;
}

</style>
<script>
    $(document).ready(function(){
        makeLabCard();
    })
    function makeLabCard(){
        var laboratory = <%=getLaboratoryList%>;
        var typeForLab = <%=typeForLab%>;
        var list = $('#labCard');
        var text = '';

        for(var i=0; i<laboratory.length; i++){
            text+= ''
                +'<div class="col-md-6 col-lg-4 item" >'
                +'<div class="box shadow rounded-3" style="height:350px" id="'+laboratory[i].id+'">'
                +'<div class="py-4">'
                +'<img id="laboratoryImg" class="rounded-circle" src="'+laboratory[i].lab_img+'">'
                +'<h4 class="name">'+laboratory[i].lab_name+'</h4>'
                +'<p class="title">연구실위치:'+laboratory[i].lab_location+'</p>'
                +'<p class="description"><a href="'+laboratory[i].lab_homepage+'">연구실홈페이지</a><p>';
            if(typeForLab.for_header=='관리자') {
                text += '<div><button class="btn btn-secondary mx-2" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeModifyLabModal('+i+')">수정</button><button class="btn btn-secondary mx-2" onclick="deleteLaboratory('+ (laboratory[i].id)+')">삭제</button></div>'
            }
            text+='</div>'
                +'</div></div>';
        }
        if(typeForLab.for_header=='관리자') {
            <!-- Button trigger modal -->
            text +='<div><button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#staticBackdrop1">연구실 추가</button><div>'
        }
        list.append(text);
    }

</script>

<script>
    function makeModifyLabModal(i){ // 연구실 정보 수정하는 모달 창 만드는 js 함수
        var list = $('#myModalbody');
        var laboratory1 = <%=getLaboratoryList%>;
        var a ='';
        a+= '<div>연구실 이름</div><input type="text" class="form-control" id="modify_lab_name" name="lab_name1" value="'+(laboratory1[i].lab_name)+'" placeholder="lab_name">'
        a+='<div>연구실 위치</div><input type="text" class="form-control" id="modify_lab_location" name="lab_location1" value="'+(laboratory1[i].lab_location)+'" placeholder="lab_location">'
        a+='<div>연구실 홈페이지</div><input type="text" class="form-control" id="modify_lab_homepage" name="lab_homepage1" value="'+(laboratory1[i].lab_homepage)+'" placeholder="lab_homepage">'

        a+='<div id="fileUploadSection">'
        a+='<input type="file" name="uploadFile" id="uploadFile" accept="image/*">'
        a+='<button class="btn btn-secondary" onclick="uploadfile()"><i class="bi bi-upload"></i> 업로드</button>'
        a+='</div>'

        // a+='<div><form style="display : inline-block" name="fileform" id="fileform" action="" method="post" enctype="multipart/form-data">'
        // a+='<input type="text" name="LaboratoryID" value="' +i.id+ '" hidden>'
        // a+='<input style="display : inline-block" type="file" name="uploadFile" id="uploadFile" accept=".jpg, .jpeg, .png">'
        // a+='<button type="button" class="btn btn-secondary my-2" data-dismiss="modal" onclick="modifyImage()">사진 수정</button></form></div>'
        a += '<button type="button" class="btn btn-dark pull-right my-2" data-dismiss="modal" aria-label="Close" onclick="modifyLabModal('+i+')">완료</button>';
        list.html(a);
    }

    var file_id; //나중에 파일 상세정보를 uploadedFile로부터 역참조 하고싶은 경우에 사용하라고 만들어둠 (꼭 사용해야 하는 것은 아님)
    var file_path; //파일이 업로드된 상대경로
    function uploadfile(){
        var formData = new FormData();
        var folder='/img/laboratory';//업로드 된 파일 folder 경로 설정은 여기에서 해줍니다. (마지막에 /가 오면 절대 안됩니다.)
        if($('input[name=uploadFile]')[0].files[0]!=null){
            formData.append("file_data",$('input[name=uploadFile]')[0].files[0]);
            formData.append("file_type", "image"); //전송하려는 파일 타입 설정 (제한이 없으려면 null로 한다.)
            formData.append("board_level", "0"); // board_level 제한 (부정 업로드 방지용. 교수까지 하려면 1, 학생까지 하려면 2로 설정하면 됨.)

            $.ajax({
                url : 'upload.kgu?folder='+folder,
                type : "post",
                async:false,
                data : formData,
                processData : false,
                contentType : false,
                success : function(data){//데이터는 주소
                    if(data=='fail'){
                        alert('실패');
                    }
                    else {
                        alert(data);
                        var fileLog=data.split("-/-/-");
                        var a='';
                        a+='<div>파일제출</div><div>'+fileLog[1]+'</div>';
                        a+='<div><a href="#"><button class="btn btn-secondary"><i class="bi bi-download"></i> 다운로드(미구현)</button></a>'
                        a+='<button class="btn btn-danger" onclick="makeUploadSliderModal()"><i class="bi bi-x-circle-fill"></i> 첨부파일 수정하기</button></div>';
                        file_id=fileLog[0];
                        file_path=folder+'/'+fileLog[1];
                        $('#fileUploadSection').html(a);
                    }
                }
            })
        }else{
            alert("파일을 등록해주세요");
        }
        // return address;
    }

    function insertLab() { // 연구실 정보 추가
        var lab_img = file_path;
        var name1 = $('#add_lab_name').val();
        var location2= $('#add_lab_location').val();
        var homepage2= $('#add_lab_homepage').val();
        var data2 =lab_img+'-/-/-'+name1+'-/-/-'+location2+'-/-/-'+homepage2;
        var check = confirm("정말 추가하시겠습니까?");
        if(check){
            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "insertLaboratory",
                    data : data2
                },
                success : function(data2) {
                    if (data2== 'success'){
                        alert("추가가 완료되었습니다");
                        location.reload();
                    }
                    else
                        alert("추가를 실패하였습니다");
                }
            })
        }
    }


    function deleteLaboratory(i){ //데이터 삭제
        var check = confirm("[중요] 정말로 이 데이터를 삭제하시나요? 취소하실 수 없습니다.");
        if (check) {
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post",
                data: {
                    req: "deleteLaboratory", //이 메소드를 찾아서
                    data: i //이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (data) { //성공 시
                    alert("해당 데이터가 삭제되었습니다.");
                    location.reload()
                }
            })
        }
    }

    function modifyLabModal(i){ // 데이터 정보 받아와서 DB에 정보 수정 후 화면에 반영
        var laboratory2 = <%=getLaboratoryList%>;
        var id = laboratory2[i].id;
        var lab_img='';
        if(file_path!=null)
            lab_img = file_path;
        else
            lab_img = laboratory2[i].lab_img
        var name = $('input[name=lab_name1]').val();
        var location1 = $('input[name=lab_location1]').val();
        var homepage = $('input[name=lab_homepage1]').val();
        var update = lab_img+"-/-/-"+name + "-/-/-" + location1 + "-/-/-" + homepage +  "-/-/-" + id;
        var check = confirm("정말 수정하시겠습니까?");
        if(check){
            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "modifyLaboratory",
                    data : update
                },
                dataType : "json",
                success : function(data) {
                    alert("수정이 완료되었습니다");
                    location.reload();
                }
            })
        }
    }


</script>


<div>
    <div class="team-boxed">
        <div class="container" >
            <div class="intro">
                <h3 class="text-center">연구실</h3>
            </div>
            <div class="row people" id="labCard" ></div>
        </div>
    </div>
</div>

<!-- Modal / 연구실 수정 모달-->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">수정하기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id = "myModalbody"></div>
            <%--                        <div class="modal-footer">--%>
            <%--                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>--%>
            <%--                            <button type="button" class="btn btn-primary">추가하기</button>--%>
            <%--                        </div>--%>
        </div>
    </div>
</div>


<div>
    <!-- Modal / 연구실 추가 모달-->
    <div class="modal fade" id="staticBackdrop1" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel1">연구실 추가하기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="modalReset">
                    <div>연구실 이름 </div>
                    <input type="text" class="form-control" id="add_lab_name" name="add_lab_name1" value="" placeholder="lab_name">
                    <div>연구실 위치</div>
                    <input type="text" class="form-control" id="add_lab_location" name="add_lab_location1" value="" placeholder="lab_location">
                    <div>연구실 홈페이지</div>
                    <input type="text" class="form-control" id="add_lab_homepage" name="add_lab_homepage1" value="" placeholder="lab_homepage">
                    <div>
                        <div id="fileUploadSection">
                        <input type="file" name="uploadFile" id="uploadFile" accept="image/*">
                        <button class="btn btn-secondary" onclick="uploadfile()"><i class="bi bi-upload"></i> 업로드</button>
                        </div>
                    </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-secondary" aria-label="Close" onclick="insertLab()">추가</button>
                </div>
            </div>
        </div>
        </div>
    <%--modal end--%>