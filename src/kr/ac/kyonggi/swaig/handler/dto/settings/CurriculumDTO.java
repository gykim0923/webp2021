package kr.ac.kyonggi.swaig.handler.dto.settings;

public class CurriculumDTO {
    String major;
    int year;
    String curriculum_img;
    String edu_img;

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getCurriculum_img() {
        return curriculum_img;
    }

    public void setCurriculum_img(String curriculum_img) {
        this.curriculum_img = curriculum_img;
    }

    public String getEdu_img() {
        return edu_img;
    }

    public void setEdu_img(String edu_img) {
        this.edu_img = edu_img;
    }
}
