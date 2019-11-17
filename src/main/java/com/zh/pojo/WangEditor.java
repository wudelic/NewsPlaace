package com.zh.pojo;

import java.util.Arrays;

public class WangEditor {
    private Integer errno;//错误代码,0代表没有错误
    private String[] data;//上传图片的路径
    public WangEditor(){
        super();
    }
    public WangEditor(String[] data){
        super();
        this.errno = 0;
        this.data = data;
    }
    public Integer getErrno(){
        return errno;
    }
    public void setErrno(Integer errno){
        this.errno = errno;
    }
    public String[] getData(){
        return data;
    }
    public void setData(String[] data){
        this.data = data;
    }
    public String toString() {
        return "WangEditor [errno=" + errno + ", data=" + Arrays.toString(data)
                + "]";
    }
}
