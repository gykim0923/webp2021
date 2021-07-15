package kr.ac.kyonggi.swaig.handler.action.main.page_stand_alone;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LocationAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        request.setAttribute("jsp", gson.toJson("location")); //location.jsp
        request.setAttribute("pageTitle", gson.toJson("학교 위치")); //location.jsp에 띄울 타이틀
        return "RequestDispatcher:jsp/page_stand_alone/page_stand_alone.jsp";
    }
}
