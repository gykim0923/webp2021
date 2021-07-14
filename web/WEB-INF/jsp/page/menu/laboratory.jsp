<%--
  Created by IntelliJ IDEA.
  User: jinny
  Date: 2021-07-14
  Time: 오전 12:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String typeForInformation = (String)session.getAttribute("type");
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
        makeLabCard();
    })
    function makeLabCard(){
        var laboratory = <%=getLaboratoryList%>;
        var list = $('#labCard');
        var text = '';

        for(var i=0; i<laboratory.length; i++){
            text+= ''
                +'<div class="col-md-6 col-lg-4 item">'
                +'<div class="box shadow rounded-3"><img class="rounded-circle" src="'+laboratory[i].lab_img+'">'
                +'<h4 class="name">'+laboratory[i].lab_name+'</h4>'
                +'<p class="title">연구실위치:'+laboratory[i].lab_location+'</p>'
                +'<p class="description"><a href="'+laboratory[i].lab_homepage+'">연구실홈페이지</a><p>'
                +'</div>'
                +'</div>'

        }
        list.append(text);
    }
</script>

<div>
    <div class="team-boxed">
    <div class="container">
        <div class="intro">
            <h3 class="text-center">연구실</h3>
            </div>
        <div class="row people" id="labCard"></div>
       </div>
    </div>
</div>
