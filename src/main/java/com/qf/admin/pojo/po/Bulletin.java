package com.qf.admin.pojo.po;

public class Bulletin {

    private int id;
    private String bulletin;
    private String time;
    private String creater;
    private String status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBulletin() {
        return bulletin;
    }

    public void setBulletin(String bulletin) {
        this.bulletin = bulletin;
    }

    public String getTime() {
        return time.substring(0, time.length() - 2);
    }

    public String getCreater() {
        return creater;
    }

    public void setCreater(String creater) {
        this.creater = creater;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Bulletin{" +
                "id=" + id +
                ", bulletin='" + bulletin + '\'' +
                ", time='" + time + '\'' +
                ", creater='" + creater + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
