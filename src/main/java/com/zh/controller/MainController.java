package com.zh.controller;

import com.zh.pojo.Msg;
import com.zh.pojo.Tab;
import com.zh.service.EditorService;
import com.zh.service.NewsService;
import com.zh.service.ReporterService;
import com.zh.service.TabService;
import com.zh.util.RandomValidateCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.Console;
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
    public ModelAndView toME(HttpSession session){
        ModelAndView M;
        if (session.getAttribute("admin") == null)
        {
            M = new ModelAndView("NotAccess");
            return M;
        }

        M = new ModelAndView("ManagementE");
        return M;
    }
    @RequestMapping("/ManagementR")
    public ModelAndView toMR(HttpSession session){
        ModelAndView R;
        if(session.getAttribute("admin") == null){
            R = new ModelAndView("NotAccess");
            return R;
        }

        R = new ModelAndView("ManagementR");
        return R;
    }

    /**
     * 获得验证码
     */
    @RequestMapping(value = "/getVerify")
    public void getVerify(HttpServletRequest request, HttpServletResponse response){
        response.setContentType("image/jpeg");
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expire", 0);
        RandomValidateCode randomValidateCode = new RandomValidateCode();
        try {
            randomValidateCode.getRandcode(request, response);//输出验证码图片方法
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @RequestMapping(value = "/checkVerify", method = RequestMethod.GET)
    @ResponseBody
    public int checkVerify(HttpSession session, @RequestParam("inputStr") String inputStr){
        int message;
        String random = (String) session.getAttribute("RANDOMVALIDATECODEKEY");
        if (random.equals(inputStr)){
            message = 1;
        }else{
            message = 0;
        }
        return message;
    }

    @RequestMapping(value = "/forgetPwd", method = RequestMethod.GET)
    public String findPassword(){
        return "forgetPwd";
    }

}
