package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.ClubDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

public class ClubDAO {
    public static ClubDAO it;

    public static ClubDAO getInstance() {
        if(it == null)
            it = new ClubDAO();
        return it;
    }

    public ArrayList<ClubDTO> getClub(){
        /**
         * 클럽 DB를 가져오는 역할
         *
         * */
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `club`;", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<ClubDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ClubDTO>>() {}.getType());
        return selectedList;
    }





    public String getNumber(String id) {//번호(74번 가정)
        return null;

    }
    public String modifyclub(String data) {
        String arr[] = data.split("-/-/-");//0=id 1=name 2=content 3=URL
        Connection conn =Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE club SET clubname=?, clubcontent=?, clubaddr=? WHERE id=?",arr[1],arr[2],arr[3],arr[0]);
        }catch(SQLException se) {
            se.printStackTrace();
        }finally {
            DbUtils.closeQuietly(conn);
        }
        return "1";
    }
    public String insertclub(String data) {
        String arr[] = data.split("-/-/-");//0=clubname 1=clubcontent 2=clubaddr
        Connection conn =Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO club(clubname,clubcontent,clubaddr) VALUES (?,?,?)",arr[0],arr[1],arr[2]);
        }catch(SQLException se) {
            se.printStackTrace();
        }finally {
            DbUtils.closeQuietly(conn);
        }
        return "1";
    }
    public String deleteclub(String data) {
        Connection conn =Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM club WHERE id=?",data);
        }catch(SQLException se) {
            se.printStackTrace();
        }finally {
            DbUtils.closeQuietly(conn);
        }
        return "1";
    }
}
