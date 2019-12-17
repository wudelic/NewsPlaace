package com.zh.service;

import com.zh.pojo.Editor;

import java.util.List;

public interface EditorService {
    List<Editor> queryAllEditor();

    List<Editor> queryEdiByIdNum(String idNumber);

    boolean existsEdi(String idNumber);

    Editor checkEdi(String idNumber, String password);

    void signUpEdi(Editor editor);

    void deleteEdi(Integer id);

    void add(Editor editor);

    Editor getEdiById(Integer id);

    void updateEdiById(Editor editor);

    List<String> getIdNumber(String idNumber);

    void deleteByIds(Integer[] ids);

    int login(String idNumber, String password);

    Editor getRepByIdNum(String idNumber);

    int getEdiNum();

    Editor geEdiByName(String name);

    Editor queryEdiByEmail(String email);
    
    void updatePwd(Editor editor);

    void updateSecurity(Editor editor);

    void SendSecurityCode(String email, Integer securityCode) throws Exception;
}
