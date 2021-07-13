package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.CurriculumDTO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class CurriculumDAO {
    public static CurriculumDAO it;

    public static CurriculumDAO getInstance() { //인스턴스 생성
        if (it == null)
            it = new CurriculumDAO();
        return it;
    }

    public ArrayList<CurriculumDTO> getCurriculums(String major){
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM curriculum WHERE major = ? ORDER BY year ASC;", new MapListHandler(), major);
        } catch(Exception se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<CurriculumDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<CurriculumDTO>>() {}.getType());

        return selected;
    }
}
