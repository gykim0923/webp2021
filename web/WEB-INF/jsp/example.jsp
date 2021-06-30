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
%>
<html>
<head>
    <title>연습용 페이지 입니다.</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
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
</head>
<body>

<header>
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
</header>

<main>
    <section class="py-5 text-center container">
        <div class="row py-lg-5">
            <div class="col-lg-6 col-md-8 mx-auto">
                <h1 class="fw-light">연습용 페이지입니다.</h1>
                <p class="lead text-muted">이 페이지에는 온갖 예제가 들어올 예정입니다. DB불러오기, DB전송하기, 부트스트랩, 제이쿼리 등 연습용 페이지로 활용될 계획이며, 만약에 더 괜찮은 연습 자료가 있다면 수정해서 Push해주세요. 감사합니다.</p>
                <p>
                    <a href="main.kgu" class="btn btn-secondary my-2">홈으로 돌아가기</a>
                </p>
            </div>
        </div>
    </section>

    <div class="b-example-divider"></div>

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
                    <p class="lead mb-4">url을 통해 넘겨받은 데이터는 <mark><%=dataByGetType%></mark> 입니다. get 방식으로 파라미터를 넘겨 받는 것을 확인해보려면 아래 빈 칸에 단어를 입력하고 버튼을 눌러보세요. <mark>버튼을 누른 후, url이 어떻게 변화하는지 비교해보세요!</mark></p>
                    <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                        <input type="text" class="form-control" value="test" id="dataForGet">
                        <button type="button" class="btn btn-primary btn-lg px-4 gap-3" onclick="reloadPageWithNewURL()">get방식으로 데이터를 넘긴 후, url 새로 받기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="b-example-divider"></div>

    <div class="container">
        <div><h1>Modal 예제 (띄우기 및 jQuery를 활용한 내용 변경 예제)</h1></div>
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
            Modal 타입 1
        </button>

        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Modal 제목</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modalAppend">
                        바깥 영역을 누르면 사라지는 Modal 페이지 입니다.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" onclick="modalAppend()">버튼을 눌러 무언가 추가하기.(누를때마다 추가됨)</button>
                    </div>
                </div>
            </div>
        </div>




        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
            Modal 타입 2
        </button>

        <!-- Modal -->
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">Modal 제목</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modalReset">
                        바깥 영역을 눌러도 사라지지 않는 Modal 페이지 입니다.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" onclick="modalReset()">버튼을 눌러 내용 교체</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="b-example-divider"></div>

    <div class="album py-5 bg-light">
        <div class="container">
            <h1>Tab 전환</h1>
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">버튼을</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">누르면</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button" role="tab" aria-controls="contact" aria-selected="false">전환됨</button>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">내용내용내용</div>
                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">내용내용</div>
                <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">내용내용내용내용</div>
            </div>
        </div>
    </div>

    <div class="b-example-divider"></div>
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
        var data=$('#dataForGet').val();
        window.location.href="example.kgu?data="+data;
    }

    function modalAppend(){
        var list=$('#modalAppend');
        var text='';
        text+='<input type="date" class="form-control" value="날짜를 입력하세요" placeholder="Date">'
            +'<input type="text" class="form-control" value="텍스트를 입력하세요">'
            +'<select class="form-control"><option value="1">1</option>';
        for(var i=2;i<6;i++){
            text+='<option value="'+i+'">'+i+'</option>';
        }
        text+='</select>';
        list.append(text);//누를때마다 modalAppend에 추가됨.
    }

    function modalReset(){
        var list=$('#modalReset');
        var text='';
        text+='버튼을 눌러 내용을 바꿨습니다!';
        list.html(text);//누를때마다 modalReset 내용이 초기화됨.
    }


</script>
</html>
