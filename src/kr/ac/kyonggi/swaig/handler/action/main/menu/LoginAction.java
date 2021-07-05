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

public class LoginAction implements Action{

   /*
   1. id가 존재하는지 검사.
   2. pw가 일치하는지 검사.
   3. 1번과 2번이 일치하는 경우 현재 url을 기준으로 2가지 방향 (cs와 ai)으로 나눔.
   4. cs의 경우에는 로그인 정상적으로 시켜줌.
   5. ai의 경우에는 ai 권한이 있어야 로그인 가능.
   6. 실패하면 다시 login페이지로
    */

   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      LoginManager manager = LoginManager.getInstance();
      String id = request.getParameter("id");
      String password = request.getParameter("password_hash");
      UserDAO dao = UserDAO.getInstance();
      UserDTO it = dao.getUser(id);
      HttpSession session = request.getSession();
      Gson gson = new Gson();
      Boolean managerLevel=false;

      if(it != null) { //id 존재시 특정 신분의 유저에게는 managerLevel을 True로 줌. (양쪽 사이트에서 로그인이 가능하게.)
         if (it.type.equals("관리자") || it.type.equals("홈페이지관리자") || it.type.equals("교수1") || it.type.equals("조교") || it.type.equals("졸업논문관리자") || it.type.equals("교수2"))
            managerLevel = true;
         else { //일반 학생들
            managerLevel = false;
         }
      }
      session.setAttribute("Access", 0); //회원 정보는 일치하나, 권한이 없는 사이트로 로그인 시 보낼 신호 ( 0 = 정상 / 1 = 실패 ).

      if(it!=null) { //id 존재시
         if (it.password.equals(password)) { //로그인 성공시 (비밀번호 일치 시)

            StringBuffer url_Login = request.getRequestURL();

            //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가

            if (url_Login.substring(7, 9).equals("cs") || url_Login.substring(7, 9).equals("lo")) {//url이 cs.kyonggi.ac.kr인 경우
               if (managerLevel || ai_user==null) { //cs.kyonggi.ac.kr에서 ai권한이 없는 사람이 로그인 했을 때
                  if (manager.isUsing(id)) {
                     manager.removeSession(id);
                  }
                  manager.setSession(request.getSession(), id);
                  UserTypeDTO type = dao.getType(it.type);
                  String path = "kr.ac.kyonggi.cs.handler.vo.user." + type.class_type;
                  Class<?> t = Class.forName(path);
                  UserDTO who = (UserDTO) t.newInstance();
                  if (who.getClass().getName().equals("kr.ac.kyonggi.cs.handler.vo.user.BigUser"))
                     copy2(who, it);
                  else
                     copy1(who, it);
                  dao.whoIsLogIn(id);
                  File log = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
                  BufferedWriter bufWriter = new BufferedWriter(new FileWriter(log, true));
                  bufWriter.write(new Date().toString() + "] " + it.id + "(" + it.name + ")이 로그인하였습니다.\r\n");
                  bufWriter.close();
                  session.setAttribute("user", gson.toJson(who));
                  session.setAttribute("type", gson.toJson(type));
                  session.setAttribute("miss", 0);
                  return "RequestDispatcher:jsp/main/main.jsp";
               }
               else {  //cs.kyonggi.ac.kr에서 ai권한을 가진 사람이 로그인 했을 때
                  session.setAttribute("Access", 2); //회원 정보는 일치하나, 권한이 없는 사이트로 로그인 시 보낼 신호 ( 0 = 정상 ).
                  return "RequestDispatcher:jsp/main/login.jsp";
               }
            }
         }
      }
      session.setAttribute("miss",(Integer)session.getAttribute("miss")+1); //잘못된 정보로 인한 로그인 실패시 (id가 없거나 pw가 틀리거나)
      return "RequestDispatcher:jsp/main/login.jsp"; //잘못된 정보로 인한 로그인 실패시 (id가 없거나 pw가 틀리거나)
   }


   void copy1(UserDTO it, UserDTO copy) {
      it.id = copy.id;
      it.name = copy.name;
      it.gender = copy.gender;
      it.birth = copy.birth;
      it.email = copy.email;
      it.phone = copy.phone;
      it.type = copy.type;
      it.reg_date = copy.reg_date;
      it.myhomeid = copy.myhomeid;
   }

   void copy2(UserDTO who, UserDTO it) {
      who.id = it.id;
      who.name = it.name;
      who.gender = it.gender;
      who.birth = it.birth;
      who.email = it.email;
      who.phone = it.phone;
      who.type = it.type;
      who.reg_date = it.reg_date;
      who.major = it.major;
      who.per_id = it.per_id;
      who.grade = it.grade;
      who.state = it.state;
      who.myhomeid = it.myhomeid;
   }

}