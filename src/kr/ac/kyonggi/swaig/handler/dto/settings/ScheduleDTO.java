package kr.ac.kyonggi.swaig.handler.dto.settings;

import java.util.Date;

public class ScheduleDTO {
    public String id, content;
    public Date date;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDate() { return date; }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
