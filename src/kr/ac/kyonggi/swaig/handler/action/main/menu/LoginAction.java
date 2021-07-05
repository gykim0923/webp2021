package kr.ac.kyonggi.swaig.handler.action.main.menu;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.common.controller.LoginManager;
import kr.ac.kyonggi.swaig.handler.dao.user.UserDAO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserDTO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;

public class LoginAction implements Action {


   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      LoginManager manager = LoginManager.getInstance();
      String id = request.getParameter("id");
      String password = request.getParameter("password_hash");
      UserDAO dao = UserDAO.getInstance();
      UserDTO it = dao.getUser(id); //id에 따른 유저 정보를 일단 받아옴. (아이디가 일치하지 않으면 null을 갖게됨)
      HttpSession session = request.getSession();
      Gson gson = new Gson();
      if(it!=null) { //조회한 id가 존재한다면
         if (it.password.equals(password)) { //조회한 id의 비밀번호가 입력한 비밀번호와 일치한다면
            if (manager.isUsing(id)) { //접속중이라면
               manager.removeSession(id); //접속중인 세션 제거
            }
            System.out.println("로그인 성공");
            manager.setSession(request.getSession(), id); //세션 설정하기
            UserTypeDTO type = dao.getType(it.type);
//            String path = "kr.ac.kyonggi.cs.handler.vo.user."+ type.class_type;
//            Class<?> t = Class.forName(path);
//            UserDTO who = (UserDTO)t.newInstance();
//            if(who.getClass().getName().equals("kr.ac.kyonggi.cs.handler.vo.user.BigUser"))
//               copy2(who,it);
//            else
//               copy1(who, it);
            dao.whoIsLogIn(id);
            File log = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
            BufferedWriter bufWriter = new BufferedWriter(new FileWriter(log, true));
            bufWriter.write(new Date().toString() + "] " + it.id + "(" + it.name + ")이 로그인하였습니다.\r\n");
            bufWriter.close();
            session.setAttribute("user", gson.toJson(it));
            session.setAttribute("type", gson.toJson(type));
            session.setAttribute("miss", 0);
            return "RequestDispatcher:jsp/main/main.jsp";
         }
      }
      System.out.println("로그인 실패");
      session.setAttribute("miss",(Integer)session.getAttribute("miss")+1);
      return "RequestDispatcher:jsp/main/login.jsp";
   }

//
//   void copy1(UserBean it, UserBean copy) {
//      it.id = copy.id;
//      it.name = copy.name;
//      it.gender = copy.gender;
//      it.birth = copy.birth;
//      it.email = copy.email;
//      it.phone = copy.phone;
//      it.type = copy.type;
//      it.reg_date = copy.reg_date;
//      it.myhomeid = copy.myhomeid;
//   }
//
//   void copy2(UserBean who, UserBean it) {
//      who.id = it.id;
//      who.name = it.name;
//      who.gender = it.gender;
//      who.birth = it.birth;
//      who.email = it.email;
//      who.phone = it.phone;
//      who.type = it.type;
//      who.reg_date = it.reg_date;
//      who.major = it.major;
//      who.per_id = it.per_id;
//      who.grade = it.grade;
//      who.state = it.state;
//      who.myhomeid = it.myhomeid;
//
//   }

}