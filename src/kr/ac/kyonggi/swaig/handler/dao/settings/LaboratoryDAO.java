package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.LaboratoryDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class LaboratoryDAO {
    public static LaboratoryDAO it;

    public static LaboratoryDAO getInstance() {
        if(it == null)
            it = new LaboratoryDAO();
        return it;
    }

    public ArrayList<LaboratoryDTO> getLaboratory() {
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
        ArrayList<LaboratoryDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LaboratoryDTO>>() {}.getType());
        return selected;
    }
    public LaboratoryDTO getOneLaboratory(String data) {
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
        ArrayList<LaboratoryDTO> results = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LaboratoryDTO>>() {}.getType());
        return results.get(0);
    }
    public String modifyLaboratory(String data) {
        String arr[]=data.split("-/-/-");//0=연구실 이름 1=연구실  위치    2=홈페이지 3=id
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE laboratory SET lab_name=?, lab_location=?, lab_homepage=? WHERE id=?;",arr[0],arr[1],arr[2],arr[3]);

            listOfMaps=queryRunner.query(conn,"SELECT * FROM laboratory WHERE id=?",new MapListHandler(),Integer.parseInt(arr[3]));

        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }

        Gson gson = new Gson();
        ArrayList<LaboratoryDTO> results = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LaboratoryDTO>>() {}.getType());
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
       /* try {
            String path = request.getSession().getServletContext().getRealPath("/");
            File deleteFile = new File(path, it.lab_img);
            deleteFile.delete();
        } catch(Exception e) {
            e.printStackTrace();
        }*/
        return "";
    }

    public LaboratoryDTO insertLaboratory(String data) {
        String arr[]=data.split("-/-/-");//0=연구실 이름 1=연구실 위치 2=홈페이지
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO laboratory (lab_name,lab_location,lab_homepage) VALUES(?,?,?);", arr[0],arr[1],arr[2]);
            listOfMaps=queryRunner.query(conn,"SELECT * FROM laboratory WHERE lab_name=? and lab_location=? AND lab_homepage=?",new MapListHandler(),arr[0],arr[1],arr[2]);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<LaboratoryDTO> results = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LaboratoryDTO>>() {}.getType());
        return results.get(0);
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
