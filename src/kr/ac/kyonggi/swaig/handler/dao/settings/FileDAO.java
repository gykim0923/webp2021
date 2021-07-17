package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dao.tutorial.TutorialDAO;
import kr.ac.kyonggi.swaig.handler.dto.settings.UploadedFileDTO;
import kr.ac.kyonggi.swaig.handler.dto.tutorial.TutorialDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class FileDAO {

    public static FileDAO it;

    public static FileDAO getInstance() { //인스턴스 생성
        if (it == null)
            it = new FileDAO();
        return it;
    }


    public String insertFileUploadLog(String parameter) {
        System.out.println(parameter);
        String arr[]=parameter.split("-/-/-"); // String parameter = id+"-/-/-"+uploadFile+"-/-/-"+newFileName+"-/-/-"+upload_time+"-/-/-"+savePath+"-/-/-"+path;
        String user_id = arr[0];
        String uploadFile = arr[1];
        String newFileName = arr[2];
        String upload_time = arr[3];
        String savePath = arr[4];
        String path = arr[5];

        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.query(conn, "INSERT `uploadedFile` SET user_id=?, uploadFile=?, newFileName=?, upload_time=?, savePath=?, path=?", new MapListHandler(),
                    user_id, uploadFile, newFileName, upload_time, savePath, path);
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `uploadedFile` WHERE user_id=? AND newFileName=?", new MapListHandler(),
                    user_id, newFileName);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<UploadedFileDTO> result = null;
        result = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UploadedFileDTO>>() {
        }.getType());
        if(result.size()>0) {
            return result.get(0).getId();
        }
        else {
            return null;
        }


    }
}
