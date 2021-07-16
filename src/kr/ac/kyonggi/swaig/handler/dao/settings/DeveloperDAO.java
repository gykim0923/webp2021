package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.DeveloperDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.MenuDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class DeveloperDAO {
    public static DeveloperDAO it;

    public static DeveloperDAO getInstance() { //인스턴스 생성
        if (it == null)
            it = new DeveloperDAO();
        return it;
    }

    public ArrayList<DeveloperDTO> getDevelopers(){
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `developer` ORDER BY `team_name` ASC;", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<DeveloperDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<DeveloperDTO>>() {}.getType());
        return selectedList;
    }

    public String addDeveloper(String data) {
        String arr[] = data.split("-/-/-"); // name+'-/-/-'+members+'-/-/-'+startDate+'-/-/-'+endDate';
        String teamName = arr[0];
        String members = arr[1];
        String startDate = arr[2];
        String endDate = arr[3];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO developer(team_name, members, start_date, end_date) VALUE(?,?,?,?);", teamName,members,startDate,endDate);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }
}
