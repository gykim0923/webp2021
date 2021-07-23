package kr.ac.kyonggi.swaig.handler.action.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.user.UserDAO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;
import kr.ac.kyonggi.swaig.handler.excel.ExcelReader;
import kr.ac.kyonggi.swaig.handler.excel.ExcelWriter;

public class ExcelAction extends CustomAction {

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

      String writeorread=request.getParameter("writeorread");
      String type=request.getParameter("type");//user(엑셀이용)
      String data=request.getParameter("data");
      String address=request.getParameter("address");
      String result=null;
      
      UserDAO userdao = UserDAO.getInstance();
      Gson gson=new Gson();
      if(writeorread.equals("write")) {
         ExcelWriter ex = new ExcelWriter();
         
         UserTypeDTO type1 = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeDTO.class);
         if(type1.board_level>0)
            return null;
         String savePath = request.getServletContext().getRealPath("/uploadFile"); //저장경로

          //폴더가 없다면 생성
          File dircheck = new File(savePath);
          if(!dircheck.exists()) {
              dircheck.mkdirs();
          }

         String file_name = ex.xlsWriter(userdao.getAlluser(),savePath);
         
          String filename = file_name;// 서버에 실제 저장된 파일명
          String orgfilename = file_name; // 실제 내보낼 파일명
          InputStream in = null;
          OutputStream os = null;
          File file = null;
          boolean skip = false;
          String client = "";
       
          try{
              // 파일을 읽어 스트림에 담기
              try{
                  file = new File(savePath, filename);
                  in = new FileInputStream(file);
              }catch(FileNotFoundException fe){
                  skip = true;
              }
               
              client = request.getHeader("User-Agent");
              // 파일 다운로드 헤더 지정
              response.reset() ;
              response.setContentType("application/octet-stream");
              response.setHeader("Content-Description","JSP Generated Data");
       
       
              if(!skip){
                  // IE
                  if(client.indexOf("MSIE") != -1){
                      response.setHeader ("Content-Disposition", "attachment;filename="+new String(orgfilename.getBytes("KSC5601"),"ISO8859_1"));
                  }else{
                      // 한글 파일명 처리
                      orgfilename = new String(orgfilename.getBytes("utf-8"),"iso-8859-1");
       
                      response.setHeader("Content-Disposition", ("attachment; filename=\"" + orgfilename + "\""));
                      response.setHeader("Content-Type", "application/octet-stream;charset=utf-8");
                  } 
                   
                  response.setHeader ("Content-Length", ""+file.length());
             
                  os = response.getOutputStream();
                  byte b[] = new byte[(int)file.length()];
                  int leng = 0;
                   
                  while( (leng = in.read(b)) > 0 ){
                      os.write(b,0,leng);
                  }
              }
              in.close();
              os.close();
          }catch(Exception e){
            e.printStackTrace();
          }
          
          try {
             File deleteFile = new File(savePath, filename);
             deleteFile.delete();
          }catch(Exception e) {
             e.printStackTrace();
          }
          
         return null;
      
      }else {//read
          String xls = address.substring(address.lastIndexOf(".") + 1);
          if (xls.equals("xlsx")) {
              ExcelReader ex = new ExcelReader();
              if (data != null) {
                  result = gson.toJson(ex.xlsxUserReadermodify(data, address));
              } else
                  result = gson.toJson(ex.xlsxUserReader(address));
          } else {
              ExcelReader ex = new ExcelReader();
              if (data != null) {
                  result = gson.toJson(ex.xlsUserReadermodify(data, address));
              } else
                  result = gson.toJson(ex.xlsUserReader(address));
          }
      }
      return result;
   }

}