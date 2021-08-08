package kr.ac.kyonggi.swaig.handler.action.main.account;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;

public class LoginPageAction implements Action{

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Gson gson = new Gson();
		request.setAttribute("majorInfo", gson.toJson(HomeDAO.getInstance().getMajor("main")));

		int miss = 0;
		if(session.getAttribute("miss")!=null)
			miss = (Integer)session.getAttribute("miss");
		session.setAttribute("miss", miss);
		String result;
		if(session.getAttribute("user") == null)
			result = "RequestDispatcher:jsp/account/login.jsp";
		else{
			request.setAttribute("error", "이미 로그인 되어있습니다.");
			result = "RequestDispatcher:jsp/main/error.jsp";
		}
		return result;
	}

}
