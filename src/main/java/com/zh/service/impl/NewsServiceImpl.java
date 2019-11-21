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

    @Override
    public List<News> selectNotPassNews(Integer RepId) {
        return newsMapper.selectNotPassNews(RepId);
    }

    @Override
    public List<News> selectPassNews(Integer RepId) {
        return newsMapper.selectPassNews(RepId);
    }

    @Override
    public List<News> selectAllNews(Integer RepId) {
        return newsMapper.selectAllNews(RepId);
    }

    @Override
    public List<News> selectRejectNews(Integer RepId) {
        return newsMapper.selectRejectNews(RepId);
    }

    @Override
    public List<News> EselectNotPassNews(Integer Eid) {
        return newsMapper.EselectNotPassNews(Eid);
    }

    @Override
    public List<News> EselectPassNews(Integer Eid) {
        return newsMapper.EselectPassNews(Eid);
    }

    @Override
    public List<News> EselectAllNews(Integer Eid) {
        return newsMapper.EselectAllNews(Eid);
    }

    @Override
    public List<News> EselectRejectNews(Integer Eid) {
        return newsMapper.EselectRejectNews(Eid);
    }

    @Override
    public void setStatusone(String newsTopic,Integer Eid) {
        newsMapper.setStatusone(newsTopic, Eid);
    }

    @Override
    public void setStatustwo(String newsTopic, Integer Eid) {
        newsMapper.setStatustwo(newsTopic, Eid);
    }
}
