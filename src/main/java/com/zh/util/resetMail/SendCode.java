package com.zh.util.resetMail;

public class SendCode {
    /**
     * @param mail   给谁发邮件
     * @param code 邮件激活码
     */
    public static void sendMail(String mail, String code) throws Exception {
        /**
         *@Descriptuion TODO 根据邮箱类型发送邮件
         **/
        if(mail.endsWith("@163.com"))
            SendCode_QQ.sendMail(mail, code);
        if(mail.endsWith("@life.com"))
            SendCode_Local.sendMail(mail, code);
    }
}
