package kr.ac.kyonggi.swaig.handler.action.main.page;

import kr.ac.kyonggi.swaig.common.controller.CustomAction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class mypageAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        return "RequestDispatcher:jsp/page/mypage.jsp";
    }
}
