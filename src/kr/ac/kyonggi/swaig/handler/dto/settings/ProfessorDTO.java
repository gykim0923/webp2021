package kr.ac.kyonggi.swaig.handler.dto.settings;

public class ProfessorDTO {
    public int id;

    public String prof_major;

    public String getProf_major() {
        return prof_major;
    }

    public void setProf_major(String prof_major) {
        this.prof_major = prof_major;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProf_img() {
        return prof_img;
    }

    public void setProf_img(String prof_img) {
        this.prof_img = prof_img;
    }

    public String getProf_name() {
        return prof_name;
    }

    public void setProf_name(String prof_name) {
        this.prof_name = prof_name;
    }

    public String getProf_email() {
        return prof_email;
    }

    public void setProf_email(String prof_email) {
        this.prof_email = prof_email;
    }

    public String getProf_lecture() {
        return prof_lecture;
    }

    public void setProf_lecture(String prof_lecture) {
        this.prof_lecture = prof_lecture;
    }

    public String getProf_location() {
        return prof_location;
    }

    public void setProf_location(String prof_location) {
        this.prof_location = prof_location;
    }

    public String getProf_call() {
        return prof_call;
    }

    public void setProf_call(String prof_call) {
        this.prof_call = prof_call;
    }

    public String prof_img,prof_name,prof_email,prof_lecture,prof_location,prof_call;

    public String prof_color;

    public String getProf_color() {
        return prof_color;
    }

    public void setProf_color(String prof_color) {
        this.prof_color = prof_color;
    }
}
