package kr.ac.kyonggi.swaig.handler.action.file;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.handler.dao.DAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.AdminDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;
import kr.ac.kyonggi.swaig.handler.dao.tutorial.TutorialDAO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class UploadAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //30MB 제한
        int maxSize  = 1024*1024*30;

        String req = request.getParameter("req");
        System.out.println(req);
        String uploadedPage = request.getParameter("uploadedPage");
        DAO dao = null;

        // 웹서버 컨테이너 경로
        String folder="";
        switch (uploadedPage){
            case "admin_slider":
                dao = AdminDAO.getInstance();
                folder="/img/slider";
            default:
                dao = TutorialDAO.getInstance();
                folder="/img/slider";
        }


        String path = request.getSession().getServletContext().getRealPath(folder);
        //폴더가 없다면 생성
        File dircheck = new File(path);
        if(!dircheck.exists()) {
            dircheck.mkdirs();
        }

        // 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
        String savePath = path;

        // 업로드 파일명
        String uploadFile = "";

        // 실제 저장할 파일명
        String newFileName = "";

        int read = 0;
        byte[] buf = new byte[1024];
        FileInputStream fin = null;
        FileOutputStream fout = null;
        long currentTime = System.currentTimeMillis();
        SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss");
        Gson gson = new Gson();
        UserTypeDTO type = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeDTO.class);
        if(type.board_level != 0)
            return "fail";
//        HomeDAO dao = HomeDAO.getInstance();
        try{
            MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
            uploadFile = multi.getFilesystemName("file_data");
            String check = uploadFile.substring(uploadFile.lastIndexOf(".")+1,uploadFile.length());
            if(!check.equals("jpg") && !check.equals("jpeg") && !check.equals("png") && !check.equals("gif") && !check.equals("swf"))
                return null;
            newFileName = simDf.format(new Date(currentTime)) + "_" + uploadFile;
            // 업로드된 파일 객체 생성
            File oldFile = new File(savePath, uploadFile);

            // 실제 저장될 파일 객체 생성
            File newFile = new File(savePath, newFileName);



            // 파일명 rename
            if(!oldFile.renameTo(newFile)){

                // rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제

                buf = new byte[1024];
                fin = new FileInputStream(oldFile);
                fout = new FileOutputStream(newFile);
                read = 0;
                while((read=fin.read(buf,0,buf.length))!=-1){
                    fout.write(buf, 0, read);
                }


                fin.close();
                fout.close();
                oldFile.delete();
            }

            dao.insertFile(uploadFile, newFileName);

        }catch(Exception e){
            e.printStackTrace();
            return "fail";
        }
        return "success";
    }
}
