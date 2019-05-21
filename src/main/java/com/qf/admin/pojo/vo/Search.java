package com.qf.admin.pojo.vo;

public class Search {
    private String keyword;
    private String searchItem;
    private String departname;

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getSearchItem() {
        return searchItem;
    }

    public void setSearchItem(String searchItem) {
        this.searchItem = searchItem;
    }

    public String getDepartname() {
        return departname;
    }

    public void setDepartname(String departname) {
        this.departname = departname;
    }

    @Override
    public String toString() {
        return "Search{" +
                "keyword='" + keyword + '\'' +
                ", searchItem='" + searchItem + '\'' +
                ", departname='" + departname + '\'' +
                '}';
    }
}
