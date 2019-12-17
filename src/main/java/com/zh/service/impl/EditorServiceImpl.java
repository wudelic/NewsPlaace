package com.zh.service.impl;

import com.zh.mapper.EditorMapper;
import com.zh.pojo.Editor;
import com.zh.service.EditorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.zh.util.resetMail.SendCode;
import java.util.List;

@Service("editor")
public class EditorServiceImpl implements EditorService{
    @Autowired
    EditorMapper editorMapper;

    @Override
    public List<Editor> queryAllEditor() {
        return editorMapper.queryAllEditor();
    }

    @Override
    public List<Editor> queryEdiByIdNum(String idNumber) {
        return editorMapper.queryEdiByIdNum(idNumber);
    }

    @Override
    public boolean existsEdi(String idNumber) {
        int flag = editorMapper.existsEdi(idNumber);
        return flag==1?true:false;
    }

    @Override
    public boolean existsEdiByEmail(String email) {
        int flag = editorMapper.existsEdiByEmail(email);
        return flag==1?true:false;
    }

    @Override
    public Editor checkEdi(String idNumber, String password) {
        Editor editor = editorMapper.checkEdi(idNumber);
        if (editor != null && editor.getPassword().equals(password)){
            return editor;
        }
        return null;
    }

    @Override
    public void signUpEdi(Editor editor) {
        editorMapper.signUpEdi(editor);
    }

    @Override
    public void deleteEdi(Integer id) {
        editorMapper.deleteEdiById(id);
    }

    @Override
    public void add(Editor editor) {
        editorMapper.insertSelective(editor);
    }

    @Override
    public Editor getEdiById(Integer id) {
        Editor editor = editorMapper.selectByPrimaryKey(id);
        return editor;
    }

    @Override
    public void updateEdiById(Editor editor) {
        editorMapper.updateByPrimaryKeySelective(editor);
    }

    @Override
    public List<String> getIdNumber(String idNumber) {
        return editorMapper.getIdNum(idNumber);
    }

    @Override
    public void deleteByIds(Integer[] ids) {
        editorMapper.deleteByIds(ids);

    }

    @Override
    public int login(String idNumber, String password) {
        boolean existIdNum = existsEdi(idNumber);
        if (existIdNum){
            Editor editor = editorMapper.selectByIdNum(idNumber);
            if (editor.getPassword().equals(password)){
                return 2;
            }
            return 1;
        }
        return 0;
    }

    @Override
    public Editor getRepByIdNum(String idNumber) {
        Editor editor = editorMapper.selectByIdNum(idNumber);
        return editor;
    }

    @Override
    public int getEdiNum() {
        int count = editorMapper.countEdi();
        return count;
    }

    @Override
    public Editor geEdiByName(String name) {
        return editorMapper.selectByName(name);
    }

    @Override
    public Editor queryEdiByEmail(String email) {
        return editorMapper.queryEdiByEmail(email);
    }

    @Override
    public void updatePwd(Editor editor) {
        editorMapper.updatePwd(editor);
    }

    @Override
    public void updateSecurity(Editor editor) {
        editorMapper.updateSecurity(editor);
    }
    public void SendSecurityCode(String mail,Integer code) throws Exception {
        String codes=code.toString();
        SendCode.sendMail(mail,codes);
    }

}
