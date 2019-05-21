package com.qf.admin.pojo.po;

public class Departname {

    private int id;
    private String departname;
    private String color;
    private String addtime;
    private String adder;
    private String modifier;
    private String modifytime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getAddtime() {
        return addtime.substring(0,addtime.length()-2);
    }

    public void setAddtime(String addtime) {
        this.addtime = addtime;
    }

    public String getAdder() {
        return adder;
    }

    public void setAdder(String adder) {
        this.adder = adder;
    }

    public String getModifier() {
        return modifier;
    }

    public void setModifier(String modifier) {
        this.modifier = modifier;
    }

    public String getModifytime() {
        return modifytime.substring(0,modifytime.length()-2);
    }

    public void setModifytime(String modifytime) {
        this.modifytime = modifytime;
    }

    @Override
    public String toString() {
        return "Departname{" +
                "id=" + id +
                ", departname='" + departname + '\'' +
                ", color='" + color + '\'' +
                ", addtime='" + addtime + '\'' +
                ", adder='" + adder + '\'' +
                ", modifier='" + modifier + '\'' +
                ", modifytime='" + modifytime + '\'' +
                '}';
    }
}
