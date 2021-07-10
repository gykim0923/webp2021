package kr.ac.kyonggi.swaig.handler.dto.user;

public class UserTypeDTO {
	public int board_level, p3_level, thesis_level, resv_level, blog_level, table_level;
	public String type_name,class_type,for_header;

	public int getBoard_level() {
		return board_level;
	}

	public void setBoard_level(int board_level) {
		this.board_level = board_level;
	}

	public int getP3_level() {
		return p3_level;
	}

	public void setP3_level(int p3_level) {
		this.p3_level = p3_level;
	}

	public int getThesis_level() {
		return thesis_level;
	}

	public void setThesis_level(int thesis_level) {
		this.thesis_level = thesis_level;
	}

	public int getResv_level() {
		return resv_level;
	}

	public void setResv_level(int resv_level) {
		this.resv_level = resv_level;
	}

	public int getBlog_level() {
		return blog_level;
	}

	public void setBlog_level(int blog_level) {
		this.blog_level = blog_level;
	}

	public int getTable_level() {
		return table_level;
	}

	public void setTable_level(int table_level) {
		this.table_level = table_level;
	}

	public String getType_name() {
		return type_name;
	}

	public void setType_name(String type_name) {
		this.type_name = type_name;
	}

	public String getClass_type() {
		return class_type;
	}

	public void setClass_type(String class_type) {
		this.class_type = class_type;
	}

	public String getFor_header() {
		return for_header;
	}

	public void setFor_header(String for_header) {
		this.for_header = for_header;
	}
}
