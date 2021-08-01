<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-13
  Time: 오후 2:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String majorInfoForFooter = (String)request.getAttribute("majorInfo");
%>
<footer class="footer mt-auto py-3">
    <div class="container">
        <span><a href="location.kgu" style="padding-right : 5px; border-right : 1px white solid;">연락처 및 오시는 길</a><a href="sitemap.kgu" style="margin-left : 5px;">사이트맵</a><a onclick="esterEgg()" style="color : #455a64">.</a></span>
        <span style="float:right;"><a href="http://www.kyonggi.ac.kr/webService.kgu?menuCode=K00M0502" style="padding-right : 5px; border-right : 1px white solid; margin-right : 5px;">개인정보처리방침</a></span>
        <div id="footerCopyright"></div>
    </div>
</footer>

<script>
    $(document).ready(function(){
        makeFooterCopyright();
    })


    function makeFooterCopyright(){
        var majorInfo =<%=majorInfoForFooter%>;
        var title = $('#footerCopyright');
        title.append('Copyright 2021. KYONGGI Univ. ' + majorInfo[0].major_name + ".  All rights reserved.");
    }



    var clickCount = 0;
    function esterEgg(){
        if(clickCount == 10)
            window.location.href = 'madeby.kgu';
        clickCount++;
    }
</script>
