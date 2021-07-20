/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package kr.ac.kyonggi.swaig.common.uploader;

import com.oreilly.servlet.MultipartRequest;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

//ckeditor
@WebServlet("/Uploader")
public class Uploader extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final int KEY_SIZE = 1024;

	public Uploader() {
		super();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			response.setContentType("text/html;charset=UTF-8");
			request.setCharacterEncoding("UTF-8");
			HttpSession session = request.getSession();
			if(session.getAttribute("user") != null)
			{
				/* request.getScheme()는 http 혹은 https 반환
				*  request.getServerName()는 localhost 반환
				*  request.getServerPort()는 서버가 사용중인 포트 반환 +
				*  request.getContextPath()는 JSP 페이지가 속한 웹 어플리케이션의 컨텍스트 경로 반환
				*/
				String contextPath = request.getScheme() + "://" + request.getServerName() + ":"
						+ request.getServerPort() + request.getContextPath() + "/img/uploadimg/"; //URI
				String sFunc = request.getParameter("CKEditorFuncNum"); // 성공여부 반환

				String data = request.getServletContext().getRealPath("/");
				String url = data+"img/uploadimg"; // 실제 저장될 파일 경로

				//폴더가 없다면 생성
				File dircheck = new File(url);
				if(!dircheck.exists()) {
					dircheck.mkdirs();
				}

				MultipartRequest multi = new MultipartRequest(request, url, Integer.MAX_VALUE, "UTF-8"); // 생성해주면 파일 자체의 업로드 됨
				String filename = multi.getOriginalFileName("upload");

				String check = filename.substring(filename.lastIndexOf(".")+1, filename.length());
				if(check.equals("jsp") || check.equals("php") || check.equals("js") || check.equals("css") || check.equals("xml")) {
					File deleteFile = new File(url, filename);
					deleteFile.delete();
					response.getWriter().println("<script type='text/javascript'>alert('올릴 수 없는 확장자입니다.');</script>");
					response.getWriter().flush(); 
					return;
				}
				SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss"); 
				long currentTime = System.currentTimeMillis(); 
				String newFileName =  simDf.format(new Date(currentTime))+"-"+filename;
				File oldFile = new File(url, filename);
				// 실제 저장될 파일 객체 생성
				File newFile = new File(url, newFileName);
				// 파일명 rename
				FileInputStream fin = null;
				FileOutputStream fout = null;
				byte[] buf = new byte[1024];
				int read = 0;
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
				// url이 서버에 전송 성공하면 뜨는 스크립트
				response.getWriter().println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction(" + sFunc + ", '"+ contextPath + newFileName + "', '완료');</script>");
				response.getWriter().flush();
			}
		} catch (Exception ex) {
			throw new ServletException(ex.getMessage(), ex);
		}
	}

	//클라이언트 요청시 호출되고 Request 객체와 Response 객체 호출해서 인자로 전달
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	public String getServletInfo() {
		return "Short description";
	}
}