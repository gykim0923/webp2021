<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-06-26
  Time: 오전 12:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String exampleData = (String) request.getAttribute("ExampleData");
    String dataByGetType = (String) request.getAttribute("dataByGetType");
    String tutorial = (String) request.getAttribute("tutorial");
%>
<html>
<head>
    <!-- content에 자신의 OAuth2.0 클라이언트ID를 넣습니다. -->
    <meta name ="google-signin-client_id" content="961716324050-r6i9dib682nsqjotloum1igkvf1jm0og.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <title>연습용 페이지 입니다.</title>
</head>
<body>
<%@include file="common/tutorial_header.jsp"%>

<main>
    <%@include file="common/tutorial_section.jsp"%>
    <div class="g-signin2" data-onsuccess="onSignIn"></div>
    <script>
        $(document).ready(function(){
            onSignIn();
        })
        function onSignIn(googleUser) {
            var profile = googleUser.getBasicProfile();
            console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
            console.log('Name: ' + profile.getName());
            console.log('Image URL: ' + profile.getImageUrl());
            console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
        }
    </script>
    <a href="#" onclick="signOut();">Sign out</a>
    <script>
        function signOut() {
            var auth2 = gapi.auth2.getAuthInstance();
            auth2.signOut().then(function () {
                console.log('User signed out.');
            });
        }
    </script>

    <div class="album py-5 bg-light">
        <div class="container">
            <div><h1>jQuery로 반복 패턴 찍어내기(특정 DB 출력하기)</h1></div>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3" id="card"></div>
        </div>
    </div>
    <div class="b-example-divider"></div>

    <div class="album py-5 bg-light">
        <div class="container">
            <div class="container col-xl-10 col-xxl-8 px-4 py-5">
                <div class="row align-items-center g-lg-5 py-5">
                    <div class="col-lg-7 text-center text-lg-start">
                        <h1 class="display-4 fw-bold lh-1 mb-3">데이터 추가하기(ajax 사용)</h1>
                        <p class="col-lg-10 fs-4">데이터를 ajax를 사용하여 추가하는 방법입니다.</p>
                    </div>
                    <div class="col-md-10 mx-auto col-lg-5">
                        <form class="p-4 p-md-5 border rounded-3 bg-light">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="exampleTitle" placeholder="title">
                                <label for="exampleTitle">Title</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="exampleContent" placeholder="content">
                                <label for="exampleContent">Content</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="date" class="form-control" id="exampleDate" placeholder="date">
                                <label for="exampleDate">Date</label>
                            </div>
                            <button class="w-100 btn btn-lg btn-primary" onclick="addExampleData()">추가하기</button>
                            <hr class="my-4">
                            <small class="text-muted">ㅇㅇ</small>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="b-example-divider"></div>

    <div class="album py-5 bg-light">
        <div class="container">
            <div class="px-4 py-5 my-5 text-center">
                <h1 class="display-5 fw-bold">get방식으로 데이터 넘겨받기</h1>
                <div class="col-lg-6 mx-auto">
                    <p class="lead mb-4">url을 통해 넘겨받은 데이터는 <mark>tutorial : <%=tutorial%>, data : <%=dataByGetType%></mark> 입니다. get 방식으로 파라미터를 넘겨 받는 것을 확인해보려면 아래 빈 칸에 단어를 입력하고 버튼을 눌러보세요. <mark>버튼을 누른 후, url이 어떻게 변화하는지 비교해보세요!</mark></p>
                    <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                        <input type="text" class="form-control" value="test" id="dataForGet">
                        <button type="button" class="btn btn-primary btn-lg px-4 gap-3" onclick="reloadPageWithNewURL()">get방식으로 데이터를 넘긴 후, url 새로 받기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="b-example-divider"></div>

    <div class="album py-5 bg-light">
        <div class="container">
            <table class="boardtable" id="table1"  data-toggle="table"
                   data-pagination="true" data-toolbar="#toolbar"
                   data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
                   data-page-list="[10]">
                <thead>
                <tr>
                    <th data-field="action">설정</th>
                    <th data-field="oid" data-sortable="true">oid</th>
                    <th data-field="title" data-sortable="true">title</th>
                    <th data-field="content" data-sortable="true">content</th>
                    <th data-field="date" data-sortable="true">date</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
    <div class="b-example-divider"></div>
    <h1 class="display-5 fw-bold">파일 업로드(미구현)</h1>
    <div><button class="btn btn-secondary" onclick="uploadfile()"><i class="bi bi-upload"></i> 업로드</button></div>
