<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-06-24
  Time: 오후 6:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    String headermenulist = (String)session.getAttribute("headermenulist");
    String menulist = (String)session.getAttribute("menulist");
    String user =  (String)session.getAttribute("user");
    String type =  (String)session.getAttribute("type");
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
</head>

<header>
<%--    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">--%>
<%--        <div class="container-fluid">--%>
<%--            <a class="navbar-brand" href="#">전공이름(DB로 연동예정)</a>--%>
<%--            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">--%>
<%--                <span class="navbar-toggler-icon"></span>--%>
<%--            </button>--%>
<%--            <div class="collapse navbar-collapse" id="navbarCollapse">--%>
<%--                <ul class="navbar-nav me-auto mb-2 mb-md-0" id="headerMenu"></ul>--%>
<%--                <div class="d-flex">--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </nav>--%>
    <div class="navbar navbar-dark bg-dark shadow-sm">
        <div class="col-12" id="member"></div>
        <div class="container">
            <a href="#" class="navbar-brand d-flex align-items-center">
                <strong>학과이름은 DB에서 연동예정</strong>
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
<script>
    $(document).ready(function(){
        makeHeaderMenu();
    })

    function makeHeaderMenu(){
        var headermenulist = <%=headermenulist%>;
        var menulist = <%=menulist%>;
        var list = $('#headerMenu');
        var text = '';

        for(var i=0; i<headermenulist.length; i++){
            text+= '<div class="col-lg-2 py-4">'
                +'<h4 class="text-white">'+headermenulist[i].tab_title+'</h4>'
                +'<ul class="list-unstyled">'
                +'';
            for(var j=0; j<menulist.length; j++){
                if(headermenulist[i].tab_id==menulist[j].tab_id){
                    text+='<li><a href="'+menulist[j].page_path+'" class="text-white">'+menulist[j].page_title+'</a></li>'
                }
            }
            text+='</ul></div>';
        }
        list.append(text);
    }






</script>
<script>
    var user =<%=user%>;
    var type =<%=type%>;
    var it = $('#member');
    var graduation = '';
    if(user == null){
        var text = '<div><a href="loginPage.kgu" title="로그인">LOGIN</a></div>';
    }
    else{ //임시
        var text = '<div id="login_info text-white">안녕하세요. ' + user.name + ' (for_header)님</div><div><a href="#">마이페이지</a></div><div><a href="logout.kgu" title=LOGOUT>LOGOUT</a></div>';
    }
    // else if(type.board_level == 0){
    //     var text = '<div id="login_info">안녕하세요. ' + user.name + ' ('+type.for_header+')님</div><div><a href="admin.do?num=81" title="관리페이지">관리페이지</a></div><div><a href="logout.do" title=LOGOUT>LOGOUT</a></div>';
    // }
    // else{
    //     var text = '<div id="login_info">안녕하세요. ' + user.name + ' ('+type.for_header+')님</div><div><a href="goMyPage.do">마이페이지</a></div><div><a href="logout.do" title=LOGOUT>LOGOUT</a></div>';
    // }
    it.append(text);
</script>