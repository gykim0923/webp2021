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
    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">전공이름(DB로 연동예정)</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <ul class="navbar-nav me-auto mb-2 mb-md-0" id="headerMenu"></ul>
                <div class="d-flex">
<%--                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">--%>

                    <a href="login.kgu" class="btn btn-outline-success" onclick="letsSubmit()" style = "text-decoration: none;">
                        <div class="login_btn">
                            LOGIN
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </nav>
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
            text+= ''
                +'<li class="nav-item dropdown">'
                +'<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button" data-bs-toggle="dropdown" aria-expanded="false">'+headermenulist[i].tab_title+'</a>'
                +'<ul class="dropdown-menu" aria-labelledby="navbarDropdown2">';
            for(var j=0; j<menulist.length; j++){
                if(headermenulist[i].tab_id==menulist[j].tab_id){
                    text+='<li><a class="dropdown-item" href="#">'+menulist[j].page_title+'</a></li>'
                }
            }
            text+='</ul></li>';
        }
        list.append(text);
    }


</script>