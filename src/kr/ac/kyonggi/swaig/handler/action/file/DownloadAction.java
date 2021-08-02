package kr.ac.kyonggi.swaig.handler.action.file;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.handler.dao.settings.FileDAO;
import kr.ac.kyonggi.swaig.handler.dto.settings.UploadedFileDTO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

public class DownloadAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();
        String id = request.getParameter("id");
//        System.out.println(id);
        String path =request.getParameter("path");
//        System.out.println(path);
        String root = request.getSession().getServletContext().getRealPath(path);

//        System.out.println(root);
        UserTypeDTO userType = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeDTO.class);
        UploadedFileDTO it = FileDAO.getInstance().getFile(id);
//        NoticeBoardsBean checkboard = NoticeBoardsDAO.getInstance().getBoardRead(it.board_id);
//        BoardLevelBean checkLevel = HomeDAO.getInstance().getBoardLevel(Integer.valueOf(checkboard.category));
//        if(checkLevel.file_download_level < userType.board_level) // 허용되지 않는 오류
//            return null;
        String savePath = root;
        // 서버에 실제 저장된 파일명
        String filename = it.newFileName;

        // 실제 내보낼 파일명
        String orgfilename = it.uploadFile;

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
            response.setHeader("Content-Description", "JSP Generated Data");

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

        return null;
    }

}
