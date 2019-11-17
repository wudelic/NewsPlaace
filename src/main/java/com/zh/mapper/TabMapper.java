package com.zh.mapper;

import com.zh.pojo.Tab;

import java.util.List;

public interface TabMapper {
    List<Tab> countTab();

    Tab getByTabNameEn(String tabNameEn);
}
