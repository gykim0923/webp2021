<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-15
  Time: 오후 2:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/assets/vendors/sweetalert2/sweetalert2.all.min.js"></script>
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
                    <th data-field="slider_img">slider_img</th>
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
        var image = null;
        for(var i=0;i<getSlider.length;i++){
            var slider=getSlider[i];
            rows.push({
                id: slider.id,
                slider_img: '<a href="image_viewer.kgu?image_path='+slider.slider_img+'" target="_blank">사진 보기</a>',
                action : '<button class="btn btn-dark" type="button" onclick="deleteSlider('+i+')">삭제</button>'
            });
        }
        return rows;
    }


    function makeUploadSliderModal(){
        var majorList=<%=getAllMajor%>;

        var modal_header = '';
        modal_header += '<h5 class="modal-title" id="staticBackdropLabel">대문 사진 업로드하기</h5>';
        modal_header += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';

        var modal_body = '<div id="fileUploadSection">'
            +'<input type="file" name="uploadFile" id="uploadFile" accept="image/*">'
            +'<button class="btn btn-secondary" onclick="uploadfile()"><i class="bi bi-upload"></i> 업로드</button>'
            +'</div>';

        var modal_footer = '';
        modal_footer += '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>';  //<button type="button" class="btn btn-dark" data-dismiss="modal">Close</button>
        modal_footer += '<button type="button" class="btn btn-secondary pull-right" data-dismiss="modal" aria-label="Close" onclick="insertSlider()">추가하기</button>';

        header.html(modal_header);
        body.html(modal_body);
        footer.html(modal_footer);
    }

    var file_id; //나중에 파일 상세정보를 uploadedFile로부터 역참조 하고싶은 경우에 사용하라고 만들어둠 (다운로드에서 사용하는 기능)
    var file_folder; //다운로드에서 쓸 경로
    var file_path; //파일이 업로드된 상대경로

    function uploadfile(){
        var formData = new FormData();
        var folder='/img/slider';//업로드 된 파일 folder 경로 설정은 여기에서 해줍니다. (마지막에 /가 오면 절대 안됩니다.)
        if($('input[name=uploadFile]')[0].files[0]!=null){
            formData.append("file_data",$('input[name=uploadFile]')[0].files[0]);
            formData.append("file_type", "image"); //전송하려는 파일 타입 설정 (제한이 없으려면 null로 한다.)
            formData.append("board_level", "0"); // board_level 제한 (부정 업로드 방지용. 교수까지 하려면 1, 학생까지 하려면 2로 설정하면 됨.)

            $.ajax({
                url : 'upload.kgu?folder='+folder,
                type : "post",
                async:false,
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
                        a+='<div>파일제출</div><div>'+fileLog[1]+'</div>';
                        a+='<div><a href="download.kgu?id='+file_id+'&&path='+file_folder+'" target="_blank"><button class="btn btn-secondary"><i class="bi bi-download"></i> 다운로드</button></a>'
                        a+='<button class="btn btn-danger" onclick="makeUploadSliderModal()"><i class="bi bi-x-circle-fill"></i> 첨부파일 수정하기</button></div>';
                        $('#fileUploadSection').html(a);
                    }
                }
            })
        }else{
            swal.fire({
                title : '파일을 등록해주세요.',
                icon : 'warning',
                showConfirmButton: true

            });
        }
        // return address;
    }

    function insertSlider(){
        var slider_img = file_path;

            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post",
                data: {
                    req: "insertSlider", //이 메소드를 찾아서
                    data: slider_img //이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (data) { //성공 시
                    swal.fire({
                        title : '대문이 정상적으로 추가되었습니다.',
                        icon : 'success',
                        showConfirmButton: true

                    }).then(function (){
                        location.reload();
                    });
                }
            })
    }

    function deleteSlider(i){
        var getSlider = <%=getSlider%>;
        var slider = getSlider[i];
        var slider_id = slider.id;

        swal.fire({
            title: '정말로 삭제하시나요?',
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
                        req: "deleteSlider", //이 메소드를 찾아서
                        data: slider_id //이 데이터를 파라미터로 넘겨줍니다.
                    },
                    success: function (data) { //성공 시
                        if (data == 'success') {

                            swal.fire({
                                title: '해당 대문이 삭제되었습니다.',
                                icon: 'success',
                                showConfirmButton: true

                            }).then(function () {
                                location.reload();
                            });
                        } else {
                            swal.fire({
                                title: '권한이 부족합니다.',
                                icon: 'warning',
                                showConfirmButton: true

                            });
                        }
                    }
                })
            }

        });

    }




</script>