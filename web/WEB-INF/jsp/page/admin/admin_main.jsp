<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-07-07
  Time: 오전 8:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getAllMajor = (String)request.getAttribute("getAllMajor");
    String getSchedule = (String)request.getAttribute("getSchedule");
    String getAllKGUMajor = (String)request.getAttribute("getAllKGUMajor");
%>
<div>
    <div class="text-danger text-end mb-3">이 페이지는 가로 길이 800px 이상의 화면에서 최적화 되어있습니다.</div>
    <div class="album">
        <div class="container">
<%--           부전공 관리--%>
            <%@include file="/WEB-INF/jsp/page/admin/admin_main/admin_major.jsp"%>
            <hr>
<%--                일정 관리 --%>
            <%@include file="/WEB-INF/jsp/page/admin/admin_main/admin_schedule.jsp"%>
            <hr>
<%--                대문 관리--%>
            <%@include file="/WEB-INF/jsp/page/admin/admin_main/admin_slider.jsp"%>
            <hr>
<%--                주전공 관리--%>
            <%@include file="/WEB-INF/jsp/page/admin/admin_main/admin_kgu_major.jsp"%>
            <hr>
        </div>
    </div>
</div>

    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" id="myModalHeader"></div>
                <div class="modal-body" id = "myModalBody"></div>
                <div class="modal-footer" id="myModalFooter"></div>
            </div>
        </div>
    </div>

</div>

<script>

    var header = $('#myModalHeader');
    var body = $('#myModalBody');
    var footer = $('#myModalFooter');

</script>

