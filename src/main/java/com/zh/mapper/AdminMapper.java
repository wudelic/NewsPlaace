package com.zh.mapper;

import com.zh.pojo.Admin;
import org.apache.ibatis.annotations.Param;

public interface AdminMapper {
    Admin queryByUsername(String username);
}
