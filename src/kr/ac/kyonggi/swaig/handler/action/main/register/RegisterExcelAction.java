package kr.ac.kyonggi.swaig.handler.action.main.register;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.handler.dao.settings.RegisterDAO;
import kr.ac.kyonggi.swaig.handler.dto.settings.RegAnswerDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.RegQuestionDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.RegisterDTO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserDTO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;
import kr.ac.kyonggi.swaig.handler.excel.RegExcelWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;

public class RegisterExcelAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();
        UserTypeDTO type = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeDTO.class);
        if(type.type_name.equals("기타"))
            return "RequestDispatcher:jsp/main/error.jsp";
        String path = request.getServletContext().getRealPath("/uploadFile");
        String boardId = request.getParameter("id");
        RegisterDAO dao = RegisterDAO.getInstance();
        RegisterDTO checkReg = dao.getReg(boardId);
        UserDTO user= gson.fromJson((String) request.getSession().getAttribute("user"), UserDTO.class);
        String name = checkReg.title;
        ArrayList<RegQuestionDTO> questionCount = dao.getQuestions(boardId + "-/-/-" + type.for_header + "-/-/-" + user.id + "-/-/-" + type.board_level);
        if(type.board_level != 0 && !checkReg.writer_id.equals(user.id))
            return "RequestDispatcher:jsp/main/error.jsp";
        ArrayList<RegAnswerDTO> list = dao.getAnswerList(boardId);
        RegExcelWriter excel = new RegExcelWriter();
        excel.xlsWriter(list,questionCount,path);

        String savePath = path; //저장경로
        String filename = "신청관리.xls";// 서버에 실제 저장된 파일명
        String orgfilename = name +".xls"; // 실제 내보낼 파일명
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
    }
}
