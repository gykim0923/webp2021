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
    String getAllFile = (String) request.getAttribute("regFiles");
%>
<script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>
<script src="js/default.js"></script>
<script src="js/jquery.cookie.js"></script>
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
<div class="form-group mb-3" id="bbsTitleBox"><input class="form-control" id="bbsTitle" placeholder="제목을 입력하세요."></div>

<div class="row mb-3" >
    <div class="col-md-4 form-group" id="sDate">
        <label for="InputStartDate">시작일</label>
        <input type="date" class="form-control" name="startDate" id="InputStartDate" >
    </div>
    <div class="col-md-4 form-group" id="cDate">
        <label for="InputFinishDate">마감일</label>
        <input type="date" class="form-control" name="finishDate" id="InputFinishDate" >
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
    <div class="form-check form-check-inline ms-4" id="check1">
        <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="교수">
        <label class="form-check-label" for="inlineCheckbox1">교수</label>
    </div>
    <div class="form-check form-check-inline" id="check2">
        <input class="form-check-input" type="checkbox" id="inlineCheckbox2" value="조교">
        <label class="form-check-label" for="inlineCheckbox2">조교</label>
    </div>
    <div class="form-check form-check-inline" id="check3">
        <input class="form-check-input" type="checkbox" id="inlineCheckbox3" value="학생">
        <label class="form-check-label" for="inlineCheckbox3">학생</label>
    </div>
</div>


<textarea id="regUpdateContent"></textarea>

<!-- Modal /  폼 모달-->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id = "myModalBody"></div>
            <div class="modal-footer" id="myModalFooter"></div>
        </div>
    </div>
</div>

<%--파일 나와야 하는 자리--%>
<ul class="list-group" id="alreadyFiles"></ul>
<div class="file-loading mb-3">
    <input id="regFile" type="file" multiple>
</div>

<%--질문 폼 만드는 버튼 --%>
<div class="my-2" id="formButtons"></div>

<div id="questionYouMade"></div>

<div id="write_post" class="d-grid gap-2 d-md-flex justify-content-md-end">
    <c:choose>
        <c:when test="${jsp == '\"reg_write\"'}">
            <button type="button" class="btn btn-outline-secondary" onclick="insertReg()">추가</button>
            <script>
                var list = $('#formButtons');
                var text = '';
                text += '<div class="my-2">'
                text += '<button class="btn btn-secondary mx-1" id="q1" type="" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeQ1Modal()">주관식</button>'
                text += '<button class="btn btn-secondary mx-1" id="q2" type="" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeQ2Modal()">단일객관식</button>'
                text += '<button class="btn btn-secondary mx-1" id="q3" type="" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeQ3Modal()">다중객관식</button>'
                text += '<button class="btn btn-secondary mx-1" id="q4" type="" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeQ4Modal()">척도형</button>'
                text += '<button class="btn btn-secondary mx-1" id="q5" type="" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeQ5Modal()">파일업로드형</button> </div>'
                list.html(text);
            </script>
        </c:when>
        <c:when test="${jsp == '\"reg_modify\"'}">
            <button type="button" class="btn btn-outline-secondary" onclick="modifyReg()">수정</button>
            <script>
                function formatDate(date) { //날짜를 yyyy-mm-dd 형식으로 반환
                    var d = new Date(date),
                        month = '' + (d.getMonth() + 1),
                        day = '' + d.getDate(),
                        year = d.getFullYear();

                    if (month.length < 2) month = '0' + month;
                    if (day.length < 2) day = '0' + day;

                    return [year, month, day].join('-');
                }

                var content = $('#regUpdateContent');
                var startDate = $('#sDate');
                var endDate = $('#cDate')
                var who = $('#forWho');
                var check1 = $('#check1');
                var check2 = $('#check2');
                var check3 = $('#check3');
                var text = '';
                var getReg = <%=getReg%>;
                content.html(getReg.text);
                $('#bbsTitleBox').html('<input class="form-control" id="bbsTitle" placeholder="제목을 입력하세요." value="'+getReg.title+'">');
                startDate.html('<label for="InputStartDate">시작일</label><input type="date" class="form-control" name="startDate" id="InputStartDate" value="'+formatDate(getReg.starting_date)+'">');
                endDate.html('<label for="InputFinishDate">마감일</label><input type="date" class="form-control" name="finishDate" id="InputFinishDate" value="'+formatDate(getReg.closing_date)+'">');

                if(getReg.for_who == '1'){
                    text ='<option value="1">관리자/교수</option><option value="0">작성자만</option><option value="2">모두에게</option>'
                }
                else if(getReg.for_who == '2'){
                    text ='<option value="2">모두에게</option><option value="1">관리자/교수</option><option value="0">작성자만</option>'
                }
                else {
                    text ='<option value="0">작성자만</option><option value="1">관리자/교수</option><option value="2">모두에게</option>'
                }

                who.html(text);

                if( getReg.level.indexOf("교수") >=0){
                    check1.html('<input class="form-check-input" type="checkbox" checked  id="inlineCheckbox1" value="교수"><label class="form-check-label" for="inlineCheckbox1">교수</label>');
                }
                if( getReg.level.indexOf("조교") >=0) {
                    check2.html('<input class="form-check-input"  type="checkbox" checked id="inlineCheckbox2" value="조교"><label class="form-check-label" for="inlineCheckbox2">조교</label>');
                }
                if( getReg.level.indexOf("학생")>=0) {
                    check3.html('<input class="form-check-input" type="checkbox" checked id="inlineCheckbox3" value="학생"><label class="form-check-label" for="inlineCheckbox3">학생</label>');
                }
                var alreadyFiles = <%=getAllFile%>;
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
                                req: "deleteRegAlreadyFile",
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
    <button type="button" class="btn btn-outline-secondary" onclick="back()">뒤로</button>
