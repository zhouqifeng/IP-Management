package com.qf.admin.pojo.po;

public class Admin {

    private int id;
    private String username;
    private String passwd;
    private String oskey;
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
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", passwd='" + passwd + '\'' +
                ", oskey='" + oskey + '\'' +
                ", isadmin=" + isadmin +
                ", iprange='" + iprange + '\'' +
                ", ips='" + ips + '\'' +
                ", creater='" + creater + '\'' +
                ", createtime='" + createtime + '\'' +
                '}';
    }
}
