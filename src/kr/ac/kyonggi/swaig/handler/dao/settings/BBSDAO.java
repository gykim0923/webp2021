package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.BBSDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.BBSFileDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.CommentDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.TextDTO;
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

public class BBSDAO {
    public static BBSDAO it;

    public static BBSDAO getInstance() { //인스턴스 생성
        if (it == null)
            it = new BBSDAO();
        return it;
    }

    public ArrayList<BBSDTO> getAllBBSList(String [] numbers) {
        String sql = "SELECT * FROM bbs WHERE category=0";
        for (String number: numbers) {
            sql+=" OR category="+number;
        }
        sql+=" ORDER BY id DESC ;";
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,sql, new MapListHandler());
//            System.out.println(listOfMaps);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<BBSDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BBSDTO>>() {}.getType());
//        System.out.println(selected);
        if(selected.size()>0) {
            return selected;
        }
        else
            return null;
    }

    public ArrayList<BBSDTO> getBBSList(String num) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM bbs WHERE category=? ORDER BY id DESC ;", new MapListHandler(),num);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<BBSDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BBSDTO>>() {}.getType());
        if(selected.size()>0) {
            return selected;
        }
        else
            return null;
    }

    public ArrayList<BBSDTO> getMajorBBSList(String major, String num) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM bbs WHERE major=? AND category=? ORDER BY id DESC ;", new MapListHandler(), major,num);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<BBSDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BBSDTO>>() {}.getType());
        if(selected.size()>0) {
            return selected;
        }
        else
            return null;
    }


    public BBSDTO getBBS(String id) {

        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM bbs WHERE id=?;", new MapListHandler(),id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<BBSDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BBSDTO>>() {}.getType());
        if(selected.size()>0) {
            return selected.get(0);
        }
        else
            return null;
    }

    public String likeBoards(String data) {
        String arr[] = data.split("-/-/-");
        Connection conn = Config.getInstance().sqlLogin();
        try{
            BBSDTO checkBBS = getBBS(arr[0]);
            String isNew = "|" + arr[1] + "|";
            if(checkBBS.already_like.contains(isNew)) {
                return "already";
            }
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE bbs SET already_like = concat(already_like,?),likes = likes+1 WHERE id=?;", isNew, arr[0]);
        } catch(SQLException e) {
            e.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String insertBbs(String data) {
        String arr[] = data.split("-/-/-"); // major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+last_modified+"-/-/-"+text+"-/-/-"+uploadedFiles
        String major = arr[0];
        String writer_id = arr[1];
        String writer_name = arr[2];
        String title = arr[3];
        String category = arr[4];
        String last_modified = arr[5];
        String text = arr[6];
        String uploadedFiles = arr[7];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            System.out.println(data);
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO bbs(major, writer_id, writer_name, title, category, last_modified, text, uploadedFiles) VALUE(?,?,?,?,?,?,?,?);", major,writer_id,writer_name, title, category, last_modified, text, uploadedFiles);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String modifyBbs(String data) {
        String arr[] = data.split("-/-/-"); // id+"-/-/-"+major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+last_modified+"-/-/-"+text
        String id = arr[0];
        String major = arr[1];
        String writer_id = arr[2];
        String writer_name = arr[3];
        String title = arr[4];
        String category = arr[5];
        String last_modified = arr[6];
        String text = arr[7];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE bbs SET major=?, writer_id=?, writer_name=?, title=?, category=?, last_modified=?, text=? WHERE id=?;", major, writer_id, writer_name, title, category, last_modified, text, id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String deleteBbs(String data) {
        String arr[] = data.split("-/-/-"); // id+"-/-/-"+major+"-/-/-"+writer_id+"-/-/-"+writer_name+"-/-/-"+title+"-/-/-"+num+"-/-/-"+last_modified+"-/-/-"+text
        String id = arr[0];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM `bbs` WHERE `id`=?;", id);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }
    public String deleteComment(String data) {
        String id = data;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM `comment` WHERE `id`=?;", id);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String modifyComment(String data) {
        String arr[] = data.split("-/-/-"); // modifiedComment+'-/-/-'+commentId;
        String comment = arr[0];
        String commentDate = arr[1];
        String commentId = arr[2];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE comment SET comment=?, comment_date= ? WHERE id=?;",comment, commentDate,commentId);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }


    public String insertComment(String data) {
        String arr[] = data.split("-/-/-"); //user_id+"-/-/-"+user_name+"-/-/-"+comment+"-/-/-"+comment_date+"-/-/-"+id
        String writer_id = arr[0];
        String writer_name = arr[1];
        String comment = arr[2];
        String comment_date = arr[3];
        String id = arr[4];
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO comment(writer_id, writer_name, comment, comment_date, bbs_id) VALUE(?,?,?,?,?);", writer_id,writer_name,comment, comment_date, id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public ArrayList<CommentDTO> getCommentsList(String id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM comment WHERE bbs_id=? ORDER BY id ASC ;", new MapListHandler(),id);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<CommentDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<CommentDTO>>() {}.getType());
        if(selected.size()>0) {
            return selected;
        }
        else
            return null;
    }

    public void plusBoardView(String id) {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "UPDATE bbs SET views = views+1 WHERE id=?;", id);
        }catch (SQLException e) {
            e.printStackTrace();
        }finally {
            DbUtils.closeQuietly(conn);
        }
    }

