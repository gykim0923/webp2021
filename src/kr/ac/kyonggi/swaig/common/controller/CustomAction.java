package kr.ac.kyonggi.swaig.common.controller;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.handler.dao.settings.AdminDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserDTO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * [중요] 21-07-07자로 생긴 개념입니다.
 * CustomAction은 기존 프로젝트와 가장 큰 차이점 중 하나라고 볼 수 있는 클래스로
 * 기존의 각종 Action클래스에서 중복되어 사용되던 코드를 모아 만들었습니다.
 * 이전 프로젝트에서의 각종 Action클래스(이하 *Action 클래스)들은 Action Interface를 implements하여 execute 메소드(요청과 응답하는 간단한 역할)를 오버라이딩 하는 것에 그쳤습니다.
 * 기존 *Action 클래스들은 이로인해 자주 사용되는 setAttribute메소드나 getAttribute 메소드를 반복하여 사용해야 했고, 이는 코드 파편화의 주범이 되었습니다.
 * 예를 들어 로그인 한 사용자의 정보나 타입을 매번 Action 클래스 상단에 넣어야 했고, 페이지를 만들 때 페이지 메뉴나, 헤더의 메뉴들을 매 Action 클래스마다 불러와야 했습니다.
 * 페이지를 구성하는데 있어 기본 환경설정 하느라 정작 중요한 컨텐츠 개발에 집중 하는 것을 방해하고, 변수명 파편화나 각종 오류를 유발하는 것을 막기 위해
 * 관습적으로 자주 사용되는 메소드를 모아 CustomAction에 모았습니다.
 * 이 클래스를 상속(extends) 받고, super.execute(request,response); 해버리면
 * 헤더나 페이지의 기본적인 요소들을 설정(setAttribute)하는 것을 대신 해주므로 일절 신경쓰지 않아 해당 JSP의 컨텐츠 개발에만 집중할 수 있게 됩니다.
 * (Java의 기본 정책에 의해) super.를 통해 상속받더라도 getAttribute는 각자의 *Action에서 해주셔야 하는 것이 일반적입니다.
 *
 * 이 클래스를 상속받지 않고, 기존 방식 처럼 Action Interface를 implements해도 되는 경우는 다음과 같습니다.
 * 1. jsp에서 헤더, 페이지 등을 구현하지 않는 클래스다. (예를들어 업로드나 다운로드, Ajax나 로그인 등, 직접적인 JSP구현에 관련이 없는 클래스)
 *
 * 위 경우를 제외하고는 이 클래스를 상속 받는 것이 유지보수 측면에서도 매우 옳습니다.
 * 이 클래스를 상속받지 않고, 기존 방식처럼 Action만 implements 하는 경우에는
 * 한 개의 setAttribute 변수를 바꾸기 위해 수많은 클래스를 수정해야 하고,
 * 매 Action 클래스마다 코드가 수십줄 씩 늘어납니다.
 * 이 주석 아래에 나오는 메소드 대부분이 매 Action 클래스마다 등장해야한다고 해도 과언이 아닙니다.
 *
 * Header 또는 Page를 사용하려는 Action은 반드시 이 클래스를 상속받아야 합니다.
 * 여기에 있는 설정들이 있어야 Header가 제대로 동작합니다.
 *
 * 앞으로의 유지보수를 위해서도 이 클래스를 상속하는 것을 절대 강권합니다.
 * */

public class CustomAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();
        HttpSession session = request.getSession(true);
        String num= request.getParameter("num"); //현재 페이지의 num을 전달받음
        if(num==null){
            num="0";
        }
        request.setAttribute("num", gson.toJson(num));

        /**
         * 다음 설정은 JSP의 taglib에서 Java -> JSON으로 바로 접근이 가능하게 처리해줍니다.
         * 예를들어 Java에서 type.for_header라고 하는 경우 JSON의 for_header의 키값으로 인식하여 바로 즉시 접근이 가능하게 도와줍니다.
         * */
        String user = (String) request.getSession().getAttribute("user");
        request.setAttribute("user",gson.fromJson(user, UserDTO.class));
        String type = (String) request.getSession().getAttribute("type");
        request.setAttribute("type",gson.fromJson(type, UserTypeDTO.class));

        /**
         * 다음 설정은 Header 제작에 사용됩니다.
         * menuTabList로 대메뉴를 만들고
         * menuPageList로 소메뉴를 만듭니다.
         * */
        request.setAttribute("menuTabList", gson.toJson(HomeDAO.getInstance().getHeaderMenuTabs()));
        request.setAttribute("menuPageList", gson.toJson(HomeDAO.getInstance().getHeaderMenuPages()));

        /**
        * 다음 설정은 page.jsp의 pageMenu 및 pageHeader 제작에 관여합니다.
        * */
        request.setAttribute("pageMenu", gson.toJson(HomeDAO.getInstance().getPageMenu(num)));

        /**
         * 기존 프로젝트를 갈아엎게 만든 주범 중 하나입니다.
         * 기존 프로젝트와 다르게 이번 프로젝트의 모든 jsp 페이지는 major라는 정보를 반드시 가지고 있게 되어있습니다.
         * 현재 홈페이지의 major 관련 설정을 하는 것을 맡고 있으며, major 정보가 없는 경우에는 무조건 main으로 고정됩니다.
         * */
        String major= request.getParameter("major"); //현재 major를 전달받음
        if(major==null){ //major 변수가 비어있는 경우에는 학부 홈페이지로 보내줄 수 있도록 처리함. (오류방지)
            major="main";
        }
        request.setAttribute("major", gson.toJson(major));
        if(HomeDAO.getInstance().getMajor(major)==null){
            major="main";
        }
        request.setAttribute("majorInfo", gson.toJson(HomeDAO.getInstance().getMajor(major))); //전공 별 홈페이지 설정에 관여
        request.setAttribute("majorAllInfo", gson.toJson(HomeDAO.getInstance().getAllMajor())); //다른 홈페이지로 바로갈 수 있도록 하는 설정에 관여
        return null;
    }
}
