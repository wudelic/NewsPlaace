package com.zh.mapper;

import com.zh.pojo.News;
import org.apache.ibatis.annotations.Param;

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

    void setStatusone(@Param("newsTopic") String newsTopic, @Param("Eid") Integer Eid);

    void setStatustwo(@Param("newsTopic") String newsTopic, @Param("Eid") Integer eid);

    void deleteNewsByTopic(String newsTopic);

    List<String> getByTopic(String newsTopic);
}
