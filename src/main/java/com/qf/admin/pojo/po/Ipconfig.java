package com.qf.admin.pojo.po;

public class Ipconfig {

    private int id;
    private int departid;
    private String room;
    private String user;
    private String tel;
    private String iprange;
    private String ip;
    private String mac;
    private String specifications;
    private String type;
    private String buytime;
    private String others;
    private String adder;
    private String addtime;

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

    public String getIprange() {
        return iprange;
    }

    public void setIprange(String iprange) {
        this.iprange = iprange;
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

    public String getSpecifications() {
        return specifications;
    }

    public void setSpecifications(String specifications) {
        this.specifications = specifications;
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

    public String getAddtime() {
        return addtime.substring(0,addtime.length()-2);
    }

    public void setAddtime(String addtime) {
        this.addtime = addtime;
    }

    @Override
    public String toString() {
        return "Ipconfig{" +
                "id=" + id +
                ", departid=" + departid +
                ", room='" + room + '\'' +
                ", user='" + user + '\'' +
                ", tel='" + tel + '\'' +
                ", iprange='" + iprange + '\'' +
                ", ip='" + ip + '\'' +
                ", mac='" + mac + '\'' +
                ", specifications='" + specifications + '\'' +
                ", type='" + type + '\'' +
                ", buytime='" + buytime + '\'' +
                ", others='" + others + '\'' +
                ", adder='" + adder + '\'' +
                ", addtime='" + addtime + '\'' +
                '}';
    }
}
