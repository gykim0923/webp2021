package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.BBSDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.CommentDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.TextDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class BBSDAO {
    public static BBSDAO it;

    public static BBSDAO getInstance() { //인스턴스 생성
        if (it == null)
            it = new BBSDAO();
        return it;
    }

    public ArrayList<BBSDTO> getAllBBSList(String [] numbers) {
        String sql = "SELECT * FROM bbs WHERE category=0";
        for (String number: numbers) {
            sql+=" OR category="+number;
        }
        sql+=" ORDER BY id DESC ;";
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,sql, new MapListHandler());
//            System.out.println(listOfMaps);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<BBSDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BBSDTO>>() {}.getType());
//        System.out.println(selected);
        if(selected.size()>0) {
            return selected;
        }
        else
            return null;
    }

    public ArrayList<BBSDTO> getBBSList(String num) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM bbs WHERE category=? ORDER BY id DESC ;", new MapListHandler(),num);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<BBSDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BBSDTO>>() {}.getType());
        if(selected.size()>0) {
            return selected;
        }
        else
            return null;
    }

    public BBSDTO getBBS(String id) {

        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM bbs WHERE id=?;", new MapListHandler(),id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<BBSDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BBSDTO>>() {}.getType());
        if(selected.size()>0) {
            return selected.get(0);
        }
        else
            return null;
    }

    public String insertBbs(String data) {
        String arr[] = data.split("-/-/-"); // major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+last_modified+"-/-/-"+text
        String major = arr[0];
        String writer_id = arr[1];
        String writer_name = arr[2];
        String title = arr[3];
        String category = arr[4];
        String last_modified = arr[5];
        String text = arr[6];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO bbs(major, writer_id, writer_name, title, category, last_modified, text) VALUE(?,?,?,?,?,?,?);", major,writer_id,writer_name, title, category, last_modified, text);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String modifyBbs(String data) {
        String arr[] = data.split("-/-/-"); // id+"-/-/-"+major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+last_modified+"-/-/-"+text
        String id = arr[0];
        String major = arr[1];
        String writer_id = arr[2];
        String writer_name = arr[3];
        String title = arr[4];
        String category = arr[5];
        String last_modified = arr[6];
        String text = arr[7];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE bbs SET major=?, writer_id=?, writer_name=?, title=?, category=?, last_modified=?, text=? WHERE id=?;", major, writer_id, writer_name, title, category, last_modified, text, id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String deleteBbs(String data) {
        String arr[] = data.split("-/-/-"); // id+"-/-/-"+major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+last_modified+"-/-/-"+text
        String id = arr[0];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM `bbs` WHERE `id`=?;", id);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }


    public ArrayList<CommentDTO> getCommentsList(String id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM comment WHERE bbs_id=? ORDER BY id DESC ;", new MapListHandler(),id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<CommentDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<CommentDTO>>() {}.getType());
        if(selected.size()>0) {
            return selected;
        }
        else
            return null;
    }





}
