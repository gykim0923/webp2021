package kr.ac.kyonggi.swaig.common.controller;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CustomAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();
        HttpSession session = request.getSession(true);
        session.setAttribute("headermenulist", gson.toJson(HomeDAO.getInstance().getHeaderMenu()));
        session.setAttribute("menulist", gson.toJson(HomeDAO.getInstance().getMenu()));


        String major= request.getParameter("major"); //현재 major를 전달받음
        if(major==null){ //major 변수가 비어있는 경우에는 학부 홈페이지로 보내줄 수 있도록 처리함. (오류방지)
            major="main";
        }
        request.setAttribute("major", gson.toJson(major));
        request.setAttribute("majorInfo", gson.toJson(HomeDAO.getInstance().getMajor(major)));
        return null;
    }
}
