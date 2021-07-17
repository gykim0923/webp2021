package kr.ac.kyonggi.swaig.handler.action.file;

import kr.ac.kyonggi.swaig.common.controller.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ImageViewerAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String path = request.getParameter("image_path");
        request.setAttribute("image", path);
        return "RequestDispatcher:jsp/main/imageViewer.jsp";
    }
}
