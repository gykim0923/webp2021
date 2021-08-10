package kr.ac.kyonggi.swaig.handler.dto.settings;

public class RegAnswerDTO {
    public int id, question_num;
    public String answer, writer_name, writer_id, writer_grade, writer_type, writer_perId;

    public String getReg_id() {
        return reg_id;
    }

    public void setReg_id(String reg_id) {
        this.reg_id = reg_id;
    }

    public String reg_id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuestion_num() {
        return question_num;
    }

    public void setQuestion_num(int question_num) {
        this.question_num = question_num;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getWriter_name() {
        return writer_name;
    }

    public void setWriter_name(String writer_name) {
        this.writer_name = writer_name;
    }

    public String getWriter_id() {
        return writer_id;
    }

    public void setWriter_id(String writer_id) {
        this.writer_id = writer_id;
    }

    public String getWriter_grade() {
        return writer_grade;
    }

    public void setWriter_grade(String writer_grade) {
        this.writer_grade = writer_grade;
    }

    public String getWriter_type() {
        return writer_type;
    }

    public void setWriter_type(String writer_type) {
        this.writer_type = writer_type;
    }

    public String getWriter_perId() {
        return writer_perId;
    }

    public void setWriter_perId(String writer_perId) {
        this.writer_perId = writer_perId;
    }
}
