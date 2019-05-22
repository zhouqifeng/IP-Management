package com.qf.admin.pojo.vo;

public class Ip {

    private int id;
    private int departid;
    private String departname;
    private String room;
    private String user;
    private String type;
    private String tel;
    private String range;
    private String ip;
    private String mac;
    private String specification;
    private String buytime;
    private String others;
    private String adder;
    private String addtime;

    public String getAddtime() {
        return addtime;
    }

    public void setAddtime(String addtime) {
        this.addtime = addtime;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDepartid() {
        return departid;
    }

    public void setDepartid(int departid) {
        this.departid = departid;
    }

    public String getDepartname() {
        return departname;
    }

    public void setDepartname(String departname) {
        this.departname = departname;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getRange() {
        return range;
    }

    public void setRange(String range) {
        this.range = range;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getMac() {
        return mac;
    }

    public void setMac(String mac) {
        this.mac = mac;
    }

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification;
    }

    public String getBuytime() {
        return buytime;
    }

    public void setBuytime(String buytime) {
        this.buytime = buytime;
    }

    public String getOthers() {
        return others;
    }

    public void setOthers(String others) {
        this.others = others;
    }

    public String getAdder() {
        return adder;
    }

    public void setAdder(String adder) {
        this.adder = adder;
    }


    @Override
    public String toString() {
        return "Ip{" +
                "id=" + id +
                ", departid=" + departid +
                ", departname='" + departname + '\'' +
                ", room='" + room + '\'' +
                ", user='" + user + '\'' +
                ", type='" + type + '\'' +
                ", tel='" + tel + '\'' +
                ", range='" + range + '\'' +
                ", ip='" + ip + '\'' +
                ", mac='" + mac + '\'' +
                ", specification='" + specification + '\'' +
                ", buytime='" + buytime + '\'' +
                ", others='" + others + '\'' +
                ", adder='" + adder + '\'' +
                ", addtime='" + addtime + '\'' +
                '}';
    }
}
