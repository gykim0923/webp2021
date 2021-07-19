package kr.ac.kyonggi.swaig.handler.action.main.page;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.settings.ClubDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.LaboratoryDAO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ClubAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        request.setAttribute("getClub", gson.toJson(ClubDAO.getInstance().getClub()));
        request.setAttribute("jsp", gson.toJson("club")); //club.jsp
        return "RequestDispatcher:jsp/page/page.jsp";
    }
}
