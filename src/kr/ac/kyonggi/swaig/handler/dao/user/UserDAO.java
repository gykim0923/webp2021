package kr.ac.kyonggi.swaig.handler.dao.user;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class UserDAO {

    public static UserDAO it;

    public static UserDAO getInstance() { //인스턴스 생성
        if (it == null)
            it = new UserDAO();
        return it;
    }

    public UserTypeDTO getType(String type){
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            String sql = "SELECT * FROM usertype where type_name = '" + type + "';";
            listOfMaps = queryRunner.query(conn, sql, new MapListHandler());
        } catch(Exception se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }

        try {
            Gson gson = new Gson();
            ArrayList<UserTypeDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserTypeDTO>>() {}.getType());
            for(int i = 0; i < selected.size(); i++)
            {
            }
            if(selected.size() > 0) {
                return selected.get(0);
            }
            else
                return null;
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }


}
