package com.zh.controller;

import com.zh.pojo.WangEditor;
import org.apache.commons.io.FileUtils;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.apache.commons.lang3.RandomStringUtils;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
@Controller
public class WEditorController {
    //不知道是干什么的，到时候再补
    private Logger log = LoggerFactory.getLogger(getClass());

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public WangEditor uploadFile(
            @RequestParam("Image")MultipartFile Image,
            HttpServletRequest request){
        try{
            //获取项目路径
            String realPath = request.getSession().getServletContext().getRealPath("");
            InputStream inputStream = Image.getInputStream();
            String contextPath = request.getContextPath();
            //获取服务器根目录的路径
            String path = realPath.replace(contextPath, "");
            //根目录下新建文件夹upload，存放上传图片
            String uploadPath = path + "upload";
            //获取文件名称
            String filename = getFileName();
            //将文件上传到服务器根目录下的upload文件夹
            File file = new File(uploadPath, filename);
            FileUtils.copyInputStreamToFile(inputStream, file);
            //返回图片的访问路径
            String url = request.getScheme() + "://" + request.getServerName() +
                    ":" + request.getServerPort() + "/upload/" + filename;
            String[] str = {url};
            WangEditor we = new WangEditor(str);
            return we;
        }catch (IOException e){
            log.error("上传文件失败", e);
        }
        return null;
    }
    public String getFileName(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String timeStr = sdf.format(new Date());
        String str = RandomStringUtils.random(5,"abcdefghijklmnopqrstuvwxyz1234567890");
        String name = timeStr + str + ".jpg";
        return name;
    }
}
