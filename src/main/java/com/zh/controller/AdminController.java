package com.zh.controller;

import com.zh.pojo.Admin;
import com.zh.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin")
@SessionAttributes("admin")
public class AdminController {


    @Autowired
    private AdminService adminService;

    @RequestMapping("/login")
    public String login(){
        return "admin";
    }

    @RequestMapping("/checkLogin")
    public String checkLogin(Admin admin,Model model,HttpSession session){
        admin = adminService.checkLogin(admin.getUsername(), admin.getPassword());
        session.setAttribute("admin",admin);
        if (admin != null){
            model.addAttribute("admin",admin);
            return "Management";
        }
        else{
            model.addAttribute("errorMsg","密码或用户名错误");
            return "admin";
        }

    }

    @RequestMapping("/outLogin")
    public String outLogin(HttpSession session){
        session.invalidate();
        return "admin";
    }
}
