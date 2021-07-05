package kr.ac.kyonggi.swaig.handler.dto.settings;

public class MenuDTO {
//	public String path;
//	public String page_title;
//	public int tab_id;
//	public boolean show_in_menus;
//	public int max_level,min_level;
//	public int orderNum;
//	public int id;
//	public String getPath() {
//		return path;
//	}
//	public void setPath(String path) {
//		this.path = path;
//	}
//	public String getPage_title() {
//		return page_title;
//	}
//	public void setPage_title(String page_title) {
//		this.page_title = page_title;
//	}
//	public int getTab_id() {
//		return tab_id;
//	}
//	public void setTab_id(int tab_id) {
//		this.tab_id = tab_id;
//	}
//	public boolean isShow_in_menus() {
//		return show_in_menus;
//	}
//	public void setShow_in_menus(boolean show_in_menus) {
//		this.show_in_menus = show_in_menus;
//	}
//	public int getMax_level() {
//		return max_level;
//	}
//	public void setMax_level(int max_level) {
//		this.max_level = max_level;
//	}
//	public int getMin_level() {
//		return min_level;
//	}
//	public void setMin_level(int min_level) {
//		this.min_level = min_level;
//	}
//	public int getOrderNum() {
//		return orderNum;
//	}
//	public void setOrderNum(int orderNum) {
//		this.orderNum = orderNum;
//	}
//	public int getId() {
//		return id;
//	}
//	public void setId(int id) {
//		this.id = id;
//	}
	private String page_id;
	private String page_path;
	private String page_title;
	private String tab_id;
	private String max_level;
	private String orderNum;
	private String min_level;

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

	public String getMax_level() {
		return max_level;
	}

	public void setMax_level(String max_level) {
		this.max_level = max_level;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getMin_level() {
		return min_level;
	}

	public void setMin_level(String min_level) {
		this.min_level = min_level;
	}
}
