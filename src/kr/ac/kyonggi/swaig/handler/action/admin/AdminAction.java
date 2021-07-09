package kr.ac.kyonggi.swaig.handler.action.admin;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        String num= request.getParameter("num");
        if(num!=null){
            if(num.equals("90")){
                request.setAttribute("jsp", gson.toJson("admin_main")); //information.jsp
                return "RequestDispatcher:jsp/main/page.jsp";
            }
            else if(num.equals("91")){
                request.setAttribute("jsp", gson.toJson("admin_user")); //information.jsp
                return "RequestDispatcher:jsp/main/page.jsp";
            }
            else {
                return "RequestDispatcher:jsp/main/error.jsp";
            }
        }
        return "RequestDispatcher:jsp/main/error.jsp";
    }
}
