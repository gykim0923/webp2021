package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.BBSDTO;
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
        sql+=";";
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
            listOfMaps = queryRunner.query(conn,"SELECT * FROM bbs WHERE category=?;", new MapListHandler(),num);
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
}
