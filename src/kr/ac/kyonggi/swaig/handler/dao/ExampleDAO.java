package kr.ac.kyonggi.swaig.handler.dao;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.ExampleDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ExampleDAO {
    public static ExampleDAO it;

    public static ExampleDAO getInstance() { //인스턴스 생성
        if (it == null)
            it = new ExampleDAO();
        return it;
    }

    public ArrayList<ExampleDTO> getAllExampleData() { //모든 Example 데이터를 받아오기
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `Example`", new MapListHandler());
//            System.out.println("예제 데이터 불러옴");
//            System.out.println(listOfMaps);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<ExampleDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ExampleDTO>>() {
        }.getType()); //위에서 불러온 DB를 ExampleDTO 타입으로 만들어서 return 해줌
        return selectedList;
    }

    public String deleteExampleData(String data) {
        String oid = data;
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "DELETE FROM `Example` WHERE oid=?", new MapListHandler(), oid);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }

    public String addExampleData(String data) {
        String arr[]=data.split("-/-/-"); // title+'-/-/-'+content+'-/-/-'+date;
        String title = arr[0];
        String content = arr[1];
        String date = arr[2];
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.query(conn, "INSERT `Example` SET title=?, content=?, date=?", new MapListHandler(), title, content, date);
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `Example` WHERE title=? AND content=? AND date=?", new MapListHandler(), title, content, date);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<ExampleDTO> result = null;
        result = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ExampleDTO>>() {
        }.getType());
        return result.get(0).getOid();
    }
}