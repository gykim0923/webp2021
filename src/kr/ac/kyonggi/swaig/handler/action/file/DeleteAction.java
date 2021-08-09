package kr.ac.kyonggi.swaig.handler.action.file;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.handler.dao.settings.FileDAO;
import kr.ac.kyonggi.swaig.handler.dto.settings.UploadedFileDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class DeleteAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String folder = request.getParameter("folder");
        String fileID = request.getParameter("fileId");
        Gson gson = new Gson();
        String path = request.getSession().getServletContext().getRealPath(folder);
        FileDAO dao = FileDAO.getInstance();
        UploadedFileDTO it = dao.getFile(fileID);
        System.out.println(it.newFileName);
        File deleteFile = new File(path, it.newFileName);
        deleteFile.delete();
        dao.deleteFileWithName(it.newFileName);
        return gson.toJson(null);
    }
}
