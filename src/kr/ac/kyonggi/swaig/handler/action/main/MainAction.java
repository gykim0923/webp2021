package kr.ac.kyonggi.swaig.handler.action.main;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.settings.AdminDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.BBSDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.RegisterDAO;
import kr.ac.kyonggi.swaig.handler.dao.tutorial.TutorialDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MainAction extends CustomAction {
    /**
     * main.jsp를 띄워줍니다.
     * */
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        String major=request.getParameter("major");
        if(major==null){
            major="main";
        }
        String num=request.getParameter("num");
        request.setAttribute("scheduleAllInfo", gson.toJson(AdminDAO.getInstance().getSchedule()));
        request.setAttribute("slider", gson.toJson(AdminDAO.getInstance().getSlider()));
        request.setAttribute("bbs21", gson.toJson(BBSDAO.getInstance().getBBSList("21")));
        request.setAttribute("bbs22", gson.toJson(BBSDAO.getInstance().getBBSList("22")));
        request.setAttribute("bbs23", gson.toJson(BBSDAO.getInstance().getBBSList("23")));
        request.setAttribute("registerAllInfo",gson.toJson(RegisterDAO.getInstance().getRegisterList()));
        request.setAttribute("favorite_menu", gson.toJson(HomeDAO.getInstance().getFavoriteMenu()));
        return "RequestDispatcher:jsp/main/main.jsp";
    }
}
