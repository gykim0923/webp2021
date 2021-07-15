package kr.ac.kyonggi.swaig.handler.dto.settings;

public class SliderDTO {
    String id, real_name, original_name, slider_title, slider_content;

    public String getId() {
        return id;
    }

    public String getSlider_title() {
        return slider_title;
    }

    public void setSlider_title(String slider_title) {
        this.slider_title = slider_title;
    }

    public String getSlider_content() {
        return slider_content;
    }

    public void setSlider_content(String slider_content) {
        this.slider_content = slider_content;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getReal_name() {
        return real_name;
    }

    public void setReal_name(String real_name) {
        this.real_name = real_name;
    }

    public String getOriginal_name() {
        return original_name;
    }

    public void setOriginal_name(String original_name) {
        this.original_name = original_name;
    }
}
