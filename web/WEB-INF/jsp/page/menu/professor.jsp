<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
   String typeForProfessor = (String)session.getAttribute("type");
   String getProfessorList = (String) request.getAttribute("getProfessorlist");
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
         text+='<div class="col-12 py-2"><div class="shadow rounded-3" ><div class="p-5">'
                 +'<div id="image'+i+'" style=" display : inline"><img src="/img/professor/'+professor[i].prof_img+'"width="110px"  align ="left"  ></div>'
                 +'<div class ="name" ><b>'+professor[i].prof_name+' 교수</b></div>'
                 +'<div class ="location">사무실위치 : '+professor[i].prof_location+'</div>'
                 +'<div class ="call">연락처 : '+professor[i].prof_call+'</div>'
                 +'<div class ="email">이메일 : '+professor[i].prof_email+'</div>'
                 +'<div class ="lecture">담당과목 : '+professor[i].prof_lecture+'</div>'

               if(typeForProfessor.for_header=='관리자') {
                  text += '<div><button class="btn btn-secondary mx-2" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeModifyProModal('+(professor[i].id)+')">수정</button>'
                          +'<button class="btn btn-secondary mx-2" onclick="deleteProfessor('+ (professor[i].id)+')">삭제</button></div>'
                  // text += '<a onclick="modifyProfessor(' + (prolist[i].id) + ')"><button type="button" style = "margin : 2px;" class="btn btn-default">수정</button></a>'
                  //         + '<a onclick="deleteProfessor(' + (prolist[i].id) + ')"><button type="button" style = "margin : 2px;" class="btn btn-default">삭제</button></a>'
               }


            text+='</div></div></div>';

      }
      if(typeForProfessor.for_header=='관리자') {
         <!-- Button trigger modal -->
         text +='<div><button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#staticBackdrop1">교수님 추가</button><div>'
         // '<div><button class="btn btn-secondary mx-2" onclick="insertLab()">추가</button></div>'
      }
      prolist.append(text);
   }
   function makeModifyProModal(i) {
      var list = $('#myModalbody');
      var professor1 = <%=getProfessorList%>;
      var a = '';
      a += '<div>교숫님 이름</div><input type="text" class="form-control" id="modify_prosfessor_name" name="prosfessor_name1" value="' + (prosfessor1[i - 1].prosfessor_name) + '" placeholder="prosfessor_name">'
      a += '<div>사무실 위치</div><input type="text" class="form-control" id="modify_prosfessor_location" name="prosfessor_location1" value="' + (prosfessor1[i - 1].prosfessor_location) + '" placeholder="prosfessor_location">'
      a += '<div>연락처 </div><input type="text" class="form-control" id="modify_prosfessor_call" name="prosfessor_call1" value="' + (prosfessor1[i - 1].prosfessor_call) + '" placeholder="prosfessor_call">'
      a += '<div>이메일 </div><input type="text" class="form-control" id="modify_prosfessor_email" name="prosfessor_email1" value="' + (prosfessor1[i - 1].prosfessor_email) + '" placeholder="prosfessor_email">'
      a += '<div>담당과목 </div><input type="text" class="form-control" id="modify_prosfessor_lecture" name="prosfessor_lecture1" value="' + (prosfessor1[i - 1].prosfessor_lecture) + '" placeholder="prosfessor_lecture">'
      a += '<div><form style="display : inline-block" name="fileform" id="fileform" action="" method="post" enctype="multipart/form-data">'
      a += '<input type="text" name="ProfessorID" value="' + i.id + '" hidden>'
      a += '<input style="display : inline-block" type="file" name="uploadFile" id="uploadFile" accept=".jpg, .jpeg, .png">'
      a += '<button type="button" class="btn btn-secondary my-2" data-dismiss="modal" onclick="modifyImage()">사진 수정</button></form></div>'
      a += '<button type="button" class="btn btn-dark pull-right my-2" data-dismiss="modal" aria-label="Close" onclick="modifyProModal(' + i + ')">완료</button>';
      list.html(a);
   }
   function modifyProModal(i){ // 데이터 정보 받아와서 DB에 정보 수정 후 화면에 반영
      var id = i;
      var name = $('input[name=professor_name1]').val();
      var location = $('input[name=professor_location1]').val();
      var call = $('input[name=professor_call1]').val();
      var email = $('input[name=professor_email]').val();
      var lecture = $('input[name=professor_lecture1]').val();
      var update = name + "-/-/-" + location + "-/-/-" + call +  "-/-/-" + email +  "-/-/-"+ lecture +  "-/-/-"+ id;
      var check = confirm("정말 수정하시겠습니까?");
      if(check){
         $.ajax({
            url : "ajax.kgu",
            type : "post",
            data : {
               req : "modifyProfessor",
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
   function modifyImage(){ // 이미지 수정(업로드)
      var formData = new FormData();
      formData.append("ProfessorLID",$('input[name=ProfessorID]').val());
      formData.append("uploadFile",$('input[type=file]')[0].files[0]);
      $.ajax({
         url : "changeProfessorImage.kgu",
         type : "post",
         data : formData,
         processData : false,
         contentType : false,
         success : function(data) {
            var a = '';
            a += '<img src="img/professor/'+data+'" alt="" class="profile">';
            $('#whatImage').attr('src',data);
         }
      })
   }


   function deleteProfessor(i) {
      var check = confirm("[중요] 정말로 이 데이터를 삭제하시나요? 취소하실 수 없습니다.");
         $.ajax({
            url : "ajax.kgu",
            type : "post",
            data : {
               req : "deleteProfessor",
               data : i
            },
            success : function(data) {
               alert("해당 데이터가 삭제되었습니다.");
               location.reload()
            }
         })
      }

   function insertProfess() { // 연구실 정보 추가
      var name1 = $('#add_lab_name').val();
      var location2= $('#add_lab_location').val();
      var homepage2= $('#add_lab_homepage').val();
      var data2 =name1+'-/-/-'+location2+'-/-/-'+homepage2;
      // var formData = new FormData();
      // formData.append("lab_img",$('input[name=uploadFile]')[0].files[0]);
      // formData.append("lab_name", $('input[name=add_lab_name1]').val());
      // formData.append("lab_location", $('input[name=add_lab_location1]').val());
      // formData.append("lab_homepage", $('input[name=add_lab_homepage1]').val());

      var check = confirm("정말 추가하시겠습니까?");
      if(check){
         $.ajax({
            url : "ajax.kgu",
            type : "post",
            data : {
               req : "insertProfessor",
               data : data2
            },
            // processData : false,
            //  contentType : false,
            dataType : "json",
            success : function(data) {
               alert("추가가 완료되었습니다");
               location.reload();
            }
         })
      }
   }
</script>

<div>
   <div class="team-boxed">
      <div class="container">
         <div class="intro">
            <h3 class="text-center">교수진</h3>
         </div>
         <div class="row people" id="professorCard"></div>
      </div>
   </div>
</div>