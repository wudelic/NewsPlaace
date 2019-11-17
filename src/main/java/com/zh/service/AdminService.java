package com.zh.service;

import com.zh.pojo.Admin;

public interface AdminService {

    Admin checkLogin(String username, String password);
}
