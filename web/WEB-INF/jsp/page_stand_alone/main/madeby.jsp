<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-15
  Time: 오후 3:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getAllDevelopers = (String)request.getAttribute("getAllDevelopers");
%>
<div class="row" id="developerInfo"></div>
<div id="addDeveloperBnt" class="d-grid justify-content-md-end"></div>
<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" id="modalHeader">
<%--                <h5 class="modal-title" id="staticBackdropLabel">Modal 제목</h5>--%>
<%--                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
            </div>
            <div class="modal-body g-3" id="modalBody"></div>
            <div class="modal-footer" id="modalFooter">
<%--                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>--%>
<%--                <button type="button" class="btn btn-primary" onclick="modalReset()">버튼을 눌러 내용 교체</button>--%>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){
        makeDeveloperInfo();
    })

    function makeDeveloperInfo(){
        var developerInfo = $('#developerInfo');
        var getAllDevelopers = <%=getAllDevelopers%>;
        var text='';
        var size = getAllDevelopers.length;
        for(var i=0; i<size;i++){
            var members = getAllDevelopers[i].members.split('---')
            text+= '<div class="col-lg-4"><div class="card card-margin"><div class="card-body pt-4 pb-4"><div class="widget-49"><div class="widget-49-title-wrapper">'+
                '<div class="widget-49-date-primary"><div class="bi bi-people-fill fs-3"></div></div><div class="widget-49-meeting-info">'+
                '<span class="widget-49-pro-title"><h5>'+getAllDevelopers[i].team_name+'</h5></span><span class="widget-49-meeting-time">'+getAllDevelopers[i].start_date+' ~ '+getAllDevelopers[i].end_date+'</span></div></div>';
            for(var j=0; j<members.length;j++){
                text += '<div class="text-center mt-1">'+members[j]+'</div>';
            }
            <c:if test = "${type.for_header == '관리자'}">
                text += '<div class="widget-49-meeting-action mt-3"><button class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="modifyDeveloperModal('+i+')">수정</button>'+
                    '<button class="btn btn-sm btn-outline-secondary" onclick="deleteDeveloper('+i+')">삭제</button></div>';
            </c:if>
            text += '</div></div></div></div>'
        }
        developerInfo.html(text);

        <c:if test = "${type.for_header == '관리자'}">
        var button = $('#addDeveloperBnt')
        button.append('<button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="addDeveloperModal()">추가</button>');
        </c:if>
    }

    function deleteDeveloper(i){
        var getAllDevelopers = <%=getAllDevelopers%>;
        var developer = getAllDevelopers[i];
        var id = developer.id;
        var teamName = developer.team_name;
        var startDate = developer.start_date;
        var endDate = developer.end_date;
        var members = developer.members;
        var data = id+'-/-/-'+teamName+'-/-/-'+startDate+'-/-/-'+endDate+'-/-/-'+members;

        var check = confirm("팀 "+data+"를 삭제하시겠습니까?");
        if (check) {
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post", //post 방식으로
                data: {
                    req: "deleteDeveloper", //이 메소드를 찾아서
                    data: data //이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (data) { //성공 시
                    if(data=='success'){
                        alert("해당 팀이 삭제되었습니다.");
                        location.reload();
                    }
                    else{
                        alert('권한이 부족합니다.');
                    }
                }
            })
        }
    }

    function addDeveloperModal(){
        var header = $('#modalHeader');
        var body = $('#modalBody');
        var footer = $('#modalFooter');
        var h = '', b = '', f = '';
        h += '<h5 class="modal-title" id="staticBackdropLabel">추가하기</h5><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>'
        b += '<div><label for="teamName" class="form-label">팀 명</label><input type="text" class="form-control" id="teamName" placeholder="예)웹 0기"></div>'+
            '<div><label for="InputDate">시작 일</label><input class="form-control" id="startDate" type="date" name="startDate" value="' + formatDate(new Date()) + '"></div>'+
            '<div><label for="InputDate">종료 일</label><input class="form-control" id="endDate" type="date" name="endDate" value="' + formatDate(new Date()) + '"></div>'+
            '<div><label for="madeByContent" class="form-label">팀원</label><div class="form-floating"><input type="text" class="form-control" id="madeByContent" placeholder="개발진들의 학번과 이름을 적어주세요." value="oo학번 xxx"> <label for="madebyContent">19학번 ooo ooo---20학번 xxx 식으로 적어주시기 바랍니다.</label> </div></div>';
        f += '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button><button type="button" class="btn btn-primary" onclick="addDeveloper()">추가</button>';

        header.html(h);
        body.html(b);
        footer.html(f);
    }

    function addDeveloper(){
        var teamName = $('#teamName').val();
        var madeByContent = $('#madeByContent').val();
        var startDate = $('#startDate').val();
        var endDate = $('#endDate').val();

        var data = teamName + '-/-/-' + madeByContent + '-/-/-' + startDate + '-/-/-' + endDate;
        var check = confirm("팀 "+data+"를 추가하시겠습니까?");
        if (check) {
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post", //post 방식으로
                data: {
                    req: "addDeveloper", //이 메소드를 찾아서
                    data: data //이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (data) { //성공 시
                    if(data=='success'){
                        alert("해당 팀이 추가되었습니다.");
                        location.reload();
                    }
                    else{
                        alert('권한이 부족합니다.');
                    }
                }
            })
        }
    }

    function modifyDeveloperModal(i){
        var getAllDevelopers = <%=getAllDevelopers%>;
        var header = $('#modalHeader');
        var body = $('#modalBody');
        var footer = $('#modalFooter');
        var h = '', b = '', f = '';
        h += '<h5 class="modal-title" id="staticBackdropLabel">수정하기</h5><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>'
        b += '<div><label for="teamName" class="form-label">팀 명</label><input type="text" class="form-control" id="teamName" placeholder="예)웹 0기" required value="'+getAllDevelopers[i].team_name+'"></div>'+
            '<div><label for="InputDate">시작 일</label><input class="form-control" id="startDate" type="date" name="startDate" value="' + formatDate(getAllDevelopers[i].start_date) + '"></div>'+
            '<div><label for="InputDate">종료 일</label><input class="form-control" id="endDate" type="date" name="endDate" value="' + formatDate(getAllDevelopers[i].end_date) + '"></div>'+
            '<div><label for="madeByContent" class="form-label">팀원</label><div class="form-floating"><input type="text" class="form-control" id="madeByContent" placeholder="개발진들의 학번과 이름을 적어주세요." value="'+getAllDevelopers[i].members+'"> <label for="madebyContent">19학번 ooo ooo---20학번 xxx 식으로 적어주시기 바랍니다.</label> </div></div>';
        f += '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button><button type="button" class="btn btn-primary" onclick="modifyDeveloper('+i+')">수정</button>';

        header.html(h);
        body.html(b);
        footer.html(f);
    }

    function modifyDeveloper(i){
        var getAllDevelopers = <%=getAllDevelopers%>;
        var id = getAllDevelopers[i].id;
        var teamName = $('#teamName').val();
        var madeByContent = $('#madeByContent').val();
        var startDate = $('#startDate').val();
        var endDate = $('#endDate').val();

        var data = id + '-/-/-' + teamName + '-/-/-' + madeByContent + '-/-/-' + startDate + '-/-/-' + endDate;
        var check = confirm("팀 "+data+"를 수정하시겠습니까?");
        if (check) {
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post", //post 방식으로
                data: {
                    req: "modifyDeveloper", //이 메소드를 찾아서
                    data: data //이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (data) { //성공 시
                    if(data=='success'){
                        alert("해당 팀이 수정되었습니다.");
                        location.reload();
                    }
                    else{
                        alert('권한이 부족합니다.');
                    }
                }
            })
        }
    }

    function formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }
</script>

<style>
    .card-margin {
        margin-bottom: 1.875rem;
    }

    .card {
        border: 0;
        box-shadow: 0px 0px 10px 0px rgba(82, 63, 105, 0.1);
        -webkit-box-shadow: 0px 0px 10px 0px rgba(82, 63, 105, 0.1);
        -moz-box-shadow: 0px 0px 10px 0px rgba(82, 63, 105, 0.1);
        -ms-box-shadow: 0px 0px 10px 0px rgba(82, 63, 105, 0.1);
    }
    .card {
        position: relative;
        display: flex;
        flex-direction: column;
        min-width: 0;
        word-wrap: break-word;
        background-color: #ffffff;
        background-clip: border-box;
        border: 1px solid #e6e4e9;
        border-radius: 8px;
    }

    .widget-49 .widget-49-title-wrapper {
        display: flex;
        align-items: center;
    }

    .widget-49 .widget-49-title-wrapper .widget-49-date-primary {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        background-color: #edf1fc;
        width: 4rem;
        height: 4rem;
        border-radius: 50%;
    }

    .widget-49 .widget-49-title-wrapper .widget-49-meeting-info {
        display: flex;
        flex-direction: column;
        margin-left: 1rem;
    }

    .widget-49 .widget-49-title-wrapper .widget-49-meeting-info .widget-49-pro-title {
        color: #3c4142;
        font-size: 14px;
    }

    .widget-49 .widget-49-title-wrapper .widget-49-meeting-info .widget-49-meeting-time {
        color: #B1BAC5;
        font-size: 13px;
    }

    .widget-49 .widget-49-meeting-points .widget-49-meeting-item span {
        margin-left: .5rem;
    }

    .widget-49 .widget-49-meeting-action a {
        text-transform: uppercase;
    }
</style>