package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.*;
import kr.ac.kyonggi.swaig.handler.dto.user.UserDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
//            System.out.println(listOfMaps);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<RegisterDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<RegisterDTO>>() {}.getType());
//        System.out.println(selected);
        return selected;
    }

    public RegisterDTO getReg(String id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM bbs_reg WHERE id=?;", new MapListHandler(),id);
            queryRunner.update(conn, "UPDATE bbs_reg SET `views`= `views`+1 WHERE `id` = ?;", id);
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

    public RegisterDTO getRegRead(String id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM bbs_reg WHERE id=?;", new MapListHandler(),id);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<RegisterDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<RegisterDTO>>() {}.getType());
        selected.get(0).title = getRemoveHtmlText(selected.get(0).title);
        selected.get(0).text = getRemoveHtmlText(selected.get(0).text);
        return selected.get(0);
    }

    public String modifyReg(String data){
        String arr[] = data.split("-/-/-"); //id+"-/-/-"+ title +"-/-/-"+ text +"-/-/-"+writer_id+"-/-/-"+for_who+"-/-/-"+level +"-/-/-"+startingDate +"-/-/-" +closingDate+"-/-/-"+writer_name+"-/-/-"+last_modified;

        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE bbs_reg SET title=?, text =? , for_who =?, level = ?, starting_date =? , closing_date =?, last_modified =?  WHERE id=?;",arr[1], arr[2], arr[4], arr[5],arr[6],arr[7],arr[9],arr[0]);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
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
//            System.out.println(arr[0]);
            listOfMaps = queryRunner.query(conn,
                    "SELECT * FROM bbs_reg WHERE writer_id=? AND title=? AND text=? AND starting_date=? AND closing_date=? AND level=? AND for_who=?;",
                    new MapListHandler(), arr[0], arr[2], arr[4], arr[5], arr[6], arr[7], arr[8]);
            ArrayList<RegisterDTO> array = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<RegisterDTO>>() {
                    }.getType());
            RegisterDTO it = array.get(0);
//            System.out.println(it.id+"dd");
            id = Integer.toString(it.id);
            for (int i = 0; i < ques.length; i++) {
                String text[] = ques[i].split("-/!/-"); //유형과 내용으로 구분
                String type = text[0];
                String content = text[1];
                queryRunner.update(conn,
                        "INSERT INTO bbs_regQuestion(reg_id, question_num, question_content, question_type) VALUES (?,?,?,?);",
                        it.id, i + 1, content, Integer.valueOf(type));
//                System.out.println(i);
            }
//            queryRunner.update(conn, "UPDATE bbs_reg_WriterFile SET board_id=? WHERE board_id=0 AND writer_id=?", id,
//                    arr[0]);
        } catch (SQLException se) {
            se.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return id;
    }

    public String whoAnswerIt(String data) {
        String arr[] = data.split("-/-/-");// 0= board_number 1= user_id
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM bbs_reg_answer WHERE reg_id=? AND writer_id=?;",
                    new MapListHandler(), arr[0], arr[1]);
        } catch (SQLException e) {
            e.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<RegAnswerDTO> list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<RegAnswerDTO>>() {}.getType());
        if(list.isEmpty())
            return "empty";
        for(int i = 0 ; i < list.size() ; ++i)
            list.get(i).answer = getRemoveHtmlText(list.get(i).answer);
        return gson.toJson(list);
    }

    public ArrayList<RegQuestionDTO> getQuestions(String data) {
        String arr[] = data.split("-/-/-");// 0= id 1=type.for_header 2= user.id 3= type.board_level
        List<Map<String, Object>> listOfMaps = null;
        Gson gson = new Gson();
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM bbs_reg WHERE id=?;", new MapListHandler(), arr[0]);
            ArrayList<RegisterDTO> reqList = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<RegisterDTO>>() {
                    }.getType());
            if (!reqList.get(0).writer_id.equals(arr[2]) && !reqList.get(0).level.contains(arr[1]) && Integer.valueOf(arr[3]) != 0) //권한 확인 (작성지인지, 신청 대상인지, 관리자인지 확인)
                return null;
            listOfMaps = queryRunner.query(conn, "SELECT * FROM bbs_regQuestion WHERE reg_id=? ORDER BY question_num;", new MapListHandler(), arr[0]);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        ArrayList<RegQuestionDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<RegQuestionDTO>>() {}.getType());
        for(int i = 0 ; i < selected.size() ; ++i)
            selected.get(i).question_content = getRemoveHtmlText(selected.get(i).question_content);
        return selected;
    }

    public String insertAnswers(String data) {
        System.out.println(data);
        String arr[] = data.split("-/-/-");// 0= userName 1=userid 2=per_id 3=grade 4=type 5=board_number 6=answers 7= question개수
        String answers[] = arr[6].split("-/#/-"); // answer별 구분자 -/#/- 다중객관식은 그냥 answer에 구분자쨰로 넣음.
        if(arr[2].equals("null"))
            arr[2] = "-";
        if(arr[3].equals("null"))
            arr[3] = "-";
        Connection conn = Config.getInstance().sqlLogin();
        boolean result = false;
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM bbs_reg_answer WHERE writer_id=? AND reg_id=?;",
                    new MapListHandler(), arr[1], arr[5]);
            if (listOfMaps.size() > 0)
                return "already";
            for (int i = 0; i < answers.length; i++) {
                System.out.println(answers[i]);
                queryRunner.update(conn,
                        "INSERT INTO bbs_reg_answer(writer_name, writer_id, writer_perId, writer_grade, writer_type, question_num, reg_id, answer) VALUES(?,?,?,?,?,?,?,?);",
                        arr[0], arr[1], arr[2], arr[3], arr[4], (i + 1), arr[5], answers[i]);
            }
            for (int j = answers.length ; j < Integer.valueOf(arr[7]) ; ++j) {
                queryRunner.update(conn,
                        "INSERT INTO bbs_reg_answer(writer_name, writer_id, writer_perId, writer_grade, writer_type, question_num, reg_id, answer) VALUES(?,?,?,?,?,?,?,?);",
                        arr[0], arr[1], arr[2], arr[3], arr[4], (j + 1), arr[5], "");
            }
            queryRunner.update(conn, "UPDATE bbs_reg SET `applicant_count`= `applicant_count`+1 WHERE `id` = ?;", arr[5]);
            result = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        if (result)
            return "success";
        else
            return "fail";
    }

    public String modifyAnswer(String data) {
        System.out.println(data);
        String arr[] = data.split("-/-/-");// 0= userName 1=userid 2=per_id 3=grade 4=type 5=board_number 6=answers 7= question개수
        String answers[] = arr[6].split("-/#/-"); // answer별 구분자 -/#/- 다중객관식은 그냥 answer에 구분자쨰로 넣음.
        Connection conn = Config.getInstance().sqlLogin();
        boolean result = false;
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,
                    "DELETE FROM bbs_reg_answer WHERE writer_id = ? AND reg_id = ?;", arr[1], arr[5]);
            for (int i = 0; i < answers.length; i++) {
                queryRunner.update(conn,
                        "INSERT INTO bbs_reg_answer(writer_name, writer_id, writer_perId, writer_grade, writer_type, question_num, reg_id, answer) VALUES(?,?,?,?,?,?,?,?);",
                        arr[0], arr[1], arr[2], arr[3], arr[4], (i + 1), arr[5], answers[i]);
            }
            for (int j = answers.length ; j < Integer.valueOf(arr[7]) ; ++j) {
                System.out.println("222");
                queryRunner.update(conn,
                        "INSERT INTO bbs_reg_answer(writer_name, writer_id, writer_perId, writer_grade, writer_type, question_num, reg_id, answer) VALUES(?,?,?,?,?,?,?,?);",
                        arr[0], arr[1], arr[2], arr[3], arr[4], (j + 1), arr[5], "");
            }
            result = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        if (result)
            return "success";
        else
            return "fail";
    }

    public ArrayList<RegAnswerDTO> getResult(String id) {
        Gson gson = new Gson();
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,
                    "SELECT * FROM bbs_reg_answer WHERE reg_id=? ORDER BY writer_name, question_num;",
                    new MapListHandler(), id);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            DbUtils.closeQuietly(conn);
        }
        ArrayList<RegAnswerDTO> it = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<RegAnswerDTO>>() {}.getType());
        for(int i = 0 ; i < it.size() ; ++i)
            it.get(i).answer = getRemoveHtmlText(it.get(i).answer);
        return it;
    }

    public String deleteWhoAnswer(String data) {
        String arr[] = data.split("-/-/-");// 0= reg_id 1= user_name 2=user_per_id 3=user_grade 4 = user_id
        // realPath +\Q+question_num 해야함
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM bbs_reg_answer WHERE reg_id=? AND writer_id=?", new MapListHandler(), arr[0],arr[4]);
            ArrayList<RegAnswerDTO> ansList = gson.fromJson(gson.toJson(listOfMaps),new TypeToken<List<RegAnswerDTO>>() {}.getType());
            if (!ansList.get(0).writer_id.equals(arr[4])) //본인이 삭제하는지 검사
                return null;
            listOfMaps = queryRunner.query(conn, "SELECT * FROM bbs_regQuestion WHERE reg_id=?", new MapListHandler(), arr[0]);
            ArrayList<RegQuestionDTO> reqList = gson.fromJson(gson.toJson(listOfMaps),new TypeToken<List<RegQuestionDTO>>() {}.getType());
            int que_size = reqList.size();
            System.out.println(que_size);
            queryRunner.update(conn, "DELETE FROM bbs_reg_answer WHERE reg_id=? AND writer_id=?;", arr[0], arr[4]);
            listOfMaps = queryRunner.query(conn, "SELECT * FROM bbs_reg_answerFile WHERE reg_id=? AND writer_id=?;",
                    new MapListHandler(), arr[0], arr[4]);
            ArrayList<RegAnswerFileDTO> files = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<RegAnswerFileDTO>>() {}.getType());
