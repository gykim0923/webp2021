package kr.ac.kyonggi.swaig.handler.action.main.page;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class mypageAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        HttpSession session = request.getSession();
        if(session.getAttribute("user") == null){
            request.setAttribute("error", "로그인이 필요한 메뉴입니다.");
            return "RequestDispatcher:jsp/main/error.jsp";
        }
        else{
            request.setAttribute("jsp", gson.toJson("mypage")); //mypage.jsp
            request.setAttribute("getAllMajor", gson.toJson(HomeDAO.getInstance().getAllMajor()));
            return "RequestDispatcher:jsp/page/page.jsp";
        }
    }
}
