package kr.ac.kyonggi.swaig.handler.action.main.bbs;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.settings.BBSDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BulletinBoardServiceAction extends CustomAction {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request, response);
        Gson gson = new Gson();
        String mode= request.getParameter("mode"); //현재 mode를 가져옴
        if(mode==null){ //mode가 비어있는 경우 list로 출력
            mode="list";
        }
        String num = request.getParameter("num");
        if(num.equals("40")){ //전체 알림
            request.setAttribute("getBBS", gson.toJson(BBSDAO.getInstance().getBBS()));
        }
        else if(num.equals("41")||num.equals("42")||num.equals("43")){ // 학과/수업/취업 공지
            request.setAttribute("getBBS", gson.toJson(BBSDAO.getInstance().getBBS(num)));
        }

        request.setAttribute("mode", gson.toJson(mode));
        request.setAttribute("jsp", gson.toJson("bbs")); //bbs.jsp

        return "RequestDispatcher:jsp/page/page.jsp";
    }
}
