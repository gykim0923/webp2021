package kr.ac.kyonggi.swaig.handler.dao;

import kr.ac.kyonggi.swaig.handler.dao.settings.AdminDAO;

public interface DAO {

    void insertFile(String uploadFile, String newFileName);
}
