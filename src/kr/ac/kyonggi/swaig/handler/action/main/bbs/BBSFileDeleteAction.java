//package kr.ac.kyonggi.swaig.handler.action.main.bbs;
//
//
//import kr.ac.kyonggi.swaig.handler.dto.settings.BBSFileDTO;
//import kr.ac.kyonggi.swaig.common.controller.CustomAction;
//import kr.ac.kyonggi.swaig.handler.dao.settings.BBSDAO;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.File;
//import java.util.ArrayList;
//
//public class BBSFileDeleteAction extends CustomAction {
//	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		String writer = request.getParameter("data");
//		BBSDAO dao = BBSDAO.getInstance();
//		ArrayList<BBSFileDTO> list = dao.getFilesForDelete(writer);
//		String path = request.getSession().getServletContext().getRealPath("/uploadFile/noticeBoards");
//
//		try {
//			for(int i = 0 ; i < list.size() ; ++i) {
//				String fileName = list.get(i).filelink;
//				File deleteFile = new File(path,fileName);
//				deleteFile.delete();
//				dao.deleteFileWithName(fileName);
//			}
//		}catch(Exception e) {
//			e.printStackTrace();
//			return "fail";
//		}
//		return "success";
//	}
//
//}
