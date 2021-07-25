package kr.ac.kyonggi.swaig.handler.action;


import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.common.controller.Action;
import kr.ac.kyonggi.swaig.handler.dao.settings.*;
import kr.ac.kyonggi.swaig.handler.dao.tutorial.TutorialDAO;
import kr.ac.kyonggi.swaig.handler.dao.user.UserDAO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserDTO;
import kr.ac.kyonggi.swaig.handler.dto.user.UserTypeDTO;
import kr.ac.kyonggi.swaig.handler.excel.ExcelReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class AjaxAction implements Action {
    /**
     * DB를 JSP에서 JAVA로 보낼 때 사용하는 클래스입니다.
     * JSP의 ajax에서 정해준 req, data 값을 가지고 작업을 하게됩니다.
     * req는 필요한 case문을 찾아 들어가는데 사용하고
     * data는 DAO로 넘길 데이터를 의미합니다.
     * data의 경우에는 "일반적으로" JS가 여러 데이터 값을 한줄로 합쳐놓은 상태입니다.
     * 따라서 마지막으로 받는 메소드는 항상 split해줘야 하는지 고민해야 합니다.
     * */


    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();
        String req = request.getParameter("req"); //JSP에서 넘겨준 req
        HttpSession session = request.getSession(); //Session에 있는 정보로 뭔가 해야할 때 사용
        String data = request.getParameter("data"); //JSP에서 넘겨준 data
        UserDTO user = gson.fromJson((String)session.getAttribute("user"), UserDTO.class);
        UserTypeDTO type = gson.fromJson((String)session.getAttribute("type"), UserTypeDTO.class);
        String result=null;
        String address = null;
        switch(req) {
            case "deleteExampleData":   //테스트용
                result = TutorialDAO.getInstance().deleteExampleData(data); //삭제할 oid를 넘겨줍니다.
                break;
            case "addExampleData":
                result = TutorialDAO.getInstance().addExampleData(data); //추가할 데이터 정보를 넘겨줍니다.
                break;
            case "checkId":      //권한 확인 필요 없음(회원가입 중복아이디 체크)
                if (UserDAO.getInstance().checkID(data))
                    result = "";
                else
                    result = "dup";
                break;
            case "registerBig":
                String big[] = data.split("-/-/-");
                if (UserDAO.getInstance().checkID(big[0]))
                    result = UserDAO.getInstance().registerBigID(data);
                if (result.equals("success")) {
                    File log = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
                    BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(log, true));
                    bufferedWriter.write(new Date().toString() + "] 회원가입! " + "ID : " + big[0] + " 이름 :" + big[2]  + "\r\n");
                    bufferedWriter.close();
                } else
                    result = "fail";
                break;
            case "registerSmall":
                String small[] = data.split("-/-/-");
                if (UserDAO.getInstance().checkID(small[0]))
                    result = UserDAO.getInstance().registerSmallID(data);
                if (result.equals("success")) {
                    File log = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
                    BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(log, true));
                    bufferedWriter.write(new Date().toString() + "] 회원가입! " + "ID : " + small[0] + " 이름 :" + small[2]  + "\r\n");
                    bufferedWriter.close();
                } else
                    result = "fail";
                break;

            case "modifyText":
                if (type.board_level != 0)
                    return "fail";
                result = HomeDAO.getInstance().modifyText(data);
                break;

            case "deleteUser":
                String delete[] = data.split("-/-/-");
                if (type.board_level == 0 || delete[0].equals(user.id)){
                    result=UserDAO.getInstance().deleteUser(data);
                    break;
                }
                return "fail";
            case "modifyuserdata":
                String arr[] = data.split("-/-/-");//0:id 1:phone 2:birth 3:email
                if (!arr[0].equals(user.id))
                    return "fail";
                result = UserDAO.getInstance().modifydata(data);
                session.setAttribute("user", gson.toJson(UserDAO.getInstance().getUser(arr[0])));
                break;

            case "addMajor":
                if (type.board_level != 0){
                    return "fail";
                }
                result=AdminDAO.getInstance().addMajor(data);
                break;

            case "modifyMajor":
                if (type.board_level != 0){
                    return "fail";
                }
                result=AdminDAO.getInstance().modifyMajor(data);
                break;

            case "checkPassword":
                if (UserDAO.getInstance().checkPassword(data))
                    result = "true";
                else
                    result = "false";
                break;
            case "modifyPwd":
                String modifyPwd[] = data.split("-/-/-");
                if (modifyPwd[0].equals(user.id) || type.board_level == 0)
                    result = UserDAO.getInstance().modifypw(data);
                break;
            case "modifyProfessor":   //직접 권한 확인
                if (type.board_level == 0)
                    result = ProfessorDAO.getInstance().modifyProfessor(data);
                break;
            case "getOneProfessor":   //직접 권한 확인
                if (type.board_level == 0)
                    result = gson.toJson(ProfessorDAO.getInstance().getOneProfessor(data));
                break;
            case "insertProfessor":      //직접 권한 확인
                if (type.board_level == 0)
                    result =ProfessorDAO.getInstance().insertProfessor(data);
                break;
            case "deleteProfessor":      //직접 권한 확인
                if (type.board_level == 0)
                    result = ProfessorDAO.getInstance().deleteProfessor(data);
                break;

            case "addSchedule":
                if (type.board_level == 0)
                    result=AdminDAO.getInstance().addSchedule(data);
                break;
            case "modifySchedule":
                if (type.board_level == 0)
                    result=AdminDAO.getInstance().modifySchedule(data);
                break;
            case "updateSchedule":
                if (type.board_level == 0)
                    result=AdminDAO.getInstance().updateSchedule();
                break;
            case "deleteSchedule":
                if (type.board_level == 0)
                    result=AdminDAO.getInstance().deleteSchedule(data);
                break;
            case "modifyLoc":   //직접 권한 확인
                if (type.board_level == 0)
                    result = LocationDAO.getInstance().modifyLoc(data);
                break;
            case "addDeveloper":
                if (type.board_level == 0)
                    result=DeveloperDAO.getInstance().addDeveloper(data);
                break;
            case "insertSlider":
                if(type.board_level==0)
                    result=AdminDAO.getInstance().addSlider(data);
                break;
            case "modifyDeveloper":
                if (type.board_level == 0)
                    result=DeveloperDAO.getInstance().modifyDeveloper(data);
                break;
            case "deleteDeveloper":
                if (type.board_level == 0)
                    result=DeveloperDAO.getInstance().deleteDeveloper(data);
                break;
            case "modifyCurriculum":
                if(type.board_level==0)
                    result=CurriculumDAO.getInstance().modifyCurriculum(data);
                break;
            case "insertCurriculum":
                if(type.board_level==0)
                    result=CurriculumDAO.getInstance().insertCurriculum(data);
                break;
            case "deleteCurriculum":
                if(type.board_level==0)
                    result=CurriculumDAO.getInstance().deleteCurriculum(data);
                break;
            case "insertBbs":
                if(type.board_level==0)
                    result=BBSDAO.getInstance().insertBbs(data);
                break;
            case "modifyBbs":
                if(type.board_level==0)
                    result=BBSDAO.getInstance().modifyBbs(data);
                break;
            case "deleteBbs":
                if(type.board_level==0)
                    result=BBSDAO.getInstance().deleteBbs(data);
                break;
            case "insertComment":
                if(user!=null)
                    result=BBSDAO.getInstance().insertComment(data);
                break;
            case "likeBoard":
                data = data.concat("-/-/-" + user.id);
                result = BBSDAO.getInstance().likeBoards(data);
                break;
            case "deleteuser":
                if (type.board_level == 0) // 유저 삭제
                {
                    result = UserDAO.getInstance().deleteUser(data);
                    File log = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
                    BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(log, true));
                    bufferedWriter.write(new Date().toString() + "] 아이디 삭제! " + "ID : " + data + "\r\n");
                    bufferedWriter.close();
                }
                break;
            case "insertexceluser": // 엑셀 유저 추가
                if (type.board_level == 0) {
                    address = request.getParameter("address");
                    List<Map<String, Object>> insertmap = null;
                    String xls = address.substring(address.lastIndexOf(".") + 1);
                    if (xls.equals("xlsx"))
                        insertmap = new ExcelReader().xlsxUserReader(address);
                    else
                        insertmap = new ExcelReader().xlsUserReader(address);
                    result = UserDAO.getInstance().insertexceluser(insertmap);
                    String path = request.getSession().getServletContext().getRealPath("/") + "excel";
                    File deleteFile = new File(path, address);
                    deleteFile.delete();
                }
                break;
            case "modifyexceluser": // 엑셀 유저 수정
                if (type.board_level == 0) {
                    address = request.getParameter("address");
                    String xlsx = address.substring(address.lastIndexOf(".") + 1);
                    List<Map<String, Object>> modifymap = null;
                    if (xlsx.equals("xlsx"))
                        modifymap = new ExcelReader().xlsxUserReadermodify(data, address);
                    else
                        modifymap = new ExcelReader().xlsUserReadermodify(data, address);
                    result = UserDAO.getInstance().modifyexceluser(modifymap);
                    String path2 = request.getSession().getServletContext().getRealPath("/") + "excel";
                    File deleteFile2 = new File(path2, address);
                    deleteFile2.delete();
                }
                break;
        }

        return result;
    }
}