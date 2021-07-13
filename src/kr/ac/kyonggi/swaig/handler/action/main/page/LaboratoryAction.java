package kr.ac.kyonggi.swaig.handler.action.main.page;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.LaboratoryDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LaboratoryAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        //http://localhost:8080/information.kgu?major=main&&num=10
        String major=request.getParameter("major");
        String num=request.getParameter("num");

        request.setAttribute("laboratory", gson.toJson(HomeDAO.getInstance().getText(major,num)));
        request.setAttribute("getLaboratoryList", gson.toJson(LaboratoryDAO.getInstance().getLaboratory()));
       // request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu(menu)));
        request.setAttribute("jsp", gson.toJson("laboratory")); //laboratory.jsp
        return "RequestDispatcher:jsp/main/page.jsp";
    }
}
