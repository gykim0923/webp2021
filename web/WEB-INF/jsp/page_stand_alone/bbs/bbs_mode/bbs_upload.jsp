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
    String getAllFile = (String) request.getAttribute("bbsFiles");
%>
<script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>
<script src="js/default.js"></script>
<%--<script src="js/jquery-3.2.1.min.js"></script>--%>
<script src="js/jquery.cookie.js"></script>
<script src="//cdn.ckeditor.com/4.8.0/standard/ckeditor.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.2/js/plugins/sortable.min.js" type="text/javascript"></script>
<link href="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.2/css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
<script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.2/js/fileinput.min.js"></script>
<link
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
        media="all" rel="stylesheet" type="text/css" />
<script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.2/themes/fas/theme.min.js"></script>

<div class="h3">글 작성하기</div>
<%--ckeditor가 나와야 하는 자리--%>
<div class="form-group mb-3" id="bbsTitleBox"><input class="form-control" id="bbsTitle" placeholder="제목을 입력하세요. (최대 200자)"></div>
<textarea id="bbsUpdateContent"></textarea>

<ul class="list-group" id="alreadyFiles"></ul>
<div class="file-loading">
    <input id="bbsFile" type="file" multiple>
</div>
<%--버튼이 나와야 하는 자리--%>
<div id="write_post" class="mt-3 d-grid gap-2 d-flex justify-content-between">
    <button type="button" class="btn btn-outline-danger" onclick="back()">뒤로</button>
<c:choose>
    <c:when test="${jsp == '\"bbs_write\"'}">
        <button type="button" class="btn btn-outline-success" onclick="insertBbs()">추가</button>
    </c:when>
    <c:when test="${jsp == '\"bbs_modify\"'}">
        <button type="button" class="btn btn-outline-primary" onclick="modifyBbs()">수정</button>
        <script>
            var content = $('#bbsUpdateContent');
            var getBBS = <%=getBBS%>;
            content.html(getBBS.text);
            var alreadyFiles = <%=getAllFile%>;
            $('#bbsTitleBox').html('<input class="form-control" id="bbsTitle" placeholder="제목을 입력하세요." value="'+getBBS.title+'">');
            if(alreadyFiles.length > 0){
                var alreadyPanel = $('#alreadyFiles');
                for(var i = 0 ; i < alreadyFiles.length ; ++i){
                    var value = alreadyFiles[i];
                    alreadyPanel.append('<li class="list-group-item d-flex justify-content-between align-items-center" id="alreadyFileDiv' + i + '">' + value.original_FileName + '<a onclick="alreadyDelete(' + i + ')"><i class="bi bi-x-lg"></i></a></li>')
                }
            }
            function alreadyDelete(index){
                var value = alreadyFiles[index];
                swal.fire({
                    title: '정말로 파일을 삭제하시나요?',
                    text: '다시 되돌릴 수 없습니다.',
                    icon: 'warning',
                    showConfirmButton: true,
                    showCancelButton: true
                }).then(function () {
                    $.ajax({
                        url: 'ajax.kgu',
                        type: 'post',
                        data: {
                            req: "deleteBbsAlreadyFile",
                            data: value.id
                        },
                        success: function (data) {
                            if (data == "success") {
                                $('#alreadyFileDiv' + index).remove();
                                swal.fire({
                                    title: '파일이 삭제되었습니다.',
                                    icon: 'success',
                                    showConfirmButton: true
                                })
                            } else {
                                swal.fire({
                                    title: '서버에러',
                                    text: '다음에 다시 시도해주세요',
                                    icon: 'error',
                                    showConfirmButton: true
                                });
                                return;
                            }
                        }
                    })
                });
            }
        </script>
    </c:when>