</div>

<script>

    var body = $('#myModalBody');
    var footer = $('#myModalFooter');

    function makeQ1Modal(){
        $('#staticBackdropLabel').html('주관식');
        var index = 1;
        var text ='';
        var text1 ='';
        text = '<div class="form-group"><input type="text" class="form-control" id="InputQ1" placeholder="질문을 입력해주세요"></div>';
        text1 = '<button type="button" class="btn btn-secondary my-2" data-bs-dismiss="modal" onclick="submitQ1('+index+')">저장</button>';
        body.html(text);
        footer.html(text1);
    }

    function makeQ2Modal(){
        $('#staticBackdropLabel').html('단일객관식');
        answerIndex = 1;
        var index = 2;
        var text ='';
        var text1 ='';
        text +='<div class="form-group my-2"><input type="text" class="form-control" id="InputQ2" placeholder="질문을 입력해주세요"></div>'
        text += '<div id="answers"></div>';
        text += '<div class="my-2" style="width : 200px"><div class="input-group"><input type="text" class="form-control" placeholder="새로운 답변" id="newAnswer"><span class="input-group-btn"><button type="button" class="btn btn-secondary mx-2" onclick="makeAnswer()">추가!</button></span></div></div>';
        text1 ='<button type="button" class="btn btn-secondary my-2" data-bs-dismiss="modal" onclick="submitQ2('+index+')">저장</button>'
        body.html(text);
        footer.html(text1);
    }

    function makeQ3Modal(){
        $('#staticBackdropLabel').html('단중객관식');
        answerIndex = 1;
        var index = 3;
        var text ='';
        var text1 ='';
        text += '<div class="form-group my-2"><input type="text" class="form-control" id="InputQ3" placeholder="질문을 입력해주세요"></div>';
        text += '<div  id="answers"></div>';
        text += '<div class="my-2" style="width : 200px"><div class="input-group"><input type="text" class="form-control" placeholder="새로운 답변" id="newAnswer"><span class="input-group-btn"><button type="button" class="btn btn-secondary mx-2" onclick="makeAnswer()">추가!</button></span></div></div>';
        text1 = '<button type="button" class="btn btn-secondary my-2" data-bs-dismiss="modal" onclick="submitQ3('+index+')">저장</button>'
        body.html(text);
        footer.html(text1);
    }

    function makeQ4Modal(){
        $('#staticBackdropLabel').html('척도형');
        var list = $('#myModalbody');
        var index = 4;
        var text ='';
        var text1 ='';
        text += '<div class="form-group"><input type="text" class="form-control my-2" id="InputQ4" placeholder="질문을 입력해주세요"></div>';
        text += '<div class="form-group my-2" style="width : 200px"><input type="text" class="form-control" id="InputMin" placeholder="최솟값"></div>';
        text += '<div class="form-group my-2" style="width : 200px"><input type="text" class="form-control" id="InputMax" placeholder="최댓값"></div>';
        text1 = '<button type="button" class="btn btn-secondary my-2" data-bs-dismiss="modal" onclick="submitQ4('+index+')">저장</button>'
        body.html(text);
        footer.html(text1);
    }

    function makeQ5Modal(){
        $('#staticBackdropLabel').html('파일업로드형');
        var list = $('#myModalbody');
        var index = 5;
        var text ='';
        var text1 ='';
        text += '<div class="form-group my-2"><input type="text" class="form-control" id="InputQ5" placeholder="어떠한 파일을 올릴지 간단한 설명을 적어주세요"></div>';
        text1 ='<div class="my-2"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="submitQ5('+index+')">저장</button></div>';
        body.html(text);
        footer.html(text1);
    }
    var questionIndex = 1;
    var whatSequence = [];
    var howManyQuestion = whatSequence.length;
    var question;

    for(var k = 1 ; k <= howManyQuestion ; k ++){
        var i = whatSequence[k-1]
        if($('#Type'+i).text() == '주관식'){
            question += '1-/!/-';
            question += $('#question'+i).val();

        }

        if($('#Type'+i).text() == "단일객관식"){
            question += "2-/!/-";
            question += $('#question'+i).val() + "-/@/-";
            var length = $('.Q'+i).length;
            for(var j = 1 ; j <= length ; j++){
                var text = $('#Q'+i+'A'+j).val();
                question += text;
                if(j != length)
                    question += "-/@/-"
            }
        }

        if($('#Type'+i).text() == "다중객관식"){
            question += "3-/!/-";
            question += $('#question'+i).val() + "-/@/-";
            var length = $('.Q'+i).length;
            for(var j = 1 ; j <= length ; j++){
                var text = $('#Q'+i+'A'+j).val();
                question += text;
                if(j != length)
                    question += "-/@/-"
            }
        }
        if($('#Type'+i).text() == '척도형'){
            question += "4-/!/-";
            question += $('#question'+i).val() + "-/@/-"
            question += $('#min'+i).val() + "-/@/-" + $('#max'+i).val();
        }
        if($('#Type'+i).text() == '파일업로드형'){
            question += '5-/!/-';
            question += $('#question'+i).val();
        }
        if(k != howManyQuestion)
            question += "-/#/-"
    }
    var a ='';
    function submitQ1(index){
        a='';
        var text = $('#InputQ1').val();
        if(text == null){
            swal.fire({
                title : '질문을 만들어 주세요.',
                icon : 'warning',
                showConfirmButton: true

            });
            return;
        }
        a += '<div class= "my-1" id="wantRemove'+questionIndex+'"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16"><path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/></svg><span id="Type'+questionIndex+'">주관식</span>' +
            '<div class="input-group mb-3 my-2"> <input type="text" class="form-control" readonly id="question'+questionIndex+'" name="question'+questionIndex+'" placeholder="" value="'+ text +'" aria-label="" aria-describedby="button-addon2"> <div class="input-group-append"> <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="removeQuestion('+questionIndex+')">삭제</button> </div></div><hr style="border:1px dotted black"></div>';
        whatSequence.push(questionIndex);
        questionIndex++;
        $('#questionYouMade').append(a);
    }

    function submitQ2(index){
        a='';
        var answerLength = $('.count').length;
        var text = $('#InputQ2').val();
        if(text == null){
            swal.fire({
                title : '질문을 만들어 주세요.',
                icon : 'warning',
                showConfirmButton: true

            });
            return;
        }
        a += '<div class= "my-1" id="wantRemove'+questionIndex+'"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16"><path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/></svg><span id="Type'+questionIndex+'">단일객관식</span>'+
            '<div class="input-group mb-3 my-2"> <input type="text" class="form-control" readonly id="question'+questionIndex+'" name="question'+questionIndex+'" placeholder=""value="'+ text +'" aria-label="" aria-describedby="button-addon2"> <div class="input-group-append"> <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="removeQuestion('+questionIndex+')">삭제</button> </div><hr style="border:1px dotted black"></div>';
        a+='<div id="answerOf'+questionIndex+'"></div><hr style="border : 1px dotted black"></div>';
        $('#questionYouMade').append(a);
        var b = '';
        for(var i = 1 ; i <= answerLength ; ++i){
            var answer = $('#answer'+i).val();
            b += '<div class="radio disabled"><label><input type="radio" disabled class="Q' + questionIndex + '" id="Q' + questionIndex + 'A' + i + '" value="' + answer + '">' + answer + '</label></div>';
        }
        $('#answerOf'+questionIndex).html(b);
        whatSequence.push(questionIndex);
        questionIndex++;
    }
    function submitQ3(index){
        a = '';
        var answerLength = $('.count').length;
        var text = $('#InputQ3').val();
        if(text == null){
            swal.fire({
                title : '질문을 만들어 주세요.',
                icon : 'warning',
                showConfirmButton: true

            });
            return;
        }
        a += '<div class= "my-1" id="wantRemove'+questionIndex+'"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16"><path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/></svg><span id="Type'+questionIndex+'">다중객관식</span>'+
            '<div class="input-group mb-3 my-2"> <input type="text" class="form-control" readonly id="question'+questionIndex+'" name="question'+questionIndex+'" placeholder=""value="'+ text +'" aria-label="" aria-describedby="button-addon2"> <div class="input-group-append"> <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="removeQuestion('+questionIndex+')">삭제</button> </div><hr style="border:1px dotted black"></div>';
        a+='<div id="answerOf'+questionIndex+'"></div><hr style="border : 1px dotted black"></div>';
        $('#questionYouMade').append(a);
        var b = '';
        for(var i = 1 ; i <= answerLength ; ++i){
            var answer = $('#answer'+i).val();
            b += '<div class="checkbox disabled"><label><input type="checkbox" disabled class="Q' + questionIndex + '" id="Q' + questionIndex + 'A' + i + '" value="' + answer + '">' + answer + '</label></div>';
        }
        $('#answerOf'+questionIndex).html(b);
        whatSequence.push(questionIndex);
        questionIndex++;
    }
    function submitQ4(index){ // 척도형
        a='';
        var text = $('#InputQ4').val();
        var min = $('#InputMin').val() + '';
        var max = $('#InputMax').val() + '';
        var avg = Number(max) + Number(min);
        if(text == null){
            swal.fire({
                title : '질문을 만들어 주세요.',
                icon : 'warning',
                showConfirmButton: true

            });
            return;
        }
        if(min == '' || max == ''){
            swal.fire({
                title : '빈칸을 입력해주세요.',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        if(min > max){
            swal.fire({
                title : '최소값이 최댓값보다 큽니다!',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        if(!checkInt(min) || !checkInt(max)){
            swal.fire({
                title : '숫자만 입력해주세요',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        a += '<div class= "my-1" id="wantRemove'+questionIndex+'"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16"><path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/></svg><span id="Type'+questionIndex+'">척도형</span>';
        a += '<div class="input-group mb-3 my-2"> <input type="text" class="form-control" readonly id="question'+questionIndex+'" name="question'+questionIndex+'" placeholder="" value="'+ text +'" aria-label="" aria-describedby="button-addon2">';
        a += '<div class="input-group-append"> <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="removeQuestion('+questionIndex+')">삭제</button> </div></div>';

        a += min +'<input type="range" id="range' + questionIndex + '">' + max + '<input type="hidden" id="min' + questionIndex + '" value="' + min + '"><input type="hidden" id="max' + questionIndex + '" value="' + max + '"><br></div></div>';
        a += '<hr style="border : 1px dotted black"></div>'

        $('#questionYouMade').append(a);
        $('#range'+questionIndex).slider({
            min : min ,
            max : max ,
            value : Math.floor(avg/2),
            step : 1,
            enabled : false
        });
        whatSequence.push(questionIndex);
        questionIndex++;
    }
    function submitQ5(index){
        a = '';
        var text = $('#InputQ5').val();
        if(text == null){
            swal.fire({
                title : '질문을 만들어 주세요',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        a += '<div class= "my-1" id="wantRemove'+questionIndex+'"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16"><path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/></svg><span id="Type'+questionIndex+'">파일업로드형</span>'
            + '<div class="input-group mb-3 my-2"> <input type="text" class="form-control" readonly id="question'+questionIndex+'" name="question'+questionIndex+'" placeholder="" value="'+ text +'" aria-label="" aria-describedby="button-addon2"> <div class="input-group-append"> <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="removeQuestion('+questionIndex+')">삭제</button></div></div><input type="file" disabled><hr style="border:1px dotted black"></div>';
        whatSequence.push(questionIndex);
        questionIndex++;
        $('#questionYouMade').append(a);
    }


    function removeQuestion(index){
        $('#wantRemove'+index).remove();
        whatSequence = jQuery.grep(whatSequence, function(value) {
            return value != index;
        });
    }
    var answerIndex = 1;
    function makeAnswer(){
        var text = $('#newAnswer').val();
        if(text == ''){
            swal.fire({
                title : '칸을 입력해주세요',
                icon : 'warning',
                showConfirmButton: true
            });;
            return;
        }
        $('#newAnswer').val('');
        var a = '<div class="radio disabled count"><label><input type="radio" id="answer'+answerIndex+'" value="'+text+'" disabled>'+text+'</label></div>';
        $('#answers').append(a);
        answerIndex++;
    }
    function checkInt(String){
        var a = ['0','1','2','3','4','5','6','7','8','9'];
        var isOk = 1;
        for(var i = 0 ; i < String.length ; ++i){
            var value = String[i];
            if(!a.includes(value))
                isOk = 0;
        }
        if(isOk == 0)
            return false;
        else
            return true;
    }

</script>

<script>
    var major = <%=major%>;
    var num = <%=num%>;
    var id = <%=id%>;
    var user = <%=user%>;
    var type = <%=type%>;
    var arr = [];

    CKEDITOR.replace('regUpdateContent', {
        allowedContent: true,
        height: 500,
        'filebrowserUploadUrl': 'Uploader'
    });

    function insertReg(){
        var writer_id = user.id;
        var writer_name = type.for_header;
        var title = $('#bbsTitle').val();
        if(title.length == 0){
            swal.fire({
                title : '제목을 입력해주세요',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        var last_modified = formatDate(new Date());
        var text = CKEDITOR.instances.regUpdateContent.getData();
        if(text.length == 0){
            swal.fire({
                title : '내용을 입력해주세요',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        var starting_date = $('#InputStartDate').val();
        var closing_date = $('#InputFinishDate').val();
        if(starting_date.length == 0 || closing_date.length == 0){
            swal.fire({
                title : '시작일/종료일을 입력해주세요',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        var level = '';
        for(var i = 0 ; i < 4 ; ++i){
            if($('input:checkbox[id="inlineCheckbox' + i +'"]').is(":checked") ==  true)
                level += '|'+$('#inlineCheckbox'+i).val()+'|';
        }
        if(level.length == 0){
            swal.fire({
                title : '신청대상을 선택해주세요.',
                icon : 'warning',
                showConfirmButton: true
            });
            return;;
        }
        var for_who = $('#forWho').val();

        // -/#/- 로 문제마다 구분 -/!/-로 문제 유형과 답변 구분  -/@/- 로 답변별 구분    1 주관 2 단일객관 3 다중객관 4척도형 5 파일업로드형
        var question = '';
        var howManyQuestion = whatSequence.length;
        if(howManyQuestion == 0){
            swal.fire({
                title : '질문을 만들어 주세요',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        for(var k = 1 ; k <= howManyQuestion ; k ++){
            var i = whatSequence[k-1]
            if($('#Type'+i).text() == '주관식'){
                question += '1-/!/-';
                question += $('#question'+i).val();
            }
            if($('#Type'+i).text() == "단일객관식"){
                question += "2-/!/-";
                question += $('#question'+i).val() + "-/@/-";
                var length = $('.Q'+i).length;
                for(var j = 1 ; j <= length ; j++){
                    var text = $('#Q'+i+'A'+j).val();
                    question += text;
                    if(j != length)
                        question += "-/@/-"
                }
            }
            if($('#Type'+i).text() == "다중객관식"){
                question += "3-/!/-";
                question += $('#question'+i).val() + "-/@/-";
                var length = $('.Q'+i).length;
                for(var j = 1 ; j <= length ; j++){
                    var text = $('#Q'+i+'A'+j).val();
                    question += text;
                    if(j != length)
                        question += "-/@/-"
                }
            }
            if($('#Type'+i).text() == '척도형'){
                question += "4-/!/-";
                question += $('#question'+i).val() + "-/@/-"
                question += $('#min'+i).val() + "-/@/-" + $('#max'+i).val();
            }
            if($('#Type'+i).text() == '파일업로드형'){
                question += '5-/!/-';
                question += $('#question'+i).val();
            }
            if(k != howManyQuestion)
                question += "-/#/-"
        }

        var data = writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+last_modified+"-/-/-"+text+"-/-/-"+starting_date+"-/-/-"+closing_date+"-/-/-"+level+"-/-/-"+for_who+"-/-/-"+question+"-/-/-"+type.board_level;


            $.ajax({
                url: 'ajax.kgu',
                type: 'post',
                data: {
                    req: "insertReg",
                    data: data
                },
                success: function (data) {
                    if (data == 'success') {
                        swal.fire({
                            title : '내용이 추가되었습니다.',
                            icon : 'success',
                            showConfirmButton: true
                        }).then(function (){
                            location.href = 'reg.kgu?major=' + major + '&&num=' + num + '&&mode=list';
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


    function modifyReg(){
        var id = getReg.id;
        var title = $('#bbsTitle').val();
        var text = CKEDITOR.instances.regUpdateContent.getData();
        var writer_id = user.id;
        var for_who = $('#forWho').val();
        var level = '';
        for(i=1; i<=3; i++){
            if($('input:checkbox[id="inlineCheckbox' + i +'"]').is(":checked") ==  true)
                    level += '|'+$('#inlineCheckbox'+i).val()+'|';
        }
        var startingDate =$('#InputStartDate').val();;
        var closingDate =$('#InputFinishDate').val();;
        var writer_name = type.for_header;
        var last_modified = formatDate(new Date());
        var data = id+"-/-/-"+ title +"-/-/-"+ text +"-/-/-"+writer_id+"-/-/-"+for_who+"-/-/-"+level +"-/-/-"+startingDate +"-/-/-" +closingDate+"-/-/-"+writer_name+"-/-/-"+last_modified;

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "modifyReg", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if(data=='success'){

                    swal.fire({
                        title : '해당 내용이 수정되었습니다.',
                        icon : 'success',
                        showConfirmButton: true

                    })
                    back();
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

    function back(){
        window.location.href = 'reg.kgu?major='+major+'&&num='+num+'&&mode=list';
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

    var upload_folder = '/img/bbs_reg';

    $("#regFile").fileinput({
        'uploadUrl': 'upload.kgu?folder='+upload_folder,
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
    // }).on('fileuploaded', function() {
        //파일이 삭제되었습니다 추가?
    }).on('filedeleted', function() {
        swal.fire({
            title : '파일이 삭제되었습니다.',
            icon : 'success',
            showConfirmButton: true
        })
    });
</script>