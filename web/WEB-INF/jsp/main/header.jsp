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
    <div id="headercontainer">
        <div id="member">
        </div>
    </div>
</header>


<%
    StringBuffer url2_ = request.getRequestURL();
    String logo_img;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_.substring(7,9).equals("ai") || url2_.substring(7,9).equals("lo")){
        logo_img = "img/ai_logo.png";
        out.print("<link href='css/default_ai.css' rel='stylesheet' type='text/css'>");
    }
    else{
        logo_img = "img/cs_logo.png";
        out.print("<link href='css/default.css' rel='stylesheet' type='text/css'>");
    }
%>
<header2>
    <div id="headercontainer2">
        <div id="logo_container">
            <a href="Index"><img src=<%=logo_img%> id="logo" title=""></a>
        </div>
        <div id="headermenu">
            <span class="divide">|</span>
        </div>
        <div id="dropcontainer">
            <div id="no-padding" class="dropdowncontents">
                <div id="drop_menu">
                    <script>

                        var headermenu = <%=headermenulist%>;
                        var div = $('#headermenu');

                        <%--var myurl = window.location.href.slice(7,9);--%>
                        <%--if ((myurl == "lo") || (myurl == "ai")) {--%>
                        <%--    //ai 사이트면 메뉴 7개 정상적으로 불러옴.--%>
                        <%--    for (var i = 0; i < 7; i++) {--%>
                        <%--        var it = headermenu[i];--%>
                        <%--        var text = '';--%>
                        <%--        if(it.tab_title == '신청하기' && <%=user%> == null)--%>
                        <%--            text = '<div id=head'+ (i+1) +' style="font-size : 17px">' + it.tab_title + '</div><span class="divide">|</span>';--%>
                        <%--        else--%>
                        <%--            text = '<div id=head'+ (i+1) +'><a href="'+it.tab_url+'">' + it.tab_title + '</a></div><span class="divide">|</span>';--%>

                        <%--        div.append(text);--%>
                        <%--    }--%>

                        <%--    var menu = <%=menulist%>;--%>
                        <%--    var type = <%=type%>;--%>
                        <%--    var drop = $('#drop_menu');--%>
                        <%--    var it;--%>
                        <%--    var seqNum = 1;--%>
                        <%--    drop.append('<ul id="list2' + seqNum + '">');--%>
                        <%--    for (var i = 0; i < menu.length ; ++i) {--%>
                        <%--        it = menu[i];--%>
                        <%--        if (seqNum != it.tab_id && it.tab_id < 8) {--%>
                        <%--            drop.append('</ul>');--%>
                        <%--            seqNum = it.tab_id;--%>
                        <%--            drop.append('<ul id="list2'+seqNum+'">');--%>
                        <%--        }--%>
                        <%--        var list = $('#list2' + seqNum);--%>
                        <%--        if (it.show_in_menus && it.tab_id < 8){--%>
                        <%--            if(it.max_level >= type.board_level && it.min_level <= type.board_level){--%>
                        <%--                var num = it.tab_id*10+it.orderNum;--%>
                        <%--                if(it.page_title == '졸업논문' || it.page_title == '나의 이수 현황'|| it.page_title == '사물함 신청')--%>
                        <%--                    var text = '<li><a href="'+it.path+'">' + it.page_title + '</a></li>';--%>
                        <%--                else--%>
                        <%--                    var text = '<li><a href="' + it.path + '?num=' + num + '">' + it.page_title + '</a></li>';--%>
                        <%--                list.append(text);--%>
                        <%--            }--%>
                        <%--            else{--%>
                        <%--                var text = '<li>' + it.page_title + '</li>';--%>
                        <%--                list.append(text);--%>
                        <%--            }--%>
                        <%--        }--%>
                        <%--    }--%>
                        <%--    drop.append('</ul>');--%>
                        <%--}--%>
                        <%--else{--%>
                            //cs 사이트면 메뉴 6개만 불러오고 마지막을 공백div로 채움. (ai탭 안보이도록하려고)
                            for (var i = 0; i < 2; i++) {
                                var it = headermenu[i];
                                var text = '';
                                if(it.tab_title == '신청하기' && <%=user%> == null)
                                    text = '<div id=head'+ (i+1) +' style="font-size : 17px">' + it.tab_title + '</div><span class="divide">|</span>';
                                else
                                    text = '<div id=head'+ (i+1) +'><a href="'+it.tab_url+'">' + it.tab_title + '</a></div><span class="divide">|</span>';


                                div.append(text);
                            }
                            div.append('<div style="font-size: 17px"></div>')

                            //헤더 tab 끝

                            var menu = <%=menulist%>;
                            var type = <%=type%>;
                            var drop = $('#drop_menu');
                            var it;
                            var seqNum = 1;

                            drop.append('<ul id="list2' + seqNum + '">');
                            for (var i = 0; i < menu.length ; ++i) {

                                it = menu[i];
                                if (it.tab_id == 7) { continue; }  //ai탭 (tabid=7) 이면 하위메뉴추가안하고 넘겼음.

                                if (seqNum != it.tab_id && it.tab_id < 8) {
                                    drop.append('</ul>');
                                    seqNum = it.tab_id;
                                    drop.append('<ul id="list2'+seqNum+'">');
                                }
                                var list = $('#list2' + seqNum);
                                if (it.show_in_menus && it.tab_id < 8){
                                    if(it.max_level >= type.board_level && it.min_level <= type.board_level){
                                        var num = it.tab_id*10+it.orderNum;
                                        if(it.page_title == '졸업논문' || it.page_title == '나의 이수 현황')
                                            var text = '<li><a href="'+it.path+'">' + it.page_title + '</a></li>';
                                        else
                                            var text = '<li><a href="' + it.path + '?num=' + num + '">' + it.page_title + '</a></li>';
                                        list.append(text);
                                    }
                                    else{
                                        var text = '<li>' + it.page_title + '</li>';
                                        list.append(text);
                                    }
                                }
                            }
                            drop.append('</ul>');

                        // }



                    </script>
                </div>
            </div>
        </div>
    </div>
</header2>
<script>
    $(document).ready(function() {
        var headermenu = $('#headermenu').width();
        $('#drop_menu').css('width', headermenu);
    });


    var user =<%=user%>;
    var type =<%=type%>;
    var it = $('#member');
    var graduation = '';
    if(user == null)
        var text = '<div><a href="loginpage.do" title="로그인">LOGIN</a></div>';
    else if(type.board_level == 0)
        var text = '<div id="login_info">안녕하세요. ' + user.name + ' ('+type.for_header+')님</div><div><a href="admin.do?num=81" title="관리페이지">관리페이지</a></div><div><a href="logout.do" title=LOGOUT>LOGOUT</a></div>';
    else
        var text = '<div id="login_info">안녕하세요. ' + user.name + ' ('+type.for_header+')님</div><div><a href="goMyPage.do">마이페이지</a></div><div><a href="logout.do" title=LOGOUT>LOGOUT</a></div>';
    it.append(text);
</script>