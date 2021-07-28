<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-28
  Time: 오후 4:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

</head>


<header class="z-10 py-4 bg-white shadow-md dark:bg-gray-800">
    <div
            class="container flex items-center justify-between h-full px-6 mx-auto text-purple-600 dark:text-purple-300"
    >
        <!-- Mobile hamburger -->
        <button
                class="p-1 mr-5 -ml-1 rounded-md md:hidden focus:outline-none focus:shadow-outline-purple"
                @click="toggleSideMenu"
                aria-label="Menu"
        >
            <svg
                    class="w-6 h-6"
                    aria-hidden="true"
                    fill="currentColor"
                    viewBox="0 0 20 20"
            >
                <path
                        fill-rule="evenodd"
                        d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                        clip-rule="evenodd"
                ></path>
            </svg>
        </button>
        <!-- Search input start -->
        <div class="flex justify-center flex-1 lg:mr-32">
            <div class="relative w-full max-w-xl mr-6 focus-within:text-purple-500"></div>
        </div>
<%--        Search input end--%>
<%--        우측 User Info 시작--%>
        <ul class="flex items-center flex-shrink-0 space-x-6">
            <!-- User Info Section -->
            <li class="flex" id="userInfo"></li>
            <!-- Profile menu -->
            <li class="relative">
                <button
                        class="align-middle rounded-full focus:shadow-outline-purple focus:outline-none"
                        @click="toggleProfileMenu"
                        @keydown.escape="closeProfileMenu"
                        aria-label="Account"
                        aria-haspopup="true"
                        id = "profilePicture"
                >
                </button>
                <template x-if="isProfileMenuOpen">
                    <ul
                            x-transition:leave="transition ease-in duration-150"
                            x-transition:leave-start="opacity-100"
                            x-transition:leave-end="opacity-0"
                            @click.away="closeProfileMenu"
                            @keydown.escape="closeProfileMenu"
                            class="absolute right-0 w-56 p-2 mt-2 space-y-2 text-gray-600 bg-white border border-gray-100 rounded-md shadow-md dark:border-gray-700 dark:text-gray-300 dark:bg-gray-700"
                            aria-label="submenu"
                    >
                        <li class="flex">
                            <a
                                    class="inline-flex items-center w-full px-2 py-1 text-sm font-semibold transition-colors duration-150 rounded-md hover:bg-gray-100 hover:text-gray-800 dark:hover:bg-gray-800 dark:hover:text-gray-200"
                                    href="#"
                            >
                                <svg
                                        class="w-4 h-4 mr-3"
                                        aria-hidden="true"
                                        fill="none"
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        viewBox="0 0 24 24"
                                        stroke="currentColor"
                                >
                                    <path
                                            d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                                    ></path>
                                </svg>
                                <span>마이페이지</span>
                            </a>
                        </li>
                        <li class="flex">
                            <a
                                    class="inline-flex items-center w-full px-2 py-1 text-sm font-semibold transition-colors duration-150 rounded-md hover:bg-gray-100 hover:text-gray-800 dark:hover:bg-gray-800 dark:hover:text-gray-200"
                                    href="#"
                            >
                                <svg
                                        class="w-4 h-4 mr-3"
                                        aria-hidden="true"
                                        fill="none"
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        viewBox="0 0 24 24"
                                        stroke="currentColor"
                                >
                                    <path
                                            d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"
                                    ></path>
                                    <path d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                </svg>
                                <span>관리페이지</span>
                            </a>
                        </li>
                        <li class="flex">
                            <a
                                    class="inline-flex items-center w-full px-2 py-1 text-sm font-semibold transition-colors duration-150 rounded-md hover:bg-gray-100 hover:text-gray-800 dark:hover:bg-gray-800 dark:hover:text-gray-200"
                                    href="#"
                                    onclick="signOut();"
                            >
                                <svg
                                        class="w-4 h-4 mr-3"
                                        aria-hidden="true"
                                        fill="none"
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        viewBox="0 0 24 24"
                                        stroke="currentColor"
                                >
                                    <path
                                            d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"
                                    ></path>
                                </svg>
                                <span>로그아웃</span>
                            </a>
                        </li>
                    </ul>
                </template>
            </li>
        </ul>
    </div>
</header>

<script>

    $(document).ready(function(){
        makeHeaderUserInfo(); //Header User Info 제작
        makeHeaderUserPicture(); //profilePicture 제작
        // makeHeaderTitle(); //Header Title 제작
    })

    function makeHeaderUserPicture() {
        var major=<%=major%>;
        var user =<%=user%>;
        var type =<%=type%>;
        var it = $('#profilePicture');
        var text = '';
        text+='<img class="object-cover w-8 h-8 rounded-full"'
            +'src="';
        if (user==null){
            text +='https://images.unsplash.com/photo-1502378735452-bc7d86632805?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=aa3a807e1bbdfd4364d1f449eaa96d82';
        }
        else{
            text += user.google_img;
        }
        text+='" alt=""'
            +'aria-hidden="true" />';
        it.append(text);
    }

    function makeHeaderUserInfo(){
        var major=<%=major%>;
        var user =<%=user%>;
        var type =<%=type%>;
        var it = $('#userInfo');
        if(user == null){ //Guest
            var text = '<a href="loginPage_v2.kgu">로그인이 필요합니다.</a>';
        }
        else{ //로그인 시
            var text = '<div>안녕하세요. ' + user.name + ' ('+type.for_header+')님. ';
        }

        // if(user == null){ //Guest
        //     var text = '<div><a href="loginPage_v2.kgu" title="로그인" class="text-white">LOGIN(Google)</a></div>';
        //     text += '<div><a href="loginPage.kgu" title="로그인" class="text-white">LOGIN(OLD)</a></div>';
        // }
        // else{ //로그인 시
        //     var text = '<div>안녕하세요. ' + user.name + ' ('+type.for_header+')님. ';
        //     if(type.for_header=='관리자'){
        //         text +='<a href="admin.kgu?num=70" class="text-white"> 관리페이지 </a> '
        //     }
        //     else{
        //         text +=' <a href="mypage.kgu?major='+major+'&&num=60" class="text-white">마이페이지</a> ';
        //     }
        //     text +='<a href="#" onclick="signOut();" class="text-white" >LOGOUT(with Google)</a>';
        // }
        it.append(text);
    }

    function signOut() {
        var auth2 = gapi.auth2.getAuthInstance();
        auth2.signOut().then(function () {
            console.log('User signed out.');
            window.location.href='logout.kgu';
        });
    }

</script>
<script>
    function onLoad() {
        gapi.load('auth2', function() {
            gapi.auth2.init();
        });
    }
</script>
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
