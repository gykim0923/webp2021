<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-05
  Time: 오후 6:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String google_name = (String)session.getAttribute("google_name");
    String google_email = (String)session.getAttribute("google_email");
    String getAllKguMajor = (String)request.getAttribute("getAllKguMajor");
    String getAllType = (String)request.getAttribute("getAllType");
%>
<html>
<head>
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0">
    <%--    Bootstrap--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <%--    jQuery--%>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <%--    Bootstrap Table--%>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css">
    <script src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>
    <script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>

<%--    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">--%>
    <link rel="stylesheet" href="/assets/css/bootstrap.css">
    <link rel="stylesheet" href="/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="/assets/css/app.css">
    <link rel="stylesheet" href="/assets/css/pages/auth.css">
    <style>
        .my-2 {

        }
    </style>
</head>
<body>
<div id="auth">

    <div class="row h-100">
        <div class="col-lg-5 col-12">
            <div id="auth-left">
                <div class="auth-logo">
<%--                    <a href="index.html"><img src="/assets/images/logo/logo.png" alt="Logo"></a>--%>
                </div>
                <h1 class="auth-title">회원가입</h1>
                <p class="auth-subtitle mb-5">추가 정보를 입력하고<br> 회원가입을 완료하세요.</p>

                <div>
                    <div class="form-group position-relative has-icon-left mb-4">
                        <input type="text" class="form-control form-control-xl" placeholder="이메일" id="email" value=<%=google_email%> readonly>
                        <div class="form-control-icon">
                            <i class="bi bi-envelope"></i>
                        </div>
                    </div>
                    <div class="form-group position-relative has-icon-left mb-4">
                        <input type="text" class="form-control form-control-xl" id="name"  placeholder="이름" value=<%=google_name%>>
                        <div class="form-control-icon">
                            <i class="bi bi-person"></i>
                        </div>
                    </div>

                    <div class="form-group position-relative has-icon-left mb-4">
                        <div class="input-group">
                            <input type="text" class="form-control form-control-xl" id="id" placeholder="학번(혹은 교번)" value="" required>
                            <div class="form-control-icon">
                                <i class="bi bi-person"></i>
                            </div>
                            <button type="submit" class="btn btn-secondary" onclick="checkID()">중복확인</button>
                        </div>
                        <span id="warningID"></span>
                        <div class="invalid-feedback">
                            학번을 입력해 주세요.
                        </div>

                    </div>

                    <div class="form-group position-relative has-icon-left mb-4">
                        <label for="gender" class="form-label">성별</label>
                        <div id="gender">
                            <div class="form-check">
                                <input id="male" name="gender" type="radio" class="form-check-input" value="남" checked required>
                                <label class="form-check-label" for="male">남</label>
                            </div>
                            <div class="form-check">
                                <input id="female" name="gender" type="radio" class="form-check-input" value="여" required>
                                <label class="form-check-label" for="female">여</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group position-relative has-icon-left mb-4">
                        <div class="form-floating mb-3">
                            <input type="date" class="form-control form-control-xl" id="birth" placeholder="date">
                            <label for="birth">생년월일</label>
                        </div>
                    </div>

                    <div class="form-group position-relative has-icon-left mb-4">
                        <input type="text" class="form-control form-control-xl" id="phone" placeholder="전화번호(-포함해서 적어주세요.)" required>
                        <div class="form-control-icon">
                            <i class="bi bi-person"></i>
                        </div>
                        <div class="invalid-feedback">
                            전화번호를 입력해주세요.
                        </div>
                    </div>

                    <div class="form-group position-relative has-icon-left mb-4">
                        <div class="row">
                            <div class="col-12">
                                <label for="hope_type" class="form-label">희망구분<span> (관리자 승인후 변경됩니다.)</span></label>
                                <select class="form-select form-select-xl" id="hope_type" required></select>
                                <div class="invalid-feedback">
                                    희망구분을 선택해 주세요.
                                </div>
                            </div>

                            <div class="col-12 my-3">
                                <label for="major" class="form-label">학과</label>
                                <select class="form-select form-select-xl" id="major" required></select>
                                <div class="invalid-feedback">
                                    학과를 선택해 주세요
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Button trigger for scrollbar modal -->
                    <button type="button" class="btn btn-outline-success" data-bs-toggle="modal"
                            data-bs-target="#exampleModalLong">
                        이용약관
                    </button>

                    <!--scrollbar Modal -->
                    <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog"
                         aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLongTitle">이용약관</h5>
                                    <button type="button" class="close" data-bs-dismiss="modal"
                                            aria-label="Close">
                                        <i data-feather="x"></i>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <h5>경기대학교 K-WITH 융합교육원 홈페이지 이용약관 동의(필수)</h5><br>
                                    <p>이 약관은 K-WITH 융합교육원이 온라인으로 제공하는 콘텐츠 및 제반서비스의 이용과 관련하여 경기대 융합교육원과 이용자와의 권리, 의무 및 책임사항 등을 규정함을 목적으로 합니다. </p>
                                    <br><br><br><br>
                                    <strong>1. 수집하는 개인정보 항목</strong><br>
                                    이 홈페이지는 회원가입, 원활한 서비스 제공, 상담 등을 위해 아래와 같이 개인정보를 수집하고 있습니다.<br>
                                    <strong>1) 수집항목</strong><br>
                                    [필수항목] Google 고유 ID, 이메일, Google 프로필 사진, 이름, 학번, 성별, 생년월일, 전화번호, 희망구분(홈페이지 내 접근 권한), 학과<br>
                                    [선택항목] 부전공, 상태, 학년<br>
                                    <strong>2) 수집방법</strong><br>
                                    [필수항목] 회원가입 시 Google 서버로부터 자동으로 수집, 사용자가 직접 입력<br>
                                    [선택항목] 회원가입 후, 마이페이지에서 직접 입력<br><br>
                                    -------------------------------<br>
                                    OAuth 서비스 제공자(이하 Google)의 OAuth 서비스(이하 Google People API)를 이용하는 경우 Google People API로부터 일회성 Token을 발급받아 홈페이지 서버로 전송합니다.
                                    또한, 일회성 Token을 이용하여 Google 서버와 신뢰성 있는 연결을 통해 여러분의 데이터에 직접 액세스하고 서비스에 사용할 수 있습니다.<br><br>
                                    <strong>- Google로 부터 전달받은 Token 정보 - </strong><br>
                                    이 홈페이지는 일회성 Token을 데이터베이스에 저장하지 않습니다.<br>
                                    <strong>- Token을 활용하여 전달받은 Google 계정 정보 - </strong><br>
                                    홈페이지 서버에서 일회성 Token을 사용하여 Google 서버로부터 계정정보를 직접 받아서 데이터베이스에 저장하게 되며, 저장되는 정보는 아래와 같습니다.<br>
                                    가) Google 고유 ID<br>
                                    나) Google 이미지 경로<br>
                                    다) Google 이메일 주소<br><br><br>
                                    <strong>3) 탈퇴 및 개인정보 삭제</strong><br>
                                    회원은 언제든지 마이페이지에서 탈퇴가 가능하며, 회원 탈퇴 시 1) 수집항목에 있는 모든 항목이 삭제됩니다. 단, 회원이 직접 작성한 게시글이나 정보와 같은 데이터는 자동으로 삭제되지 않습니다.<br>
                                    <br><br><br><br>
                                    <strong>2. 회원이 등록한 게시물의 이용 및 삭제</strong><br>
                                    1) 홈페이지는 회원이 등록한 게시물 중 본 약관 및 관계법령 등에 위배되는 게시물이 있는 경우 이를 지체없이 삭제합니다.<br><br>
                                    2) 홈페이지가 운영하는 게시판 등에 게시된 정보로 인하여 법률상 이익이 침해된 자는 홈페이지에게 당해 정보의 삭제 또는 반박내용의 게재를 요청할 수 있습니다. 이 경우 홈페이지는 지체없이 필요한 조치를 취하고 이를 즉시 신청인에게 통지합니다.<br><br>
                                    3) 홈페이지는 홈페이지가 제공하는 웹사이트에 회원이 게시한 게시물을 이용·수정하여 마케팅 및 출판 등에 활용할 수 있습니다.<br><br>
                                    4) 회원은 전항에 따른 홈페이지의 이용 등에 대하여 웹사이트 등을 통하여 철회 할 수 있으며, 홈페이지는 회원의 철회의사를 받은 후로부터 해당 회원의 게시물을 사용하지 않습니다. 단, 홈페이지는 철회의 의사표시 전 기 제작된 제작물에 대하여는 소진 시 까지 사용할 수 있습니다.<br><br>

                                </div>
                            </div>
                        </div>
                    </div>

                    <button type="button" class="btn btn-outline-success" onclick="window.open('http://www.kyonggi.ac.kr/webService.kgu?menuCode=K00M0502');">
                        개인정보 처리방침
                    </button>


                    <div class="form-check form-check-lg d-flex align-items-end">
                        <input class="form-check-input me-2" type="checkbox" value="" id="flexCheckDefault">
                        <label class="form-check-label text-gray-600" for="flexCheckDefault">
                            <a href="#" class="font-bold">이용약관</a> 및 <a href="#" class="font-bold">개인정보 처리방침</a>에 동의합니다.(필수)
                        </label>
                    </div>

                    <button class="btn btn-primary btn-block btn-lg shadow-lg mt-5" onclick="LetsRegisterGoogle()">가입 하기</button>
                </div>
                <div class="text-center mt-5 text-lg fs-4">
                    <p class='text-gray-600'>
