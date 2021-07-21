package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.ContactDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ContactDAO {
    public static ContactDAO it;

    public static ContactDAO getInstance() {
        if(it == null)
            it = new ContactDAO();
        return it;
    }

    public ArrayList<ContactDTO> getLaboratory() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM laboratory;", new MapListHandler());
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<ContactDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ContactDTO>>() {}.getType());
        return selected;
    }
    public ContactDTO getOneLaboratory(String data) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM laboratory WHERE id=?", new MapListHandler(), Integer.parseInt(data));
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<ContactDTO> results = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ContactDTO>>() {}.getType());
        return results.get(0);
    }
    public String modifyLaboratory(String data) { // 연구실 데이터 수정
        String arr[]=data.split("-/-/-");//lab_img+"-/-/-"+name + "-/-/-" + location1 + "-/-/-" + homepage +  "-/-/-" + id;
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "UPDATE laboratory SET lab_img=?,lab_name=?, lab_location=?, lab_homepage=? WHERE id=?;", arr[0], arr[1], arr[2], arr[3], arr[4]);

            listOfMaps=queryRunner.query(conn,"SELECT * FROM laboratory WHERE id=?",new MapListHandler(),Integer.parseInt(arr[4]));

        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }

        Gson gson = new Gson();
        ArrayList<ContactDTO> results = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ContactDTO>>() {}.getType());
        return gson.toJson(results.get(0));
    }

    public String deleteLaboratory(String data) {
        Connection conn = Config.getInstance().sqlLogin();

        try { //DB에서 연구실 정보 삭제
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM laboratory WHERE id=?;", data);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }

    public String insertLaboratory(String data) { // 연구실 데이터 추가

        Connection conn = Config.getInstance().sqlLogin();
        String arr[]=data.split("-/-/-");//lab_img+'-/-/-'+name1+'-/-/-'+location2+'-/-/-'+homepage2;
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            if(arr[0]!=null)
                queryRunner.update(conn,"INSERT INTO laboratory (lab_img,lab_name,lab_location,lab_homepage) VALUES(?,?,?,?);", arr[0],arr[1],arr[2],arr[3]);
            else
                queryRunner.update(conn,"INSERT INTO laboratory (lab_img,lab_name,lab_location,lab_homepage) VALUES('#',?,?,?);",arr[1],arr[2],arr[3]);
            //listOfMaps=queryRunner.query(conn,"SELECT * FROM laboratory WHERE lab_name=? and lab_location=? AND lab_homepage=?",new MapListHandler(),arr[0],arr[1],arr[2]);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public void changeImage(int id, String img) {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE laboratory SET `lab_img` = ? WHERE `id`=?;", img, id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
    }
}
