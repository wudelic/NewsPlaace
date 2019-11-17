package com.zh.service.impl;

import com.zh.mapper.TabMapper;
import com.zh.pojo.Tab;
import com.zh.service.TabService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("tabService")
public class TabServiceImpl implements TabService {

    @Autowired
    TabMapper tabMapper;
    @Override
    public List<Tab> getAllTabs() {
        return tabMapper.countTab();
    }

    @Override
    public Tab getByTabName(String tabNameEn) {
        return tabMapper.getByTabNameEn(tabNameEn);
    }
}
