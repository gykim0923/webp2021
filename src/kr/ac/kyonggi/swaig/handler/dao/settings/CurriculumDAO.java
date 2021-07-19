package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.CurriculumDTO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class CurriculumDAO {
    public static CurriculumDAO it;

    public static CurriculumDAO getInstance() { //인스턴스 생성
        if (it == null)
            it = new CurriculumDAO();
        return it;
    }

    public ArrayList<CurriculumDTO> getCurriculums(String major){
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM curriculum WHERE major = ? ORDER BY year ASC;", new MapListHandler(), major);
        } catch(Exception se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<CurriculumDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<CurriculumDTO>>() {}.getType());

        return selected;
    }

    public String insertCurriculum(String data) {
        String arr[] = data.split("-/-/-"); // major+'-/-/-'+year+'-/-/-'+curriculum_img+'-/-/-'+edu_img
        String major = arr[0];
        String year = arr[1];
        String curriculum_img = arr[2];
        String edu_img = arr[3];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO curriculum(major, year, curriculum_img, edu_img) VALUE(?,?,?,?);", major,year,curriculum_img, edu_img);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String modifyCurriculum(String data) {
        String arr[] = data.split("-/-/-"); // major+'-/-/-'+year+'-/-/-'+curriculum_img+'-/-/-'+edu_img
        String major = arr[0];
        String year = arr[1];
        String curriculum_img = arr[2];
        String edu_img = arr[3];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE curriculum SET curriculum_img=?, edu_img=? WHERE major=? and year=?;", curriculum_img, edu_img, major, year);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String deleteCurriculum(String data) {
        String arr[] = data.split("-/-/-"); // major+'-/-/-'+year
        String major = arr[0];
        String year = arr[1];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM `curriculum` WHERE `major`=? and `year`=?;", major, year);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }
}
