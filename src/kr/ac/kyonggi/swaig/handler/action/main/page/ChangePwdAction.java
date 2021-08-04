package kr.ac.kyonggi.swaig.handler.action.main.page;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.settings.CurriculumDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ChangePwdAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();

        String type = (String) request.getSession().getAttribute("type");
        if(!type.equals("홈페이지관리자")){
            request.setAttribute("error", "구글 아이디는 비밀번호 변경이 불가능합니다.");
            return "RequestDispatcher:jsp/main/error.jsp";
        }

        String major=request.getParameter("major");
        String num=request.getParameter("num");

        request.setAttribute("jsp", gson.toJson("changePwd")); //curriculum.jsp
        return "RequestDispatcher:jsp/page/page.jsp";
    }
}
