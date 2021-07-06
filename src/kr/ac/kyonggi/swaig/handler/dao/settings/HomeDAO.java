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

    public ArrayList<HeaderMenuDTO> getHeaderMenu(){
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
    public ArrayList<MenuDTO> getMenu(){
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
        return selectedList;
    }
}
