package com.zh.service;

import com.zh.pojo.News;

import java.util.List;

public interface NewsService {
    /***
     * 获取全部新闻主题及用户信息 用于首页渲染
     */
    List<News> listTopicsAndUsers();

    /****
     * 获取新闻总数
     * @return
     */
    int getNewsNum();

    boolean addNew(News news);

    /**
     * 渲染指定页面
     */
    List<News> listTopicsAndUsersOfTab(Integer tabId);

    /**
     *点击量加一
     */
    boolean clickAddOne(Integer id);

    /**
     * 获取指定id的新闻
     */
    News selectById(Integer id);
}
