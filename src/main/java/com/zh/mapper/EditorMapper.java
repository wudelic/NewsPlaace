package com.zh.mapper;

import com.zh.pojo.Editor;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EditorMapper {
    List<Editor> queryAllEditor();

    List<Editor> queryEdiByIdNum(@Param("idNumber") String idNumber);

    int existsEdi(String idNumber);

    Editor checkEdi(@Param("idNumber") String idNumber);

    void signUpEdi(Editor editor);

    void deleteEdiById(Integer id);

    void insertSelective(Editor editor);

    Editor selectByPrimaryKey(Integer id);

    void updateByPrimaryKeySelective(Editor editor);

    List<String> getIdNum(String idNumber);

    void deleteByIds(Integer[] ids);

    Editor selectByIdNum(String idNumber);

    int countEdi();
}
