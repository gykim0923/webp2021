<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-31
  Time: 오전 1:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class='mb-3'>
  <nav class="navbar navbar-expand navbar-light ">
    <div class="container-fluid">
      <a href="#" class="burger-btn d-block">
        <i class="bi bi-justify fs-3"></i>
      </a>

      <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
              data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
              aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
<%--          <li class="nav-item dropdown me-1">--%>
<%--            <a class="nav-link active dropdown-toggle" href="#" data-bs-toggle="dropdown"--%>
<%--               aria-expanded="false">--%>
<%--              <i class='bi bi-envelope bi-sub fs-4 text-gray-600'></i>--%>
<%--            </a>--%>
<%--            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">--%>
<%--              <li>--%>
<%--                <h6 class="dropdown-header">Mail</h6>--%>
<%--              </li>--%>
<%--              <li><a class="dropdown-item" href="#">No new mail</a></li>--%>
<%--            </ul>--%>
<%--          </li>--%>
<%--          <li class="nav-item dropdown me-3">--%>
<%--            <a class="nav-link active dropdown-toggle" href="#" data-bs-toggle="dropdown"--%>
<%--               aria-expanded="false">--%>
<%--              <i class='bi bi-bell bi-sub fs-4 text-gray-600'></i>--%>
<%--            </a>--%>
<%--            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">--%>
<%--              <li>--%>
<%--                <h6 class="dropdown-header">Notifications</h6>--%>
<%--              </li>--%>
<%--              <li><a class="dropdown-item">No notification available</a></li>--%>
<%--            </ul>--%>
<%--          </li>--%>
        </ul>
        <c:choose>
          <c:when test="${user == null}">
            <div class="dropdown">
              <a href="loginPage_v2.kgu">로그인(구글)</a>
              <a href="loginPage.kgu">로그인(구버전)</a>
            </div>
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
      </div>
    </div>
  </nav>
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