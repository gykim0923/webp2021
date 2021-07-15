package kr.ac.kyonggi.swaig.handler.dto.settings;

public class ClubDTO {
    public int id;
    public String club_name;
    public String club_content;
    public String club_address;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getClub_name() {
        return club_name;
    }

    public void setClub_name(String club_name) {
        this.club_name = club_name;
    }

    public String getClub_content() {
        return club_content;
    }

    public void setClub_content(String club_content) {
        this.club_content = club_content;
    }

    public String getClub_address() {
        return club_address;
    }

    public void setClub_address(String club_address) {
        this.club_address = club_address;
    }
}
