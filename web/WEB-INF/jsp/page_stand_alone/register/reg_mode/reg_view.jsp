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
    String AnswerWhoDone = (String) request.getAttribute("AnswerWhoDone");
    String getAllFile = (String) request.getAttribute("regFiles");
%>
<script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>

<script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
<%--<script src="js/bootstrap-slider.js"></script>--%>
<div>
    <div class="h2" id="view_title"></div>
    <hr>
    <div class="row" id="view_info"></div>
    <hr>
    <div id="post_box"></div>
    <div id="view_content"></div>
    <hr>
    <div id="questions" class="card"></div>
    <ul class="list-group" id="anotherDone"></ul>
</div>
<div class="mt-3 d-grid gap-2 d-flex justify-content-between" id="list_button"></div>

<script>
    var major = <%=major%>;
    var num = <%=num%>;
    var id = <%=id%>;
    var type = <%=type%>;
    var user = <%=user%>;
    var getReg = <%=getReg%>;
    var anotherAnswer = <%=AnswerWhoDone%>;
    var getAllFile = <%=getAllFile%>;

    var file_id; //나중에 파일 상세정보를 uploadedFile로부터 역참조 하고싶은 경우에 사용하라고 만들어둠 (다운로드에서 사용하는 기능)
    var file_folder; //다운로드에서 쓸 경로
    var file_path; //파일이 업로드된 상대경로

    var questions = null;
    var starting_date = getReg.starting_date;
    var start = new Date(starting_date).getTime();
    var closing_date = getReg.closing_date;
    var close = new Date(closing_date).getTime() + 1000*60*60*24;
    var current = new Date().getTime();
    var isAvailable = 0; // 신청이 가능한지 검사하는 변수
    var isFileExist = false //파일이 존재하는지 검사하는 변수 파일이 있어야 압축 버튼 생김
    var wasDone = 0; //예전에 제출한 것이 있는지 검사하는 변수
    if(start <= current && current <= close){
        isAvailable = 1;
    }

    $(document).ready(function(){
        if(user == null)
            return;
        check();
        makeViewTitle();
        makeViewInfo();
        makeViewPost()
        makeViewContent();
        getQuestion();
        makeAnother();
        if(wasDone == 0)
            settingQuestion();
        else
            whatIDone();
        makeViewButtons();
    })

    function formatDate(date) {  //주어진 날짜를 yyyy-mm-dd 형식으로 반환해주는 함수
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }

    function makeViewTitle() {
        var content = $('#view_title');
        content.append(getReg.title);
    }
    function makeViewInfo(){
        var content = $('#view_info');
        content.append('<div class="col">'+getReg.writer_name+'</div><div class="col-md-auto">참여자 수 : '+getReg.applicant_count+'</div><div class="col-md-auto">참여기간 : '+formatDate(getReg.starting_date)+'~'+formatDate(getReg.closing_date)+'</div>');
    }
    function makeViewContent() {
        var content = $('#view_content');
        content.append(getReg.text);
    }

    var doneQuestion = null;
    function check(){ //이미 신청을 한 사람인지 확인
        var sending = getReg.id;
        $.ajax({
            url : 'ajax.kgu',
            type : 'post',
            async :false,
            data : {
                req: 'whoAnswerIt',
                data: sending
            },
            dataType : 'json',
            success : function(data){
                if(data == 'fail')
                    swal.fire({
                        title : '서버에러',
                        text : '다음에 다시 시도해주세요',
                        icon : 'error',
                        showConfirmButton: true

                    });
                if(data == 'empty'){
                    return;
                }
                else{
                    wasDone = 1;
                    doneQuestion = data;
                }
            }
        })
    }

    function makeAnother(){
        var AnotherPanel = $('#anotherDone');
        if(getReg.for_who == 0){
            if(getReg.writer_id != user.id)
                return;
        }
        else if(getReg.for_who == 1){
            if(type.for_header != "관리자" && type.for_header != "교수")
                return;
        }
        if(anotherAnswer.length > 0){
            AnotherPanel.append('<li class="list-group-item list-group-item-primary text-center">각각을 클릭하면 상세한 정보를 볼 수 있습니다.</li>')
            var done = [];
            for(var i = 0 ; i < anotherAnswer.length ; ++i){
                var value = anotherAnswer[i];
                var sequence = Math.floor(i/questions.length);

                done.push(value);
                if(i % questions.length == 0){
                    var text = '<a onclick="doMoreView(' + sequence + ')"><li class="list-group-item text-center">' + value.writer_name + '(' + value.writer_perId + ')의 신청입니다</li></a><div id="moreViewAnother' + sequence + '" style="display:none;"></div>';
                    AnotherPanel.append(text);
                }
                if(i % questions.length == (questions.length - 1)){
                    whatAnotherDone(sequence, done);
                    done = [];
                }
            }
            AnotherPanel.append('<a onclick="doAllView()"><li class="list-group-item text-center">전체결과보기</li></a><div id ="moreViewAll" style="display : none; overflow:auto;">총 ' + (anotherAnswer.length / questions.length) + '명</div>');
            makeAllView();
        }
        else if(type.for_header == '관리자' || getReg.writer_id == user.id || (getReg.for_who == 1 && type.for_header == '교수')){
            AnotherPanel.append('<li class="list-group-item text-center">※아직 신청자가 없습니다</li>');
        }
    }

    function doMoreView(index){
        $('#moreViewAnother'+index).toggle();
    }

    function doAllView(){
        $('#moreViewAll').toggle();
    }

    function whatAnotherDone(index, doneQuestions){
        var panel = $('#moreViewAnother'+index);
        var doneQuestion = doneQuestions;
        panel.css('border','1px black solid');
        panel.css('padding-bottom','10px');
        panel.empty();
        panel.append('<div id="AnotherPanel' + index + '" style="text-align : center ; font-size : 20px; margin-bottom:10px;">' + doneQuestion[0].writer_name + '(' + doneQuestion[0].writer_perId + ')의 신청 현황</div>');
        makeView(index, doneQuestions, panel);
    }

    function makeView(index, doneQuestions, panel) {
        var doneQuestion = doneQuestions;
        for (var i = 0; i < doneQuestion.length; i++) {
            var it = questions[i];//타입 1 = 주관식 2 = 단일객관식 3 = 다중객관식 4 = 척도형 5 = 파일업로드형
            var done = doneQuestion[i];

            if (it.question_type == '1') {  //주관식
                var text = '<div class="mx-3">';
                if (done.answer != '')
                    text += '<div class="form-group" id="question' + i + 'who' + index + '"><label>' + (i + 1) + '.' + it.question_content + '</label><input type="text" class="form-control" name="answer' + i + '" value="' + done.answer + '" readonly></div>';
                else
                    text += '<div class="form-group" id="question' + i + 'who' + index + '"><label>' + (i + 1) + '.' + it.question_content + '</label><input type="text" class="form-control" name="answer' + i + '" value="답변을 하지 않았습니다." readonly></div>';
                panel.append(text + '</div>');
            }
            if (it.question_type == '2') {  //단일객관식
                var text = '<div class="mx-3">';
                var allAnswer = it.question_content;
                var answers = allAnswer.split('-/@/-');
                text += '<div class="form-group" id="question' + i + '"><label>' + (i + 1) + '.' + answers[0] + '</label><div id="allAnswers' + i + 'who' + index + '"></div>';
                panel.append(text + '</div>');
                var answerPanel = $('#allAnswers' + i + 'who' + index);
                for (var j = 1; j < answers.length; ++j) {
                    if (answers[j] == done.answer)
                        var input = '<div class="radio disabled"><label><input type="radio" disabled checked="true" name="answer' + i + 'who' + index + '" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                    else
                        var input = '<div class="radio disabled"><label><input type="radio" disabled name="answer' + i + 'who' + index + '" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                    answerPanel.append(input);
                }
                if (done.answer == '')
                    answerPanel.append('<span style="font-size : 14px; color : red">답변을 하지 않았습니다.</span>');
            }
            if (it.question_type == '3') {  //다중객관식
                var text = '<div class="mx-3">';
                var allAnswer = it.question_content;
                var answers = allAnswer.split('-/@/-');
                var myAnswer = done.answer.split('-/@/-');
                text += '<div class="form-group" id="question' + i + '"><label>' + (i + 1) + '.' + answers[0] + '<span style="color : gray; font-size : 12px">(다중 선택 가능 문항입니다)</span></label><div id="allAnswers' + i + 'who' + index + '"></div>';
                panel.append(text + '</div>');
                var answerPanel = $('#allAnswers' + i + 'who' + index);
                for (var j = 1; j < answers.length; ++j) {
                    if (myAnswer.includes(answers[j]))
                        var input = '<div class="checkbox disabled"><label><input type="checkbox" disabled checked="true" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                    else
                        var input = '<div class="checkbox disabled"><label><input type="checkbox" disabled id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                    answerPanel.append(input);
                }
                if (done.answer == '')
                    answerPanel.append('<span style="font-size : 14px; color : red">답변을 하지 않았습니다.</span>');
            }
            if (it.question_type == '4') {  //척도형
                var text = '<div class="mx-3">';
                var allAnswer = it.question_content;
                var answers = allAnswer.split('-/@/-');
                text += '<div class="form-group" id="question' + i + '"><label>' + (i + 1) + '.' + answers[0] + '</label><div class="for_slider" id="sliderPanel' + i + 'who' + index + '"></div>';
                panel.append(text + '</div>');
                var sliderPanel = $('#sliderPanel' + i + 'who' + index);
                var text = '<div class="d-flex justify-content-between align-items-center"><span>' + answers[1] + '&nbsp;</span><input type="range" class="form-range" id="range' + i + 'who' + index + '" min=' + answers[1] + ' max=' + answers[2] + ' value="' + done.answer + '" step=1 disabled> <span>&nbsp;' + answers[2] + '</span></div><span class="for4"> 선택값 : ' + done.answer + '</span>';
                sliderPanel.append(text);
            }
            if (it.question_type == '5') {  //파일업로드형
                var filename = done.answer.split("_");
                var fileOriginalName = filename[2];
                for(var j=3; j<filename.length;j++)
                    fileOriginalName += '_'+filename[j];
                var text = '<div class="mx-3">';
                if (done.answer.length != 0){
                    text += '<div class="form-group" id="question' + i + 'who' + index + '"><label>' + (i + 1) + '.' + it.question_content + '</label><div class="input-group mb-3" id="fileUploadSection'+i+'"><input type="text" class="form-control" value="'+fileOriginalName+'" readonly><a class="btn btn-secondary" href="download.kgu?id='+filename[0]+'&&path=/uploaded/bbs_reg/reg'+getReg.id+'/Q'+it.question_num+'"><i class="bi bi-download"></i> 다운로드</a></div></div>';
                    isFileExist = true;
                }
                else
                    text += '<div class="form-group" id="question' + i + 'who' + index + '"><label>' + (i + 1) + '.' + it.question_content + '</label><br><span style="font-size : 14px; color : red">파일을 올리지 않았습니다.</span></div>';
                panel.append(text + '</div>');
            }
        }
    }

    function makeAllView(){
        var forAnswer = []
        var allPanel = $('#moreViewAll');
        allPanel.css('border', '1px solid black');
        allPanel.css('padding-bottom', '10px');
        var allViewTable = $('<table></table>').attr({'id' : 'table'});
        allViewTable.addClass('table table-striped table-hover table-bordered');
        var allViewThead = $('<thead></thead>').attr('id', 'allTableThead').appendTo(allViewTable);
        var allViewTr = $('<tr></tr>').attr('id','allTableTr').appendTo(allViewThead);
        $('<th></th>').attr({'data-field' : 'name', 'data-sortable' : 'true'}).text('이름').appendTo(allViewTr);
        $('<th></th>').attr({'data-field' : 'per_id', 'data-sortable' : 'true'}).text('학번').appendTo(allViewTr);
        $('<th></th>').attr({'data-field' : 'grade', 'data-sortable' : 'true'}).text('학년').appendTo(allViewTr);
        for(var i = 0 ; i < questions.length ; i++){
            $('<th></th>').attr({'data-field' : 'AnswerAnother' + i , 'data-sortable' : 'true'}).text((i+1) + '번').appendTo(allViewTr);
        }
        var allViewTbody = $('<tbody></tbody>').appendTo(allViewTable);
        allViewTable.appendTo(allPanel);
        var getDatas = data();
        for(var i = 0 ; i < getDatas.length ; ++i){
            var value = getDatas[i];
            var oneTr = $('<tr></tr>').appendTo(allViewTbody);
            $('<td></td>').text(value.name).appendTo(oneTr);
            $('<td></td>').text(value.per_id).appendTo(oneTr);
            $('<td></td>').text(value.grade).appendTo(oneTr);
            for(var j = 0 ; j < questions.length; ++j) {
                var url = '/uploaded/bbs_reg/reg' + getReg.id + '/Q' + questions[j].question_num;
                if (questions[j].question_type == 5) {
                    if (value['AnswerAnother' + j] != 'null') {
                        var ans = value['AnswerAnother' + j];
                        var filename = ans.split("_");
                        var fileOriginalName = filename[2];
                        for (var k = 3; k < filename.length; k++)
                            fileOriginalName += '_' + filename[k];
                        $('<td></td>').html('<a href="download.kgu?id=' + filename[0] + '&&path='+url+'">' + fileOriginalName + '</a>').appendTo(oneTr);
                    } else
                        $('<td></td>').html('<span style="font-size : 14px; color : red">미제출<span>').appendTo(oneTr);
                } else if (questions[j].question_type == 3) {
                    if (value['AnswerAnother' + j] != ''){
                        var ans = value['AnswerAnother' + j];
                        var selected = ans.split("-/@/-");
                        var sel = selected[0];
                        for (var k = 1; k < selected.length-1; k++)
                            sel += ', ' + selected[k];
                        $('<td></td>').text(sel).appendTo(oneTr);
                    }
                    else
                        $('<td></td>').html('<span style="color : red; font-size : 14px;">미답변</span>').appendTo(oneTr);
                } else {
                    if (value['AnswerAnother' + j] != '')
                        $('<td></td>').text(value['AnswerAnother' + j]).appendTo(oneTr);
                    else
                        $('<td></td>').html('<span style="color : red; font-size : 14px;">미답변</span>').appendTo(oneTr);
                }
            }
        }
    }

    function data(){
        var rows = [];
        var forRows;
        for(var i = 0 ; i < anotherAnswer.length ; ++i){
            var value= anotherAnswer[i];
            var number = i % questions.length;
            if(number == 0){
                forRows = new Object();
                forRows.name = value.writer_name;
                forRows.per_id = value.writer_perId;
                forRows.grade = value.writer_grade;
            }
            forRows['AnswerAnother'+number] = value.answer;
            if(number == (questions.length - 1))
                rows.push(forRows);
        }
        return rows;
    }

    function getQuestion(){
        $.ajax({
            url : 'ajax.kgu',
            type : 'post',
            async :false,
            data : {
                req: 'getQuestions',
                data: getReg.id
            },
            dataType : "json",
            success : function(data){
                questions = data;
            }
        })
    }

    function settingQuestion(){
        if(isAvailable == 1 && getReg.level.indexOf(type.for_header) >= 0){
            var panel = $('#questions');
            panel.html('<div class="card-body"><div id="myPanel" class="mt-3" style="text-align : center ; font-size : 20px; margin-bottom:10px;">신청 폼 작성</div>');
            for(var i = 0 ; i < questions.length ; ++i ){
                var it = questions[i];//타입 1 = 주관식 2 = 단일객관식 3 = 다중객관식  4 = 척도형  5 = 파일업로드형
                if(it.question_type == '1'){
                    var text = '<div class="mx-3">';
                    text += '<div class="form-group mt-3" id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><input type="text" class="form-control" name="answer' + i + '" placeholder="답변을 해주세요"></div>';
                    panel.append(text+"</div>");
                }
                if(it.question_type == '2'){
                    var text = '<div class="mx-3">';
                    var answers = it.question_content.split('-/@/-');
                    text += '<div class="form-group mt-3" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '</label><div id="allAnswers' + i + '"></div>';
                    panel.append(text+"</div>");
                    var answerPanel = $('#allAnswers'+i);
                    for(var j = 1 ; j < answers.length ; ++j){
                        var input = '<div class="radio"><label><input type="radio" name="answer' + i + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                        answerPanel.append(input);
                    }
                }
                if(it.question_type == '3'){
                    var text = '<div class="mx-3">';
                    var answers = it.question_content.split('-/@/-');
                    text += '<div class="form-group mt-3" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '<span style="color : gray; font-size : 12px">(다중 선택 가능 문항입니다)</span></label><div id="allAnswers' + i + '"></div>';
                    panel.append(text+"</div>");
                    var answerPanel = $('#allAnswers'+i);
                    for(var j = 1 ; j < answers.length ; ++j){
                        var input = '<div class="checkbox"><label><input type="checkbox" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                        answerPanel.append(input);
                    }
                }

                if(it.question_type == '4'){
                    var text = '<div class="mx-3">';
                    var answers = it.question_content.split('-/@/-');
                    text += '<div class="form-group mt-3" id="question' + i + '"><label for="customRange3" class="form-label">'+ (i+1) + '.' + answers[0] + '</label><div class="for_slider" id="sliderPanel' + i + '"></div>';
                    panel.append(text+"</div>");
                    var sliderPanel = $('#sliderPanel'+i);
                    var text = '<div class="d-flex justify-content-between align-items-center"><span>'+answers[1] + '&nbsp;</span><input type="range" class="form-range" id="range' + i + '" min='+answers[1]+' max='+answers[2]+' step=1> <span>&nbsp;'+answers[2]+'</span></div>' ;
                    sliderPanel.append(text);
                }
                if(it.question_type == '5'){
                    var text = '<div class="mx-3">';
                    text += '<div class="form-group mt-3" id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><div class="input-group mb-3" id="fileUploadSection'+i+'"><input type="file" class="form-control" name="answer' + i + '" id="answer' + i + '"><button class="btn btn-outline-secondary" type="button" onclick="uploadAnswerFile('+i+')">Upload</button></div></div>';
                    panel.append(text+"</div>");
                }
            }
            $('#questions').append('<button class="btn btn-secondary mt-3" onclick="submitNewAnswer()">제출할래요</button></div>');
        }
    }

    function uploadAnswerFile(i){
        var formData = new FormData();
        var folder='/uploaded/bbs_reg/reg'+getReg.id+'/Q'+(i+1);
        formData.append('file_data', $('input[name=answer' + i + ']')[0].files[0]);
        formData.append("file_type", "null"); //전송하려는 파일 타입 설정 (제한이 없으려면 null로 한다.)
        formData.append("board_level", "2"); // board_level 제한 (부정 업로드 방지용. 교수까지 하려면 1, 학생까지 하려면 2로 설정하면 됨.)
        $.ajax({
            url : 'upload.kgu?folder='+folder,
            type : 'post',
            data : formData,
            processData : false,
            contentType : false,
            success : function(data){//데이터는 주소
                if(data=='fail'){
                    swal.fire({
                        title : '실패',
                        icon : 'error',
                        showConfirmButton: true
                    });
                }
                else {
                    var fileLog=data.split("-/-/-");
                    file_id=fileLog[0];
                    file_folder=folder;
                    file_path=folder+'/'+fileLog[1];
                    var a='';
                    a+='<span class="input-group-text">파일제출</span><input type="text" class="form-control" id="answer'+i+'" value="'+fileLog[1]+'" readonly><input id="fileId'+i+'" value="'+fileLog[0]+'" hidden>';
                    a+='<div><a href="download.kgu?id='+file_id+'&&path='+file_folder+'" type="button" target="_blank"><button class="btn btn-secondary"><i class="bi bi-download"></i> 다운로드</button></a>'
                    a+='<button class="btn btn-danger" type="button" onclick="modifyAnswerFile('+i+')"><i class="bi bi-x-circle-fill"></i>첨부파일 수정하기</button></div>';
                    $('#fileUploadSection'+i+'').html(a);
                }
            }
        })
    }

    function modifyAnswerFile(i){
        $.ajax({
            url : 'delete.kgu?fileId='+file_id+'&&folder='+file_folder,
            type : 'post',
            success : function(data){//데이터는 주소
                $('#fileUploadSection'+i+'').html('<input type="file" class="form-control" name="answer' + i + '" id="answer' + i + '"><button class="btn btn-outline-secondary" type="button" onclick="uploadAnswerFile('+i+')">Upload</button>');
            }
        })
    }

    function submitNewAnswer(){
        var now = new Date().getTime();
        if(start >= now || now >= close){
            swal.fire({
                title : '현재 참여하실 수 없습니다.',
                icon : 'warning',
                showConfirmButton: true
            }).then(function (){
                location.href = 'reg.kgu?major=' + major + '&&num=' + num + '&&mode=list';
            });
        }
        var Answer = '';
        var AnswerFile = getReg.id+'-/-/-' + user.id+'-/-/-';
        var board_number = getReg.id;
        var fileSequence = 1;
        for(var i = 0 ; i < questions.length ; i ++){
            var it = questions[i];
            if($('input:text[name=answer'+i+']').val() != null)
                if($('input:text[name=answer'+i+']').val().length >= 150){
                    swal.fire({
                        title : (i+1) + '번 문항의 답변이 너무 깁니다.',
                        icon : 'warning',
                        showConfirmButton: true
                    });
                    return;
                }
            if(it.question_type == '1'){
                Answer += $('input:text[name=answer'+i+']').val();
                if($('input:text[name=answer'+i+']').val().includes('-/@/-') || $('input:text[name=answer'+i+']').val().includes('-/-/-')){
                    swal.fire({
                        title : (i+1) + '번 문항의 답변에 \'-/@/-\'나 \'-/-/-\'을 제거해주시기 바랍니다.',
                        icon : 'warning',
                        showConfirmButton: true
                    });
                    return;
                }
            }
            if(it.question_type == '2'){
                if($('input:radio[name=answer'+i+']:checked').val() != undefined)
                    Answer += $('input:radio[name=answer'+i+']:checked').val();
                else
                    Answer += '';
            }
            if(it.question_type == '3'){
                var length = it.question_content.split('-/@/-').length;
                for(var j = 1 ; j < length ; j ++){
                    if($('input:checkbox[id="answer' + i + 'S' + j + '"]').is(":checked") ==  true)
                    {
                        Answer += $('#answer'+i+'S'+j).val();
                        Answer +='-/@/-' //무조건 하나 더생기므로 나중에 액션에서 다오에서 고려
                    }
                }
            }
            if(it.question_type == '4'){
                Answer += $('#range'+i).val();
            }
            if(it.question_type == '5'){
                if($('#answer'+i).val()){
                    Answer += $('#fileId'+i).val()+'_'+$('#answer'+i).val();
                    AnswerFile += $('#fileId'+i).val()+'-/-/-';
                }

            }
            if(i != questions.length)
                Answer += '-/#/-';
        }

        var data = board_number + "-/-/-" + Answer + "-/-/-" + questions.length;
        $.ajax({
            url : 'ajax.kgu',
            type : 'post',
            data : {
                req: 'insertAnswer',
                data: data
            },
            success : function(data){
                if(data == 'success'){
                    $.ajax({
                        url : 'ajax.kgu',
                        type : 'post',
                        async :false,
                        data : {
                            req: 'insertAnswerFile',
                            data: AnswerFile
                        },
                        success : function(data){//데이터는 주소
                            if(data == 'success'){
                                swal.fire({
                                    title : '신청 성공',
                                    icon : 'success',
                                    showConfirmButton: true
                                }).then(function (){
                                    if(getReg.for_who == 1)
                                        window.location.href= 'reg.kgu?major=' + major + '&&num=' + num + '&&mode=view&&id=' + getReg.id;
                                    wasDone = 1;
                                    check();
                                    whatIDone();
                                })
                            }
                            else {
                                swal.fire({
                                    title : '파일 업로드실패',
                                    icon : 'error',
                                    showConfirmButton: true
                                });
                                return;
                            }
                        }
                    })
                }
                else if(data == 'fail'){
                    swal.fire({
                        title : '서버에러',
                        text : '다음에 다시 시도해주세요.',
                        icon : 'error',
                        showConfirmButton: true

                    });
                } else if(data == 'timeout'){
                    swal.fire({
                        title : '해당되는 기간이 아닙니다.',
                        icon : 'warning',
                        showConfirmButton: true
                    });
                    return;
                }
                else {
                    swal.fire({
                        title : '이미 신청한 글입니다.',
                        icon : 'warning',
                        showConfirmButton: true
                    });
                }
            }
        })
    }

    function whatIDone() {//doneQuestion 이용
        var panel = $('#questions');
        panel.html('<div class="card-body"><div id="myPanel" class="mt-3" style="text-align : center ; font-size : 20px; margin-bottom:10px;">나의 신청 현황</div>');
        makeView(0,doneQuestion,panel);
        var rightNow = new Date().getTime();
        if(start <= rightNow && rightNow <= close)
            panel.append('<div class="m-3 d-grid gap-2 d-md-flex justify-content-md-end"><button class="btn btn-secondary" onclick="modifyMyAnswer()">수정</button><button class="btn btn-secondary" onclick="deleteMyAnswer()">삭제</button></div>');
        panel.append('</div>')
    }

    function modifyMyAnswer(){
        var rightNow = new Date().getTime();
        if(start > rightNow || rightNow > close){

            swal.fire({
                title : '현재 수정하실 수 없습니다.',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }
        var panel = $('#questions');
        panel.html('<div class="card-body"><div id="myPanel" style="text-align : center ; font-size : 20px; margin-bottom:10px;">나의 신청 현황</div>');
        for(var i = 0 ; i < doneQuestion.length ; ++i){
            var it = questions[i];//타입 1 = 주관식 2 = 단일객관식 3 = 다중객관식 4 = 척도형 5 = 파일업로드형
            var done = doneQuestion[i];
            if(it.question_type == '1'){
                var text = '<div class="mx-3">';
                text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><input type="text" class="form-control" name="answer' + i + '" value="' + done.answer + '"></div>';
                panel.append(text+'</div>');
            }
            if(it.question_type == '2'){
                var text = '<div class="mx-3">';
                var allAnswer = it.question_content;
                var answers = allAnswer.split('-/@/-');
                text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '</label><div id="allAnswers' + i + '"></div>';
                panel.append(text+'</div>');
                var answerPanel = $('#allAnswers'+i);
                for(var j = 1 ; j < answers.length ; ++j){
                    if(answers[j] == done.answer)
                        var input = '<div class="radio"><label><input type="radio" checked="true" name="answer' + i + '" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                    else
                        var input = '<div class="radio"><label><input type="radio" name="answer' + i + '" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                    answerPanel.append(input);
                }
            }
            if(it.question_type == '3'){
                var text = '<div class="mx-3">';
                var allAnswer = it.question_content;
                var answers = allAnswer.split('-/@/-');
                var myAnswer = done.answer.split('-/@/-');
                text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '<span style="color : gray; font-size : 12px">(다중 선택 가능 문항입니다)</span></label><div id="allAnswers' + i + '"></div>';
                panel.append(text+'</div>');
                var answerPanel = $('#allAnswers'+i);
                for(var j = 1 ; j < answers.length ; ++j){
                    if(myAnswer.includes(answers[j]))
                        var input = '<div class="checkbox"><label><input type="checkbox" checked="true" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                    else
                        var input =  '<div class="checkbox"><label><input type="checkbox" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                    answerPanel.append(input);
                }
            }
            if(it.question_type == '4'){
                var text = '<div class="mx-3">';
                var allAnswer = it.question_content;
                var answers = allAnswer.split('-/@/-');
                text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '</label><div  class="for_slider" id="sliderPanel' + i + '"></div>';
                panel.append(text+'</div>');
                var sliderPanel = $('#sliderPanel'+i);
                var text = '<div class="d-flex justify-content-between align-items-center"><span>'+answers[1] + '&nbsp;</span><input type="range" class="form-range" id="range' + i + '" min='+answers[1]+' max='+answers[2]+' value="'+done.answer+'" step=1> <span>&nbsp;'+answers[2]+'</span></div>';
                sliderPanel.append(text);
            }
            if(it.question_type == '5'){
                var filename = done.answer.split("_");
                var fileOriginalName = filename[1];
                for(var j=2; j<filename.length;j++)
                    fileOriginalName += '_'+filename[j];
                var text = '<div class="mx-3">';
                if (done.answer.length != 0)
                    text += '<div class="form-group" id="question' + i +'"><label>' + (i + 1) + '.' + it.question_content + '</label><div class="input-group mb-3" id="fileUploadSection'+i+'"><input type="text" id="answer'+i+'" class="form-control" value="'+fileOriginalName+'" readonly><input id="fileId'+i+'" value="'+filename[0]+'" hidden><button class="btn btn-secondary" onclick="reUploadFile('+i+','+filename[0]+')"><i class="bi bi-file-earmark-arrow-up-fill"></i> 재업로드</button></div></div>';
                else
                    text += '<div class="form-group mt-3" id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><div class="input-group mb-3" id="fileUploadSection'+i+'"><input type="file" class="form-control" name="answer' + i + '" id="answer' + i + '"><button class="btn btn-outline-secondary" type="button" onclick="uploadAnswerFile('+i+')">Upload</button></div></div>';
                panel.append(text + '</div>');
            }
        }
        $('#questions').append('<button class="btn btn-secondary" onclick="submitModifyAnswer()">수정할래요</button></div>');
    }

    function reUploadFile(i, fileId){
        file_id = fileId;
        file_folder = '/uploaded/bbs_reg/reg'+getReg.id+'/Q'+(i+1);
        modifyAnswerFile(i);
    }

    function submitModifyAnswer(){
        var rightNow = new Date().getTime();
        if(start > rightNow || rightNow > close){

            swal.fire({
                title : '현재 수정하실 수 없습니다.',
                icon : 'warning',
                showConfirmButton: true
            });
            return;
        }

        var reg = getReg;
        var Answer = '';
        var board_number = getReg.id;
        var fileSequence = 1;
        var modifyAnswerFile = reg.id+'-/-/-' + user.id+'-/-/-';
        for(var i = 0 ; i < questions.length ; i ++){
            var it = questions[i];
            if(it.question_type == '1'){
                Answer += $('input:text[name=answer'+i+']').val();
            }
            if(it.question_type == '2'){
                Answer += $('input:radio[name=answer'+i+']:checked').val();
            }
            if(it.question_type == '3'){
                var length = it.question_content.split('-/@/-').length;
                for(var j = 1 ; j < length ; j ++){
                    if($('input:checkbox[id="answer' + i + 'S' + j + '"]').is(":checked") ==  true)
                    {
                        Answer += $('#answer'+i+'S'+j).val();
                        Answer +='-/@/-' //무조건 하나 더생기므로 나중에 액션에서 다오에서 고려
                    }
                }
            }
            if(it.question_type == '4'){
                Answer += $('#range'+i).val();
            }
            if(it.question_type == '5'){
                if($('#answer'+i).val()){
                    Answer += $('#fileId'+i).val()+'_'+$('#answer'+i).val();
                    modifyAnswerFile += $('#fileId'+i).val()+'-/-/-';
                }
            }
            if(i != questions.length)
                Answer += '-/#/-';
        }
        var data = board_number + "-/-/-" + Answer + "-/-/-" + questions.length;
        $.ajax({
            url : 'ajax.kgu',
            type : 'post',
            data : {
                req: 'modifyAnswer',
                data: data
            },
            success : function(data){
                if(data == 'success'){
                    $.ajax({
                        url : 'ajax.kgu',
                        type : 'post',
                        data : {
                            req: 'modifyAnswerFile',
                            data: modifyAnswerFile
                        },
                        success : function(data){//데이터는 주소
                            if(data == 'success'){
                                swal.fire({
                                    title : '수정 성공',
                                    icon : 'success',
                                    showConfirmButton: true
                                }).then(function (){
                                    if(getReg.for_who == 1)
                                        window.location.href= 'reg.kgu?major=' + major + '&&num=' + num + '&&mode=view&&id=' + getReg.id;
                                    wasDone = 1;
                                    check();
                                    whatIDone();
                                })
                            }
                            else {
                                swal.fire({
                                    title : '파일 업로드실패',
                                    icon : 'error',
                                    showConfirmButton: true
                                });
                                return;
                            }
                        }
                    })
                }
                else if(data == 'fail'){
                    swal.fire({
                        title : '서버에러',
                        text : '다음에 다시 시도해주세요',
                        icon : 'error',
                        showConfirmButton: true

                    });
                } else{
                    swal.fire({
                        title : '이미 신청한 글입니다.',
                        icon : 'warning',
                        showConfirmButton: true
                    });
                }
            }
        })
    }

    function deleteMyAnswer() {
        var rightNow = new Date().getTime();
        if (start > rightNow || rightNow > close) {
            swal.fire({
                title: '현재 삭제하실 수 없습니다.',
                icon: 'warning',
                showConfirmButton: true
            });
            return;
        }
        var data = getReg.id;
        swal.fire({
            title: '답변을 삭제하시나요?',
            icon: 'warning',
            showConfirmButton: true,
            showCancelButton: true

        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: 'ajax.kgu',
                    type: 'post',
                    async: false,
                    data: {
                        req: 'deleteWhoAnswer',
                        data: data
                    },
                    success: function (data) {
                        if (data == 'success') {
                            swal.fire({
                                title: '삭제에 성공하였습니다.',
                                icon: 'success',
                                showConfirmButton: true
                            });
                            $('#questions').empty();
                            wasDone = 0;
                            settingQuestion();
                            if (start <= rightNow && rightNow <= close) {
                                isAvailable = 1;
                            }
                        } else {
                            swal.fire({
                                title: '서버에러',
                                text: '다음에 다시 시도해주세요',
                                icon: 'error',
                                showConfirmButton: true

                            });
                        }
                    }
                });
            }

        })
    }

    function makeViewButtons() {
        var list_button = $('#list_button');
        var listUrl = 'reg.kgu?major='+major+'&&num='+num+'&&mode=list';
        var modifyUrl = 'reg.kgu?major='+major+'&&num='+num+'&&mode=modify&&id='+id;
        /**
         * 작성자 : 본인이 작성한 글 수정 및 삭제 / 엑셀 다운
         * 관리자 : 본인이 작성한 글 수정 및 삭제 + 남이 쓴 글 삭제 기능 / 엑셀, 압축파일 다운
         * 교수 : 본인이 작성한 글 수정 및 삭제 + 보기 권한이 있는 글 엑셀, 압축파일 다운
         * 압축파일은 파일형 질문이 존재하고 업로드된 답변이 있을 떄만 볼 수 있음
         * */
        var text = '';
        text+='<div><a href="'+listUrl+'" class="btn btn-secondary">목록</a></div><div>'
        if((getReg.for_who == 1 && type.for_header == '교수') ||user.id == getReg.writer_id) {
            text += '<a href="regExcel.kgu?id=' + getReg.id + '"><div class="btn btn-outline-success mx-1">엑셀파일</div></a>'
            if(isFileExist == true)
                text += '<a href="regCompress.kgu?id=' + getReg.id+'"><div class="btn btn-outline-warning mx-1">파일답변 압축파일</div></a>'
        }
        if(user.id == getReg.writer_id || type.board_level == 0){
            text += '<a href="'+modifyUrl+'"><div class="btn btn-primary mx-1">수정</div></a>'
                + '<a onclick="deleteReg()"><div class="btn btn-danger mx-1">삭제</div></a>'
        }
        list_button.append(text+"</div>");
    }

    function deleteReg() {
        var id = getReg.id;
        var writer_id = getReg.writer_id;
        var data = id + "-/-/-" + writer_id;

        swal.fire({
            title: '글을 삭제하시겠습니까?',
            text: '다시 되돌릴 수 없습니다.',
            icon: 'warning',
            showConfirmButton: true,
            showCancelButton: true

        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "ajax.kgu", //AjaxAction에서
                    type: "post", //post 방식으로
                    data: {
                        req: "deleteReg", //이 메소드를 찾아서
                        data: data //이 데이터를 파라미터로 넘겨줍니다.
                    },
                    dataType : "json",
                    success: function (data) { //성공 시
                        if (data == 'success') {
                            swal.fire({
                                title: '해당 내용이 삭제되었습니다.',
                                icon: 'success',
                                showConfirmButton: true
                            }).then(function (){
                                location.href = 'reg.kgu?major=' + major + '&&num=' + num + '&&mode=list'
                            })
                        } else {
                            swal.fire({
                                title: '권한이 부족합니다.',
                                icon: 'error',
                                showConfirmButton: true
                            });
                        }
                    }
                })
            }
        })
    }

    function makeViewPost(){ //첨부파일 표시
        var postbox = $('#post_box');
        var a = '<div>';
        if(getAllFile.length == 0)
            $('#post_box').remove();
        a += '첨부파일: ';
        for(var i = 0 ; i < getAllFile.length ; i++){
            var it = getAllFile[i];
            if(user != null){
                if(getReg.level.includes(type.for_header) || type.for_header == '관리자' || user.id == getReg.writer_id)
                    a += '<a href="download.kgu?id='+it.id+'&&path=/uploaded/bbs_reg">' + it.original_FileName + '</a>&emsp;&nbsp;';
                else
                    a  += '<span>'+it.original_FileName + '&emsp;&nbsp;</span>';
            }
            else
                a  += '<span>'+it.original_FileName + '&emsp;&nbsp;</span>';
        }
        a += '</div><hr>'
        postbox.append(a);
    }
</script>