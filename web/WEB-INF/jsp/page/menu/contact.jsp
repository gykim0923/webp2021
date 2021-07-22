<%--
  Created by IntelliJ IDEA.
  User: jinny
  Date: 2021-07-14
  Time: 오전 12:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
//    String typeForLab = (String)session.getAttribute("type");
    String getAllMajor = (String)request.getAttribute("getAllMajor");
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

<div>
    <div class="team-boxed">
        <div class="container" >
            <div class="intro">
                <h3 class="text-center">학과 위치 및 사무실</h3>
            </div>
            <div class="row people" id="majorCard" ></div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function(){
        makeMajorCard();
    })
    function makeMajorCard(){
        var major = <%=getAllMajor%>;
        var typeForLab = <%=type%>;
        var list = $('#majorCard');
        var text = '';

        for(var i=0; i<major.length; i++){
            text+= ''
                +'<div class="col-md-6 col-lg-4 item" >'
                +'<div class="box shadow rounded-3" style="height:350px" id="major'+i+'">'
                +'<div class="py-4">'
                // +'<img  onerror="this.src=\'http://placehold.it/100x100\'" id="laboratoryImg" class="rounded-circle" src="' + major[i].lab_img + '">'
                +'<h4 class="name">'+major[i].major_name+'</h4>'
                +'<p class="title">연구실 위치 : '+major[i].major_location+'</p>'
                +'<p class="description">연구실 전화번호 : '+major[i].major_contact+'</p>';
            text+='</div></div></div>';
        }
        list.append(text);
    }

</script>