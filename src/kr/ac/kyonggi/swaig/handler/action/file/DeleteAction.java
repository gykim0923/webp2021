package kr.ac.kyonggi.swaig.handler.action.file;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.handler.dao.settings.FileDAO;
import kr.ac.kyonggi.swaig.handler.dto.settings.UploadedFileDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class DeleteAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String fileID = request.getParameter("id");
        String folder = request.getParameter("folder");
        Gson gson = new Gson();
        FileDAO dao = FileDAO.getInstance();
        UploadedFileDTO it = dao.getFile(fileID);
        String path = request.getSession().getServletContext().getRealPath(folder);
        File deleteFile = new File(path, it.newFileName);
        deleteFile.delete();
        dao.deleteFileWithName(it.newFileName);
        return gson.toJson(null);
    }
}
