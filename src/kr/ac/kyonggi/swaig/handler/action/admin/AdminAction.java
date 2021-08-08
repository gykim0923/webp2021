package kr.ac.kyonggi.swaig.handler.action.admin;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.settings.AdminDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.LogDAO;
import kr.ac.kyonggi.swaig.handler.dao.tutorial.TutorialDAO;
import kr.ac.kyonggi.swaig.handler.dao.user.UserDAO;
import kr.ac.kyonggi.swaig.handler.dto.settings.LogDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.MemoryDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        String num= request.getParameter("num");
        if(num!=null){
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
                request.setAttribute("getAllLog",gson.toJson(LogDAO.getInstance().getAllLog()));
                List<Map<String, String>> spaceInfo = this.getSpaceInfo();
                System.out.println(spaceInfo);
                ArrayList<MemoryDTO> selected = gson.fromJson(gson.toJson(spaceInfo), new TypeToken<List<MemoryDTO>>() {}.getType());
                request.setAttribute("getSpaceInfo",gson.toJson(selected));
                return "RequestDispatcher:jsp/page/page.jsp";
            }
            else if(num.equals("74")){
                request.setAttribute("jsp", gson.toJson("admin_excel")); //admin_excel.jsp
                request.setAttribute("getAllUser", gson.toJson(UserDAO.getInstance().getAllUser()));
                return "RequestDispatcher:jsp/page/page.jsp";
            }
            else {
                return "RequestDispatcher:jsp/main/error.jsp";
            }
        }
        return "RequestDispatcher:jsp/main/error.jsp";
    }

    public static List<Map<String, String>> getSpaceInfo() {

        List<Map<String, String>> listOfMaps = new ArrayList<Map<String, String>>();

        String disk = "";
        double total = 0;
        double used = 0;
        double free = 0;

        File[] drives = File.listRoots();
        for(File drive : drives) {
            Map<String,String> result = new HashMap<String,String>();
            disk = drive.getAbsolutePath();
            total = drive.getTotalSpace() / Math.pow(1024, 3);
            free = drive.getUsableSpace() / Math.pow(1024, 3);
            used = total - free;
            result.put("disk", disk);
            result.put("total", String.valueOf(total));
            result.put("used", String.valueOf(used));
            result.put("free", String.valueOf(free));

            listOfMaps.add(result);

//            for(Map<String, String> strMap : listOfMaps){
//                System.out.print(strMap.get("disk") + " ");
//                System.out.print(strMap.get("total") + " ");
//                System.out.print(strMap.get("used") + " ");
//                System.out.print(strMap.get("free") + " ");
//                System.out.println();
//            }
        }
        return listOfMaps;

    }
}
