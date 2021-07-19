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
    })
    function makeSiteMap() { // 사이트맵 화면 만드는 함수
        var pageMenu1 = <%=pageMenu1%>;
        var pageTab1 = <%=pageTab1%>;
        //var num1=<%=num1%>;
        var major1 =<%=major1%>;
        var list = $('#siteMapCard');
        var text = '';
        var count =0;

        for (var i = 0; i < pageTab1.length; i++) {
            text += ''
            text+='<div class="col-md-6">'
            text +='<section id="sec">'
            text +='<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-geo-alt-fill" viewBox="0 0 16 16"> <path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10zm0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6z"/></svg><h2>'+pageTab1[i].tab_title+'</h2>'
            text +='<div class="row">'
            text +='<div class="col-md-6">'
            text +='<ol>';
            for(var j= count; pageMenu1[j].tab_id== pageTab1[i].tab_id; j++){
                text +='<li  class="widget-49-meeting-item"><a href="'+pageMenu1[j].page_path+'?major='+major1+'&&num='+pageMenu1[j].page_id+'"><span>'+pageMenu1[j].page_title+'</span></a></li>'
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
        </div>

    </div>
</div>
