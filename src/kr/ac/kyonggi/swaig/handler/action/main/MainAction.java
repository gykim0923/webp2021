package kr.ac.kyonggi.swaig.handler.action.main;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MainAction implements Action {
    /**
     * 단순히 main.jsp를 띄워줍니다.
     * */
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();
        HttpSession session = request.getSession(true);
        session.setAttribute("headermenulist", gson.toJson(HomeDAO.getInstance().getHeaderMenu()));
        session.setAttribute("menulist", gson.toJson(HomeDAO.getInstance().getMenu()));

        return "RequestDispatcher:jsp/main/main.jsp";
    }
}
