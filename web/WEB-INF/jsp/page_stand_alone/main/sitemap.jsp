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
        border-bottom: 1px solid #ccc;
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
            text +='<section id="sec">'
            text +='<h2>'+pageTab1[i].tab_title+'</h2>'
            text +='<div class="row">'
            text +='<div class="col-md-12">'
            text +='<ul>';

            for(var j= count; pageMenu1[j].tab_id== pageTab1[i].tab_id; j++){
                text +='<li><a href="'+pageMenu1[j].page_path+'?major='+major1+'&&num='+pageMenu1[j].page_id+'">'+pageMenu1[j].page_title+'</a></li>'
                count +=1;
            }
            text +='</ul>'
            text +='</div></div></section>';
        }
        list.append(text);
    }
</script>

<div>
    <div class="container">
        <div id="siteMapCard">
        </div>
    </div>
</div>
<!-- /container -->