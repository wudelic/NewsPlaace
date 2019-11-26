package com.zh.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zh.pojo.Msg;
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
import org.springframework.web.bind.annotation.*;
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
/*
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
        indexPage.addObject("news",news);
        indexPage.addObject("newsNum", newsNum);
        indexPage.addObject("usersNum",RNum+ENum);
        return indexPage;
    }
*/
    @RequestMapping(value = "/")
    public ModelAndView toMain(@RequestParam(defaultValue = "1",value = "pn")Integer pn, HttpSession session){
        ModelAndView indexPage = new ModelAndView("index");
        PageHelper.startPage(pn,8);
        //全部新闻
        List<News> list = newsService.listTopicsAndUsers();
        PageInfo<News> pageInfo = new PageInfo<>(list);
        //获取统计信息
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        //获取用户信息
        Integer Rid = (Integer)session.getAttribute("RepId");
        indexPage.addObject("pageInfo",pageInfo);
        indexPage.addObject("news",list);
        indexPage.addObject("newsNum", newsNum);
        indexPage.addObject("usersNum",RNum+ENum);
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
        indexPage = new ModelAndView("redirect:/Rep/An");
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

    @RequestMapping("/n/newsTopic/{newsTopic}")
    public ModelAndView TopictoNews(@PathVariable("newsTopic")String newsTopic,HttpSession session){
        //点击量加1
        boolean ifSucc = newsService.clickAddOneByTopic(newsTopic);
        //获取主题信息
        News news = newsService.selectByTopic(newsTopic);
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
    /**
     * 查询未过审核的新闻
     */
    @RequestMapping("/Rep/Nn")
    public ModelAndView RtoNotpassNews(HttpSession session)
    {
        int Rid = (Integer) session.getAttribute("RepId");//拿到用户id
        List<News> news = newsService.selectNotPassNews(Rid);//根据用户id查
        ModelAndView m = new ModelAndView("RepSurface");
        //统计信息
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        m.addObject("news",news);
        m.addObject("newsNum", newsNum);
        m.addObject("usersNum",RNum+ENum);
        m.addObject("N",1);
        return m;
    }
    /**
     * 过审核的新闻
     */
    @RequestMapping("/Rep/Pn")
    public ModelAndView RtoPassNews(HttpSession session)
    {
        int Rid = (Integer) session.getAttribute("RepId");//拿到用户id
        List<News> news = newsService.selectPassNews(Rid);
        ModelAndView m = new ModelAndView("RepSurface");
        //统计信息
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        m.addObject("news",news);
        m.addObject("newsNum", newsNum);
        m.addObject("usersNum",RNum+ENum);
        m.addObject("P",1);
        return m;
    }
    /**
     * 上传过的所有新闻
     */
    @RequestMapping("/Rep/An")
    public ModelAndView RtoAllNews(HttpSession session){
        int Rid = (Integer) session.getAttribute("RepId");//拿到用户id
        List<News> news = newsService.selectAllNews(Rid);
        ModelAndView m = new ModelAndView("RepSurface");
        //统计信息
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        m.addObject("news",news);
        m.addObject("newsNum", newsNum);
        m.addObject("usersNum",RNum+ENum);
        m.addObject("A",1);
        return m;
    }
    /**
     * 被拒绝的新闻
     */
    @RequestMapping("/Rep/Rn")
    public ModelAndView RtoRejectNews(HttpSession session){
        int Rid = (Integer) session.getAttribute("RepId");//拿到用户id
        List<News> news = newsService.selectRejectNews(Rid);
        ModelAndView m = new ModelAndView("RepSurface");
        //统计信息
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        m.addObject("news",news);
        m.addObject("newsNum", newsNum);
        m.addObject("usersNum",RNum+ENum);
        m.addObject("R", 1);
        return m;
    }

    /**
     * 主编的个人信息部分
     * 1.审核过的新闻
     * 2.未审核的新闻
     * 3.审核通过的新闻
     * 4.审核不通过的新闻
     */
    /**
     * 审核过的新闻
     */
    @RequestMapping("/Edi/An")
    public ModelAndView EtoAllNews(HttpSession session){
        int Eid = (Integer) session.getAttribute("EdiId");//拿到用户id
        List<News> news = newsService.EselectAllNews(Eid);
        ModelAndView m = new ModelAndView("EdiSurface");
        //统计信息
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        m.addObject("news",news);
        m.addObject("newsNum", newsNum);
        m.addObject("usersNum",RNum+ENum);
        m.addObject("A",1);
        return m;
    }
    /**
     *未审核的新闻
     */
    @RequestMapping("/Edi/Nn")
    public ModelAndView EtoNotpassNews(HttpSession session)
    {
        int Eid = (Integer) session.getAttribute("EdiId");//拿到用户id
        List<News> news = newsService.EselectNotPassNews(Eid);//根据用户id查
        ModelAndView m = new ModelAndView("EdiSurface");
        //统计信息
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        m.addObject("news",news);
        m.addObject("newsNum", newsNum);
        m.addObject("usersNum",RNum+ENum);
        m.addObject("N",1);//页面选项
        return m;
    }
    /**
     * 通过审核的新闻
     */
    @RequestMapping("/Edi/Pn")
    public ModelAndView EtoPassNews(HttpSession session)
    {
        int Eid = (Integer) session.getAttribute("EdiId");//拿到用户id
        List<News> news = newsService.EselectPassNews(Eid);
        ModelAndView m = new ModelAndView("EdiSurface");
        //统计信息
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        m.addObject("news",news);
        m.addObject("newsNum", newsNum);
        m.addObject("usersNum",RNum+ENum);
        m.addObject("P",1);
        return m;
    }
    /**
     * 审核不通过新闻
     */
    @RequestMapping("/Edi/Rn")
    public ModelAndView EtoRejectNews(HttpSession session){
        int Eid = (Integer) session.getAttribute("EdiId");//拿到用户id
        List<News> news = newsService.EselectRejectNews(Eid);
        ModelAndView m = new ModelAndView("EdiSurface");
        //统计信息
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        m.addObject("news",news);
        m.addObject("newsNum", newsNum);
        m.addObject("usersNum",RNum+ENum);
        m.addObject("R",1);
        return m;
    }

    /**
     * 将新闻状态变成审核通过
     */
    @ResponseBody
    @RequestMapping("/news/pass")
    public Msg passNews(@RequestParam("newsTopic")String newsTopic,@RequestParam("Eid")Integer Eid){
        newsService.setStatusone(newsTopic, Eid);
        return Msg.success();
    }
    /**
     * 不允许新闻发布
     */
    @ResponseBody
    @RequestMapping("/news/unpass")
    public Msg unpassNews(@RequestParam("newsTopic")String newsTopic,@RequestParam("Eid")Integer Eid){
        newsService.setStatustwo(newsTopic, Eid);
        return Msg.success();
    }
    /**
     * 删除新闻
     */
    @ResponseBody
    @RequestMapping("/news/delete")
    public Msg deleteNews(@RequestParam("newsTopic")String newsTopic){
        newsService.deleteNewsByTopic(newsTopic);
        return Msg.success();
    }
    /**
     * 查找新闻ajax
     */
    @RequestMapping("/news/getByTopic")
    @ResponseBody
    public List<String> getByTopic(@RequestParam("newsTopic")String newsTopic){
        List<String> NewsList = newsService.getByTopic(newsTopic);
        return NewsList;
    }
}
