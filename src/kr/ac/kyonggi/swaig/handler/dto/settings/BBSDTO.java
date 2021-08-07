package kr.ac.kyonggi.swaig.handler.dto.settings;

public class BBSDTO {
    public String id;
    public String major;
    public String writer_id;
    public String writer_name;
    public String title;
    public String category;
    public String views;
    public String level;
    public String last_modified;
    public String text;
    public String comments_count;

    public String already_like;
    public String uploadedFiles;

    public String getAlready_like() {
        return already_like;
    }

    public void setAlready_like(String already_like) {
        this.already_like = already_like;
    }

    public String getUploadedFiles() {
        return uploadedFiles;
    }

    public void setUploadedFiles(String uploadedFiles) {
        this.uploadedFiles = uploadedFiles;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getWriter_id() {
        return writer_id;
    }

    public void setWriter_id(String writer_id) {
        this.writer_id = writer_id;
    }

    public String getWriter_name() {
        return writer_name;
    }

    public void setWriter_name(String writer_name) {
        this.writer_name = writer_name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getViews() {
        return views;
    }

    public void setViews(String views) {
        this.views = views;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getLast_modified() {
        return last_modified;
    }

    public void setLast_modified(String last_modified) {
        this.last_modified = last_modified;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getComments_count() {
        return comments_count;
    }

    public void setComments_count(String coments_count) {
        this.comments_count = coments_count;
    }
}
