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
    String menuTabList = (String)request.getAttribute("menuTabList");
    String menuPageList = (String)request.getAttribute("menuPageList");
    String majorInfo = (String)request.getAttribute("majorInfo");
    String majorAllInfo = (String)request.getAttribute("majorAllInfo");

    /**
     * [공통] 로그인 정보 제어
     * */
    String user =  (String)session.getAttribute("user");
    String type =  (String)session.getAttribute("type");

%>
<head>

    <!-- content에 자신의 OAuth2.0 클라이언트ID를 넣습니다. -->
    <meta name ="google-signin-client_id" content="961716324050-r6i9dib682nsqjotloum1igkvf1jm0og.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>

    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0">

    <%--    Bootstrap    --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    <%--    jQuery    --%>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>

    <%--    Bootstrap Table    --%>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css">
    <script src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>

    <%--    ckeditor    --%>
    <script src="//cdn.ckeditor.com/4.8.0/standard/ckeditor.js"></script>

    <%--    icon    --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

    <style>
        #headerTitle {
            height: 4rem;
        }
    </style>
</head>

<header>
    <div class="bg-secondary">
        <div class="container text-end text-white" id="user"></div>
    </div>
    <div class="navbar navbar-light bg-light shadow-sm">
        <div class="container" id="headerTitle">
            <a class="navbar-brand d-flex align-items-center" href="main.kgu">
                <h3><strong id="majorTitle"></strong></h3>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </div>
    <div class="collapse" id="navbarHeader">
        <div class="container">
            <div class="row" id="headerContent"></div>
        </div>
    </div>
</header>

<script>
    $(document).ready(function(){
        makeHeaderUserInfo(); //Header User Info 제작
        makeHeaderTitle(); //Header Title 제작
        makeHeaderMenu(); //Header Menu 제작
    })

    function makeHeaderMenu(){
        var menuTabList = <%=menuTabList%>;
        var menuPageList = <%=menuPageList%>;
        var majorAllInfo = <%=majorAllInfo%>;
        var major=<%=major%>;
        var list = $('#headerContent');
        var text = '';
        //기본 메뉴
        for(var i=0; i<3; i++){
            text+= '<div class="col-lg py-lg-4 py-2">'
                +'<h4 class="text-dark">'+menuTabList[i].tab_title+'</h4>'
                +'<ul class="list-unstyled">'
                +'';
            for(var j=0; j<menuPageList.length; j++){
                if(menuTabList[i].tab_id==menuPageList[j].tab_id){
                    text+='<li><a href="'+menuPageList[j].page_path+'?major=main&&num='+menuPageList[j].page_id+'" class="text-dark">'+menuPageList[j].page_title+'</a></li>'
                }
            }
            text+='</ul></div>';
        }

        //전공 선택
        text+= '<div class="col-lg py-lg-4 py-2">'
            +'<h4 class="text-dark">'+menuTabList[3].tab_title+'</h4>'
            +'<ul class="list-unstyled">'
            +'';
        for(var j=0; j<majorAllInfo.length; j++){
            text+='<li onclick="makeHeaderMajorBBS('+j+')">'+majorAllInfo[j].major_name+'</li>'
        }
        text+='</ul></div>';

        //전공 뜨는 곳
        text+= '<div class="col-lg py-lg-4 py-2">'
            +'<h4 class="text-dark" id="majorBBStitle">'+menuTabList[4].tab_title+'</h4>'
            +'<ul class="list-unstyled" id="majorBBSname">'
            +'';
        text+='</ul></div>';

        list.append(text);
    }


    //헤더 제어
    function makeHeaderMajorBBS(i){
        var menuPageList = <%=menuPageList%>;
        var majorAllInfo = <%=majorAllInfo%>;
        var major = majorAllInfo[i];
        var majorBBStitle = $('#majorBBStitle');
        majorBBStitle.html(major.major_name);
        var list = $('#majorBBSname');
        var text='';
        for (var j=0; j<menuPageList.length; j++){
            if (menuPageList[j].tab_id==5){
                var url = menuPageList[j].page_path+'?major='+major.major_id+'&&num='+menuPageList[j].page_id;
                text += '<li><a href="'+url+'">'+menuPageList[j].page_title+'</a></li>';
            }
        }
        list.html(text);
    }

    function makeHeaderTitle(){
        var majorAllInfo =<%=majorAllInfo%>;
        var title = $('#majorTitle');
        title.append('경기대학교 '+majorAllInfo[0].major_name);
    }

    function makeHeaderUserInfo(){
        var major=<%=major%>;
        var user =<%=user%>;
        var type =<%=type%>;
        var it = $('#user');
        if(user == null){ //Guest
            var text = '<div><a href="loginPage_v2.kgu" title="로그인" class="text-white">LOGIN</a></div>';
            text += '<div><a href="loginPage.kgu" title="로그인" class="text-white">LOGIN(OLD)</a></div>';
        }
        else{ //로그인 시
            var text = '<div>안녕하세요. ' + user.name + ' ('+type.for_header+')님. ';
            if(type.for_header=='관리자'){
                text +='<a href="admin.kgu?num=70" class="text-white"> 관리페이지 </a> '
            }
            else{
                text +=' <a href="mypage.kgu?major='+major+'&&num=60" class="text-white">마이페이지</a> ';
            }
            text +='<a href="#" onclick="signOut();">Sign out</a>'
                +'  <a href="logout.kgu" class="text-white" title=LOGOUT>LOGOUT(OLD)</a></div>';
        }
        it.append(text);
    }

    function signOut() {
        var auth2 = gapi.auth2.getAuthInstance();
        auth2.signOut().then(function () {
            console.log('User signed out.');
            window.location.href='logout.kgu';
        });
    }

    function onLoad() {
        gapi.load('auth2', function() {
            gapi.auth2.init();
        });
    }

</script>
