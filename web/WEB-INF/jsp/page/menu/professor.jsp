
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

            text+='<div id="image'+i+'" style=" display : inline"><img src="/img/professor/'+professor[i].prof_img+'"></div>'

                    +'<div class ="name">교수 : '+professor[i].prof_name+'</div>'
                    +'<div class ="email">이메일 : '+professor[i].prof_email+'교수</div>'
                    +'<div class ="lecture">담당과목 : '+professor[i].prof_lecture+'교수</div>'
                    +'<div class ="location">사무실위치 : '+professor[i].prof_location+'교수</div>'
                    +'<div class ="call">연락처 : '+professor[i].prof_call+'교수</div>'
            if(typeForProfessor.for_header=='관리자'){
              text+='<a onclick="modifyProfessor('+(prolist[i].id)+')"><button type="button" style = "margin : 2px;" class="btn btn-default">수정</button></a>'
                    +'<a onclick="deleteProfessor('+(prolist[i].id)+')"><button type="button" style = "margin : 2px;" class="btn btn-default">삭제</button></a>'

            }

         }
         prolist.append(text);
      }
         function modifyProfessor(i) {
            $.ajax({
               url : "ajax.kgu",
               type : "post",
               data : {
                  req : "getoneprofessor",
                  data : i
               },
               dataType : "json",
               success : function(data) {
                  var a = '';
                  var it = data;
                  a += '<div><form style="display : inline-block" name="fileform" id="fileform" action="" method="post" enctype="multipart/form-data"><input type="text" name="ProfessorID" value="' +it.id+ '" hidden><input style="display : inline-block" type="file" name="uploadFile" id="uploadFile" accept=".jpg, .jpeg, .png"><a onclick="modifyImage()"><button type="button" class="btn btn-default pull-right" style="display : inline-block">사진 수정</button></a></form></div>';
                  a += '<dd>이름 :<input type="text" class="form-control" name="prof_name1" id="professor" value="'+it.prof_name+'"></dd>';
                  a += '<dd>이메일 :<input type="text" class="form-control" name="prof_location1" id="professor" value="'+it.prof_location+'"></dd>';
                  a += '<dd>담당과목 :<input type="text" class="form-control" name="prof_call1" id="professor" value="'+it.prof_call+'"></dd>';
                  a += '<dd>사무실위치 :<input type="text" class="form-control" name="prof_email1" id="professor" value="'+it.prof_email+'"></dd>';
                  a += '<dd>전화번호 :<input type="text" class="form-control" name="prof_lecture1" id="professor" value='+it.prof_lecture+'></dd>';
                  a += '<a onclick="modifyPro('
                          + it.id
                          + ')"><button type="button" class="btn btn-default pull-right">정보 수정</button></a>';

                  $('#professor' + (it.id)).html(a);
               }
            })
         }

         function deleteProfessor(i) {
            var check = confirm("정말 삭제하시겠습니까?");
            if(check){
               $.ajax({
                  url : "ajax.kgu",
                  type : "post",
                  data : {
                     req : "deleteProfessor",
                     data : i
                  },
                  success : function(data) {
                     alert("삭제 되었습니다");
                     var a = '';
                     $('#professor_profile' + i).html(a);
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
