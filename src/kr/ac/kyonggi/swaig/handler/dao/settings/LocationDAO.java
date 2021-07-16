package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.LocationDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class LocationDAO  {
    public static LocationDAO it;

    public static LocationDAO getInstance() {
        if(it == null)
            it = new LocationDAO();
        return it;
    }
    public ArrayList<LocationDTO> getLocation(){
        /**
         * location DB를 가져오는 역할
         *
         * */
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `location`;", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<LocationDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LocationDTO>>() {}.getType());
        return selectedList;
    }
    public String modifyLoc(String data) {
        String arr[] = data.split("-/-/-");//0=id 1=address 2=contact_num 3=content
        Connection conn =Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE location SET address=?, contact_num=?, content=? WHERE id=?",arr[1],arr[2],arr[3],arr[0]);
        }catch(SQLException se) {
            se.printStackTrace();
        }finally {
            DbUtils.closeQuietly(conn);
        }
        return "1";
    }
}
