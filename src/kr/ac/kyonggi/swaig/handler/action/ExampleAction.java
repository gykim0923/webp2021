package kr.ac.kyonggi.swaig.handler.action;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.handler.dao.ExampleDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ExampleAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();

        String dataByGetType = request.getParameter("data");
        request.setAttribute("dataByGetType", gson.toJson(dataByGetType));

        request.setAttribute("ExampleData", gson.toJson(ExampleDAO.getInstance().getAllExampleData()));
        return "RequestDispatcher:jsp/example.jsp";
    }
}
