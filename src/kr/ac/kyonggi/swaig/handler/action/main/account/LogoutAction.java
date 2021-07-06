package kr.ac.kyonggi.swaig.handler.action.main.account;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.kyonggi.swaig.common.controller.Action;

public class LogoutAction implements Action{

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		response.sendRedirect("/");
		
		return null;


	}
}
