package com.qf.admin.pojo.dto;

import java.util.List;

public class ResultTable<T> {
    private String year;
    private long pages;
    private String time;
    private long count;
    private List<T> data;

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public long getPages() {
        return pages;
    }

    public void setPages(long pages) {
        this.pages = pages;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public long getCount() {
        return count;
    }

    public void setCount(long count) {
        this.count = count;
    }

    public List<T> getData() {
        return data;
    }

    public void setData(List<T> data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "ResultTable{" +
                "year=" + year +
                ", pages=" + pages +
                ", time='" + time + '\'' +
                ", count=" + count +
                ", data=" + data +
                '}';
    }
}
