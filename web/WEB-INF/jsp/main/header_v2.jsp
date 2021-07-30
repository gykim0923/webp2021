<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-28
  Time: 오후 4:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="z-10 py-4 bg-white shadow-md dark:bg-gray-800">
    <div class="container flex items-center justify-between h-full px-6 mx-auto text-purple-600 dark:text-purple-300">
        <%--        <!-- Mobile hamburger -->--%>
        <%--        <button class="p-1 mr-5 -ml-1 rounded-md md:hidden focus:outline-none focus:shadow-outline-purple" @click="toggleSideMenu" aria-label="Menu">--%>
        <%--            <svg class="w-6 h-6" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20">--%>
        <%--                <path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd"></path>--%>
        <%--            </svg>--%>
        <%--        </button>--%>
        <a href="#" class="burger-btn d-block d-xl-none">
            <i class="bi bi-justify fs-3"></i>
        </a>
            <p>경기대학교</p>
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
                <c:choose>
                    <c:when test="${user == null}">
                        <a href="loginPage_v2.kgu">로그인(구글)</a>
                        <a href="loginPage.kgu">로그인(구버전)</a>
                    </c:when>
                    <c:when test="${user != null}">
                        <div class="dropdown">
                            <a href="#" data-bs-toggle="dropdown" aria-expanded="false">
                                <div class="user-menu d-flex">
                                    <div class="user-name text-end me-3">
                                        <h6 class="mb-0 text-gray-600" id="profileName">name(for_header)</h6>
                                        <p class="mb-0 text-sm text-gray-600" id="profileMajor">major</p>
                                    </div>
                                    <div class="user-img d-flex align-items-center">
                                        <div class="avatar avatar-md">
                                            <img id="profilePicture">
                                        </div>
                                    </div>
                                </div>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                                <li>
                                    <h6 class="dropdown-header" id="profileHello"></h6>
                                </li>

                                <li>
                                    <a class="dropdown-item" href="mypage.kgu?num=60">
                                        <i class="icon-mid bi bi-person me-2"></i>마이페이지
                                    </a>
                                </li>
                                <c:if test="${type.for_header == '관리자'}">
                                    <li>
                                        <a class="dropdown-item" href="admin.kgu?num=70">
                                            <i class="icon-mid bi bi-gear me-2"></i>관리페이지
                                        </a>
                                    </li>
                                </c:if>
                                    <hr class="dropdown-divider">
                                </li>
                                <li>
                                    <a class="dropdown-item" href="#" onclick="signOut();">
                                        <i class="icon-mid bi bi-box-arrow-left me-2"></i> 로그아웃(통합버전)
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:when>
                </c:choose>
            </li>
        </ul>
    </div>
</header>

<script>

    $(document).ready(function () {
        makeHeaderProfile(); //profile 제작
    })

    function makeHeaderProfile() {
        var user =<%=user%>;
        var type=<%=type%>;
        if (user != null) {
            $('#profileName').html(user.name+'('+type.for_header+')');
            $('#profileMajor').html(user.major);
            $('#profilePicture').attr("src", user.google_img);
            $('#profileHello').html('안녕하세요, '+user.name+'님!')
        }
    }


    function signOut() {
        var auth2 = gapi.auth2.getAuthInstance();
        auth2.signOut().then(function () {
            console.log('User signed out.');
            window.location.href = 'logout.kgu';
        });
    }

</script>

<%--구글 로그아웃 관련 설정 시작. 절대 건들지 마세요.--%>
<script>
    //절대 건들지 마세요. (위치 수정 금지)
    function onLoad() {
        gapi.load('auth2', function () {
            gapi.auth2.init();
        });
    }
</script>
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
<%--구글 로그아웃 관련 설정 끝 --%>