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

      }
      prolist.append(text);
   }
   function makeModifyProModal(i) {
      var list = $('#myModalbody');
      var professor1 = <%=getProfessorList%>;
      var a = '';
      a += '<div>교수님 이름</div><input type="text" class="form-control" id="modify_pro_name" name="pro_name1" value="' + (professor1[i].pro_name) + '" placeholder="pro_name">'
      a += '<div>사무실 위치</div><input type="text" class="form-control" id="modify_pro_location" name="pro_location1" value="' + (professor1[i].pro_location) + '" placeholder="pro_location">'
      a += '<div>연락처 </div><input type="text" class="form-control" id="modify_pro_call" name="pro_call1" value="' + (professor1[i].pro_call) + '" placeholder="pro_call">'
      a += '<div>이메일 </div><input type="text" class="form-control" id="modify_pro_email" name="pro_email1" value="' + (professor1[i].pro_email) + '" placeholder="pro_email">'
      a += '<div>담당과목 </div><input type="text" class="form-control" id="modify_pro_lecture" name="pro_lecture1" value="' + (professor1[i].pro_lecture) + '" placeholder="pro_lecture">'
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
      if (check) {
         $.ajax({
            url: "ajax.kgu",
            type: "post",
            data: {
               req: "deleteProfessor",
               data: i
            },
            success: function (data) {
               alert("해당 데이터가 삭제되었습니다.");
               location.reload()
            }
         })
      }
   }

   function insertPro() { //교수님 정보 추가
      var name1 = $('#add_pro_name').val();
      var location2= $('#add_pro_location').val();
      var call2= $('#add_pro_call').val();
      var email2= $('#add_pro_email').val();
      var lecture2= $('#add_pro_lecture').val();
      var data2 =name1+'-/-/-'+location2+'-/-/-'+call2+'-/-/-'+email2+'-/-/-'+lecture2;


      var check = confirm("정말 추가하시겠습니까?");
      if(check){
         $.ajax({
            url : "ajax.kgu",
            type : "post",
            data : {
               req : "insertProfessor",
               data : data2
            },

            dataType : "json",
            success : function(data2) {
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
<!-- Modal /  교수님 수정 모달-->
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
               <input type="text" class="form-control" id="add_pro_name" name="add_pro_name1" value="" placeholder="pro_name">
               <div>사무실 위치</div>
               <input type="text" class="form-control" id="add_pro_location" name="add_pro_location1" value="" placeholder="pro_location">
               <div>연락처</div>
               <input type="text" class="form-control" id="add_pro_call" name="add_pro_call1" value="" placeholder="pro_call">
               <div>이메일</div>
               <input type="text" class="form-control" id="add_pro_email" name="add_pro_email1" value="" placeholder="pro_email">
               <div>담당과목</div>
               <input type="text" class="form-control" id="add_pro_lecture" name="add_pro_lecture1" value="" placeholder="pro_lecture">
               <div>
                  <div>
                     <form style="display : inline-block" name="fileform" id="fileform" action="" method="post" enctype="multipart/form-data">
                        <input type="text" name="ProfessorID" value="' +it.id+ '" hidden>
                        <input style="display : inline-block" type="file" name="uploadFile" id="uploadFile" accept=".jpg, .jpeg, .png">
                        <button type="button" class="btn btn-secondary my-2" data-dismiss="modal" onclick="modifyImage()">사진 수정</button>
                     </form>
                  </div>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                  <button type="button" class="btn btn-secondary" aria-label="Close" onclick="insertProfessor()">추가</button>
               </div>
            </div>
         </div>
      </div>
<%--modal end--%>