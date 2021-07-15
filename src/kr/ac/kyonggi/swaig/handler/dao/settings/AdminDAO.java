package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.ScheduleDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class AdminDAO {
    public static AdminDAO it;

    public static AdminDAO getInstance() { //인스턴스 생성
        if (it == null)
            it = new AdminDAO();
        return it;
    }

    public String addMajor(String data) {
        String arr[] = data.split("-/-/-"); //major_id+'-/-/-'+major_name+'/-/-'+major_color1+'/-/-'+major_color2+'/-/-'+major_color3;
        String major_id = arr[0];
        String major_name = arr[1];
        String major_color1 = arr[2];
        String major_color2 = arr[3];
        String major_color3 = arr[4];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO major(major_id,major_name,major_color1,major_color2,major_color3) VALUE(?,?,?,?,?);", major_id,major_name,major_color1,major_color2,major_color3);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String modifyMajor(String data) {
        String arr[] = data.split("-/-/-"); // target_oid+'-/-/-'+major_name+'-/-/-'+major_color1+'-/-/-'+major_color2+'-/-/-'+major_color3;
        String target_oid = arr[0];
//        String major_id = arr[1];
        String major_name = arr[1];
        String major_color1 = arr[2];
        String major_color2 = arr[3];
        String major_color3 = arr[4];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE major SET major_name=?,major_color1=?,major_color2=?,major_color3=? WHERE oid=?;", major_name,major_color1,major_color2,major_color3, target_oid);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";

    }

    public ArrayList<ScheduleDTO> getSchedule() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `schedule`;", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<ScheduleDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ScheduleDTO>>() {}.getType());
        return selectedList;
    }
}
