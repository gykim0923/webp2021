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

    public RegisterDTO getReg(String id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM bbs_reg WHERE id=?;", new MapListHandler(),id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<RegisterDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<RegisterDTO>>() {}.getType());
        if(selected.size()>0) {
            return selected.get(0);
        }
        else
            return null;
    }

    public String insertReg(String data) {
        String arr[] = data.split("-/-/-");
        // 0=writer_id 1=writer_name 2=title 3=last_modified 4=text 5=starting_date 6=closing_date 7=level 8=for_who
        // 9=question (-/#/- 로 문제마다 구분 -/!/-로 문제 유형과 답변 구분  -/@/- 로 답변별 구분    1 주관 2 단일객관 3 다중객관 4척도형 5 파일업로드형)
        // 10=type
        String ques[] = arr[9].split("-/#/-"); //문제 구분
        Gson gson = new Gson();
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        String id = "fail";
        try {
            QueryRunner queryRunner = new QueryRunner();
            if (1 < Integer.parseInt(arr[10]))
                return "fail";
            queryRunner.update(conn,
                    "INSERT INTO bbs_reg(writer_id, writer_name, title, last_modified, text, starting_date, closing_date, level, for_who) VALUES (?,?,?,?,?,?,?,?,?);",
                    arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[8]);
            System.out.println(arr[0]);
            listOfMaps = queryRunner.query(conn,
                    "SELECT * FROM bbs_reg WHERE writer_id=? AND title=? AND text=? AND starting_date=? AND closing_date=? AND level=? AND for_who=?;",
                    new MapListHandler(), arr[0], arr[2], arr[4], arr[5], arr[6], arr[7], arr[8]);
            ArrayList<RegisterDTO> array = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<RegisterDTO>>() {
                    }.getType());
            RegisterDTO it = array.get(0);
            System.out.println(it.id+"dd");
            id = Integer.toString(it.id);
            for (int i = 0; i < ques.length; i++) {
                String text[] = ques[i].split("-/!/-"); //유형과 내용으로 구분
                String type = text[0];
                String content = text[1];
                queryRunner.update(conn,
                        "INSERT INTO bbs_regquestion(reg_id, question_num, question_content, question_type) VALUES (?,?,?,?);",
                        it.id, i + 1, content, Integer.valueOf(type));
                System.out.println(i);
            }
//            queryRunner.update(conn, "UPDATE bbs_req_writerfile SET board_id=? WHERE board_id=0 AND writer_id=?", id,
//                    arr[0]);
        } catch (SQLException se) {
            se.printStackTrace();
            System.out.println("fail2");
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }
}
