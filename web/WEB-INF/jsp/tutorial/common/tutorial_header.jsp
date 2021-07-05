<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-03
  Time: 오후 12:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<haed>
  <%--    Bootstrap--%>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  <%--    jQuery--%>
  <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
  <%--    Bootstrap Table--%>
  <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css">
  <script src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }
      .b-example-divider {
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

</haed>
<header>

  <div class="navbar navbar-dark bg-dark shadow-sm">
    <div class="container">
      <a href="#" class="navbar-brand d-flex align-items-center">
        <%--                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" aria-hidden="true" class="me-2" viewBox="0 0 24 24"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"/><circle cx="12" cy="13" r="4"/></svg>--%>
        <strong>Tutorial</strong>
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
    </div>
  </div>
  <div class="collapse bg-dark" id="navbarHeader">
    <div class="container">
      <div class="row">
        <div class="col-sm-8 col-md-7 py-4">
          <h4 class="text-white">연습용 페이지</h4>
          <p class="text-muted">이 페이지의 뼈대는 부트스트랩5.0의 example album에서 가져왔습니다. 디자인에 관한 자세한 내용은 우측 링크에서 확인하세요</p>
        </div>
        <div class="col-sm-4 offset-md-1 py-4">
          <h4 class="text-white">디자인 참고 링크</h4>
          <ul class="list-unstyled">
            <li><a href="https://getbootstrap.com/" class="text-white">부트스트랩 공식 홈페이지</a></li>
            <li><a href="https://getbootstrap.com/docs/5.0/getting-started/introduction/" class="text-white">부트스트랩 공식 문서</a></li>
            <li><a href="https://getbootstrap.com/docs/5.0/examples/" class="text-white">부트스트랩 각종 예시</a></li>
            <li><a href="https://getbootstrap.com/docs/5.0/examples/cheatsheet/" class="text-white">부트스트랩 치트 시트</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</header>