//            for (int j = 0; j < files.size(); ++j){
            for (int i = 0; i < que_size; i++) {
                if(reqList.get(i).question_type == 5){
                    String folder = arr[5]+"\\Q"+(i+1);
                    for (int j = 0; j < files.size(); ++j){
                        RegAnswerFileDTO it = files.get(j);
                        File deleteFile = new File(folder, it.real_FileName);
                        deleteFile.delete();
                        queryRunner.update(conn, "DELETE FROM bbs_reg_answerFile WHERE reg_id=? AND writer_id=?;", arr[0], arr[4]);
                    }
                }
            }
            queryRunner.update(conn, "UPDATE bbs_reg SET `applicant_count`=`applicant_count`-1 WHERE `id` = ?;", arr[0]);
        } catch (SQLException e) {
            e.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String deleteReg(String data) {
        String arr[] = data.split("-/-/-"); // id+writer_id
        String id = arr[0];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM `bbs_reg` WHERE `id`=?;", id);
            queryRunner.update(conn,"DELETE FROM `bbs_reg_answer` WHERE `reg_id`=?;", id);
            queryRunner.update(conn,"DELETE FROM `bbs_regQuestion` WHERE `reg_id`=?;", id);
            queryRunner.update(conn,"DELETE FROM `bbs_reg_answerFile` WHERE `reg_id`=?;", id);
            queryRunner.update(conn,"DELETE FROM `bbs_reg_writerFile` WHERE `reg_id`=?;", id);
            //파일 삭제 추가
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    private String getRemoveHtmlText(String content) {
        if(content == null)
            return null;
        Pattern SCRIPTS = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>", Pattern.DOTALL);
        Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>", Pattern.DOTALL);
        //Pattern TAGS = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");
        //Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");
        Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
        Pattern WHITESPACE = Pattern.compile("\\s\\s+");
        Pattern WHITE = Pattern.compile("<!--");
        Pattern ON = Pattern.compile("(on)+[a-z]*=");

        Matcher m;

        m = SCRIPTS.matcher(content);
        content = m.replaceAll("");
        m = STYLE.matcher(content);
        content = m.replaceAll("");
        m = ENTITY_REFS.matcher(content);
        content = m.replaceAll("");
        m = WHITESPACE.matcher(content);
        content = m.replaceAll(" ");
        m = WHITE.matcher(content);
        content = m.replaceAll("");
        m = ON.matcher(content);
        content = m.replaceAll("");
        return content;
    }

    public ArrayList<RegWriterFileDTO> getRegFiles(String id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM bbs_reg_WriterFile WHERE reg_id = ? ORDER BY id DESC;", new MapListHandler(), id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<RegWriterFileDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<RegWriterFileDTO>>() {}.getType());
        return selected;
    }

    public String insertRegFile(ArrayList<UploadedFileDTO> files, String reg_id) {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            for(UploadedFileDTO ud : files){
                queryRunner.update(conn, "INSERT `bbs_reg_WriterFile` SET id=?, reg_id=?, original_FileName=?, real_FileName=?",
                        ud.id, reg_id, ud.uploadFile, ud.newFileName);
            }
        } catch (SQLException se) {
            se.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String deleteAlreadyFile(String data) {
        String arr[] = data.split("-/-/-"); // 0 data 1 id 2 type.type_name
        List<Map<String, Object>> listOfMaps = null;
        List<Map<String, Object>> listOfMaps2 = null;
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM bbs_reg_WriterFile WHERE id=?;", new MapListHandler(),
                    arr[0]);
            ArrayList<RegWriterFileDTO> lists = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<RegWriterFileDTO>>() {
                    }.getType());
            RegWriterFileDTO it = lists.get(0);
            listOfMaps2 = queryRunner.query(conn, "SELECT * FROM bbs_reg WHERE id=?;", new MapListHandler(), it.reg_id);
            ArrayList<RegisterDTO> lists2 = gson.fromJson(gson.toJson(listOfMaps2),
                    new TypeToken<List<RegisterDTO>>() {
                    }.getType());
            RegisterDTO reg = lists2.get(0);
            if (!reg.writer_id.equals(arr[1]) && !arr[2].equals("관리자"))
                return "fail";
            queryRunner.update(conn, "DELETE FROM bbs_reg_WriterFile WHERE id=?;", arr[0]);
        } catch (SQLException se) {
            se.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String insertAnswerFile(String data) {
        String arr[] = data.split("-/-/-");// reg_id + '-/-/-' + user_id + '-/-/-' + 업로드한 파일 수만큼 fileId+'-/-/-'
        Connection conn = Config.getInstance().sqlLogin();
        boolean result = false;
        List<Map<String, Object>> listOfMaps = null;
        Gson gson = new Gson();
        try {
            QueryRunner queryRunner = new QueryRunner();
            System.out.println(arr.length);
            for (int i = 2; i < arr.length; i++) {
                listOfMaps = queryRunner.query(conn, "SELECT * FROM bbs_reg_answerFile WHERE reg_id=? AND id=?;",
                        new MapListHandler(), arr[0], arr[i]);
                ArrayList<RegAnswerFileDTO> lists = gson.fromJson(gson.toJson(listOfMaps),
                        new TypeToken<List<RegAnswerFileDTO>>() {
                        }.getType());
                if(!listOfMaps.isEmpty())
                    continue;
                UploadedFileDTO file = FileDAO.getInstance().getFile(arr[i]);
                queryRunner.update(conn,
                        "INSERT INTO bbs_reg_answerFile(id, reg_id, original_FileName, real_FileName, writer_id) VALUES(?,?,?,?,?);",
                        arr[i], arr[0], file.uploadFile, file.newFileName, arr[1]);
            }
            result = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        if (result)
            return "success";
        else
            return "fail";
    }

    public String modifyAnswerFile(String data) {
        String arr[] = data.split("-/-/-");// reg_id + '-/-/-' + user_id + '-/-/-' + 업로드한 파일 수만큼 fileId+'-/-/-'
        Connection conn = Config.getInstance().sqlLogin();
        boolean result = false;
        try {
            QueryRunner queryRunner = new QueryRunner();
            System.out.println("123");
            queryRunner.update(conn, "DELETE FROM `bbs_reg_answerFile` WHERE `reg_id`=? AND `writer_id`=?;" ,arr[0], arr[1]);
            System.out.println(arr.length);
            for (int i = 2; i < arr.length; i++) {
                System.out.println("1"+arr[i]);
                if(arr[1].equals("undefined"))
                    continue;
                UploadedFileDTO file = FileDAO.getInstance().getFile(arr[i]);
                queryRunner.update(conn,
                        "INSERT INTO bbs_reg_answerFile(id, reg_id, original_FileName, real_FileName, writer_id) VALUES(?,?,?,?,?);",
                        arr[i], arr[0], file.uploadFile, file.newFileName, arr[1]);
            }
            result = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        if (result)
            return "success";
        else
            return "fail";
    }

    public ArrayList<RegAnswerDTO> getAnswerList(String id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM bbs_reg_answer WHERE reg_id=? ORDER BY writer_id DESC;", new MapListHandler(), id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<RegAnswerDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<RegAnswerDTO>>() {}.getType());
        return selected;
    }

    public ArrayList<RegisterDTO> getBoardsWhatIDone(String id) {
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        ArrayList<RegisterDTO> lists = new ArrayList<>();
        Gson gson = new Gson();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT DISTINCT reg_id FROM bbs_reg_answer WHERE writer_id=?", new MapListHandler(), id);
            ArrayList<RegAnswerDTO> answers = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<RegAnswerDTO>>() {}.getType());
            for(int i = 0 ; i < answers.size() ; ++i) {
                RegisterDTO thing = getRegRead(answers.get(i).reg_id);
                lists.add(thing);
            }
        }catch(SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return lists;
    }
}
