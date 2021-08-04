package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.ScheduleDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.SliderDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
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
        String arr[] = data.split("-/-/-"); //major_id+'-/-/-'+major_name+'-/-/-'+major_location+'-/-/-'+major_contact;
        String major_id = arr[0];
        String major_name = arr[1];
        String major_location = arr[2];
        String major_contact = arr[3];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO major(major_id,major_name,major_location,major_contact) VALUE(?,?,?,?);", major_id,major_name,major_location,major_contact);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String modifyMajor(String data) {
        String arr[] = data.split("-/-/-"); // major_id+'-/-/-'+major_name+'-/-/-'+major_location+'-/-/-'+major_contact;
        String target_oid = arr[0];
        String major_name = arr[1];
        String major_location = arr[2];
        String major_contact = arr[3];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE major SET major_name=?,major_location=?,major_contact=? WHERE oid=?;", major_name,major_location,major_contact, target_oid);
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
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `schedule` ORDER BY `date` ASC;", new MapListHandler());
//            System.out.println(listOfMaps);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<ScheduleDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ScheduleDTO>>() {}.getType());
//        System.out.println(selectedList);
        return selectedList;
    }

    public String modifySchedule(String data) {
        String arr[] = data.split("-/-/-"); // target_id+'-/-/-'+date+'-/-/-'+content;
        String schedule_id = arr[0];
        String schedule_date = arr[1];
        String schedule_content = arr[2];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE schedule SET date=?, content=? WHERE id=?;", schedule_date, schedule_content, schedule_id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String addSchedule(String data) {
        String arr[] = data.split("-/-/-"); // date+'-/-/-'+content;
        String schedule_date = arr[0];
        String schedule_content = arr[1];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO schedule(date, content) VALUE(?,?);", schedule_date,schedule_content);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String updateSchedule() {
        Date today = new Date();
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<ScheduleDTO> selectedList = this.getSchedule();
        try {
            QueryRunner queryRunner = new QueryRunner();
            for (ScheduleDTO S : selectedList) {
//                System.out.println(S.content);
                if (((S.getDate().getTime() - today.getTime()) / (24 * 60 * 60 * 1000)) < 0) {
                    queryRunner.update(conn, "DELETE FROM `schedule` WHERE `id`=?;", S.id);
                }
            }
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String deleteSchedule(String data) {
        String arr[] = data.split("-/-/-"); // id+'-/-/-'+date+'-/-/-'+content;
        String schedule_id = arr[0];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM `schedule` WHERE `id`=?;", schedule_id);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public ArrayList<SliderDTO> getSlider() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM slider ORDER BY id DESC", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<SliderDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<SliderDTO>>() {}.getType());
        return selectedList;
    }

    public String addSlider(String data) {
        String arr[] = data.split("-/-/-"); // slider_img
        String slider_img = arr[0];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO slider(slider_img) VALUE(?);", slider_img);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String deleteSlider(String data) {

        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM slider WHERE id=?", data);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String modifyKguMajor(String data) {
        String arr[] = data.split("-/-/-"); // kguMajor+'-/-/-'+campus+'-/-/-'+college+'-/-/-'+id;
        String major = arr[0];
        String campus = arr[1];
        String college = arr[2];
        String id = arr[3];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE kgu_major SET campus=?,college=?,major=? WHERE id=?;", campus,college,major,id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";

    }
    public String addKguMajor(String data) {
        String arr[] = data.split("-/-/-"); //campus+'-/-/-'+college+'-/-/-'+major;
        String campus = arr[0];
        String college = arr[1];
        String major = arr[2];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO kgu_major(campus,college,major) VALUE(?,?,?);", campus,college,major);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String deleteKguMajor(String data) {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM kgu_major WHERE major=?" ,data);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String deleteLog() {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"delete from log where log_time < DATE_FORMAT( CURDATE() + INTERVAL -1 MONTH , '%Y/%m/%d' )");
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }
}
