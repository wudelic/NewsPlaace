package com.zh.service;

import com.zh.pojo.Tab;
import org.springframework.stereotype.Service;

import java.util.List;

public interface TabService {
    List<Tab> getAllTabs();

    Tab getByTabName(String tabNameEn);
}