<%--                        제 구글 계정은 안전한가요?--%>
<%--                        <a href="#" class="font-bold">확인하기</a>.--%>
                    </p>
                </div>
            </div>
        </div>
        <div class="col-lg-7 d-none d-lg-block">
            <div id="auth-right">

            </div>
        </div>
    </div>
</div>

<br>
</body>
</html>
<script>

    $(document).ready(function(){
        makeTypeList();
        makeMajorList();
    })

    function makeMajorList(){
        var major = $('#major');
        var majorList=<%=getAllKguMajor%>;
        var text = '';
        for(var i=0;i<majorList.length;i++){
            text+='<option value="'+majorList[i].major+'">'+majorList[i].campus+' '+majorList[i].college+' '+majorList[i].major+'</option>';
        }
        text+='<option>기타</option>';
        major.append(text);
    }

    function makeTypeList(){
        var type = $('#hope_type');
        var typeList=<%=getAllType%>;
        var text = '';
        for(var i=0;i<typeList.length;i++){
            text+='<option>'+typeList[i].type_name+'</option>';
        }
        type.append(text);
    }
</script>

<script>
    var ischeckID = 0;

    function checkID() { //중복확인
        var id = $('#id').val();
        $.ajax({
            url: "ajax.kgu",
            type: "post",
            data: {
                req: "checkId",
                data: id
            },
            success: function (data) {
                var result = data;
                if (data == 'dup') {
                    ischeckID = 0;
                    $('#warningID').html('*중복된 ID입니다');
                    $('#warningID').css('color', 'red');
                    $('#warningID').css('font-size', '11px');
                    $('#warningID').css('margin-left', '10px');

                } else {
                    ischeckID = 1;
                    $('#warningID').html('*사용가능한 ID입니다');
                    $('#warningID').css('color', 'blue');
                    $('#warningID').css('font-size', '11px');
                    $('#warningID').css('margin-left', '10px');
                }
            }
        })
    }


    function LetsRegisterGoogle() { //여기서부터 작업
        if (ischeckID == 1) {
            var name = $('#name').val();
            var id = $('#id').val();
            var gender = $('input[name=gender]:checked').val();
            var birth = $('#birth').val();
            var phone = $('#phone').val();
            var hopetype = $('#hope_type').val();
            var major = $('#major').val();
            var perID = id;

            if (name != '' && gender != '' && birth != '' && phone != '') {
                var update = id+"-/-/-"+perID+"-/-/-"+name+"-/-/-"+gender+"-/-/-"+birth+"-/-/-"+hopetype+"-/-/-"+phone+"-/-/-"+major;

                $.ajax({
                    url: "ajax.kgu",
                    type: "post",
                    data: {
                        req: "registerGoogle",
                        data: update
                    },
                    success: function (data) {
                        if (data == 'success') {
                            swal.fire({
                                title : '회원가입 성공',
                                icon : 'success',
                                showConfirmButton: true
                            }).then(function (){
                                window.location.href='main.kgu';
                            });
                        } else

                        swal.fire({
                            title : '서버에러, 다음에 시도해주세요',
                            icon : 'error',
                            showConfirmButton: true
                        });
                    }
                })
            } else {
                swal.fire({
                    title : '빈칸을 입력해주세요',
                    icon : 'warning',
                    showConfirmButton: true
                });

            }
        } else
            swal.fire({
                title : '아이디 중복확인을 해주세요',
                icon : 'warning',
                showConfirmButton: true
            });
    }

</script>

