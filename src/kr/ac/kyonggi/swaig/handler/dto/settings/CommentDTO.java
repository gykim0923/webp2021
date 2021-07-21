package kr.ac.kyonggi.swaig.handler.dto.settings;

public class CommentDTO {
    String id, writer_id, writer_name, comment, comment_date, bbs_id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getComment_date() {
        return comment_date;
    }

    public void setComment_date(String comment_date) {
        this.comment_date = comment_date;
    }

    public String getBbs_id() {
        return bbs_id;
    }

    public void setBbs_id(String bbs_id) {
        this.bbs_id = bbs_id;
    }
}