</c:choose>
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
        if(title.length == 0){
            swal.fire({
                title : '제목을 입력해주세요',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        if(title.length > 200){
            swal.fire({
                title : '제목은 200자 이하로 작성하여 주시기바랍니다.',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        var text = CKEDITOR.instances.bbsUpdateContent.getData();
        if(text.length == 0){
            swal.fire({
                title : '내용을 입력해주세요',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        var writer_id = user.id;
        var writer_name = user.name;
        var last_modified = formatDate(new Date());
        var data = major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+last_modified+"-/-/-"+text;
            $.ajax({
                url: 'ajax.kgu',
                type: 'post',
                data: {
                    req: "insertBbs",
                    data: data
                },
                success: function (data) {
                    console.log("error : "+data);
                    if (data == 'success') {
                        swal.fire({
                            title : '내용이 추가되었습니다.',
                            icon : 'success',
                            showConfirmButton: true

                        }).then(function (){
                            location.href = 'bbs.kgu?major=' + major + '&&num=' + num + '&&mode=list';
                        });
                    } else
                        swal.fire({
                            title : '서버에러',
                            text : '다음에 다시 시도해주세요',
                            icon : 'error',
                            showConfirmButton: true

                        });
                }
            })
        }


    function modifyBbs(){
        var bbs_id = getBBS.id;
        var title = $('#bbsTitle').val();
        if(title.length == 0){
            swal.fire({
                title : '제목을 입력해주세요',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        if(title.length > 200){
            swal.fire({
                title : '제목은 200자 이하로 작성하여 주시기바랍니다.',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        var text = CKEDITOR.instances.bbsUpdateContent.getData();
        if(text.length == 0){
            swal.fire({
                title : '내용을 입력해주세요',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        var writer_id = user.id;
        var writer_name = user.name;
        var last_modified = formatDate(new Date());
        var data = bbs_id+"-/-/-"+major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+last_modified+"-/-/-"+text;

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "modifyBbs", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if(data=='success'){
                    swal.fire({
                        title : '해당 내용이 수정되었습니다.',
                        icon : 'success',
                        showConfirmButton: true
                    });

                }
                else{
                    swal.fire({
                        title : '권한이 부족합니다.',
                        icon : 'error',
                        showConfirmButton: true

                    });
                }
                window.location.href = 'bbs.kgu?major='+major+'&&num='+num+'&&mode=view&&id='+id;
            }
        })
    }

    function back(){
        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "deleteNotUploadedFile", //이 메소드를 찾아서
                data: '/uploaded/bbs' //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if(data=='success'){
                    swal.fire({
                        title : '뒤로가기',
                        text : '올렸던 글과 파일들은 저장되지 않습니다!',
                        icon : 'error',
                        showConfirmButton: true
                    }).then(function () {
                        window.location.href = 'bbs.kgu?major='+major+'&&num='+num+'&&mode=list';
                    });
                }
                else{
                    swal.fire({
                        title : '서버에러',
                        text : '다음에 다시 시도해주세요',
                        icon : 'error',
                        showConfirmButton: true
                    });
                }
            }
        })
    }

    history.pushState(null, null, location.href);

    window.onpopstate = function(event) { //뒤로가기 이벤트 발생시
        history.go(1); //뒤로 가지 않고 현재 페이지에서 머물어 업로드 되지 못한 파일 삭제 후 리스트 페이지로 감
        back();
    };

    function formatDate(date) { //날짜를 yyyy-mm-dd 형식으로 반환
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }

    var file_id; //나중에 파일 상세정보를 uploadedFile로부터 역참조 하고싶은 경우에 사용하라고 만들어둠 (다운로드에서 사용하는 기능)
    var file_folder; //다운로드에서 쓸 경로
    var file_path; //파일이 업로드된 상대경로


    var upload_folder = '/uploaded/bbs';
    $("#bbsFile").fileinput({
        uploadUrl: 'upload.kgu?folder='+upload_folder,
        uploadExtraData:{
            file_type : 'null',
                board_level : '1',
                upload_mode : 'bbs',
        },
        overwriteInitial : false,
        preferIconicPreview: true,
        previewFileIconSettings: { // configure your icon file extensions
                'doc': '<i class="bi bi-file-earmark-word-fill text-primary"></i>',
                'hwp': '<i class="bi bi-file-earmark-richtext-fill text-primary"></i>',
                'xls': '<i class="bi bi-file-earmark-excel-fill text-success"></i>',
                'ppt': '<i class="bi bi-file-earmark-ppt-fill text-danger"></i>',
                'pdf': '<i class="bi bi-file-earmark-pdf-fill text-danger"></i>',
                'zip': '<i class="bi bi-file-earmark-zip-fill text-muted"></i>',
                'htm': '<i class="bi bi-file-earmark-code-fill text-info"></i>',
                'txt': '<i class="bi bi-file-earmark-text-fill text-info"></i>',
                'mov': '<i class="bi bi-file-earmark-play-fill text-warning"></i>',
                'mp3': '<i class="bi bi-file-earmark-play-fill text-warning"></i>',
                'jpg': '<i class="bi bi-file-earmark-image-fill text-danger"></i>',
                'gif': '<i class="bi bi-file-earmark-image-fill text-muted"></i>',
                'png': '<i class="bi bi-file-earmark-image-fill text-primary"></i>'
        },
        previewFileExtSettings: { // configure the logic for determining icon file extensions
            'doc': function(ext) {
                return ext.match(/(doc|docx)$/i);
            },
            'hwp': function(ext) {
                return ext.match(/(hwp)$/i);
            },
            'xls': function(ext) {
                return ext.match(/(xls|xlsx)$/i);
            },
            'ppt': function(ext) {
                return ext.match(/(ppt|pptx)$/i);
            },
            'zip': function(ext) {
                return ext.match(/(zip|rar|tar|gzip|gz|7z)$/i);
            },
            'htm': function(ext) {
                return ext.match(/(htm|html)$/i);
            },
            'txt': function(ext) {
                return ext.match(/(txt|ini|csv|java|php|js|css)$/i);
            },
            'mov': function(ext) {
                return ext.match(/(avi|mpg|mkv|mov|mp4|3gp|webm|wmv)$/i);
            },
            'mp3': function(ext) {
                return ext.match(/(mp3|wav)$/i);
            }
        }
    }).on('filedeleted', function() {
        swal.fire({
            title : '파일이 삭제되었습니다.',
            icon : 'success',
            showConfirmButton: true
        })
    });
    // $("#bbsFile").fileinput({
    //     'theme': 'explorer-fa',
    //     'uploadUrl': 'upload.kgu?folder='+upload_folder,
    //     showRemove : false,
    //     showUpload : false,
    //     overwriteInitial : false,
    //     uploadExtraData:{
    //         file_type : 'null',
    //         board_level : '0',
    //         upload_mode : 'bbs'
    //     }
    // }).on('fileuploaded', function(event, previewId, index, fileId) {
    //     console.log('File Uploaded', 'ID: ' + fileId + ', Thumb ID: ' + previewId);
    // }).on('fileuploaderror', function(event, data, msg) {
    //     console.log('File Upload Error', 'ID: ' + data.fileId + ', Thumb ID: ' + data.previewId);
    // }).on('filebatchuploadcomplete', function(event, preview, config, tags, extraData) {
    //     console.log('File Batch Uploaded', preview, config, tags, extraData);
    // });
</script>