</main>

<footer class="text-muted py-5">
    <div class="container">
        <p class="float-end mb-1">
            <a href="#">Back to top</a>
        </p>
<%--        <p class="mb-1">Album example is &copy; Bootstrap, but please download and customize it for yourself!</p>--%>
<%--        <p class="mb-0">New to Bootstrap? <a href="/">Visit the homepage</a> or read our <a href="../getting-started/introduction/">getting started guide</a>.</p>--%>
    </div>
</footer>
</body>
<script>
    $(document).ready(function(){
        makeExampleAll();
        callSetupTableView();
    })
    function makeExampleAll(){
        var makeExampleAll = <%=exampleData%>;
        var list = $('#card');
        var text = '';

        for(var i=0; i<makeExampleAll.length; i++){
            text+= '<div class="col">'
                +'<div class="card shadow-sm">'
                +'<svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">'+makeExampleAll[i].title+'</text></svg>'
                +'<div class="card-body">'
                +'<p class="card-text">'+makeExampleAll[i].content+'</p>'
                +'<div class="d-flex justify-content-between align-items-center">'
                +'<div class="btn-group">'
                +'<button type="button" class="btn btn-sm btn-outline-secondary" onclick="titleAlert('+i+')">제목을 alert로 띄워보기</button>'
                +'<button type="button" class="btn btn-sm btn-outline-secondary" onclick="deleteExampleData('+i+')">이 데이터를 삭제하기(ajax)</button>'
                +'</div>'
                +'<small class="text-muted">'+makeExampleAll[i].date+'</small>'
                +'</div></div></div></div>';
        }
        list.append(text);
    }

    function titleAlert(i){
        var makeExampleAll = <%=exampleData%>;
        alert('방금 누르신 버튼의 title은 '+makeExampleAll[i].title+'입니다.');
    }

    function deleteExampleData(i){
        var makeExampleAll = <%=exampleData%>;
        var id = makeExampleAll[i].oid;
        var check = confirm("[중요] 정말로 이 데이터를 삭제하시나요? 취소하실 수 없습니다.");
        if (check) {
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post",
                data: {
                    req: "deleteExampleData", //이 메소드를 찾아서
                    data: id //이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (data) { //성공 시
                    alert("해당 데이터가 삭제되었습니다. (복구를 원하시면 mariaDB에 db.sql을 다시 넣어주세요.)");
                    location.reload()
                }
            })
        }
    }

    function addExampleData(){
        var title=$('#exampleTitle').val();
        var content=$('#exampleContent').val();
        var date=$('#exampleDate').val();
        var data=title+'-/-/-'+content+'-/-/-'+date;
        var check = confirm("데이터 "+data+"를 추가하시겠습니까?");
        if (check) {
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post", //post 방식으로
                data: {
                    req: "addExampleData", //이 메소드를 찾아서
                    data: data //이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (oid) { //성공 시
                    alert("해당 데이터가 추가되었습니다. 추가된 데이터의 oid는 "+oid+" 입니다.");
                    location.reload();
                }
            })
        }
    }

    function reloadPageWithNewURL(){
        var tutorial = <%=tutorial%>;
        alert(tutorial);
        var data=$('#dataForGet').val();
        window.location.href="tutorial.kgu?tutorial="+tutorial+"&&data="+data;
        //파라미터 여러개 보낼 때 &&을 씀
    }

    function callSetupTableView(){
        $('#table1').bootstrapTable('load',tableData());
        // $('#table1').bootstrapTable('append',data());
        $('#table1').bootstrapTable('refresh');
    }
    function tableData(){
        var makeExampleAll = <%=exampleData%>;
        var rows = [];
        for(var i=0;i<makeExampleAll.length;i++){
            var example=makeExampleAll[i];
            rows.push({
                oid: example.oid,
                title: example.title,
                content: example.content,
                date: example.date,
                action : '<button class="btn btn-danger" type="button" onclick="deleteExampleData('+i+')">삭제</button>'
            });
        }
        // alert(rows);
        return rows;
    }

    function uploadfile(){

    }
</script>
</html>
