package kr.ac.kyonggi.swaig.handler.dao.user;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.user.UserDTO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
    public ArrayList<UserTypeDTO> getAllType(){
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM usertype WHERE board_level>0 AND board_level<3 ORDER BY board_level ASC;", new MapListHandler());
        } catch(Exception se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<UserTypeDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserTypeDTO>>() {}.getType());

        return selected;
    }

    public UserDTO getUser(String id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE id = ?;", new MapListHandler(), id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<UserDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserDTO>>() {}.getType());
        if(selected.size()>0) {
            return selected.get(0);
        }
        else
            return null;
    }

    public ArrayList<UserDTO> getAllUser() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM user;", new MapListHandler());
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<UserDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserDTO>>() {}.getType());
        return selected;
    }

    public void whoIsLogIn(String id) {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE user SET last_login = now() WHERE id = ?;", id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
    }
    public boolean checkID(String id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE id = ?;", new MapListHandler(), id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<UserDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserDTO>>() {}.getType());
        if(selected.size()==0) {
            return true;
        }
        else
            return false;
    }
    public String registerBigID(String text) {
        String arr[] = text.split("-/-/-");//id+"-/-/-"+password+"-/-/-"+name+"-/-/-"+gender+"-/-/-"+birth+"-/-/-"+email+"-/-/-"+phone+"-/-/-"+type+"-/-/-"+major+"-/-/-"+perId;
        if(!checking(text))
            return "fail";
        boolean result = false;


        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO user(id,password,name,gender,birth,hope_type,email,phone,major,per_id) VALUES (?,?,?,?,?,?,?,?,?,?);", arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],arr[6],arr[7],arr[8],arr[9]);
            result = true;
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        if(result)
            return "success";
        else
            return "fail";
    }

    public String registerSmallID(String text) {
        String arr[] = text.split("-/-/-");//id+"-/-/-"+password+"-/-/-"+name+"-/-/-"+gender+"-/-/-"+birth+"-/-/-"+email+"-/-/-"+phone+"-/-/-"+type+"-/-/-"+major+"-/-/-"+perId;
        if(!checking(text))
            return "fail";
        boolean result = false;


        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO user(id,password,name,gender,birth,hope_type,email,phone) VALUES (?,?,?,?,?,?,?,?);", arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],arr[6],arr[7]);
            result = true;
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        if(result)
            return "success";
        else
            return "fail";
    }

    private boolean checking(String content) {
        Pattern SCRIPTS = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>", Pattern.DOTALL);
        Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>", Pattern.DOTALL);
        Pattern TAGS = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");
        //Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");
        Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
        Pattern WHITESPACE = Pattern.compile("\\s\\s+");
        Pattern WHITE = Pattern.compile("<!--");
        Pattern ON = Pattern.compile("(on)+[a-z]*=");
        Pattern SQL = Pattern.compile("[`';=]");

        Matcher m;

        m = SCRIPTS.matcher(content);
        if(m.find())
            return false;
        m = STYLE.matcher(content);
        if(m.find())
            return false;
        m = TAGS.matcher(content);
        if(m.find())
            return false;
        m = ENTITY_REFS.matcher(content);
        if(m.find())
            return false;
        m = WHITESPACE.matcher(content);
        if(m.find())
            return false;
        m = WHITE.matcher(content);
        if(m.find())
            return false;
        m = ON.matcher(content);
        if(m.find())
            return false;
        m = SQL.matcher(content);
        if(m.find())
            return false;
        return true;
    }


    public String deleteUser(String data) { //id+"-/-/-"+name
        String arr[] = data.split("-/-/-");
        String id = arr[0];
        String name = arr[1];
//        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.query(conn, "DELETE FROM `user` WHERE id=? AND name=?", new MapListHandler(), id, name);
//            System.out.println(id+" "+name);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }

        return null;
    }
}
