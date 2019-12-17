package com.zh.util;

public class SecurityCode {
    public static Integer GetSecurityCode(){
        int a=(int)(Math.random()*1000000);
        return a;
    }
}
