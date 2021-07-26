package kr.ac.kyonggi.swaig.handler.action.main.register;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.settings.RegisterDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class registerAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request, response);
        Gson gson = new Gson();
        /**
         * num은 페이지 고유번호로, 같은 모드/타입의 다른 게시판을 지원하게 해줌
         * */
        String num = request.getParameter("num"); //페이지 고유번호
        request.setAttribute("num",num); //다시 JSP로 보내줌 (재활용을 위해)
        System.out.println(num);

        /**
         * bbs_type은 일반게시판, 신청게시판, 웹진게시판 인지 타입을 나타내는 것임.
         * [중요] 파라미터로 받지 말고 그냥 여기에서 타입 나누는걸로..
         * (현 상황에서 url로 넘겨주는 방식은 page Menu에서 조작하기가 쉽지 않음)
         * DB로 하고 싶었는데, 그게 오히려 더 복잡해질까봐 Action에서 변수를 정해주는 것으로 함.
         * */
        /*____________________________________________________________________
         * |          |   일반(common)  |   자유게시판(free) |   신청(application) |
         * --------------------------------------------------------------------
         * | 작성,수정  |        O       |        O        |          O         |
         * |   댓 글   |        O       |        O        |          X         |
         * |   추 천   |        X       |        O        |          X         |
         * |  신청기능  |        X       |        X        |          O         |
         * --------------------------------------------------------------------
         * */
        String reg_type = ""; // (common/free/application) 중 하나
        if (num.equals("30")){
            reg_type="application";
        }
        else { //num이 없는 경우 오류 메시지 출력용
            reg_type="error";
        }
        request.setAttribute("reg_type", gson.toJson(reg_type));
        System.out.println(reg_type);

        /**
         * mode는 현재 페이지의 모드(list/view/write/modify)를 나타냄. default 값은 list임. url로 받음.
         * */
        String mode= request.getParameter("mode"); //현재 mode를 가져옴. (list/view/write/modify) 중 하나.
        if(mode==null){ //mode가 비어있는 경우 list로 출력
            mode="list";
        }
        System.out.println(mode);
        //mode에 따라 필요한 DB가 다르다.
        if(mode.equals("list")){
            request.setAttribute("getRegList", gson.toJson(RegisterDAO.getInstance().getRegisterList()));
            System.out.println(RegisterDAO.getInstance().getRegisterList());
        }
        else { //리스트를 제외한 모든 모드에서는 게시글 1개를 가지고 작업하기 때문에 다음과 같이 게시글 1개만 불러주는 작업을 한다.
            String id = request.getParameter("id"); //게시글 고유 번호
            request.setAttribute("id", id); //다시 JSP로 보내줌 (재활용을 위해), 게시글 아이디
            request.setAttribute("getReg", gson.toJson(RegisterDAO.getInstance().getReg(id)));
            request.setAttribute("getText",gson.toJson(RegisterDAO.getInstance().getText(id)));
        }


        String reg_mode = "reg_"+mode;
        request.setAttribute("jsp", gson.toJson(reg_mode)); //bbs_*.jsp

        System.out.println(reg_mode);
        return "RequestDispatcher:jsp/page/page.jsp";
    }
}
