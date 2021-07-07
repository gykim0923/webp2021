package kr.ac.kyonggi.swaig.handler.action.admin;

import kr.ac.kyonggi.swaig.common.controller.CustomAction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        String admin= request.getParameter("admin");
        if(admin!=null){
            if(admin.equals("main")){
                return "RequestDispatcher:jsp/admin/admin_main.jsp";
            }
            else if(admin.equals("user")){
                return "RequestDispatcher:jsp/admin/admin_user.jsp";
            }
            else {
                return "RequestDispatcher:jsp/main/error.jsp";
            }
        }
        return "RequestDispatcher:jsp/main/error.jsp";
    }
}
