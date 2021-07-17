package kr.ac.kyonggi.swaig.handler.dao.settings;

import kr.ac.kyonggi.swaig.handler.dao.tutorial.TutorialDAO;

public class FileDAO {

    public static FileDAO it;

    public static FileDAO getInstance() { //인스턴스 생성
        if (it == null)
            it = new FileDAO();
        return it;
    }


    public String insertFileUploadLog(String parameter) {
        System.out.println(parameter);
        return "0";
    }
}
