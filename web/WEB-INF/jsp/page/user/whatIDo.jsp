<%--
  Created by IntelliJ IDEA.
  User: wooris
  Date: 2021-07-14
  Time: 오후 2:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String typeForMyPage = (String)session.getAttribute("type");
    String userForMyPage = (String)session.getAttribute("user");
    String notice_notes = (String) request.getAttribute("notice_notes");
    String notice_comments = (String) request.getAttribute("notice_comments");
    String answers = (String) request.getAttribute("answers");
    String likeNotes = (String) request.getAttribute("likeNotes");
%>
<div>
    <ul>
        <li id="maintext" style="margin-bottom: 5px;">
            <div id="maintitle" class="contenttitle"><label><h2><strong>활동 내역</strong></h2></label></div>
            <ul id="text1">
            </ul>
        </li>
    </ul><hr>
    <div class="whatIdo">
        <div class="container">
            <%--           작성글--%>
            <%@include file="/WEB-INF/jsp/page/user/whatIDo/writed.jsp"%>
            <hr>
                <%--           추천한 글--%>
                <%@include file="/WEB-INF/jsp/page/user/whatIDo/like.jsp"%>
                <hr>
            <%--                작성 댓글 --%>
                <%@include file="/WEB-INF/jsp/page/user/whatIDo/writed_comment.jsp"%>
            <hr>
            <%--                신청 내역--%>
                <%@include file="/WEB-INF/jsp/page/user/whatIDo/apply.jsp"%>
            <hr>
        </div>
    </div>
</div>
<script>
    var notice_notes = <%=notice_notes%>;
    var notice_comments = <%=notice_comments%>;
    var answers_notes = <%=answers%>;
    var likeNotes = <%=likeNotes%>;
    $('#text1').append('<div style="font-size : 14px">지금까지 <span style="color : red; font-size : 22px">' + (notice_notes.length) + '</span>개의 글, <span style="color : red; font-size : 22px">' + (notice_comments.length) + '</span>개의 댓글, <span style="color : red; font-size : 22px">' + (likeNotes.length) + '</span>개의 추천, <span style="color : red; font-size : 22px">' + (answers_notes.length) + '</span>개의 신청을 하셨습니다.</div>');
</script>

