package com.qf.admin.pojo.vo;

public class AdminAdd {

    private int id;
    private String username;
    private String passwd;
    private String oskey;
    private int isadmin;
    private String iprange;
    private String ipstart;
    private String ipend;
    private String creater;

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

    public String getOskey() {
        return oskey;
    }

    public void setOskey(String oskey) {
        this.oskey = oskey;
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

    public String getIpstart() {
        return ipstart;
    }

    public void setIpstart(String ipstart) {
        this.ipstart = ipstart;
    }

    public String getIpend() {
        return ipend;
    }

    public void setIpend(String ipend) {
        this.ipend = ipend;
    }

    public String getCreater() {
        return creater;
    }

    public void setCreater(String creater) {
        this.creater = creater;
    }

    @Override
    public String toString() {
        return "AdminAdd{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", passwd='" + passwd + '\'' +
                ", oskey='" + oskey + '\'' +
                ", isadmin=" + isadmin +
                ", iprange='" + iprange + '\'' +
                ", ipstart='" + ipstart + '\'' +
                ", ipend='" + ipend + '\'' +
                ", creater='" + creater + '\'' +
                '}';
    }
}
