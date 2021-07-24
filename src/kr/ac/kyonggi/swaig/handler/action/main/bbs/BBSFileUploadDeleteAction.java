//package kr.ac.kyonggi.swaig.handler.action.main.bbs;
//
//import com.google.gson.Gson;
//import kr.ac.kyonggi.swaig.common.controller.Action;
//import kr.ac.kyonggi.swaig.handler.dao.settings.BBSDAO;
//import kr.ac.kyonggi.swaig.handler.dto.settings.BBSFileDTO;
//import kr.ac.kyonggi.swaig.common.controller.CustomAction;
//
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.File;
//
//public class BBSFileUploadDeleteAction extends CustomAction {
//	@Override
//	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		super.execute(request,response);
//		String fileID = request.getParameter("id");
//		Gson gson = new Gson();
//		BBSDAO dao = BBSDAO.getInstance();
//		BBSFileDTO it = dao.getFile(fileID);
//		String path = request.getSession().getServletContext().getRealPath("/uploadFile/noticeBoards");
//		File deleteFile = new File(path, it.filelink);
//		deleteFile.delete();
//		dao.deleteFileWithName(it.filelink);
//		return gson.toJson(null);
//	}
//}
