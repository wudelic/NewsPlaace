<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>主编登录</title>
    <link href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="/static/js/jquery-3.4.1.min.js"></script>
    <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <style>
        li {list-style-type:none;}
        html, body {
            height: 100%;
            font-size: 14px;
            color: #525252;
            font-family: NotoSansHans-Regular,AvenirNext-Regular,arial,Hiragino Sans GB,"Microsoft Yahei","Hiragino Sans GB","WenQuanYi Micro Hei",sans-serif;
            background: #f0f2f5;
        }
        .footer {
            background-color: #fff;
            margin-top: 22px;
            margin-bottom: 22px;
            width: 100%;
            padding-top: 22px;
            color: #8A8A8A;
            display: block;
            height: 200px;
            border: 1px ;
            clear:both
        }

        .container {
            margin-right: 5%;
            margin-left: 5%;
            padding-left: 15px;
            padding-right: 15px;
            width: 40%;
            float: left;
        }
        .info {
            margin-right: 5%;
            width: 10%;
            float: left;
        }
        a{
            color: #8A8A8A;
            cursor: pointer;
        }
    </style>
</head>
<body>
<!-- 引入header文件 -->

<div class="panel panel-default" id="login" style="width: 20%;margin-left: 40%;margin-top: 5%;margin-bottom: 5%">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">主编登录</h3>
    </div>
    <div class="panel-body">
        <form method="post">
        <div class="form-group">
            <label for="LoginID">证件号</label>
            <input type="text" class="form-control" id="LoginID" name="idNumber" placeholder="请输入用户名" required="required">
        </div>
        <div class="form-group">
            <label for="Loginpwd">密码</label>
            <input type="password" class="form-control" id="Loginpwd" name="password" placeholder="请输入密码" required="required">
        </div>
        <div class="text-right">
            <a  href="#">忘记密码?</a>
        </div>
        <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
        <button id="loginButton" class="btn btn-success btn-block" type="button">登录</button>

        </form>
    </div>
</div>
<script>
    $("#loginButton").click(function(){
        var IdNumber = $("#LoginID").val();
        var password = $("#Loginpwd").val();
        if ( IdNumber=='' && password==''){
            $("#info").text("提示:账号和密码不能为空");
        }else if (IdNumber == ''){
            $("#info").text("提示:账号不能为空");
        }else if (password == ''){
            $("#info").text("提示:密码不能为空");
        }else{
            $.ajax({
                type: "POST",
                url:"${path}/editor/login",
                data:{LoginId:IdNumber, Loginpwd:password},
                contentType :'application/x-www-form-urlencoded',
                dataType:"json",
                success: function (data) {
                    if(data.stateCode.trim() == "0") {
                        alert("提示:用户名不存在!");
                    } else if(data.stateCode.trim() == "1") {
                        alert("提示:密码错误!");
                    } else if(data.stateCode.trim() == "2"){
                        window.location.href="../..";

                    }
                }
            })
        }
    })
</script>
<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>
</body>
</html>