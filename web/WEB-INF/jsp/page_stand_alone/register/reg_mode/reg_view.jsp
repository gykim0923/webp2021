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
<script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
<div>
    <div class="h2" id="view_title"></div>
    <hr>
    <div class="row" id="view_info"></div>
    <hr>
    <div id="view_content"></div>
    <hr>
    <div>신청하기 폼은 여기에서 뜰 예정</div>
    <div id="questions">
    </div>
    <div id="anotherDone">
    </div>
</div>
<div class="mt-3 d-grid gap-2 d-md-flex justify-content-md-end" id="list_button"></div>

<script>
    var major = <%=major%>;
    var num = <%=num%>;
    var id = <%=id%>;
    var type = <%=type%>;
    var user = <%=user%>;
    var getReg = <%=getReg%>;

    var starting_date = getReg.starting_date;
    var start = new Date(starting_date).getTime();
    var closing_date = getReg.closing_date;
    var close = new Date(closing_date).getTime();
    var current = new Date().getTime();
    var isAvailable = 0; // 신청이 가능한지 검사하는 변수
    var wasDone = 0; //예전에 제출한 것이 있는지 검사하는 변수
    if(start <= current && current <= close){
        isAvailable = 1;
    }

    $(document).ready(function(){
        makeViewTitle();
        makeViewInfo();
        makeViewContent();
        check();
        getQuestion();
        if(wasDone == 0)
            settingQuestion();
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
            success : function(data){
                if(data == 'fail')
                    alert('SERVER ERROR, Please try again later.');
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

    var questions = null;
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
            for(var i = 0 ; i < questions.length ; ++i ){
                var it = questions[i];//타입 1 = 주관식 2 = 단일객관식 3 = 다중객관식  4 = 척도형  5 = 파일업로드형
                if(it.question_type == '1'){
                    var text = '';
                    text += '<div class="form-group mt-3" id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><input type="text" class="form-control" name="answer' + i + '" placeholder="답변을 해주세요"></div>';
                    panel.append(text);
                }
                if(it.question_type == '2'){
                    var text = '';
                    var answers = it.question_content.split('-/@/-');
                    text += '<div class="form-group mt-3" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '</label><div id="allAnswers' + i + '"></div>';
                    panel.append(text);
                    var answerPanel = $('#allAnswers'+i);
                    for(var j = 1 ; j < answers.length ; ++j){
                        var input = '<div class="radio"><label><input type="radio" name="answer' + i + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                        answerPanel.append(input);
                    }
                }
                if(it.question_type == '3'){
                    var text = '';
                    var answers = it.question_content.split('-/@/-');
                    text += '<div class="form-group mt-3" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '<span style="color : gray; font-size : 12px">(다중 선택 가능 문항입니다)</span></label><div id="allAnswers' + i + '"></div>';
                    panel.append(text);
                    var answerPanel = $('#allAnswers'+i);
                    for(var j = 1 ; j < answers.length ; ++j){
                        var input = '<div class="checkbox"><label><input type="checkbox" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                        answerPanel.append(input);
                    }
                }

                if(it.question_type == '4'){
                    var text = '';
                    var answers = it.question_content.split('-/@/-');
                    text += '<div class="form-group mt-3" id="question' + i + '"><label for="customRange3" class="form-label">'+ (i+1) + '.' + answers[0] + '</label><div class="for_slider" id="sliderPanel' + i + '"></div>';
                    panel.append(text);
                    var sliderPanel = $('#sliderPanel'+i);
                    var text = '<div class="d-flex justify-content-between align-items-center"><span>'+answers[1] + '&nbsp;</span><input type="range" class="form-range" id="range' + i + '"> <span>&nbsp;'+answers[2]+'</span></div>' ;
                    sliderPanel.append(text);
                    $('#range'+i).slider({
                        id : 'getRange'+i,
                        min : Number(answers[1]),
                        max : Number(answers[2]),
                        value : Math.floor((Number(answers[1]) + Number(answers[2]))/2),
                        step : 1,
                        enabled : true
                    });
                }
                if(it.question_type == '5'){
                    var text = '';
                    text += '<div class="form-group mt-3" id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><div><input type="file" name="answer' + i + '"></div></div>';
                    panel.append(text);
                }
            }
            $('#questions').append('<div class="col-md-4"></div><button class="btn btn-secondary mt-3" onclick="submitNewAnswer()">제출할래요</button>');
        }
    }

    function makeViewButtons() {
        var list_button = $('#list_button');
        var listUrl = 'reg.kgu?major='+major+'&&num='+num+'&&mode=list';
        var modifyUrl = 'reg.kgu?major='+major+'&&num='+num+'&&mode=modify&&id='+id;
        var text = '';
        if(type.board_level == 0 || type.board_level == 1){
            text += '<a href="'+modifyUrl+'"><div class="btn btn-secondary">수정</div></a>'
                + '<a onclick="deleteBbs()"><div class="btn btn-secondary">삭제</div></a>'
                + '<a onclick="deleteBbs()"><div class="btn btn-secondary">엑셀</div></a>'
        }
        text+='<a href="'+listUrl+'"><div class="btn btn-secondary">목록</div></a>'
        list_button.append(text);
    }

    function deleteBbs(){
        var id = getReg.id;
        var title = getReg.title;
        var writer_id = getReg.writer_id;
        var writer_name = getReg.writer_name;
        var applicant_count = getReg.applicant_count;
        var data = id+"-/-/-"+major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+applicant_count+"-/-/-"+starting_date+"-/-/-"+closing_date;

        var check = confirm(data+"를 삭제하시겠습니까?");
        if (check) {
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post", //post 방식으로
                data: {
                    req: "deleteReg", //이 메소드를 찾아서
                    data: data //이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (data) { //성공 시
                    if(data=='success'){
                        alert("해당 내용이 삭제되었습니다.");
                        window.location.href = 'reg.kgu?major=' + major + '&&num=' + num + '&&mode=list';
                    }
                    else{
                        alert('권한이 부족합니다.');
                    }
                }
            })
        }
    }
</script>