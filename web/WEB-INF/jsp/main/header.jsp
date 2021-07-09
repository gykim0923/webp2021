<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-06-24
  Time: 오후 6:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    /**
     * [공통] url 제어
     * */
    String major = (String)request.getAttribute("major");
    String num=(String)request.getAttribute("num");

    /**
     * [공통] 헤더 제어
     * */
    String headermenulist = (String)request.getAttribute("headermenulist");
    String menulist = (String)request.getAttribute("menulist");
    String main_url = "main.kgu?major="+major.substring(1, major.length()-1);
    String majorInfo = (String)request.getAttribute("majorInfo");

    /**
     * [공통] 로그인 정보 제어
     * */
    String user =  (String)session.getAttribute("user");
    String type =  (String)session.getAttribute("type");

    /**
     * [일부] 페이지 메뉴 제어
     * */
    String pageMenu = (String)request.getAttribute("pageMenu");
%>
<head>
    <%--    Bootstrap--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <%--    jQuery--%>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <%--    Bootstrap Table--%>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css">
    <script src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>
    <style>
        .header-title {
            height: 4rem;
        }
    </style>
</head>

<header>
    <div class="bg-secondary">
        <div class="container text-end text-white" id="member" ></div>
    </div>
    <div class="navbar navbar-dark bg-dark shadow-sm">
        <div class="container header-title">
            <a href=<%=main_url%> class="navbar-brand d-flex align-items-center">
                <h3><strong id="majorTitle"></strong></h3>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </div>
    <div class="collapse bg-dark" id="navbarHeader">
        <div class="container">
            <div class="row" id="headerMenu"></div>
        </div>
    </div>
</header>
<script> //Header Menu 제작
    $(document).ready(function(){
        makeHeaderMenu();
    })

    function makeHeaderMenu(){
        var headermenulist = <%=headermenulist%>;
        var menulist = <%=menulist%>;
        var list = $('#headerMenu');
        var text = '';

        for(var i=0; i<headermenulist.length; i++){
            text+= '<div class="col-lg py-4">'
                +'<h4 class="text-white">'+headermenulist[i].tab_title+'</h4>'
                +'<ul class="list-unstyled">'
                +'';
            for(var j=0; j<menulist.length; j++){
                if(headermenulist[i].tab_id==menulist[j].tab_id){
                    text+='<li><a href="'+menulist[j].page_path+'?num='+menulist[i].page_id+'" class="text-white">'+menulist[j].page_title+'</a></li>'
                }
            }
            text+='</ul></div>';
        }
        list.append(text);
    }

</script>
<script> //헤더 제어
    $(document).ready(function(){
        makeHeaderInfo();
        makeHeaderTitle();
    })
    function makeHeaderTitle(){
        var majorInfo =<%=majorInfo%>;
        var title = $('#majorTitle');
        title.append('경기대학교 '+majorInfo[0].major_name);
    }

    function makeHeaderInfo(){
        var user =<%=user%>;
        var type =<%=type%>;
        var it = $('#member');
        if(user == null){ //Geust
            var text = '<div class=""><a href="loginPage.kgu" title="로그인">LOGIN</a></div>';
        }
        else{ //로그인 시
            var text = '<div>안녕하세요. ' + user.name + ' ('+type.for_header+')님. ';
            if(type.for_header=='관리자'){
                text +='<a href="admin.kgu?num=90"> 관리페이지 </a> <a href="tutorial.kgu?tutorial=main"> 튜토리얼 </a>';
            }
            else{
                text +=' <a href="mypage.kgu?num=80">마이페이지</a> ';
            }
            text += '  <a href="logout.kgu" title=LOGOUT>LOGOUT</a></div>';
        }
        it.append(text);
    }


</script>

<script>
    $(document).ready(function(){ //본문 제어
        makePageHeader();
        makePageMenu();
    })

    function makePageHeader() {
        var num = <%=num%>;
        var list = $('#page_title');
        var pageMenu = <%=pageMenu%>;
        var page_title='';
        for (var i = 0; i < pageMenu.length; i++) {
            if(pageMenu[i].page_id==num){
                page_title=pageMenu[i].page_title;
            }
        }
        var text='<h2><strong>'+page_title+'</strong></h2>';
        list.append(text);
    }

    function makePageMenu() {
        var list = $('#page_menu');
        var text='';
        var pageMenu = <%=pageMenu%>;
        for (var i = 0; i < pageMenu.length; i++) {
            text+='<div><span class="deco_dot">●</span><a href="'+pageMenu[i].page_path+'?num='+pageMenu[i].page_id+'">'+ pageMenu[i].page_title + '</div>';
        }
        list.append(text);
    }
</script>
