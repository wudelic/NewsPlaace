package com.zh.service.impl;

import com.zh.mapper.NewsMapper;
import com.zh.pojo.News;
import com.zh.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NewsServiceImpl implements NewsService {
   @Autowired
    NewsMapper newsMapper;

    @Override
    public List<News> listTopicsAndUsers() {
        return newsMapper.listTopicsAndUsers();
    }

    @Override
    public int getNewsNum() {
        return newsMapper.countNews();
    }

    @Override
    public boolean addNew(News news) {
        return newsMapper.insert(news)>0;
    }

    @Override
    public List<News> listTopicsAndUsersOfTab(Integer tabId) {
        return newsMapper.listTopicsAndUsersOfTab(tabId);
    }

    @Override
    public boolean clickAddOne(Integer id) {
        return newsMapper.clickAddOne(id)>0;
    }

    @Override
    public News selectById(Integer id) {
        News news = newsMapper.selectById(id);
        return news;

    }
}
