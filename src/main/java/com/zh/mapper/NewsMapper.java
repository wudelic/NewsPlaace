package com.zh.mapper;

import com.zh.pojo.News;

import java.util.List;

public interface NewsMapper {
    List<News> listTopicsAndUsers();

    int countNews();

    int insert(News news);

    List<News> listTopicsAndUsersOfTab(Integer tabId);

    int clickAddOne(Integer id);

    News selectById(Integer id);

    List<News> selectNotPassNews(Integer RepId);

    List<News> selectPassNews(Integer RepId);

    List<News> selectAllNews(Integer repId);

    List<News> selectRejectNews(Integer repId);

    List<News> EselectNotPassNews(Integer eid);

    List<News> EselectPassNews(Integer eid);

    List<News> EselectAllNews(Integer eid);

    List<News> EselectRejectNews(Integer eid);
}
