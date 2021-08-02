package kr.ac.kyonggi.swaig.handler.dao.user;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dao.settings.LogDAO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserDTO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ColumnListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
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
//            System.out.println(listOfMaps);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<UserDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserDTO>>() {}.getType());
//        System.out.println(selected);
        if(selected.size()>0) {
//            System.out.println(selected.get(0).birth);
//            System.out.println(selected.get(0).email);
//            System.out.println(selected.get(0).phone);
            return selected.get(0);
        }
        else
            return null;
    }

    public UserDTO getGoogleUser(String google_id){
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE google_id = ?;", new MapListHandler(), google_id);
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

    public String registerGoogleID(String text) {
//        System.out.println(text);
        String arr[] = text.split("-/-/-");
//        google_id+"-/-/-"+google_img+"-/-/-"+id+"-/-/-"+password+"-/-/-"+name+"-/-/-"+gender+"-/-/-"+birth+"-/-/-"+email+"-/-/-"+phone+"-/-/-"+hope_type+"-/-/-"+major+"-/-/-"+per_id;
        if(!checking(text))
            return "fail";
        boolean result = false;
        String google_id = arr[0];
        String google_img = arr[1];
        String id = arr[2];
        String password = arr[3];
        String name = arr[4];
        String gender = arr[5];
        String birth = arr[6];
        String email = arr[7];
        String phone = arr[8];
        String hope_type = arr[9];
        String major = arr[10];
        String per_id = arr[11];


        Connection conn = Config.getInstance().sqlLogin();
        try {
//            System.out.println("dd");
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO user(google_id,google_img,id,password,name,gender,birth,email,phone,hope_type,major,per_id) VALUES (?,?,?,?,?,?,?,?,?,?,?,?);", google_id,google_img,id,password,name,gender,birth,email,phone,hope_type,major,per_id);
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
//        Pattern SQL = Pattern.compile("[`';=]");

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
//        m = SQL.matcher(content);
//        if(m.find())
//            return false;
        return true;
    }


    public String deleteUser(String data) { //id+"-/-/-"+name+"-/-/-"+type
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

        return "success";
    }

    public String modifydata(String data) {
        String arr[] = data.split("-/-/-");//0:id 1:phone 2:birth 3:email
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE user SET phone=?,birth=?,email=? WHERE id = ?;",arr[1],arr[2],arr[3],arr[0]);
        }catch(SQLException se) {
            se.printStackTrace();
        }finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }

    public boolean checkPassword(String data) {
        String arr[] = data.split("-/-/-");//password, id
        if(!checking(arr[1]))
            return false;
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE id = ?;", new MapListHandler(), arr[1]);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<UserDTO> results = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserDTO>>() {}.getType());
        if(results.get(0).password.equals(arr[0]))
            return true;
        else
            return false;
    }

    public String modifypw(String data) {
        String arr[] = data.split("-/-/-");
        String result = "fail";
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE user SET password = ? WHERE id = ?;", arr[1], arr[0]);
            result = "success";
        }catch(Exception se) {
            se.printStackTrace();
        }finally {
            DbUtils.closeQuietly(conn);
        }
        return result;
    }

    public String compareUser(String header, String id) {//header value
        List<Map<String, Object>> listOfMaps = null;

        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE id=?;",new MapListHandler() ,id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        String data=null;
        if(!listOfMaps.isEmpty())
            data=(String)listOfMaps.get(0).get(header);

        if(data!=null) {
            return data;
        }
        else {
            return null;
        }
    }

    public ArrayList<UserDTO> getAlluser() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE type <> '관리자';", new MapListHandler());
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<UserDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserDTO>>() {}.getType());
        if(selected.size()>0) {
            return selected;
        }
        else
            return null;
    }

    public String insertexceluser(List<Map<String, Object>> xlsUserReader) {
        Connection conn = Config.getInstance().sqlLogin();
        boolean die=false;
        int dieid =0;
        try {
            QueryRunner queryRunner = new QueryRunner();

            for(int i=0;i<xlsUserReader.size();i++) {
                UserDTO user=new UserDTO();
                user.id=(String) xlsUserReader.get(i).get("id");//id
                user.per_id=(String) xlsUserReader.get(i).get("per_id");//학번
                if(user.id==null) {
                    user.id=user.per_id;
                }
                List<String> idlist=queryRunner.query(conn,"SELECT id FROM user ",new ColumnListHandler<String>());

                for(int j=0;j<idlist.size();j++) {//중복id검사(한사람 죽어버리기)
                    if(user.id.equals(idlist.get(j))) {
                        die=true;
                        dieid++;
                        break;
                    }
                }
                if(die) {
                    die=false;
                    continue;
                }
                user.major=(String) xlsUserReader.get(i).get("major");//전공
                if(user.major==null)
                user.sub_major=(String) xlsUserReader.get(i).get("sub_major");//부전공
                if(user.sub_major==null)
                    user.sub_major="-";
                user.phone=(String) xlsUserReader.get(i).get("phone");//휴대폰
                if(user.phone==null)
                    user.phone="-";
                user.grade=(String) xlsUserReader.get(i).get("grade");
                if(user.grade==null)
                    user.grade="-";//학년
                user.name=(String) xlsUserReader.get(i).get("name");//이름
                user.birth=(String) xlsUserReader.get(i).get("birth");//생일
                user.state=(String) xlsUserReader.get(i).get("state");//재적상태
                if(user.state==null)
                    user.state="-";
                user.type=(String) xlsUserReader.get(i).get("type");//타입
                if(user.type == null)
                    user.type = "학부생";
                user.email=(String) xlsUserReader.get(i).get("email");//이메일
                if(user.email==null)
                    user.email="-";
                List<String> namelist=queryRunner.query(conn,"SELECT name FROM user ",new ColumnListHandler<String>());
                List<String> birthlist=queryRunner.query(conn,"SELECT birth FROM user ",new ColumnListHandler<String>());
                for(int k=0;k<namelist.size();k++) {
                    if(user.name.equals(namelist.get(k))&&user.birth.equals(birthlist.get(k))) {
                        queryRunner.update(conn,"UPDATE user SET major=?,per_id=?,type=?,state=? WHERE name=? and birth=?",namelist.get(k),birthlist.get(k));//전공,학번,타입,재적상태
                        die=true;
                        break;
                    }
                }
                if(die) {
                    die=false;
                }
                String[] p =user.birth.split("-");
                String password=p[0].substring(2, 4)+p[1]+p[2];//yymmdd
                String toSha = user.id + password;
                user.password=SHA256(toSha);
                Date date=new Date();
                queryRunner.update(conn,"INSERT INTO user(id,password,major,sub_major,phone,grade,name,birth,state,type,email,per_id,reg_date) VALUE(?,?,?,?,?,?,?,?,?,?,?,?,?)",user.id,user.password,user.major,user.sub_major,user.phone,user.grade,user.name,user.birth,user.state,user.type,user.email,user.per_id,date);//id 중복될경우
            }
        }catch(SQLException se) {
            se.printStackTrace();
        }finally {
            DbUtils.closeQuietly(conn);
        }

        return Integer.toString(xlsUserReader.size()-dieid);
    }

    public String SHA256(String str){
        String SHA = "";
        try{
            MessageDigest sh = MessageDigest.getInstance("SHA-256");
            sh.update(str.getBytes());
            byte byteData[] = sh.digest();
            StringBuffer sb = new StringBuffer();
            for(int i = 0 ; i < byteData.length ; i++){
                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
            }
            SHA = sb.toString();
        }catch(NoSuchAlgorithmException e){
            e.printStackTrace();
            SHA = null;
        }
        return SHA;
    }

    public String modifyexceluser(List<Map<String, Object>> modifymap) {
        Connection conn = Config.getInstance().sqlLogin();

        try {
            QueryRunner queryRunner = new QueryRunner();
            for(int i=0;i<modifymap.size();i++) {
                UserDTO user=new UserDTO();
                user.id=(String) modifymap.get(i).get("id");//id
                user.per_id=(String) modifymap.get(i).get("per_id");//학번
                user.major=(String) modifymap.get(i).get("major");//전공
                user.sub_major=(String) modifymap.get(i).get("sub_major");//부전공
                user.grade=(String) modifymap.get(i).get("grade");//학년
                user.state=(String) modifymap.get(i).get("state");//재적상태
                user.type=(String) modifymap.get(i).get("type");//타입
                if(user.per_id!=null)
                    queryRunner.update(conn,"UPDATE user SET per_id=? WHERE id=?",user.per_id,user.id);
                if(user.major!=null)
                    queryRunner.update(conn,"UPDATE user SET major=? WHERE id=?",user.major,user.id);
                if(user.sub_major!=null)
                    queryRunner.update(conn,"UPDATE user SET sub_major=? WHERE id=?",user.sub_major,user.id);
                if(user.grade!=null)
                    queryRunner.update(conn,"UPDATE user SET grade=? WHERE id=?",user.grade,user.id);
                if(user.state!=null)
                    queryRunner.update(conn,"UPDATE user SET state=? WHERE id=?",user.state,user.id);
                if(user.type!=null)
                    queryRunner.update(conn,"UPDATE user SET type=? WHERE id=?",user.type,user.id);

            }
        }catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return Integer.toString(modifymap.size());
    }

    public String modifyUserType(String data) {
        String arr[] = data.split("-/-/-"); // type+'-/-/-'+id(+'-/-/-'+id 여러개)
        UserDTO modifiedUser;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            for (int i = 1; i < arr.length; i++){
                modifiedUser = UserDAO.getInstance().getUser(arr[i]);
                String type = modifiedUser.type;
                queryRunner.update(conn,"UPDATE user SET type=? WHERE id=?;", arr[0], arr[i]);
                LogDAO.getInstance().insertLog(modifiedUser.id, modifiedUser.name, modifiedUser.type, new Date(), "구분변경("+type+" to "+arr[0]+")");
            }
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }
}
