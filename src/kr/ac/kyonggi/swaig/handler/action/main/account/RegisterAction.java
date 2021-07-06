package kr.ac.kyonggi.swaig.handler.action.main.account;

import kr.ac.kyonggi.swaig.common.controller.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RegisterAction implements Action {

    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        if(session.getAttribute("user") != null)
            return "RequestDispatcher:jsp/main/error.jsp";
        String result;
        result = "RequestDispatcher:jsp/account/register.jsp";
        return result;
    }

}