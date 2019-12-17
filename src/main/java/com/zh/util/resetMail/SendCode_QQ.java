package com.zh.util.resetMail;

import com.sun.mail.util.MailSSLSocketFactory;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SendCode_QQ {
    public static void sendMail(String mail, String code)throws Exception{
        //      1.创建连接对象，连接到邮箱服务器
        Properties props = new Properties();
        props.setProperty("mail.smtp.host","smtp.163.com"); //发送主机等信息
        props.setProperty("mail.smtp.auth", "true");// 打开认证
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("13229767281@163.com", "wcl7wcl7");  //qq邮箱为授权码
            }
        });
//      QQ邮箱固有
        MailSSLSocketFactory mailss = new MailSSLSocketFactory();
        mailss.setTrustAllHosts(true);
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.socketFactory", mailss);

//      2.创建邮件对象
        Message message = new MimeMessage(session);
//      2.1设置发件人
        message.setFrom(new InternetAddress("13229767281@163.com"));//QQ邮箱服务器
//      2.2设置收件人
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(mail));
//      2.3设置邮件主题
        message.setSubject("验证码");
//      2.4设置邮件内容
        message.setContent("<h1>验证码</h1><h2>" +    code + "</h2>", "text/html;charset=UTF-8");
//      3.发送一封邮件
        Transport.send(message);
    }
}
