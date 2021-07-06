package kr.ac.kyonggi.swaig.handler.action.main.page;

import kr.ac.kyonggi.swaig.common.controller.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InformationAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        return "RequestDispatcher:jsp/page/information.jsp";
    }
}
