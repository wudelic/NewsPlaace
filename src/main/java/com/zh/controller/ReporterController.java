package com.zh.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zh.pojo.Msg;
import com.zh.pojo.News;
import com.zh.pojo.Reporter;
import com.zh.service.EditorService;
import com.zh.service.NewsService;
import com.zh.service.ReporterService;
import com.zh.service.TabService;
import com.zh.util.ProduceMD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/reporter")
public class ReporterController {
    @Autowired
    ReporterService reporterService;

    @Autowired
    TabService tabService;

    @Autowired
    EditorService editorService;

    @Autowired
    NewsService newsService;
    @RequestMapping("/query/allReporterJson")
    @ResponseBody
    public Msg getReportersWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                                    Model model) {
        PageHelper.startPage(pn, 5);
        List<Reporter> reporters = reporterService.queryAllReporter();
        PageInfo page = new PageInfo(reporters, 5);
        model.addAttribute("pageInfo", page);
        return Msg.success().add("pageInfo", page);
    }

    @RequestMapping("/query/RepByIdNumber")
    @ResponseBody
    public Msg getRepByIdNumber(@RequestParam(value = "pn", defaultValue = "1") Integer pn,Model model, @RequestParam("idNumber") String idNumber) {
        PageHelper.startPage(pn, 5);
        List<Reporter> reporters = reporterService.queryRepByIdNumber(idNumber);
        PageInfo page = new PageInfo(reporters, 5);
        model.addAttribute("pageInfo", page);

        return Msg.success().add("pageInfo", page);
    }


    @RequestMapping("/login")
    @ResponseBody
    public Object signin(HttpServletRequest request, HttpSession session){
        String password = ProduceMD5.getMD5(request.getParameter("Loginpwd"));
        String idNumber = request.getParameter("LoginId");
        int loginVerify = reporterService.login(idNumber,password);
        HashMap<String, String> res = new HashMap<>();
        if (loginVerify == 2) {//用户存在

            Reporter reporter = reporterService.getRepByIdNum(idNumber);
            Integer RepId = reporter.getId();
            String RepName = reporter.getName();
            session.setAttribute("RepId", RepId);
            session.setAttribute("RepName", RepName);

            res.put("stateCode", "2");
        }else if (loginVerify == 1){
            res.put("stateCode", "1");
        }else{
            res.put("stateCode", "0");
        }
        return res;
    }


    @RequestMapping(value = "/checkIdNumber", method = RequestMethod.POST)
    @ResponseBody
    public int checkIdNumber(String idNumber){
        boolean isExists = reporterService.existsReporter(idNumber);
        int message;
        if (isExists)
        {
            message=1;
        }
        else{
            message=0;
        }
        return message;
    }

    @RequestMapping("/signUp")
    public String signUp(Model model, HttpServletRequest request){
        Reporter reporter = new Reporter();
        //密码
        String password = ProduceMD5.getMD5(request.getParameter("password"));
        //date
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date age = new Date();
        try{
            age = df.parse(request.getParameter("age"));
        }catch (Exception e){

        }
        reporter.setName(request.getParameter("name"));
        reporter.setPassword(password);
        reporter.setGender(request.getParameter("gender"));
        reporter.setIdNumber(request.getParameter("idNumber"));
        reporter.setAge(age);
        reporter.setAddress(request.getParameter("address"));
        reporter.setPhoneNum(request.getParameter("phoneNum"));
        reporter.setEmail(request.getParameter("email"));
        reporter.setDetail(request.getParameter("detail"));
        reporterService.signUpReporter(reporter);
        model.addAttribute("msg","注册成功");
        return "heiheihei";
    }

    @ResponseBody
    @RequestMapping("/delete/{id}")
    public Msg deleteReporterById(@PathVariable("id")Integer id){
        reporterService.deleteReporter(id);
        return Msg.success();
    }

    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public Msg add(Reporter reporter){
        reporterService.add(reporter);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "/{id}",method = RequestMethod.GET)
    public Msg getRepById(@PathVariable("id") Integer id){
        Msg msg = new Msg();
        Reporter reporter = reporterService.getRepById(id);
        msg.setCode(100);
        msg.setMsg("查询成功");
        msg.getExtend().put("rep", reporter);
        return msg;
    }

    @RequestMapping(value = "/update/{id}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateRepById(Reporter reporter){
        reporterService.updateRepById(reporter);
        return Msg.success();
    }

    @RequestMapping("/getIdNumber")
    @ResponseBody
    public List<String> getIdNumber(@RequestParam(value = "idNumber") String idNumber)
    {
        List<String> idNumberList = reporterService.getIdNumber(idNumber);
        return idNumberList;

    }

    @RequestMapping(value = "/deleteByIds", method = RequestMethod.POST)
    @ResponseBody
    public Msg deleteByIds(Integer[] ids)
    {
        reporterService.deleteByIds(ids);
        return Msg.success();
    }

    @RequestMapping("/outLogin")
    public String outLogin(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }

    @RequestMapping("/member/{name}")
    public ModelAndView personalCenter(@PathVariable("name")String name,HttpSession session){
        //统计
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        //获取用户信息
        Integer Rid = (Integer)session.getAttribute("RepId");
        Reporter reporter = reporterService.getRepById(Rid);

        ModelAndView mv = new ModelAndView("user_info");
        Reporter result = reporterService.getRepByName(name);
        Date test = (Date) result.getCreateTime();
        mv.addObject("RepInfo",result);
        mv.addObject("newsNum", newsNum);
        mv.addObject("usersNum",RNum+ENum);
        mv.addObject("reporter",reporter);
        return mv;
    }
}

