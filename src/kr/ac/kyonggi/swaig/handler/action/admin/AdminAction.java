package kr.ac.kyonggi.swaig.handler.action.admin;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.common.monitor.Monitor;
import kr.ac.kyonggi.swaig.handler.dao.settings.AdminDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.LogDAO;
import kr.ac.kyonggi.swaig.handler.dao.user.UserDAO;
import kr.ac.kyonggi.swaig.handler.dto.monitor.DiskDTO;
import kr.ac.kyonggi.swaig.handler.dto.monitor.OSDTO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class AdminAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        String num= request.getParameter("num");
        HttpSession session = request.getSession();
        UserTypeDTO type = gson.fromJson((String)session.getAttribute("type"), UserTypeDTO.class);
        if(num!=null && type.board_level==0){
            if(num.equals("70")){
                request.setAttribute("jsp", gson.toJson("admin_main")); //admin_main.jsp
                request.setAttribute("getAllMajor", gson.toJson(HomeDAO.getInstance().getAllMajor()));
                request.setAttribute("getSchedule", gson.toJson(AdminDAO.getInstance().getSchedule()));
                request.setAttribute("getSlider", gson.toJson(AdminDAO.getInstance().getSlider()));
                request.setAttribute("getAllUser", gson.toJson(UserDAO.getInstance().getAllUser()));
                request.setAttribute("getAllKGUMajor", gson.toJson(HomeDAO.getInstance().getAllKguMajor()));
                return "RequestDispatcher:jsp/page/page.jsp";
            }
            else if(num.equals("71")){
                request.setAttribute("jsp", gson.toJson("admin_user")); //admin_user.jsp
                request.setAttribute("getAllUser", gson.toJson(UserDAO.getInstance().getAllUser()));
                return "RequestDispatcher:jsp/page/page.jsp";
            }
            else if(num.equals("72")){
                request.setAttribute("jsp", gson.toJson("admin_menu")); //admin_menu.jsp
                request.setAttribute("getPageMenu", gson.toJson(HomeDAO.getInstance().getHeaderMenuPages()));
                request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getHeaderMenuTabs()));
                return "RequestDispatcher:jsp/page/page.jsp";
            }
            else if(num.equals("73")){
                request.setAttribute("jsp", gson.toJson("admin_log")); //admin_log.jsp

                // 로그
                request.setAttribute("getAllLog",gson.toJson(LogDAO.getInstance().getAllLog()));

                // 저장공간 정보
                List<Map<String, String>> spaceInfo = Monitor.getInstance().getSpaceInfo();
                ArrayList<DiskDTO> getSpaceInfo = gson.fromJson(gson.toJson(spaceInfo), new TypeToken<List<DiskDTO>>() {}.getType());
                request.setAttribute("getSpaceInfo",gson.toJson(getSpaceInfo));

                //

                Monitor.getInstance().showMemory();


                // 운영체제 정보
                List<Map<String, String>> osInfo = Monitor.getInstance().getOSInfo();
                ArrayList<OSDTO> getOSInfo = gson.fromJson(gson.toJson(osInfo), new TypeToken<List<OSDTO>>() {}.getType());
                request.setAttribute("getOSInfo",gson.toJson(getOSInfo));



                Monitor.getInstance().systemMemory();

                //Monitor.getInstance().showCPU(); //문제 있음. 활성화 금지

                return "RequestDispatcher:jsp/page/page.jsp";
            }
            else if(num.equals("74")){
                request.setAttribute("jsp", gson.toJson("admin_excel")); //admin_excel.jsp
                request.setAttribute("getAllUser", gson.toJson(UserDAO.getInstance().getAllUser()));
                return "RequestDispatcher:jsp/page/page.jsp";
            }
            else if(num.equals("75")){
                request.setAttribute("jsp", gson.toJson("changePwd")); //changePwd.jsp
                return "RequestDispatcher:jsp/page/page.jsp";
            }
            else {
                request.setAttribute("error", "올바른 요청이 아닙니다.");
                return "RequestDispatcher:jsp/main/error.jsp";
            }
        }
        request.setAttribute("error", "권한이 없습니다.");
        return "RequestDispatcher:jsp/main/error.jsp";
    }

}
