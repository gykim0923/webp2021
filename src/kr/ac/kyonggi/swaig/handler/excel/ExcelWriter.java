package kr.ac.kyonggi.swaig.handler.excel;

import java.io.FileOutputStream;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import kr.ac.kyonggi.swaig.handler.dto.user.UserDTO;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


public class ExcelWriter {
   public String xlsWriter(ArrayList<UserDTO> arraylist, String path) throws IOException, NoSuchAlgorithmException {
       //DB조회후 데이터를 담았다는 가상의 데이터
       ArrayList<ArrayList<String>> array=new ArrayList<>();
       for(int i=0;i<arraylist.size();i++) {
           UserDTO user = arraylist.get(i);
          if(user.type.equals("관리자")) {
             continue;
          }

          ArrayList<String> a = new ArrayList<>();
          a.add(user.id);
          a.add(user.name);
          a.add(user.birth);
          a.add(user.type);
          a.add(user.email);
          a.add(user.phone);
          a.add(user.major);
          a.add(user.sub_major);
          a.add(user.per_id);
          a.add(user.grade);
          a.add(user.state);
          array.add(a);
       }


       //1차로 workbook을 생성
       HSSFWorkbook workbook=new HSSFWorkbook();
       //2차는 sheet생성
       HSSFSheet sheet=workbook.createSheet("등록 현황");
       //엑셀의 행
       HSSFRow row=null;
       //엑셀의 셀
       HSSFCell cell=null;
       //임의의 DB데이터 조회
       row=sheet.createRow(0);
       String header[]= {"ID","이름","생일","타입","이메일","휴대폰","전공","부전공","학번","학년","학적상태"};
       for(int k=0;k<header.length;k++) {
         cell=row.createCell(k);
         cell.setCellValue(header[k]);
      }

       if(array !=null &&array.size() >0){
           for(int i=0;i<array.size();i++){
              ArrayList<String> user = array.get(i);
               row=sheet.createRow((short)i+1);
               if(user !=null &&user.size() >0){
                   for(int j=0;j<user.size();j++){
                       //생성된 row에 컬럼을 생성한다
                       cell=row.createCell(j);
                       //map에 담긴 데이터를 가져와 cell에 add한다
                       cell.setCellValue(user.get(j));

                   }
               }
           }
       }
       FileOutputStream fileoutputstream=new FileOutputStream(path+"/k-with회원관리.xls");
       //파일을 쓴다
       workbook.write(fileoutputstream);
       //필수로 닫아주어야함
       fileoutputstream.close();
       return "회원관리.xls";

    }

    public String xlsxWriter(ArrayList<UserDTO> arraylist) throws IOException, NoSuchAlgorithmException {
       //DB조회후 데이터를 담았다는 가상의 데이터
       ArrayList<ArrayList<String>> array=new ArrayList<>();
       for(int i=0;i<arraylist.size();i++) {
           UserDTO user = arraylist.get(i);
          if(user.type.equals("관리자")) {
             continue;
          }
          ArrayList<String> a = new ArrayList<>();
          a.add(user.id);
          a.add(user.name);
          a.add(user.birth);
          a.add(user.type);
          a.add(user.email);
          a.add(user.phone);
          a.add(user.major);
          a.add(user.per_id);
          a.add(user.sub_major);
          a.add(user.grade);
          a.add(user.state);

          array.add(a);
       }


       //1차로 workbook을 생성
       XSSFWorkbook workbook=new XSSFWorkbook();
       //2차는 sheet생성
       XSSFSheet sheet=workbook.createSheet("등록 현황");
       //엑셀의 행
       XSSFRow row=null;
       //엑셀의 셀
       XSSFCell cell=null;
       //임의의 DB데이터 조회
       row=sheet.createRow(0);
       String header[]= {"ID","이름","생일","타입","이메일","휴대폰","전공","부전공","학번","학년","학적상태"};
       for(int k=0;k<header.length;k++) {
         cell=row.createCell(k);
         cell.setCellValue(header[k]);
      }

       if(array !=null &&array.size() >0){
           for(int i=0;i<array.size();i++){
              ArrayList<String> user = array.get(i);
               row=sheet.createRow((short)i+1);
               if(user !=null &&user.size() >0){
                   for(int j=0;j<user.size();j++){
                       //생성된 row에 컬럼을 생성한다
                       cell=row.createCell(j);
                       //map에 담긴 데이터를 가져와 cell에 add한다
                       cell.setCellValue(user.get(j));

                   }
               }
           }
       }
       FileOutputStream fileoutputstream=new FileOutputStream("D:\\회원관리.xls");
       //파일을 쓴다
       workbook.write(fileoutputstream);
       //필수로 닫아주어야함
       fileoutputstream.close();
       return Integer.toString(array.size())+"명의 Excel이 생성되었습니다.";

    }

}
