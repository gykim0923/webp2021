package kr.ac.kyonggi.swaig.handler.action.main;

import kr.ac.kyonggi.swaig.common.controller.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainAction implements Action {
    /**
     * 단순히 main.jsp를 띄워줍니다.
     * */
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        System.out.println("dd");
        return "RequestDispatcher:jsp/main/main.jsp";
    }
}
