package com.qf.admin.pojo.vo;

public class AdminDepart {

    private int id;
    private String username;
    private String passwd;
    private int oskey;
    private String departname;
    private String color;
    private int isadmin;
    private String iprange;
    private String ips;
    private String creater;
    private String createtime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public int getOskey() {
        return oskey;
    }

    public void setOskey(int oskey) {
        this.oskey = oskey;
    }

    public String getDepartname() {
        return departname;
    }

    public void setDepartname(String departname) {
        this.departname = departname;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getIsadmin() {
        return isadmin;
    }

    public void setIsadmin(int isadmin) {
        this.isadmin = isadmin;
    }

    public String getIprange() {
        return iprange;
    }

    public void setIprange(String iprange) {
        this.iprange = iprange;
    }

    public String getIps() {
        return ips;
    }

    public void setIps(String ips) {
        this.ips = ips;
    }

    public String getCreater() {
        return creater;
    }

    public void setCreater(String creater) {
        this.creater = creater;
    }

    public String getCreatetime() {
        return createtime.substring(0,createtime.length()-2);
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "AdminDepart{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", passwd='" + passwd + '\'' +
                ", oskey=" + oskey +
                ", departname='" + departname + '\'' +
                ", color='" + color + '\'' +
                ", isadmin=" + isadmin +
                ", iprange='" + iprange + '\'' +
                ", ips='" + ips + '\'' +
                ", creater='" + creater + '\'' +
                ", createtime='" + createtime + '\'' +
                '}';
    }
}
