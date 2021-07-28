package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.*;
import kr.ac.kyonggi.swaig.handler.dto.user.UserDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import javax.persistence.criteria.CriteriaBuilder;
import java.awt.*;
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

    public ArrayList<KguMajorDTO> getAllKguMajor() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `kgu_major`;", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<KguMajorDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<KguMajorDTO>>() {}.getType());
        return selectedList;
    }

    public TextDTO getText(String major, String num) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM text WHERE major = ? AND id =?;", new MapListHandler(), major, num);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<TextDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TextDTO>>() {}.getType());
        if(selected.size()>0) {
            return selected.get(0);
        }
        else
            return null;
    }

    public String modifyText(String data) {
        String arr[]=data.split("-/-/-");// information.id+"-/-/-"+information.major+"-/-/-"+content;
        String id=arr[0];
        String major=arr[1];
        String content=arr[2];
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE text SET content=? WHERE id=? AND major=?;",content,id, major);
            listOfMaps = queryRunner.query(conn, "SELECT * FROM text WHERE id=? AND major=? ;",new MapListHandler(),id, major);
        } catch (SQLException se) {
            se.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<TextDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TextDTO>>() {}.getType());
        return gson.toJson(selectedList.get(0));
    }

    public ArrayList<FavoriteMenuDTO> getFavoriteMenu() {
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM favorite_menu;",new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<FavoriteMenuDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<FavoriteMenuDTO>>() {}.getType());
        return selectedList;
    }
    public String getOneMenu(String id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `menu_pages` where `id` = ?;", new MapListHandler(), Integer.parseInt(id));
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<MenuDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuDTO>>() {}.getType());
        return gson.toJson(selectedList.get(0));
    }

    public String modifyMenu(String data) { // 메뉴 이름 수정
        String arr[] = data.split("-/-/-");//0: page_title, 1: id
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE menu_pages SET page_title=? WHERE page_id = ?;",arr[0],arr[1]);
        }catch(SQLException se) {
            se.printStackTrace();
        }finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }

    public String deleteMenu(String id) {            //메뉴 삭제
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM `menu_pages` WHERE `page_id`=?",id);
            queryRunner.update(conn,"DELETE FROM `text` WHERE `id`=?",id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }
}
