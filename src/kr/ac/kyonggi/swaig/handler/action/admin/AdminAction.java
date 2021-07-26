package kr.ac.kyonggi.swaig.handler.action.admin;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.settings.AdminDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.LogDAO;
import kr.ac.kyonggi.swaig.handler.dao.tutorial.TutorialDAO;
import kr.ac.kyonggi.swaig.handler.dao.user.UserDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        String num= request.getParameter("num");
        if(num!=null){
            if(num.equals("70")){
                request.setAttribute("jsp", gson.toJson("admin_main")); //admin_main.jsp
                request.setAttribute("getAllMajor", gson.toJson(HomeDAO.getInstance().getAllMajor()));
                request.setAttribute("getSchedule", gson.toJson(AdminDAO.getInstance().getSchedule()));
                request.setAttribute("getSlider", gson.toJson(AdminDAO.getInstance().getSlider()));
                request.setAttribute("getAllUser", gson.toJson(UserDAO.getInstance().getAllUser()));
                return "RequestDispatcher:jsp/page/page.jsp";
            }
            else if(num.equals("71")){
                request.setAttribute("jsp", gson.toJson("admin_user")); //admin_user.jsp
                request.setAttribute("getAllUser", gson.toJson(UserDAO.getInstance().getAllUser()));
                return "RequestDispatcher:jsp/page/page.jsp";
            }
            else if(num.equals("72")){
                request.setAttribute("jsp", gson.toJson("admin_menu")); //admin_menu.jsp
                request.setAttribute("getPageMenu", gson.toJson(HomeDAO.getInstance().getHeaderMenuPages()));
                request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getHeaderMenuTabs()));
                return "RequestDispatcher:jsp/page/page.jsp";
            }
            else if(num.equals("73")){
                request.setAttribute("jsp", gson.toJson("admin_log")); //admin_log.jsp
                request.setAttribute("getAllLog",gson.toJson(LogDAO.getInstance().getAllLog()));
                return "RequestDispatcher:jsp/page/page.jsp";
            }
            else if(num.equals("74")){
                request.setAttribute("jsp", gson.toJson("admin_excel")); //admin_excel.jsp
                request.setAttribute("getAllUser", gson.toJson(UserDAO.getInstance().getAllUser()));
                return "RequestDispatcher:jsp/page/page.jsp";
            }
            else {
                return "RequestDispatcher:jsp/main/error.jsp";
            }
        }
        return "RequestDispatcher:jsp/main/error.jsp";
    }
}
