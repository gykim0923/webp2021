package kr.ac.kyonggi.swaig.handler.action.main.menu;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.kyonggi.swaig.common.controller.Action;

public class LoginPageAction implements Action{

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		int miss = 0;
		if(session.getAttribute("miss")!=null)
			miss = (Integer)session.getAttribute("miss");
		session.setAttribute("miss", miss);
		String result;
		if(session.getAttribute("user") == null)
			result = "RequestDispatcher:jsp/main/login.jsp";
		else
			result = "RequestDispatcher:jsp/main/main.jsp";
		return result;
	}

}
