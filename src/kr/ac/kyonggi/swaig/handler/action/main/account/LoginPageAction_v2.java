package kr.ac.kyonggi.swaig.handler.action.main.account;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginPageAction_v2 implements Action {


    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Gson gson = new Gson();
        request.setAttribute("majorInfo", gson.toJson(HomeDAO.getInstance().getMajor("main")));
        String result;
        if(session.getAttribute("user") == null){
            result = "RequestDispatcher:jsp/account/login_v2.jsp";
        }
        else{
            request.setAttribute("error", "이미 로그인 되어있습니다.");
            result = "RequestDispatcher:jsp/main/error.jsp";
        }
        return result;


    }
}
