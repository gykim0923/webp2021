package kr.ac.kyonggi.swaig.handler.action.main.page_stand_alone;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SiteMapAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        request.setAttribute("jsp", gson.toJson("sitemap")); //sitemap.jsp
        request.setAttribute("pageTitle", gson.toJson("사이트맵")); //sitemap.jsp에 띄울 타이틀
        request.setAttribute("pageMenu", gson.toJson(HomeDAO.getInstance().getHeaderMenuPages()));
        request.setAttribute("pageTab", gson.toJson(HomeDAO.getInstance().getHeaderMenuTabs()));
        return "RequestDispatcher:jsp/page_stand_alone/page_stand_alone.jsp";
    }
}
