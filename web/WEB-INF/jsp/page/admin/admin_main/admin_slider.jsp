<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-15
  Time: 오후 2:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getSlider = (String) request.getAttribute("getSlider");
%>
<div class="py-5">
    <%--대문 관리--%>

    <label><h2><strong>대문 관리</strong></h2></label>
        <div>
            <table class="boardtable" id="table3"  data-toggle="table"
                   data-pagination="true" data-toolbar="#toolbar"
                   data-search="true" data-side-pagination="true" data-click-to-select="true" data-height="460"
                   data-page-list="[10]">
                <thead>
                <tr>
                    <th data-field="action">설정</th>
                    <th data-field="real_name">real_name</th>
                    <th data-field="original_name">original_name</th>
                    <th data-field="slider_title">slider_title</th>
                    <th data-field="slider_content">slider_content</th>
                </tr>
                </thead>
            </table>
        </div>

        <!-- Button trigger modal -->
        <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="makeUploadSliderModal()">대문 사진 추가</button>

</div>

<script>
    $(document).ready(function(){
        callSetupTableView3();
    })
    function callSetupTableView3(){
        $('#table3').bootstrapTable('load',tableData3());
        $('#table3').bootstrapTable('refresh');
    }
    function tableData3(){
        var getSlider = <%=getSlider%>;
        var rows = [];
        for(var i=0;i<getSlider.length;i++){
            var slider=getSlider[i];
            rows.push({
                id: slider.id,
                real_name: slider.real_name,
                original_name: slider.original_name,
                slider_title: slider.slider_title,
                slider_content: slider.slider_content,
                action : '<button class="btn btn-dark" type="button" onclick="deleteSlider('+i+')">삭제</button>'
            });
        }
        return rows;
    }

    function makeUploadSliderModal(){
        var modal_header = '';
        modal_header += '<h5 class="modal-title" id="staticBackdropLabel">대문 사진 업로드하기</h5>';
        modal_header += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';

        var modal_body = '<div id="fileUploadSection">'
            +'<input type="file" name="uploadFile" id="uploadFile" accept="image/*">'
            +'<button class="btn btn-secondary" onclick="uploadfile()"><i class="bi bi-upload"></i> 업로드</button>'
            +'</div>'
            +'<div>'
            +'<input type="text" class="form-control" id="slider_title" name="new_table" value="" placeholder="slider_title">'
            +'<input type="text" class="form-control" id="slider_content" name="new_table" value="" placeholder="slider_content">'
            +'</div>';

        var modal_footer = '';
        modal_footer += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>';  //<button type="button" class="btn btn-dark" data-dismiss="modal">Close</button>
        modal_footer += '<button type="button" class="btn btn-secondary pull-right" data-dismiss="modal" aria-label="Close" onclick="foo()">추가하기</button>';

        header.html(modal_header);
        body.html(modal_body);
        footer.html(modal_footer);
    }

    function uploadfile(){
        var formData = new FormData();
        var address="";
        if($('input[name=uploadFile]')[0].files[0]!=null){
            formData.append("file_data",$('input[name=uploadFile]')[0].files[0]);
            formData.append("dao_name", 'AdminDAO'); //호출하고 싶은 dao이름
            formData.append("real_method_name",'sliderUpload'); // 인터페이스 DAO에 있는 insertFile 메소드 안에서 이 이름대로 나눠줄 예정임.
            formData.append("user_id",'${user.id}'); //업로드한 사람 (출처용)
            formData.append("text", ''); //같이 보내고 싶은 문자열(여러개인 경우 -/-/- 으로 구분. ex) 윤주현-/-/-201713919-/-/-컴퓨터공학전공)
            $.ajax({
                url : 'upload.kgu?folder='+'/img/slider', //업로드 된 파일 folder 경로 설정은 여기에서 해줍니다.
                type : "post",
                async:false,
                data : formData,
                processData : false,
                contentType : false,
                success : function(data){//데이터는 주소
                    if(data=='success'){
                        alert('파일 업로드 성공');
                    }
                    else {
                        alert('실패');
                    }


                    <%--var file=data.split("-/-/-");--%>
                    <%--var a='';--%>
                    <%--a+='<div>파일제출</div><div>'+file[0]+'</div>';--%>
                    <%--a+='<div><a href="download.kgu?id=${user.id}"><button class="btn btn-secondary"><i class="bi bi-download"></i> 다운로드(미구현)</button></a>'--%>
                    <%--a+='<button class="btn btn-danger" onclick="makeUploadSliderModal()"><i class="bi bi-x-circle-fill"></i> 사진 수정하기</button></div>';--%>
                    <%--uploadf=file[0];--%>
                    <%--hashfile=file[1];--%>
                    <%--$('#fileUploadSection').html(a);--%>
                }
            })
        }else{
            alert("파일을 등록해주세요");
        }
        return address;
    }



    //여기까지
    function insert_data(){
        var modi='';
        var obj = new Object();
        obj.per_id = user.per_id; //여기 user.per_id 였었다
        obj.name = user.name;
        <%--obj.locker_num = ${assignedStudent.locker_num};--%>

        obj.file = hashfile; //파일이름(uploadf)
        obj.realfile = uploadf;
        // if (obj.file == null && modify == "1") {
        //     obj.file = stage_data.interim_filename;
        // }

        // obj.progress = $('#progress_content').val();
        // obj.plan = $('#plan_content').val();
        // obj.per_id = user.per_id;
        // obj.stage = 3; //여기 추가
        var jsonobj = JSON.stringify(obj);
        $.ajax({
            url: "ajax.do",
            type: "post",
            dataType: "json",
            data: {
                req: "return_picture",
                data: jsonobj,
                modify: modi
            },
            success: function (data) {
                alert(user.name + "[" + data + "]님의 반납사진(내부)이 제출 되었습니다.");
                window.location.href = "locker_apply.do?num=112";
            }
        });

    }




</script>