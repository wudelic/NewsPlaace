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
}
