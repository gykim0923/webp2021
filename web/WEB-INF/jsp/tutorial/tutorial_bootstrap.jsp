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
    <title>부트스트랩 연습용 페이지 입니다.</title>
</head>
<body>
<%@include file="common/tutorial_header.jsp"%>

<main>
    <%@include file="common/tutorial_section.jsp"%>

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
