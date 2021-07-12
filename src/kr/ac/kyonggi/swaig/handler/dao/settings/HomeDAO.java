package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.HeaderMenuDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.MajorDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.MenuDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import javax.persistence.criteria.CriteriaBuilder;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class HomeDAO {
    public static HomeDAO it;

    public static HomeDAO getInstance() { //인스턴스 생성
        if (it == null)
            it = new HomeDAO();
        return it;
    }

    public ArrayList<HeaderMenuDTO> getHeaderMenuTabs(){
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `menu_tabs`;", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<HeaderMenuDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<HeaderMenuDTO>>() {}.getType());
        return selectedList;
    }

    public ArrayList<MenuDTO> getHeaderMenuPages(){
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `menu_pages` ORDER BY `tab_id` ASC, `orderNum` ASC;", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<MenuDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuDTO>>() {}.getType());
        return selectedList;
    }

    public ArrayList<MenuDTO> getPageMenu(String num){
        /**
         * page.jsp의 좌측 메뉴를 불러오는 녀석
         * id가 3자리인 경우는 tab_id가 2자리라고 가정하고 설계함.
         * 예를들어 num=110이 들어온다면
         * tab_id는 11, orderNum은 0으로 해석됨.
         * */

        String tab_id=num.substring(0,num.length()-1);
        String orderNum=num.substring(num.length()-1, num.length());
//        System.out.println(tab_id+" "+orderNum);

        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `menu_pages` WHERE `tab_id`=? ORDER BY `orderNum` ASC ;", new MapListHandler(), tab_id);
//            System.out.println(listOfMaps);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<MenuDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuDTO>>() {}.getType());
        return selectedList;
    }


    public ArrayList<MajorDTO> getMajor(String major) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `major` WHERE `major_id`=?;", new MapListHandler(), major);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<MajorDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MajorDTO>>() {}.getType());
        if(selectedList.size()==0){
            return null;
        }
        return selectedList;
    }

    public ArrayList<MajorDTO> getAllMajor() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `major`;", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<MajorDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MajorDTO>>() {}.getType());
        return selectedList;
    }
}
