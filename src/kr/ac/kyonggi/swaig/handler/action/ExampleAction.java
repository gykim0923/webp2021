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
        /**
         * get 방식으로 parameter를 넘겨받는 작업
         * */
        String tutorial= request.getParameter("tutorial"); //주소로 부터 tutorial 변수를 받음
        if(tutorial==null){ //tutorial 변수가 null(변수를 빼먹고 넘겨주는 경우)이라면 main으로 변경해줌.
            tutorial="main";
        }
        request.setAttribute("tutorial", gson.toJson(tutorial)); //tutorial 변수를 jsp로 넘겨줌. (jsp에서는 tutorial변수를 getAttribute할 예정)

        String dataByGetType = request.getParameter("data"); //주소로 부터 data 변수를 받음.
        request.setAttribute("dataByGetType", gson.toJson(dataByGetType)); //data변수를 jsp로 넘겨줌

        /**
         * db에서 데이터를 요청하는 작업
         * */
        request.setAttribute("ExampleData", gson.toJson(ExampleDAO.getInstance().getAllExampleData()));

        /**
         * return할 url을 미리 제작해줌.
         * 여기에선 요청받은 tutorial변수에 따라 jsp를 달리 주려고 미리 제작함.
         * 미리 제작 안해도 상관 없음
         * */
        String url="RequestDispatcher:jsp/tutorial/tutorial_"+tutorial+".jsp";

        /**
         * tutorial변수에 따라서 각기 다른 jsp를 return해주는 예시.
         * tutorial변수에 따라 띄워줄 jsp를 통제한다고 생각하면 됨.
         * */
        if (tutorial.equals("main")){
            return url; //"RequestDispatcher:jsp/tutorial/tutorial_main.jsp"
        }
        else if(tutorial.equals("bootstrap")){
            return url;  //"RequestDispatcher:jsp/tutorial/tutorial_bootstrap.jsp"
        }
        else{ //예상 외의 요청이 들어오는 경우에는 error 페이지를 돌려준다.
            return "RequestDispatcher:jsp/main/error.jsp";
        }

    }
}
