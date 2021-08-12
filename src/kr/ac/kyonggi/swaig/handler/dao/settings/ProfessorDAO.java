package kr.ac.kyonggi.swaig.handler.dao.settings;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.swaig.common.sql.Config;
import kr.ac.kyonggi.swaig.handler.dto.settings.ProfessorDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ProfessorDAO {
	public static ProfessorDAO it;
	
	public static ProfessorDAO getInstance() {
		if(it == null)
			it = new ProfessorDAO();
		return it;
	}
	
   public ArrayList<ProfessorDTO> getProfessor(String major) {
      List<Map<String, Object>> listOfMaps = null;
      Connection conn = Config.getInstance().sqlLogin();
      try {
         QueryRunner queryRunner = new QueryRunner();
         listOfMaps = queryRunner.query(conn,"SELECT * FROM professor WHERE prof_major=?;", new MapListHandler(), major);
      } catch(SQLException se) {
         se.printStackTrace();
      } finally {
         DbUtils.closeQuietly(conn);
      }
      
      
      Gson gson = new Gson();
      ArrayList<ProfessorDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ProfessorDTO>>() {}.getType());
      for(int i = 0; i < selected.size(); i++)
      {
      }
      return selected;
   }
//   public ProfessorDTO getOneProfessor(String data) {
//      List<Map<String, Object>> listOfMaps = null;
//      Connection conn = Config.getInstance().sqlLogin();
//      try {
//         QueryRunner queryRunner = new QueryRunner();
//         listOfMaps = queryRunner.query(conn,"SELECT * FROM professor WHERE id=?", new MapListHandler(), Integer.parseInt(data));
//      } catch(SQLException se) {
//         se.printStackTrace();
//      } finally {
//         DbUtils.closeQuietly(conn);
//      }
//      Gson gson = new Gson();
//      ArrayList<ProfessorDTO> results = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ProfessorDTO>>() {}.getType());
//      return results.get(0);
//   }
   public String modifyProfessor(String data) {
      String arr[]=data.split("-/-/-");//0=img 1=name 2=location  3=call 4=email 5:lecture 6:id 7:color
      Connection conn = Config.getInstance().sqlLogin();
      List<Map<String, Object>> listOfMaps = null;
      try {
         QueryRunner queryRunner = new QueryRunner();
         queryRunner.update(conn,"UPDATE professor SET prof_img=?, prof_name=?, prof_location=?, prof_call=?, prof_email=?, prof_lecture=?, prof_color=? WHERE id=?;",arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],arr[7],arr[6]);

         listOfMaps=queryRunner.query(conn,"SELECT * FROM professor WHERE id=?",new MapListHandler(),Integer.parseInt(arr[6]));

      } catch(SQLException se) {
         se.printStackTrace();
      } finally {
         DbUtils.closeQuietly(conn);
      }

      Gson gson = new Gson();
      ArrayList<ProfessorDTO> results = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ProfessorDTO>>() {}.getType());
      return gson.toJson(results.get(0));
   }
   
   public String deleteProfessor(String data) {
      Connection conn = Config.getInstance().sqlLogin();
      
      try {
         QueryRunner queryRunner = new QueryRunner();
         queryRunner.update(conn,"DELETE FROM professor WHERE id=?;", data);
      } catch(SQLException se) {
         se.printStackTrace();
      } finally {
         DbUtils.closeQuietly(conn);
      }
      return "";
   }

   public String insertProfessor(String data) {
      Connection conn = Config.getInstance().sqlLogin();
      String arr[]=data.split("-/-/-");//0=img 1=name 2=location  3=call 4=email 5:lecture 6: color 7: major

      List<Map<String, Object>> listOfMaps = null;
      try {
         QueryRunner queryRunner = new QueryRunner();
         if(arr[0]!=null) {
            queryRunner.update(conn, "INSERT INTO professor(prof_img,prof_name,prof_location,prof_call,prof_email,prof_lecture,prof_color,prof_major) VALUES(?,?,?,?,?,?,?,?);", arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7]);
         }
         else {
            queryRunner.update(conn, "INSERT INTO professor(prof_img,prof_name,prof_location,prof_call,prof_email,prof_lecture,prof_color,prof_major) VALUES('#',?,?,?,?,?,?,?);", arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7]);
         }
         //listOfMaps=queryRunner.query(conn,"SELECT * FROM professor WHERE prof_name=? and prof_call=?",new MapListHandler(),arr[0],arr[2]);
      } catch(SQLException se) {
         se.printStackTrace();
      } finally {
         DbUtils.closeQuietly(conn);
      }
      return "success";
   }
   public void modifyImage(int id, String img) {
	   Connection conn = Config.getInstance().sqlLogin();
	      try {
	         QueryRunner queryRunner = new QueryRunner();
	         queryRunner.update(conn,"UPDATE professor SET `prof_img` = ? WHERE `id`=?;", img, id);
	      } catch(SQLException se) {
	         se.printStackTrace();
	      } finally {
	         DbUtils.closeQuietly(conn);
	      }
   	}
}