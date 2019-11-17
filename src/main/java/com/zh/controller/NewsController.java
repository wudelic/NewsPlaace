package com.zh.controller;

import com.zh.pojo.News;
import com.zh.pojo.Reporter;
import com.zh.pojo.Tab;
import com.zh.service.EditorService;
import com.zh.service.NewsService;
import com.zh.service.ReporterService;
import com.zh.service.TabService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/***
 * 新闻相关控制类
 */
@Controller
public class NewsController {
    @Autowired
    NewsService newsService;

    @Autowired
    ReporterService reporterService;

    @Autowired
    EditorService editorService;

    @Autowired
    TabService tabService;
    //log4j对象
    private final Log log = LogFactory.getLog(getClass());

    @RequestMapping(value = "/")
    public ModelAndView toMain(HttpSession session){
        ModelAndView indexPage = new ModelAndView("index");
        //全部新闻
        List<News> news = newsService.listTopicsAndUsers();
        //获取统计信息
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        //获取用户信息
        Integer Rid = (Integer)session.getAttribute("RepId");
      //  Reporter reporter = reporterService.getRepById(Rid);

        indexPage.addObject("news",news);
        indexPage.addObject("newsNum", newsNum);
        indexPage.addObject("usersNum",RNum+ENum);

     //   indexPage.addObject("reporter", reporter);
        return indexPage;
    }

    /**
     * 发表新闻
     */
    @RequestMapping(value = "/news/add", method = RequestMethod.POST)
    public ModelAndView addNew(HttpServletRequest request, HttpSession session){
        ModelAndView indexPage;
        if (session.getAttribute("RepId")==null){
            indexPage = new ModelAndView("redirect:/index");
            return indexPage;
        }
        //处理参数
        Integer RepId = (Integer)session.getAttribute("RepId");
        String topic = request.getParameter("topic");
        String content = request.getParameter("content");
        Byte tabId = Byte.parseByte(request.getParameter("tab"));
        //新建New
        News news = new News();
        news.setReporterId(RepId);
        news.setTopic(topic);
        news.setContent(content);
        news.setTabId(tabId);
        //添加news
        boolean ifSucc = newsService.addNew(news);
        if(ifSucc){
            if (log.isInfoEnabled()){
                log.info("新建新闻成功！");
            }
        }
        indexPage = new ModelAndView("redirect:/");
        return indexPage;
    }
    /**
     * 指定渲染板块页面
     */
    @RequestMapping("/tab/{tabNameEn}")
    public ModelAndView toTabPage(@PathVariable("tabNameEn")String tabNameEn, HttpSession session){
        Tab tab = tabService.getByTabName(tabNameEn);
        Integer tabId = tab.getId();

        ModelAndView indexPage = new ModelAndView("index");
        //板块下全部新闻
        List<News> news = newsService.listTopicsAndUsersOfTab(tabId);
        //统计
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        //获取用户信息
        Integer Rid = (Integer)session.getAttribute("RepId");

        indexPage.addObject("news",news);
        indexPage.addObject("newsNum", newsNum);
        indexPage.addObject("usersNum",RNum+ENum);
        indexPage.addObject("tab",tab);
        return indexPage;
    }

    /**
     * 渲染新闻详细页面
     */
    @RequestMapping("/n/{id}")
    public ModelAndView toNews(@PathVariable("id")Integer id,HttpSession session)
    {
        //点击量加1
        boolean ifSucc = newsService.clickAddOne(id);
        //获取主题信息
        News news = newsService.selectById(id);
        String content = news.getContent();
        String test = news.getTopic();
        //统计信息
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        Integer Rid = (Integer)session.getAttribute("Rid");

        ModelAndView newsPage = new ModelAndView("detail");
        newsPage.addObject("news",news);
        newsPage.addObject("newsNum",newsNum);
        newsPage.addObject("usersNum",RNum+ENum);
        return newsPage;
    }


}
