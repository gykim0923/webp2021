package kr.ac.kyonggi.swaig.common.controller;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Header를 사용하려는 Action은 반드시 이 클래스를 상속받아야합니다.
 * 여기에 있는 설정들이 있어야 Header가 제대로 동작합니다.
 * */

public class CustomAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();
        HttpSession session = request.getSession(true);
        String num= request.getParameter("num"); //현재 페이지의 num을 전달받음
        if(num==null){
            num="0";
        }
        request.setAttribute("num", gson.toJson(num));

        /**
        * Header 제작하기
        * */
        request.setAttribute("menuTabList", gson.toJson(HomeDAO.getInstance().getMenuTabs()));
        request.setAttribute("menuPageList", gson.toJson(HomeDAO.getInstance().getMenuPages()));

        /**
        * pageMenu 제작하기
        * */
        request.setAttribute("pageMenu", gson.toJson(HomeDAO.getInstance().getPageMenu(num)));

        /**
         * 현재 홈페이지의 major 제작하기
         * */
        String major= request.getParameter("major"); //현재 major를 전달받음
        if(major==null){ //major 변수가 비어있는 경우에는 학부 홈페이지로 보내줄 수 있도록 처리함. (오류방지)
            major="main";
        }
        request.setAttribute("major", gson.toJson(major));
        if(HomeDAO.getInstance().getMajor(major)==null){
            major="main";
        }
        request.setAttribute("majorInfo", gson.toJson(HomeDAO.getInstance().getMajor(major)));
        request.setAttribute("majorAllInfo", gson.toJson(HomeDAO.getInstance().getAllMajor()));
        return null;
    }
}
