<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-15
  Time: 오후 3:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
 String pageMenu1 = (String)request.getAttribute("pageMenu");
 String major1 = (String)request.getAttribute("major");
 String pageTab1 = (String)request.getAttribute("pageTab");
 String num1=(String)request.getAttribute("num");

%>
<style>
    section {
        /*border-bottom: 1px solid #ccc;*/
        margin-top: 1em;
    }

    section .col-md-3 {
        border-left: 1px solid #ccc;
    }

    section .col-md-3:first-child {
        border: none;
    }
</style>

<script>
    $(document).ready(function(){
        makeSiteMap();
        makePageTitleSiteMap();
    })

    function makePageTitleSiteMap() {
        var list = $('#page_title');
        var text = '<h2><i class="bi bi-info-circle-fill"></i><strong> 사이트맵</strong></h2>';
        list.html(text);
    }

    function makeSiteMap() { // 사이트맵 화면 만드는 함수
        var pageMenu1 = <%=pageMenu1%>;
        var pageTab1 = <%=pageTab1%>;
        //var num1=<%=num1%>;
        var major1 =<%=major1%>;
        var list = $('#siteMapCard');
        var text = '';
        var count =0;

        for (var i = 0; i < 3; i++) {
            text += ''
            text+='<div class="col-md-4 py-4">'
            text +='<section id="sec">'
            text +='<h2><i class="bi bi-'+pageTab1[i].tab_img+'"></i> '+pageTab1[i].tab_title+'</h2>'
            text +='<div class="row">'
            text +='<div class="col">'
            text +='<ul>';
            for(var j= count; pageMenu1[j].tab_id== pageTab1[i].tab_id; j++){
                text +='<a href="'+pageMenu1[j].page_path+'?major='+major1+'&&num='+pageMenu1[j].page_id+'"><span><li class="widget-49-meeting-item"><h3>'+pageMenu1[j].page_title+'</h3></span></a></li>'
                count +=1;
            }
            text +='</ol>'
            text +='</div></div></section></div>';
        }
        list.append(text);
    }
</script>

<div>
    <div class="container">
        <div class="row align-items-md-stretch" id="siteMapCard">
            <p class="h3"><a href="loginPage_v2.kgu">로그인(구글)</a></p>
            <p class="h3"><a href="loginPage.kgu">로그인(구버전)</a></p>
        </div>
    </div>
</div>
