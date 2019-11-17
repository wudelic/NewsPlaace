<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>主编注册</title>
    <link rel="stylesheet" href="<%=path %>/static/bootstrap-3.3.7-dist/css/bootstrap.css">
    <script src="<%=path %>/static/js/jquery-3.4.1.min.js"></script>
    <script src="<%=path %>/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="<%=path %>/static/js/jquery.cityselect.js" charset="gbk"></script>
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


<nav class="navbar navbar-default" role="navigation" style="background-color: white">
    <div class="container-fluid" style="margin-left: 10%">
        <div class="navbar-header">
            <a class="navbar-brand" href="/">LOOK NEWS</a>
        </div>
    </div>
</nav>

<div class="panel panel-default" style="width: 55%;margin-left: 10%;margin-top: 5%;margin-bottom: 5%">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">成为主编
        </h3>
    </div>
    <div class="panel-body">
        <form  method="post" class="form-horizontal" role="form" style="margin-left: 5%" action="<%=path %>/editor/signUp">
            <div class="form-group" >
                <label class="col-sm-2 control-label">姓名</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="text" class="form-control" id="name" name="name" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">密码</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="password" class="form-control" id="password" name="password" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">再次输入密码</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="password" class="form-control" id="rpassword" name="rpassword" required="required">
                </div>
            </div>
            <div class="form-group" >
                <label class="col-sm-2 control-label">性别</label>&nbsp;&nbsp;&nbsp;
                <label for="male">男</label>
                <input type="radio" name="gender" id="male" value="男">
                <label for="female">女</label>
                <input type="radio" name="gender" id="female" value="女">
            </div>
            <div class="form-group" >
                <label class="col-sm-2 control-label">证件号</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="text" class="form-control" id="idNumber" name="idNumber" required="required">
                </div>
            </div>
            <div class="form-group" >
                <label class="col-sm-2 control-label">出生日期</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input class="form-control" type="date" required id="age" name="age">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">地址</label>
                <div id="City">&nbsp;&nbsp;&nbsp;
                    <select class="prov" ></select>
                    <select class="city" disabled="disabled"></select>
                    <select class="dist" disabled="disabled"></select>
                </div>
                <input type="hidden" name="address" id="address" >
            </div>
            <div class="form-group" >
                <label class="col-sm-2 control-label">手机号码</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input class="form-control" type="text" required id="phoneNum" name="phoneNum">
                </div>
            </div>
            <div class="form-group" >
                <label class="col-sm-2 control-label">邮箱</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input class="form-control" type="email" placeholder="例如:123@123.com" id="email" name="email">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">介绍你自己</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input class="form-control" type="text" id="detail" name="detail">
                </div>
            </div>
            <input  type="submit" onclick=" test()"  value="提交" style="margin-left: 17%"/>
        </form>
    </div>
</div>
<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

</body>
</html>
<script>
    $("#City").citySelect({
        prov: "广东",
        city: "珠海",
        dist: "金湾区",
        nodata: "none",
    })

    function test(){
        var prov = $(".prov option:selected");
        var city = $(".city option:selected");
        var dist = $(".dist option:selected");
        var address = prov.val()+city.val()+dist.val();
        $("#address").val(address);
    }
</script>