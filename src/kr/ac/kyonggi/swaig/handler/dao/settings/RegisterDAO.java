package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.BBSDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.RegisterDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class RegisterDAO {
    public static RegisterDAO it;

    public static RegisterDAO getInstance() { //인스턴스 생성
        if (it == null)
            it = new RegisterDAO();
        return it;
    }

    public ArrayList<RegisterDTO> getRegisterList() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM bbs_reg ORDER BY id DESC;", new MapListHandler());
            System.out.println(listOfMaps);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<RegisterDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<RegisterDTO>>() {}.getType());
        System.out.println(selected);
        return selected;
    }

    public Object getReg(String id) {
        return null;
    }

    public Object getText(String id) {
        return null;
    }
}
