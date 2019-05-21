package com.qf.admin.pojo.vo;

public class IpColor {

    private String ip;
    private String color;
    private String departid;
    private String departname;

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getDepartid() {
        return departid;
    }

    public void setDepartid(String departid) {
        this.departid = departid;
    }

    public String getDepartname() {
        return departname;
    }

    public void setDepartname(String departname) {
        this.departname = departname;
    }

    @Override
    public String toString() {
        return "IpColor{" +
                "ip='" + ip + '\'' +
                ", color='" + color + '\'' +
                ", departid='" + departid + '\'' +
                ", departname='" + departname + '\'' +
                '}';
    }
}
