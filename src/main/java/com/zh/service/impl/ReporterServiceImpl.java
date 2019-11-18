package com.zh.service.impl;

import com.zh.mapper.ReporterMapper;
import com.zh.pojo.Reporter;
import com.zh.service.ReporterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("reporterService")
public class ReporterServiceImpl implements ReporterService {

    @Autowired
    ReporterMapper reporterMapper;

    @Override
    public List<Reporter> queryAllReporter() {
        return reporterMapper.queryAllReporter();
    }

    @Override
    public Reporter checkReporter(String idNumber, String password) {
        Reporter reporter = reporterMapper.checkReporter(idNumber);
        if (reporter != null && reporter.getPassword().equals(password)){
            return reporter;
        }
        return null;
    }

    @Override
    public boolean existsReporter(String idNumber) {
        int flag = reporterMapper.existsReporter(idNumber);
        return flag==1?true:false;
    }

    @Override
    public void signUpReporter(Reporter reporter) {
        reporterMapper.signUpReporter(reporter);
    }

    @Override
    public void deleteReporter(Integer id) {
        reporterMapper.deleteReporterById(id);
    }

    @Override
    public void add(Reporter reporter) {
        reporterMapper.insertSelective(reporter);
    }

    @Override
    public Reporter getRepById(Integer id) {
        Reporter reporter = reporterMapper.selectByPrimaryKey(id);
        return reporter;

    }

    @Override
    public void updateRepById(Reporter reporter) {
        reporterMapper.updateByPrimaryKeySelective(reporter);
    }

    @Override
    public List<String> getIdNumber(String idNumber) {
        return reporterMapper.getIdNumber(idNumber);
    }

    @Override
    public List<Reporter> queryRepByIdNumber(String idNumber) {
        return reporterMapper.queryRepByIdNumber(idNumber);
    }

    @Override
    public void deleteByIds(Integer[] ids) {
        reporterMapper.deleteByIds(ids);
    }

    @Override
    public int login(String idNumber, String password) {
        boolean existIdNum = existsReporter(idNumber);
        if (existIdNum){
            Reporter reporter = reporterMapper.selectByIdNum(idNumber);
            if (reporter.getPassword().equals(password)){
                return 2;
            }
            return 1;
        }
        return 0;
    }

    @Override
    public Reporter getRepByIdNum(String idNumber) {
        Reporter reporter = reporterMapper.selectByIdNum(idNumber);
        return reporter;
    }

    @Override
    public int getRepNum() {
        int count = reporterMapper.countRep();
        return count;
    }

    @Override
    public Reporter getRepByName(String name) {
        Reporter reporter = reporterMapper.selectByName(name);
        return reporter;
    }
}
