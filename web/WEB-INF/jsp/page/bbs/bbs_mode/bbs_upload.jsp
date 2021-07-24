<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-21
  Time: 오전 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getBBS = (String) request.getAttribute("getBBS");
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
<textarea id="bbsUpdateContent"></textarea>
<%--버튼이 나와야 하는 자리--%>
<div id="write_post" class="d-grid gap-2 d-md-flex justify-content-md-end">
<c:choose>
    <c:when test="${jsp == '\"bbs_write\"'}">
        <button type="button" class="btn btn-outline-secondary" onclick="insertBbs()">추가</button>
    </c:when>
    <c:when test="${jsp == '\"bbs_modify\"'}">
        <button type="button" class="btn btn-outline-secondary" onclick="modifyBbs()">수정</button>
        <script>
            var content = $('#bbsUpdateContent');
            var getBBS = <%=getBBS%>;
            content.html(getBBS.text);
            $('#bbsTitleBox').html('<input class="form-control" id="bbsTitle" placeholder="제목을 입력하세요." value="'+getBBS.title+'">');
        </script>
    </c:when>
</c:choose>
    <button type="button" class="btn btn-outline-secondary" onclick="back()">뒤로</button>
</div>
<div class="file-loading">
    <input id="kv-explorer" type="file" multiple>
</div>


<script>
    var major = <%=major%>;
    var num = <%=num%>;
    var id = <%=id%>;
    var user = <%=user%>;
    var type = <%=type%>;

    CKEDITOR.replace('bbsUpdateContent', {
        allowedContent: true,
        height: 500,
        'filebrowserUploadUrl': 'Uploader'
    });

    function insertBbs(){
        var title = $('#bbsTitle').val();
        var text = CKEDITOR.instances.bbsUpdateContent.getData();
        var writer_id = user.id;
        var writer_name = type.for_header;
        var last_modified = formatDate(new Date());
        var data = major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+last_modified+"-/-/-"+text;

        var check = confirm(data+"를 추가하시겠습니까?");
        if (check) {
            $.ajax({
                url: 'ajax.kgu',
                type: 'post',
                data: {
                    req: "insertBbs",
                    data: data
                },
                success: function (data) {
                    if (data == 'success') {
                        alert("내용이 추가되었습니다.");
                        window.location.href = 'bbs.kgu?major=' + major + '&&num=' + num + '&&mode=list';
                    } else
                        alert('SERVER ERROR, Please try again later');
                }
            })
        }
    }

    function modifyBbs(){
        var id = getBBS.id;
        var title = $('#bbsTitle').val();
        var text = CKEDITOR.instances.bbsUpdateContent.getData();
        var writer_id = user.id;
        var writer_name = type.for_header;
        var last_modified = formatDate(new Date());
        var data = id+"-/-/-"+major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+last_modified+"-/-/-"+text;

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "modifyBbs", //이 메소드를 찾아서
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
    $("#kv-explorer").fileinput({
        'theme': 'explorer-fa',
        'uploadUrl': 'notice_board_upload.kgu',
        showRemove : false,
        showUpload : false,
        overwriteInitial : false,
        uploadExtraData:{
            writer : user.id,
            num : num
        }
    });
</script>