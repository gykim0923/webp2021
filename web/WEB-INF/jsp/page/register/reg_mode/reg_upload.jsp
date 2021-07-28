<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-26
  Time: 오후 7:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getReg = (String) request.getAttribute("getReg");
%>
<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/jquery.cookie.js"></script>
<script src="//cdn.ckeditor.com/4.8.0/standard/ckeditor.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/fileinput.min.js"></script>
<script src="js/sortable.min.js" type="text/javascript"></script>
<script src="js/theme.js" type="text/javascript"></script>
<link
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
        media="all" rel="stylesheet" type="text/css" />

<div class="h3">글 작성하기</div>
<%--ckeditor가 나와야 하는 자리--%>
<div class="form-group mb-3" id="bbsTitleBox"><input class="form-control" id="bbsTitle" placeholder="제목을 입력하세요."></div>

<div class="row mb-3">
    <div class="col-md-4 form-group">
        <label for="InputStartDate">시작일</label>
        <input type="date" class="form-control" name="startDate" id="InputStartDate">
    </div>
    <div class="col-md-4 form-group">
        <label for="InputFinishDate">마감일</label>
        <input type="date" class="form-control" name="finishDate" id="InputFinishDate">
    </div>
    <div class="col-md-4">
        <label for="forWho">신청현황공개</label>
        <select class="form-control form-select" id="forWho">
            <option value="0">작성자만</option>
            <option value="1">관리자/교수</option>
            <option value="2">모두에게</option>
        </select>
    </div>
</div>
<div class="mb-3" id="selectLevelDiv">
    <label>신청대상</label>
    <div class="form-check form-check-inline ms-4">
        <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="교수">
        <label class="form-check-label" for="inlineCheckbox1">교수</label>
    </div>
    <div class="form-check form-check-inline">
        <input class="form-check-input" type="checkbox" id="inlineCheckbox2" value="조교">
        <label class="form-check-label" for="inlineCheckbox2">조교</label>
    </div>
    <div class="form-check form-check-inline">
        <input class="form-check-input" type="checkbox" id="inlineCheckbox3" value="학부생">
        <label class="form-check-label" for="inlineCheckbox3">학부생</label>
    </div>
</div>

<textarea id="regUpdateContent"></textarea>
<%--버튼이 나와야 하는 자리--%>
<div id="write_post" class="d-grid gap-2 d-md-flex justify-content-md-end">
    <c:choose>
        <c:when test="${jsp == '\"bbs_write\"'}">
            <button type="button" class="btn btn-outline-secondary" onclick="insertReg()">추가</button>
        </c:when>
        <c:when test="${jsp == '\"bbs_modify\"'}">
            <button type="button" class="btn btn-outline-secondary" onclick="modifyReg()">수정</button>
            <script>
                var content = $('#regUpdateContent');
                var getReg = <%=getReg%>;
                content.html(getReg.text);
                $('#bbsTitleBox').html('<input class="form-control" id="bbsTitle" placeholder="제목을 입력하세요." value="'+getReg.title+'">');
            </script>
        </c:when>
    </c:choose>
    <button type="button" class="btn btn-outline-secondary" onclick="back()">뒤로</button>
</div>
<div class="file-loading">
    <input id="kv-explorer" type="file" multiple>
</div>
<div>신청하기 폼은 여기에서 작성</div>

<script>
    var major = <%=major%>;
    var num = <%=num%>;
    var id = <%=id%>;
    var user = <%=user%>;
    var type = <%=type%>;

    CKEDITOR.replace('regUpdateContent', {
        allowedContent: true,
        height: 500,
        'filebrowserUploadUrl': 'Uploader'
    });

    function insertReg(){
        var writer_id = user.id;
        var writer_name = type.for_header;
        var title = $('#bbsTitle').val();
        var last_modified = formatDate(new Date());
        var text = CKEDITOR.instances.regUpdateContent.getData();
        // var starting_date =;
        // var closing_date = ;
        // var level =;
        // var for_who = ;

        var data = major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+last_modified+"-/-/-"+text;

        var check = confirm(data+"를 추가하시겠습니까?");
        if (check) {
            $.ajax({
                url: 'ajax.kgu',
                type: 'post',
                data: {
                    req: "insertReg",
                    data: data
                },
                success: function (data) {
                    if (data == 'success') {
                        alert("내용이 추가되었습니다.");
                        window.location.href = 'reg.kgu?major=' + major + '&&num=' + num + '&&mode=list';
                    } else
                        alert('SERVER ERROR, Please try again later');
                }
            })
        }
    }

    function modifyReg(){
        var id = getReg.id;
        var title = $('#bbsTitle').val();
        var text = CKEDITOR.instances.regUpdateContent.getData();
        var writer_id = user.id;
        var writer_name = type.for_header;
        var last_modified = formatDate(new Date());
        var data = id+"-/-/-"+major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+last_modified+"-/-/-"+text;

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "modifyReg", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if(data=='success'){
                    alert("해당 내용이 수정되었습니다.");
                    back();
                }
                else{
                    alert('권한이 부족합니다.');
                }
            }
        })
    }

    function back(){
        window.location.href = 'bbs.kgu?major='+major+'&&num='+num+'&&mode=view&&id='+id;
    }

    function formatDate(date) { //날짜를 yyyy-mm-dd 형식으로 반환
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }
    var upload_folder = '/img/bbs';
    $("#kv-explorer").fileinput({
        'theme': 'explorer-fa',
        'uploadUrl': 'upload.kgu?folder='+upload_folder,
        showRemove : false,
        showUpload : false,
        overwriteInitial : false,
        uploadExtraData:{
            file_type : 'null',
            board_level : '0',
            upload_mode : 'bbs'
        }
    });
</script>