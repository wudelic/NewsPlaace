package com.zh.controller;

import com.zh.pojo.Tab;
import com.zh.service.EditorService;
import com.zh.service.NewsService;
import com.zh.service.ReporterService;
import com.zh.service.TabService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * 主控控制类
 */
@Controller
public class MainController {
    @Autowired
    TabService tabService;
    @Autowired
    NewsService newsService;
    @Autowired
    ReporterService reporterService;
    @Autowired
    EditorService editorService;
    @RequestMapping(value = {"/new"})
    public ModelAndView newTopic(){
        ModelAndView newTopicPage = new ModelAndView("new");
        List<Tab> tabs = tabService.getAllTabs();

        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();

        newTopicPage.addObject("tabs",tabs);
        newTopicPage.addObject("newsNum",newsNum);
        newTopicPage.addObject("usersNum",RNum+ENum);
        return newTopicPage;
    }
    @RequestMapping("/signin")
    public ModelAndView toSignIn(){
        ModelAndView S = new ModelAndView("signin");
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        S.addObject("newsNum",newsNum);
        S.addObject("usersNum",RNum+ENum);
        return S;
    }
    @RequestMapping("/signup")
    public ModelAndView toSignUp(){
        ModelAndView S = new ModelAndView("signup");
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        S.addObject("newsNum",newsNum);
        S.addObject("usersNum",RNum+ENum);
        return S;
    }

    @RequestMapping("/admin")
    public ModelAndView toAdmin(){
        ModelAndView A = new ModelAndView("admin");
        return A;
    }
    @RequestMapping("*")
    public String notFind(){
        return "404";
    }

    @RequestMapping("/ManagementE")
    public ModelAndView toME(){
        ModelAndView M = new ModelAndView("ManagementE");
        return M;
    }
    @RequestMapping("/ManagementR")
    public ModelAndView toMR(){
        ModelAndView R = new ModelAndView("ManagementR");
        return R;
    }

}