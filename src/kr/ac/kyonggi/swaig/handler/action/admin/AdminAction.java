package kr.ac.kyonggi.swaig.handler.action.admin;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.settings.AdminDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;
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
            if(num.equals("90")){
                request.setAttribute("jsp", gson.toJson("admin_main")); //admin_main.jsp
                request.setAttribute("getAllMajor", gson.toJson(HomeDAO.getInstance().getAllMajor()));
                request.setAttribute("getSchedule", gson.toJson(AdminDAO.getInstance().getSchedule()));
                request.setAttribute("getSlider", gson.toJson(AdminDAO.getInstance().getSlider()));
                return "RequestDispatcher:jsp/main/page.jsp";
            }
            else if(num.equals("91")){
                request.setAttribute("jsp", gson.toJson("admin_user")); //admin_user.jsp
                request.setAttribute("getAllUser", gson.toJson(UserDAO.getInstance().getAllUser()));
                return "RequestDispatcher:jsp/main/page.jsp";
            }
            else {
                return "RequestDispatcher:jsp/main/error.jsp";
            }
        }
        return "RequestDispatcher:jsp/main/error.jsp";
    }
}
