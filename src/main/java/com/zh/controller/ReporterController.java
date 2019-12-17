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
import com.zh.util.SecurityCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
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
            session.setAttribute("LOGIN",reporter);
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

    @RequestMapping(value = "/checkEmail",method = RequestMethod.POST)
    @ResponseBody
    public int checkEmail(String email){
        boolean isExists = reporterService.existsReporterByEmail(email);
        int message;
        if (isExists){
            message=1;
        }
        else {
            message=0;
        }
        return message;
    }
    @RequestMapping("/signUp")
    public void signUp(Model model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        request.getRequestDispatcher("/WEB-INF/jsp/check.jsp").forward(request,response);
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
        String password = ProduceMD5.getMD5(reporter.getPassword());
        reporter.setPassword(password);
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
        String password = ProduceMD5.getMD5(reporter.getPassword());
        reporter.setPassword(password);
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
        ModelAndView mv;
        mv = new ModelAndView("user_info");
        Reporter result = reporterService.getRepByName(name);
        if (result ==null){
            mv = new ModelAndView("404");
            return mv;
        }
        mv.addObject("RepInfo",result);
        mv.addObject("newsNum", newsNum);
        mv.addObject("usersNum",RNum+ENum);
        mv.addObject("reporter",reporter);
        return mv;
    }

    @PostMapping("/reSetPassword")
    public ModelAndView reset(@RequestParam("email")String email) throws Exception{
        ModelAndView mv ;
        Integer securityCode = SecurityCode.GetSecurityCode();
        Reporter reporter = reporterService.queryEdiByEmail(email);

        if (reporter!=null){
            reporter.setSecurityCode(securityCode);
            reporterService.updateSecurity(reporter);
            reporterService.SendSecurityCode(email,securityCode);
            mv = new ModelAndView("RsetPassword");
        }else {
            mv = new ModelAndView("reSetPasswords_fail");
        }
        return mv;
    }

    @PostMapping("/setPassword")
    public ModelAndView resetPwd(@RequestParam("securityCode")String securityCode1,@RequestParam("password")String password,@RequestParam("email")String email) throws Exception{
        ModelAndView mv ;
        Integer sc = new Integer(securityCode1);
        Reporter reporter = reporterService.queryEdiByEmail(email);
        if (reporter == null){
            mv = new ModelAndView("reSetFail");
            return mv;
        }
        Integer a = reporter.getSecurityCode();
        if (a.equals(sc)){
            reporter.setPassword(ProduceMD5.getMD5(password));
            reporterService.updatePwd(reporter);

            reporter.setSecurityCode(0);
            reporterService.updateSecurity(reporter);
            mv = new ModelAndView("reSetSuccess");
        }else {
            mv = new ModelAndView("reSetFail");
        }

        return mv;
    }
}

