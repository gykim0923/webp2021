package kr.ac.kyonggi.swaig.handler.dto.settings;

public class MenuDTO {
    public String page_id;
    public String id;

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }

    public String orderNum;
    public String page_path;
    private String page_title;
    public String tab_id;

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String path;

    public String getPage_id() {
        return page_id;
    }

    public void setPage_id(String page_id) {
        this.page_id = page_id;
    }

    public String getPage_path() {
        return page_path;
    }

    public void setPage_path(String page_path) {
        this.page_path = page_path;
    }

    public String getPage_title() {
        return page_title;
    }

    public void setPage_title(String page_title) {
        this.page_title = page_title;
    }

    public String getTab_id() {
        return tab_id;
    }

    public void setTab_id(String tab_id) {
        this.tab_id = tab_id;
    }

}
