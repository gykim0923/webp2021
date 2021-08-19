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
        makeSiteMap1();
        makeSiteMap2();
        makePageTitleSiteMap();
    })

    function makePageTitleSiteMap() {
        var list = $('#page_title');
        var text = '<h2><i class="bi bi-info-circle-fill"></i><strong> 사이트맵</strong></h2>';
        list.html(text);
    }

    function makeSiteMap1() { // 사이트맵 화면 만드는 함수
        var pageMenu1 = <%=pageMenu1%>;
        var pageTab1 = <%=pageTab1%>;
        //var num1=<%=num1%>;
        var major1 =<%=major1%>;
        var list = $('#siteMapCard1');
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
                text +='<a href="'+pageMenu1[j].page_path+'?major='+major1+'&&num='+pageMenu1[j].page_id+'"><span><li class="widget-49-meeting-item"><h3>'+pageMenu1[j].page_title+'</h3></li></span></a>'
                count +=1;
            }
            text +='</ul>'
            text +='</div></div></section></div>';
        }
        list.append(text);
    }
    function makeSiteMap2() { // 사이트맵 화면 만드는 함수
        var pageMenu1 = <%=pageMenu1%>;
        var pageTab1 = <%=pageTab1%>;
        var major1 =<%=major1%>;
        var majorAllInfo = <%=majorAllInfo%>;
        var list = $('#siteMapCard2');
        var text = '';
        //4번째 섹션
        text+='<div class="col-md-4 py-4">'
        text +='<section id="sec">'
        text +='<h2><i class="bi bi-'+pageTab1[3].tab_img+'"></i> '+pageTab1[3].tab_title+'</h2>'
        text +='<div class="row">'
        text +='<div class="col">'
        text +='<ul>';
        for (var i = 1; i < majorAllInfo.length; i++) {
            text +='<span><li onclick="makeMajorBBS('+i+')" class="widget-49-meeting-item"><h3>'+majorAllInfo[i].major_name+'</h3></li></span>'
        }
        text +='</ul>'
        text +='</div></div></section></div>';

        //5번째 섹션
        text+='<div class="col-md-4 py-4">'
        text +='<section id="sec">'
        text +='<h2 id="majorBBStitle">전공별메뉴</h2>'
        text +='<div class="row">'
        text +='<div class="col">'
        text +='<ul id="majorBBSname"><li class="py-5">왼쪽에서 전공을 선택해주세요</li></ul>'
        text +='</div></div></section></div>';

        // //6번째 섹션
        // text+='<div class="col-md-4 py-4">'
        // text +='<section id="sec">'
        // text +='<h2><i class="bi bi-person"></i> 마이페이지</h2>'
        // text +='<div class="row">'
        // text +='<div class="col">'
        // text +='<ul>';
        // // for(var j= 0; pageMenu1[j].tab_id== pageTab1[i].tab_id; j++){
        // //     text +='<a href="'+pageMenu1[j].page_path+'?major='+major1+'&&num='+pageMenu1[j].page_id+'"><span><li class="widget-49-meeting-item"><h3>'+pageMenu1[j].page_title+'</h3></span></a></li>'
        // // }
        // text +='</ul>'
        // text +='</div></div></section></div>';


        list.append(text);
    }

    function makeMajorBBS(i){
        var menuPageList = <%=menuPageList%>;
        var majorAllInfo = <%=majorAllInfo%>;
        var major = majorAllInfo[i];
        var majorBBStitle = $('#majorBBStitle');
        majorBBStitle.html('<i class="bi bi-info-circle-fill"></i> '+major.major_name);
        var list = $('#majorBBSname');
        var text='';
        for (var j=0; j<menuPageList.length; j++){
            if (menuPageList[j].tab_id==5){
                var url = menuPageList[j].page_path+'?major='+major.major_id+'&num='+menuPageList[j].page_id;
                text += '<span><li class="widget-49-meeting-item"><a href="'+url+'"><h3>'+menuPageList[j].page_title+'</h3></a></li></span>';
            }
        }
        list.html(text);
    }
</script>

<div>
    <div class="container">
        <div class="row align-items-md-stretch" id="siteMapCard1"></div>
        <div class="row align-items-md-stretch" id="siteMapCard2"></div>
        <hr>
        <div class="row align-items-md-stretch py-4">
            <p class="col-md-4 h3"><a href="main.kgu">메 인</a></p>
            <p class="col-md-4 h3"><a href="loginPage_v2.kgu">로그인(Google)</a></p>
            <p class="col-md-4 h3"><a href="loginPage.kgu" class="text-secondary">로그인(구버전)</a></p>
        </div>
        <div class="row align-items-md-stretch py-4">
            <p class="col-md-4 h3"><a href="https://sites.google.com/kyonggi.ac.kr/k-with">K-WITH 융합교육원</a></p>
            <p class="col-md-4 h3"><a href="location.kgu">연락처 및 오시는 길</a></p>
            <p class="col-md-4 h3"><a href="sitemap.kgu">사이트맵</a></p>
        </div>
        <div class="row align-items-md-stretch py-4">
            <p class="col-md-4 h3"><a href="http://www.kyonggi.ac.kr/webService.kgu?menuCode=K00M0502">개인정보 처리방침</a></p>
            <p class="col-md-4 h3"><a href="mypage.kgu?num=60">마이페이지</a></p>
            <p class="col-md-4 h3"><a href="whatIDoPage.kgu?num=61">활동내역</a></p>
        </div>
        <hr>
<%--        <h1>Family Sites</h1>--%>
        <div class="row align-items-md-stretch py-4">
            <p class="col-md-4 h3"><a href="http://www.kyonggi.ac.kr/KyonggiUp.kgu">경기대학교</a></p>
            <p class="col-md-4 h3"><a href="https://kutis.kyonggi.ac.kr/webkutis/view/indexWeb.jsp">KUTIS</a></p>
            <p class="col-md-4 h3"><a href="https://lms.kyonggi.ac.kr/login.php">LMS</a></p>
        </div>
        <div class="row align-items-md-stretch py-4">
            <p class="col-md-4 h3"><a href="http://sugang.kyonggi.ac.kr/">수강신청</a></p>
            <p class="col-md-4 h3"><a href="https://grade.kyonggi.ac.kr/">성적확인</a></p>
        </div>
    </div>
</div>
