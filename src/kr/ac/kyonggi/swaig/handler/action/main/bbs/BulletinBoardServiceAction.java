package kr.ac.kyonggi.swaig.handler.action.main.bbs;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BulletinBoardServiceAction extends CustomAction {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request, response);
        Gson gson = new Gson();

        request.setAttribute("jsp", gson.toJson("bbs")); //bbs.jsp

        return "RequestDispatcher:jsp/page/page.jsp";
    }
}
