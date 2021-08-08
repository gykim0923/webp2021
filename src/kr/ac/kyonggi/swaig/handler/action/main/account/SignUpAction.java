package kr.ac.kyonggi.swaig.handler.action.main.account;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;
import kr.ac.kyonggi.swaig.handler.dao.user.UserDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SignUpAction implements Action {

    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        if(session.getAttribute("user") != null){
            request.setAttribute("error", "이미 로그인 되어있습니다.");
            return "RequestDispatcher:jsp/main/error.jsp";
        }
        Gson gson = new Gson();
        request.setAttribute("getAllMajor", gson.toJson(HomeDAO.getInstance().getAllMajor()));
        request.setAttribute("getAllType", gson.toJson(UserDAO.getInstance().getAllType()));

        return "RequestDispatcher:jsp/account/register.jsp";
    }

}