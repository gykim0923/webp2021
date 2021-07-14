package kr.ac.kyonggi.swaig.handler.dto.settings;

public class ClubDTO {
    public int id;
    public String clubname;
    public String clubcontent;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getClubname() {
        return clubname;
    }

    public void setClubname(String clubname) {
        this.clubname = clubname;
    }

    public String getClubcontent() {
        return clubcontent;
    }

    public void setClubcontent(String clubcontent) {
        this.clubcontent = clubcontent;
    }

    public String getClubaddr() {
        return clubaddr;
    }

    public void setClubaddr(String clubaddr) {
        this.clubaddr = clubaddr;
    }

    public String clubaddr;
}
