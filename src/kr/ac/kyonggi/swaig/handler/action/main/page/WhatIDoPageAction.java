package kr.ac.kyonggi.swaig.handler.action.main.page;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.CustomAction;
import kr.ac.kyonggi.swaig.handler.dao.settings.BBSDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;
import kr.ac.kyonggi.swaig.handler.dao.settings.RegisterDAO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WhatIDoPageAction extends CustomAction {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        UserDTO who = gson.fromJson((String)request.getSession().getAttribute("user"), UserDTO.class);
        HttpSession session = request.getSession();
        if(session.getAttribute("user") == null){
            request.setAttribute("error", "로그인이 필요한 메뉴입니다.");
            return "RequestDispatcher:jsp/main/error.jsp";
        }
        else{
            request.setAttribute("notice_notes", gson.toJson(BBSDAO.getInstance().getBoardsFromWho(who.id)));
            request.setAttribute("notice_comments", gson.toJson(BBSDAO.getInstance().getCommentsFromWho(who.id)));
            request.setAttribute("answers", gson.toJson(RegisterDAO.getInstance().getBoardsWhatIDone(who.id)));
            request.setAttribute("likeNotes", gson.toJson(BBSDAO.getInstance().getLikesFromWho(who.id)));
            request.setAttribute("jsp", gson.toJson("whatIDo")); //curriculum.jsp
            return "RequestDispatcher:jsp/page/page.jsp";
        }
    }
}
