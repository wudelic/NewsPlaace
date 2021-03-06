package com.zh.mapper;

import com.zh.pojo.Reporter;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReporterMapper {
    List<Reporter> queryAllReporter();

    List<Reporter> queryRepByIdNumber(@Param("idNumber")String idNumber);

    Reporter checkReporter(@Param("idNumber") String idNumber);

    int existsReporter(String idNumber);

    int existsReporterByEmail(String email);

    void signUpReporter(Reporter reporter);

    void deleteReporterById(Integer id);

    void insertSelective(Reporter reporter);

    Reporter selectByPrimaryKey(Integer id);

    void updateByPrimaryKeySelective(Reporter reporter);

    List<String> getIdNumber(String idNumber);

    void deleteByIds(Integer[] ids);

    Reporter selectByIdNum(String idNumber);

    int countRep();

    Reporter selectByName(String name);

    Reporter queryRepByEmail(String email);

    void updateSecurity(Reporter reporter);

    void updatePwd(Reporter reporter);
}
