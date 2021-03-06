package com.zh.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zh.pojo.Editor;
import com.zh.pojo.Msg;
import com.zh.service.EditorService;
import com.zh.service.NewsService;
import com.zh.service.ReporterService;
import com.zh.service.TabService;
import com.zh.util.ProduceMD5;
import com.zh.util.SecurityCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/editor")
public class EditorController {
    @Autowired
    EditorService editorService;

    @Autowired
    ReporterService reporterService;

    @Autowired
    TabService tabService;

    @Autowired
    NewsService newsService;

    //ajax查找全部主编
    @RequestMapping("/query/allEditorJson")
    @ResponseBody
    public Msg getEditorWithJson(@RequestParam(value="pn", defaultValue = "1") Integer pn, Model model){
        PageHelper.startPage(pn, 5);
        List<Editor> editors = editorService.queryAllEditor();
        PageInfo page = new PageInfo(editors, 5);
        model.addAttribute("pageInfo", page);
        return Msg.success().add("pageInfo", page);
    }
    //模糊查询主编
    @RequestMapping("/query/EdiByIdNum")
    @ResponseBody
    public Msg getEdiByIdNumber(@RequestParam(value = "pn", defaultValue = "1")Integer pn, Model model,@RequestParam("idNumber")String idNumber){
        PageHelper.startPage(pn, 5);
        List<Editor> editors = editorService.queryEdiByIdNum(idNumber);
        PageInfo page = new PageInfo(editors, 5);
        model.addAttribute("pageInfo", page);
        return Msg.success().add("pageInfo", page);
    }

    //登录
    @RequestMapping("/login")
    @ResponseBody
    public Object signin(HttpServletRequest request, HttpSession session){
        String password = ProduceMD5.getMD5(request.getParameter("Loginpwd"));
        String idNumber = request.getParameter("LoginId");
        int loginVerify = editorService.login(idNumber,password);
        HashMap<String, String> res = new HashMap<>();
        if (loginVerify == 2) {//用户存在

            Editor editor = editorService.getRepByIdNum(idNumber);
            Integer EdiId = editor.getId();
            String EdiName = editor.getName();
            session.setAttribute("EdiId", EdiId);
            session.setAttribute("EdiName", EdiName);
            session.setAttribute("LOGIN",editor);
            res.put("stateCode", "2");
        }else if (loginVerify == 1){
            res.put("stateCode", "1");
        }else{
            res.put("stateCode", "0");
        }
        return res;
    }

    //身份证是否被用过
    @RequestMapping(value = "/checkIdNumber", method = RequestMethod.POST)
    @ResponseBody
    public int checkIdNumber(String idNumber){
        boolean isExists = editorService.existsEdi(idNumber);
        int message;
        if(isExists){
            message = 1;
        }else
        {
            message = 0;
        }
        return message;
    }
    @RequestMapping(value = "/checkEmail", method = RequestMethod.POST)
    @ResponseBody
    public int checkEmail(String email){
        boolean isExists = editorService.existsEdiByEmail(email);
        int message;
        if(isExists){
            message = 1;
        }else
        {
            message = 0;
        }
        return message;
    }

    //注册
    @RequestMapping("/signUp")
    public void signUp(Model model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Editor editor = new Editor();
        //密码加密
        String password = ProduceMD5.getMD5(request.getParameter("password"));
        //date转化
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date age = new Date();
        try{
            age = df.parse(request.getParameter("age"));
        }catch (Exception e){
        }
        //初始化主编
        editor.setName(request.getParameter("name"));
        editor.setPassword(password);
        editor.setGender(request.getParameter("gender"));
        editor.setIdNumber(request.getParameter("idNumber"));
        editor.setAge(age);
        editor.setAddress(request.getParameter("address"));
        editor.setPhoneNum(request.getParameter("phoneNum"));
        editor.setEmail(request.getParameter("email"));
        editor.setDetail(request.getParameter("detail"));
        editorService.signUpEdi(editor);
        request.getRequestDispatcher("/WEB-INF/jsp/check.jsp").forward(request,response);
    }

    //根据id删除
    @ResponseBody
    @RequestMapping("/delete/{id}")
    public Msg deleteEdiById(@PathVariable("id")Integer id){
        editorService.deleteEdi(id);
        return Msg.success();
    }

    //添加
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public Msg add(Editor editor){
       String password = ProduceMD5.getMD5(editor.getPassword());
       editor.setPassword(password);
        editorService.add(editor);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public Msg getEdiById(@PathVariable("id")Integer id){
        Editor editor = editorService.getEdiById(id);
        return Msg.success().add("edi",editor);
    }

    @RequestMapping(value = "/update/{id}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEdiById(Editor editor){
        String password = ProduceMD5.getMD5(editor.getPassword());
        editor.setPassword(password);
        editorService.updateEdiById(editor);
        return Msg.success();
    }

    @RequestMapping("/getIdNumber")
    @ResponseBody
    public List<String> getIdNumber(@RequestParam(value = "idNumber")String idNumber){
        List<String> idNumberList = editorService.getIdNumber(idNumber);
        return idNumberList;
    }

    @RequestMapping(value = "/deleteByIds", method = RequestMethod.POST)
    @ResponseBody
    public Msg deleteByIds(Integer[] ids)
    {
        editorService.deleteByIds(ids);
        return Msg.success();
    }

    @RequestMapping("/outLogin")
    public String outLogin(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }

    @RequestMapping("/member/{name}")
    public ModelAndView personalCenter(@PathVariable("name")String name, HttpSession session){
        //统计
        int newsNum = newsService.getNewsNum();
        int RNum = reporterService.getRepNum();
        int ENum = editorService.getEdiNum();
        //获取用户信息
        Integer Eid = (Integer)session.getAttribute("EdiId");
        Editor editor = editorService.getEdiById(Eid);
        ModelAndView mv;
        mv = new ModelAndView("user_info");
        Editor result = editorService.geEdiByName(name);
        if (result == null){
            mv = new ModelAndView("404");
            return mv;
        }
        mv.addObject("EdiInfo",result);
        mv.addObject("newsNum", newsNum);
        mv.addObject("usersNum",RNum+ENum);
        mv.addObject("editor",editor);
        return mv;
    }

    @PostMapping("/reSetPassword")
    public ModelAndView reset(@RequestParam("email")String email) throws Exception{
        ModelAndView mv ;
        Integer securityCode = SecurityCode.GetSecurityCode();
        Editor editor = editorService.queryEdiByEmail(email);

        if (editor!=null){
            editor.setSecurityCode(securityCode);
            editorService.updateSecurity(editor);
            editorService.SendSecurityCode(email,securityCode);
            mv = new ModelAndView("EsetPassword");
        }else {
            mv = new ModelAndView("reSetPasswords_fail");
        }
        return mv;
    }

    @PostMapping("/setPassword")
    public ModelAndView resetPwd(@RequestParam("securityCode")String securityCode1,@RequestParam("password")String password,@RequestParam("email")String email) throws Exception{
        ModelAndView mv ;
        Integer sc = new Integer(securityCode1);
        Editor editor = editorService.queryEdiByEmail(email);
        if (editor == null){
            mv = new ModelAndView("reSetFail");
            return mv;
        }
        Integer a = editor.getSecurityCode();
       if (a.equals(sc)){
            editor.setPassword(ProduceMD5.getMD5(password));
            editorService.updatePwd(editor);

            editor.setSecurityCode(0);
            editorService.updateSecurity(editor);
            mv = new ModelAndView("reSetSuccess");
        }else {
            mv = new ModelAndView("reSetFail");
        }

        return mv;
    }

}


