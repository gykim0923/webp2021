<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-28
  Time: 오후 11:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

<%--  <meta charset="UTF-8" />--%>
<%--  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>--%>
  <link rel="stylesheet" href="/css/tailwind.output.css" />
  <script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js" defer></script>
  <script src="/js/init-alpine.js"></script>


<%--aside_v2--%>
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
  <%--    <link rel="stylesheet" href="/assets/css/bootstrap.css">--%>

  <link rel="stylesheet" href="/assets/vendors/iconly/bold.css">

  <link rel="stylesheet" href="/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
  <link rel="stylesheet" href="/assets/vendors/bootstrap-icons/bootstrap-icons.css">
  <link rel="stylesheet" href="/assets/css/app.css">
  <link rel="shortcut icon" href="/assets/images/favicon.svg" type="image/x-icon">

</head>