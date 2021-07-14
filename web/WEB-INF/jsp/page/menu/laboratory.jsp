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
            var l = laboratory+i;
            text+= ''
                +'<div class="col-md-6 col-lg-4 item" >'
                +'<div class="box shadow rounded-3" style="height:450px" id="l">'
                +'<div class="py-4">'
                +'<img id="laboratoryImg" class="rounded-circle" src="'+laboratory[i].lab_img+'">'
                +'<h4 class="name">'+laboratory[i].lab_name+'</h4>'
                +'<p class="title">연구실위치:'+laboratory[i].lab_location+'</p>'
                +'<p class="description"><a href="'+laboratory[i].lab_homepage+'">연구실홈페이지</a><p>';
            if(typeForLab.for_header=='관리자') {
                text += '<div><button class="btn btn-secondary mx-2" onclick="modifyLaboratory('+(laboratory[i].id)+')">수정</button><button class="btn btn-secondary mx-2" onclick="deleteLaboratory('+ (laboratory[i].id)+')">삭제</button></div>'
            }
            text+='</div>'
                +'</div></div>';
        }
        if(typeForLab.for_header=='관리자') {
            text += '<div><button class="btn btn-secondary mx-2" onclick="insertLab()">추가</button></div>'
        }
        list.append(text);
    }

</script>

<script>
    function modifyLaboratory(i) { // 데이터 수정
        var laboratory = <%=getLaboratoryList%>;
        var m = $('#l');
        $.ajax({
            url : "ajax.kgu",
            type : "post",
            data : {
                req : "getOneLaboratory",
                data : i
            },
            dataType : "json",
            success : function(data) {
                var a = '';
                $('#laboratoryImg'+i).css('width', '460px');
                var it = data;
                a += '<div><img id="whatImage" src="img/laboratory/'+it.lab_img+'"><form style="display : inline-block" name="fileform" id="fileform" action="" method="post" enctype="multipart/form-data"><input type="text" name="LaboratoryID" value="' +it.id+ '" hidden><input style="display : inline-block" type="file" name="uploadFile" id="uploadFile" accept=".jpg, .jpeg, .png"><a onclick="modifyImage()"><button type="button" class="btn btn-default pull-right">사진 수정</button></a></form></div>';
              //  a +='<div class="input-group mb-3">'
                a +='<div class="input-group-prepend my-1">'
                a += '<span class="input-group-text" id="inputGroup-sizing-default">연구실이름</span>'
                a += '</div>'
                a += '<input type="text" class="form-control" name="lab_name1" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">'
               // a += '</div>'
               // a +='<div class="input-group mb-3">'
                a +='<div class="input-group-prepend my-1">'
                a += '<span class="input-group-text" id="inputGroup-sizing-default">연구실위치</span>'
                a += '</div>'
                a += '<input type="text" class="form-control" name="lab_location1" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">'
               // a += '</div>'
               // a +='<div class="input-group mb-3">'
                a +='<div class="input-group-prepend my-1">'
                a += '<span class="input-group-text" id="inputGroup-sizing-default">연구실홈페이지</span>'
                //a += '</div>'
                a += '<input type="text" class="form-control" name="lab_homepage1" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">'
                a += '</div>'
                a += '<div>'
                a += '<div><button onclick="modifyLab(' + it.id + ')" class="btn btn-secondary mx-2 btn float-right">완료</button></div>'
                a += '<div><button onclick="back()" class="btn btn-secondary mx-2 btn float-right">뒤로가기</button></div>'
                a += '</dib>'
                m.html(a);
            }
        })
    }
    function back(){
        window.location.href = "laboratory.kgu";
    }


    function modifyImage(){ // 이미지 수정(업로드)
        var formData = new FormData();
        formData.append("LaboratoryID",$('input[name=LaboratoryID]').val());
        formData.append("uploadFile",$('input[type=file]')[0].files[0]);
        $.ajax({
            url : "changeLabImage.kgu",
            type : "post",
            data : formData,
            processData : false,
            contentType : false,
            success : function(data) {
                var a = '';
                a += '<img src="img/laboratory/'+data+'" alt="" class="profile">';
                $('#whatImage').attr('src',data);
            }
        })
    }

    function insertLab() { // 연구실 정보 추가
        var formData = new FormData();
        formData.append("lab_img",$('input[name=uploadFile]')[0].files[0]);
        formData.append("lab_name", $('[name=lab_name]').val());
        formData.append("lab_location", $('[name=lab_location]').val());
        formData.append("lab_homepage", $('[name=lab_homepage]').val());

        var check = confirm("정말 추가하시겠습니까?");
        if(check){
            $
                .ajax({
                    url : "insertLab.kgu",
                    type : "post",
                    data : formData,
                    processData : false,
                    contentType : false,
                    dataType : "json",
                    success : function(data) {
                        alert("추가가 완료되었습니다");
                        var it = data;
                        var lab=$("#laboratory");
                        var b='';
                        lab.append('<div id="laboratory_profile' + (it.id) + '"" style="display:inline;"><div style="display:inline-block;" id="lab_profile'+ (it.id) +'"><div id="image'+(it.id)+'" style="display:inline;"><a href ="'+it.lab_homepage+'"><img src="img/laboratory/'+it.lab_img+'" alt="" class="profile"></a></div>'
                            + '<dl id="laboratorydl'+(it.id)+'" class="dl-style">'
                            +'<dd><div class="contenttitle">' + it.lab_name + ' 연구실<div style = "padding : 0;" class = "btn pull-right"></div></dd>'
                            +'<dd>연구실 위치 : ' + it.lab_location + '</dd>'
                            +'<dd><a href ="'+it.lab_homepage+'">홈페이지 : ' + it.lab_homepage + '</a></dd></dl></div>');
                        if (type.type_name == '관리자'||type.type_name == '홈페이지관리자'){
                            var editpanel = $('#laboratory_profile' + (it.id));
                            editpanel.append('<div id="editbtn'+it.id+'" style="display:inline-block; vertical-align:top; margin-left:25px;"><a onclick="modifyLaboratory('+(it.id)+')" class="btn btn-default" style="height:34px;">수정</a>'+
                                '<a onclick="deleteLaboratory('+ (it.id)+')" class="btn btn-default" style="height:34px;">삭제</a></div>');
                            var b = $('#laboratory_profile' + (it.id));
                            b.append('<hr style="border: solid 1px lightgray;"/>');
                        }
                        $('#insertlaboratory')
                            .html(
                                '<a onclick ="insertLaboratory()"><button type ="button" class="btn btn-default pull-right">추가</button></a>');
                    }
                })
        }
    }

    function modifyLab(i) {
        var m = $('#laboratoryEdit');
        var typeForLab = <%=typeForLab%>;
        var laboratory = <%=getLaboratoryList%>;
        var id = i;
        var name = $('input[name=lab_name1]').val();
        var location = $('input[name=lab_location1]').val();
        var homepage = $('input[name=lab_homepage1]').val();
        var update = name + "-/-/-" + location + "-/-/-" + homepage +  "-/-/-" + id;
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
                        window.location.href = "laboratory.kgu";
                    }
            })
        }
    }

    function deleteLaboratory(i){
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
