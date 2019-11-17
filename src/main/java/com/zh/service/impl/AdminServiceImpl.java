package com.zh.service.impl;

import com.zh.mapper.AdminMapper;
import com.zh.pojo.Admin;
import com.zh.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;


@Service("adminService")
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;


    @Override
    public Admin checkLogin(String username, String password) {
        Admin admin = adminMapper.queryByUsername(username);
        if (admin != null && admin.getPassword().equals(password)){
            return admin;
        }
        return null;
    }
}
