<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-29
  Time: 오전 2:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="sidebar" class="active fixed-top" style="z-index: 1040">
    <div class="sidebar-wrapper active">
        <div class="sidebar-header">
            <div class="d-flex justify-content-between">
                <div class="logo">
                    <a href="main.kgu">
                        <%--<img src="/img/logo/kgu_logo(500x300).png" alt="Logo" srcset="" style="height: auto">--%>
                            <i class="bi bi-house-fill"></i> HOME
                    </a>
                </div>
                <div class="toggler">
                    <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                </div>
            </div>
        </div>


        <div class="sidebar-menu">
            <ul class="menu" id="asideMenu"></ul>
        </div>


        <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
    </div>
</div>

<script>

    $(document).ready(function () {
        makeAsideMenu(); //Aside Menu 제작
    })

    function makeAsideMenu() {
        var menuTabList = <%=menuTabList%>;
        var menuPageList = <%=menuPageList%>;
        var majorAllInfo = <%=majorAllInfo%>;
        var major =<%=major%>;
        var list = $('#asideMenu');

        var tab5start=0;
        for(var a=0 ; a<menuPageList.length; a++){
            if(menuPageList[a].tab_id == 5){
                tab5start=a;
                break;
            }
        }
        var tab5end=0;
        for(var a=0 ; a<menuPageList.length; a++){
            if(menuPageList[a].tab_id == 6){
                tab5end=a;
                break;
            }
        }

        var text = '';
        text += '<li class="sidebar-title">공통메뉴</li>';
        //기본 메뉴
        for (var i = 0; i < 3; i++) {
            text += '<li class="sidebar-item has-sub">'
                + '<a href="#" class="sidebar-link">'
                + '<div class="py-2"><i class="bi bi-'+menuTabList[i].tab_img+'"></i></div>'
                + '<div class="py-2"><span>' + menuTabList[i].tab_title + '</span></div>'
                + '</a>';
            for (var j = 0; j < menuPageList.length; j++) {
                if (menuTabList[i].tab_id == menuPageList[j].tab_id) {
                    // text += '<ul class="submenu active" style="display: block;">'
                    text += '<ul class="submenu active" style="display: block;">'
                        + '<li class="submenu-item ">'
                        + '<a href="' + menuPageList[j].page_path + '?major=main&&num=' + menuPageList[j].page_id + '">' + menuPageList[j].page_title + '</a>'
                        + '</li>'
                        + '</ul>';
                }
            }
            text += '</li>';
        }

        //전공 선택
        text += '<li class="sidebar-title">전공메뉴</li>';
        text += '<li class="sidebar-item  has-sub" style="margin-bottom: 50px;">'
            + '<a href="#" class="sidebar-link">'
            + '<i class="bi bi-stack"></i>'
            + '<span>' + menuTabList[3].tab_title + '</span>'
            + '</a>';
        for (var i = 1; i < majorAllInfo.length; i++) {
            text += '<ul class="submenu active" style="display: block;" >'
                +'<li class="submenu-item">'
                // +'<a data-bs-toggle="collapse" href="#collapseExample'+i+'" role="button" aria-expanded="false" aria-controls="collapseExample" onclick="display('+i+')">'+majorAllInfo[i].major_name+'</a>'
                +'<a data-bs-toggle="collapse" href="#collapseExample'+i+'" role="button" aria-expanded="false" aria-controls="collapseExample">'+majorAllInfo[i].major_name+'</a>'
                // +'<div class="collapse" id="collapseExample'+i+'" style="display: none;">';
                +'<div class="collapse" id="collapseExample'+i+'">';
            for(var j=tab5start; j<tab5end; j++){
                var url = menuPageList[j].page_path+'?major='+majorAllInfo[i].major_id+'&&num='+menuPageList[j].page_id;
                text += '<div class="ms-3"><a href="'+url+'">○ ' + menuPageList[j].page_title + '</a></div>';
            }
            text+='</div>'
                + '</li></ul>';
        }
        text += '</li>';

        list.append(text);
    }
    // function display(i){
        // var id = "collapseExample"+i;
        // var value = document.getElementById(id);
        //
        // if(window.getComputedStyle(value,null).getPropertyValue("display")==='none'){
        //     value.style.display = 'block'
        // } else {
        //     value.style.display = 'none';
        // }
    // }

</script>