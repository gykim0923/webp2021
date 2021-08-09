<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
   String typeForProfessor = (String)session.getAttribute("type");
   String getProfessorList = (String) request.getAttribute("getProfessorlist");
%>
<script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>

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
      max-width:160px;
   }
   .team-boxed .social {
      font-size:18px;
      color:#a2a8ae;
   }
   .team-boxed .social a {
      color:inherit;
      margin:0 10px;
      display:inline-block;
      opacity:0.7;
   }
   .team-boxed .social a:hover {
      opacity:1;
   }
   #image{
      width: 100px;
      flaot: left;
   }
</style>

<script>
   $(document).ready(function(){
      makeProfessorCard();
   })
   var typeForProfessor=<%=typeForProfessor%>;
   function makeProfessorCard(){
      var professor =<%=getProfessorList%>;
      var prolist = $('#professorCard');
      var text ='';
      for (var i = 0; i < professor.length; i++) {
         text+='<div class="col-lg-4 col-md-6">'
                 +'<div class="card">'
                 +'<svg class="card-img-top" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="'+professor[i].prof_color+'"></rect></svg>'
                 // +'<img src="https://via.placeholder.com/340x120/87CEFA/000000" alt="Cover" class="card-img-top">'
                 +'<div class="card-body text-center">'
                 +'<img src="'+professor[i].prof_img+'" style="height:130px;margin-top:-65px" alt="User" class="img-fluid img-thumbnail rounded-pill border-0 mb-3">'
                 +'<h5 class="card-title">'+professor[i].prof_name+' 교수</h5>'
                 +'<p class="">이메일 : '+professor[i].prof_email+'</p>'
                 +'<p class="">사무실 위치 : '+professor[i].prof_location+'</p>'
                 +'<p class ="">연락처 : '+professor[i].prof_call+'</p>'
                 +'<p class ="">담당과목 : '+professor[i].prof_lecture+'</p>'
                 +'</div>'

         if(typeForProfessor.for_header=='관리자') {
            text += '<div class="card-footer">'
                    +'<button class="btn btn-primary mx-2" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeModifyProModal('+i+')">수정</button>'
                    +'<button class="btn btn-danger mx-2" onclick="deleteProfessor('+i+')">삭제</button></div>'
         }

            text+='</div></div>';

      }
      if(typeForProfessor.for_header=='관리자') {
         <!-- Button trigger modal -->
         text +='<div><button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#staticBackdrop1">교수님 추가</button><div>'

      }
      prolist.append(text);
   }
   function makeModifyProModal(i) {
      var list = $('#myModalbody');
      var professor1 = <%=getProfessorList%>;
      var a = '';
      a += '<div>교수님 이름</div><input type="text" class="form-control" id="modify_pro_name" name="pro_name1" value="' + (professor1[i].prof_name) + '" placeholder="교수님 이름">'
      a += '<div>사무실 위치</div><input type="text" class="form-control" id="modify_pro_location" name="pro_location1" value="' + (professor1[i].prof_location) + '" placeholder="사무실 위치">'
      a += '<div>연락처 </div><input type="text" class="form-control" id="modify_pro_call" name="pro_call1" value="' + (professor1[i].prof_call) + '" placeholder="연락처">'
      a += '<div>이메일 </div><input type="text" class="form-control" id="modify_pro_email" name="pro_email1" value="' + (professor1[i].prof_email) + '" placeholder="이메일">'
      a += '<div>담당과목 </div><input type="text" class="form-control" id="modify_pro_lecture" name="pro_lecture1" value="' + (professor1[i].prof_lecture) + '" placeholder="담당과목">'
      a += '<div>배경색상 </div><input type="color" class="form-control" id="modify_pro_color" name="pro_color1"  value="' + (professor1[i].prof_color) + '" placeholder="#777777">'
      a+='<div>교수님 사진</div>'
      a+='<div id="fileUploadSection">'
      a+='<input type="file" name="uploadFile" id="uploadFile" accept="image/*">'
      a+='<button class="btn btn-secondary" onclick="uploadfile()"><i class="bi bi-upload"></i> 업로드</button>'
      a+='</div>'
      a+='<mark>(다른 파일들과 동일한 비율의 사진을 넣어야 예쁘게 출력됩니다.)</mark>'
       a += '<button type="button" class="btn btn-dark pull-right my-2" data-dismiss="modal" aria-label="Close" onclick="modifyProModal('+i+')">완료</button>';

      list.html(a);
   }
   var file_id; //나중에 파일 상세정보를 uploadedFile로부터 역참조 하고싶은 경우에 사용하라고 만들어둠 (꼭 사용해야 하는 것은 아님)
   var file_path; //파일이 업로드된 상대경로
   function uploadfile(){
      var formData = new FormData();
      var folder='/img/professor';//업로드 된 파일 folder 경로 설정은 여기에서 해줍니다. (마지막에 /가 오면 절대 안됩니다.)
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
                  swal.fire({
                     title : '실패',
                     icon : 'error',
                     showConfirmButton: true

                  });
               }
               else {

                  var fileLog=data.split("-/-/-");
                  file_id=fileLog[0];
                  file_folder=folder;
                  file_path=folder+'/'+fileLog[1];
                  var a='';
                  a+='<div>파일제출</div><div>'+fileLog[1]+'</div>';
                  a+='<div><a href="download.kgu?id='+file_id+'&&path='+file_folder+'"><button class="btn btn-secondary"><i class="bi bi-download"></i> 다운로드</button></a>'
                  a+='<button class="btn btn-danger" onclick="makeUploadSliderModal()"><i class="bi bi-x-circle-fill"></i> 첨부파일 수정하기</button></div>';
                  $('#fileUploadSection').html(a);
               }
            }
         })
      }else{
         swal.fire({
            title : '파일을 등록해주세요.',
            icon : 'warning',
            showConfirmButton: true

         });
      }
      // return address;
   }

   function modifyProModal(i){ // 데이터 정보 받아와서 DB에 정보 수정 후 화면에 반영
      var professor2 = <%=getProfessorList%>;
      var id = professor2[i].id;
      var prof_img='';
      if(file_path!=null)
         prof_img = file_path;
      else
         prof_img = professor2[i].prof_img

      var name = $('input[name=pro_name1]').val();
      var location1 = $('input[name=pro_location1]').val();
      var call = $('input[name=pro_call1]').val();
      var email = $('input[name=pro_email1]').val();
      var lecture = $('input[name=pro_lecture1]').val();
      var color = $('input[name=pro_color1]').val();
      var update = prof_img+"-/-/-" + name + "-/-/-" + location1 + "-/-/-" + call +  "-/-/-" + email +  "-/-/-" + lecture +  "-/-/-" + id + "-/-/-" + color;

         $.ajax({
            url : "ajax.kgu",
            type : "post",
            data : {
               req : "modifyProfessor",
               data : update
            },
            dataType : "json",
            success : function(data) {
               swal.fire({
                  title : '수정이 완료되었습니다.',
                  icon : 'success',
                  showConfirmButton: true

               }).then(function (){
                  location.reload();
               });
            }
         })
      }



   function deleteProfessor(i) {
      swal.fire({
         title: '정말로 삭제하시나요?',
         text: '다시 되돌릴 수 없습니다.',
         icon: 'warning',
         showConfirmButton: true,
         showCancelButton: true

      }).then((result) => {
         if (result.isConfirmed) {
            $.ajax({
               url: "ajax.kgu",
               type: "post",
               data: {
                  req: "deleteProfessor",
                  data: i
               },
               success: function (data) {
                  swal.fire({
                     title: '해당데이터가 삭제되었습니다.',
                     icon: 'success',
                     showConfirmButton: true

                  }).then(function () {
                     location.reload();
                  });
               }
            })
         }
      })
   }

   function insertProfessor() { //교수님 정보 추가
      var prof_img = file_path;
      var name1 = $('#add_pro_name').val();
      var location2= $('#add_pro_location').val();
      var call2= $('#add_pro_call').val();
      var email2= $('#add_pro_email').val();
      var lecture2= $('#add_pro_lecture').val();
      var color2 = $('#add_pro_color').val();
      var data2 =prof_img+'-/-/-'+name1+'-/-/-'+location2+'-/-/-'+call2+'-/-/-'+email2+'-/-/-'+lecture2+'-/-/-'+color2;



         $.ajax({
            url : "ajax.kgu",
            type : "post",
            data : {
               req : "insertProfessor",
               data : data2
            },

            success : function(data2) {
               if (data2== 'success'){
                  swal.fire({
                     title : '추가가 완료되었습니다.',
                     icon : 'success',
                     showConfirmButton: true

                  }).then(function (){
                     location.reload();
                  });
               }
               else
                  swal.fire({
                     title : '추가 실패',
                     icon : 'error',
                     showConfirmButton: true

                  });
            }

         })
      }


