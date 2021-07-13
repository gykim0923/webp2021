package kr.ac.kyonggi.swaig.handler.dto.settings;

public class LaboratoryDTO {

    String id,lab_img, lab_name, lab_location, lab_homepage;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLab_img() {
        return lab_img;
    }

    public void setLab_img(String lab_img) {
        this.lab_img = lab_img;
    }

    public String getLab_name() {
        return lab_name;
    }

    public void setLab_name(String lab_name) {
        this.lab_name = lab_name;
    }

    public String getLab_location() {
        return lab_location;
    }

    public void setLab_location(String lab_location) {
        this.lab_location = lab_location;
    }

    public String getLab_homepage() {
        return lab_homepage;
    }

    public void setLab_homepage(String lab_homepage) {
        this.lab_homepage = lab_homepage;
    }
}