// 추가
    public void insertFile(String id, String writer, String name, String link) {
        Connection conn=Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO notice_file(id, writer, filename, filelink) VALUE (?, ?, ?, ?);",id, writer, name, link);
        }
        catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
    }
    public void insertFileId(String writer, String id) {
        Connection conn=Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE notice_file SET `board_id`= ? WHERE `writer` = ? AND `board_id` = 0;",Integer.valueOf(id), writer);
        }
        catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
    }

    public ArrayList<BBSFileDTO> getFilesForDelete(String writer){
        ArrayList<BBSFileDTO> selectedList = null;
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_file WHERE writer=? AND board_id=0", new MapListHandler(), writer);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BBSFileDTO>>() {}.getType());
        return selectedList;
    }

    public void deleteFileWithName(String fileName) {
        Connection conn=Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "DELETE FROM notice_file WHERE filelink=?;", fileName);
        }
        catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
    }
    public ArrayList<BBSFileDTO> readFile(int id) {
        ArrayList<BBSFileDTO> selectedList = null;
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_file WHERE board_id=?", new MapListHandler(), id);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BBSFileDTO>>() {}.getType());
        return selectedList;
    }

    public BBSFileDTO getFile(String id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_file WHERE id=?", new MapListHandler(), id);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<BBSFileDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BBSFileDTO>>() {}.getType());
        if(selectedList.size() > 0)
            return selectedList.get(0);
        else
            return null;
    }

    public void deleteFile(String id) {
        Connection conn=Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "DELETE FROM notice_file WHERE board_id=?;", id);
        }
        catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
    }



    public String deleteAlreadyFile(String data) {
        String arr[] = data.split("-/-/-"); // 0 = file id 1= user id 2= user type name
        Connection conn=Config.getInstance().sqlLogin();
        BBSFileDTO file = getFile(arr[0]);
        if(!file.writer.equals(arr[1]) && !arr[2].equals("관리자")&&!arr[2].equals("홈페이지관리자"))
            return "error";
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "UPDATE notice_file SET board_id = -1 WHERE id=?;",arr[0]);
        }
        catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }

        return "success";
    }

    public String alreadyFileDone(String data) {
        String arr[] = data.split("-/-/-"); // 0 = board_id 1=writer_id
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE notice_file SET board_id = ? WHERE writer=? AND board_id=-1",arr[0], arr[1]);
        } catch (SQLException se) {
            se.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }

        return "success";
    }



    public ArrayList<BBSFileDTO> getFileBoardId(){
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT board_id FROM notice_file;", new MapListHandler());
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<BBSFileDTO> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BBSFileDTO>>() {}.getType());
        return lists;
    }


    public Object getDownloadList(String id) {
        return null;
    }
}
