package com.zh.pojo;

import java.util.List;

public class Tab extends BaseDomain {
    private Integer id;

    private String tabName;

    private String tabNameEn;

    private List<News> news;

    public void setNews(List<News> news) {
        this.news = news;
    }

    public List<News> getNews(){
        return news;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTabName() {
        return tabName;
    }

    public void setTabName(String tabName) {
        this.tabName = tabName;
    }

    public String getTabNameEn() {
        return tabNameEn;
    }

    public void setTabNameEn(String tabNameEn) {
        this.tabNameEn = tabNameEn;
    }
}
