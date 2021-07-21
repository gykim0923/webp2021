package kr.ac.kyonggi.swaig.handler.dto.settings;

public class MajorDTO {
    public String oid, major_id, major_name, major_location, major_contact;

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }

    public String getMajor_id() {
        return major_id;
    }

    public void setMajor_id(String major_id) {
        this.major_id = major_id;
    }

    public String getMajor_name() {
        return major_name;
    }

    public void setMajor_name(String major_name) {
        this.major_name = major_name;
    }

    public String getMajor_location() {
        return major_location;
    }

    public void setMajor_location(String major_location) {
        this.major_location = major_location;
    }

    public String getMajor_contact() {
        return major_contact;
    }

    public void setMajor_contact(String major_contact) {
        this.major_contact = major_contact;
    }
}