</script>

<div>
   <div class="team-boxed">
      <div class="container">
         <div class="row people d-flex align-content-stretch " id="professorCard"></div>
      </div>
   </div>
</div>
<!-- Modal /  교수님 수정 모달-->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">수정하기</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body" id = "myModalbody"></div>
      </div>
   </div>
</div>


<div>
   <!-- Modal / 교수님 추가 모달-->
   <div class="modal fade" id="staticBackdrop1" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel1" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="staticBackdropLabel1">교수님 추가하기</h5>
               <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="modalReset">
               <div>교수님 이름 </div>
               <input type="text" class="form-control" id="add_pro_name" name="add_pro_name1" value="" placeholder="교수님 이름">
               <div>사무실 위치</div>
               <input type="text" class="form-control" id="add_pro_location" name="add_pro_location1" value="" placeholder="사무실 위치">
               <div>연락처</div>
               <input type="text" class="form-control" id="add_pro_call" name="add_pro_call1" value="" placeholder="연락처">
               <div>이메일</div>
               <input type="text" class="form-control" id="add_pro_email" name="add_pro_email1" value="" placeholder="이메일">
               <div>담당과목</div>
               <input type="text" class="form-control" id="add_pro_lecture" name="add_pro_lecture1" value="" placeholder="담당과목">
               <div>배경색상 </div>
               <input type="color" class="form-control" id="add_pro_color" name="add_pro_color1"  value="#777777" placeholder="#777777">

               <div>교수님 사진</div>
               <div id="fileUploadSection">
                  <input type="file" name="uploadFile" id="uploadFile" accept="image/*">
                  <button class="btn btn-secondary" onclick="uploadfile()"><i class="bi bi-upload"></i> 업로드</button>
               </div>
               <mark>(다른 파일들과 동일한 비율의 사진을 넣어야 예쁘게 출력됩니다.)</mark>
               <div class="modal-footer">
                  <button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
                  <button type="button" class="btn btn-success" aria-label="Close" onclick="insertProfessor()">추가</button>
               </div>
            </div>
         </div>
      </div>
<%--modal end--%>