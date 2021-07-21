package kr.ac.kyonggi.swaig.handler.action.main.page;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.settings.ContactDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ContactAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        //http://localhost:8080/information.kgu?major=main&&num=10
        String major=request.getParameter("major");
        String num=request.getParameter("num");
        request.setAttribute("getLaboratoryList", gson.toJson(ContactDAO.getInstance().getLaboratory()));
        request.setAttribute("jsp", gson.toJson("laboratory")); //Contact.jsp
        return "RequestDispatcher:jsp/page/page.jsp";
    }
}
