<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String Rpath = request.getContextPath();
%>
<html>
<head>
    <script src="<%=Rpath %>/static/js/Reporter.js"></script>
    <script src="<%=Rpath %>/static/js/jquery.cityselect.js"></script>
</head>
<body>
<header>
    <nav class="navbar navbar-default" role="navigation" style="background-color: white">
        <div class="container-fluid" style="margin-left: 10%">
            <div class="navbar-header">
                <a class="navbar-brand" href="/">LOOK NEWS</a>
            </div>

            <div>
                <!--向左对齐-->
                <ul class="nav navbar-nav navbar-left">
                    <li <c:if test="${tab.tabNameEn == 'play'}">
                        class="active" </c:if>><a href="/tab/play">娱乐</a>
                    </li>
                    <li <c:if test="${tab.tabNameEn == 'science'}">class="active"
                    </c:if>><a href="/tab/science">科学</a></li>
                    <li <c:if test="${tab.tabNameEn == 'sport'}">class="active"
                    </c:if>><a href="/tab/sport">体育</a></li>
                    <li <c:if test="${tab.tabNameEn == 'other'}">class="active"
                    </c:if>><a href="/tab/other">其他</a></li>

                </ul>

                <c:if test="${empty RepId}">
                    <c:if test="${empty EdiId}">
                        <!--未登陆-->
                        <ul class="nav navbar-nav navbar-right">
                            <li>
                                <p class="navbar-text"><a data-toggle="modal" data-target="#Rsignin">记者登录</a></p>
                            </li>
                            <li>
                                <p class="navbar-text"><a data-toggle="modal" data-target="#Rsignup">记者注册</a></p>
                            </li>
                        </ul>
                    </c:if>
                </c:if>
                <c:if test="${!empty RepId}">
                    <!--记者已登陆-->
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <p class="navbar-text"><a href="/">首页</a></p>
                        </li>
                        <li>
                            <p class="navbar-text"><a href="/reporter/member/${sessionScope.RepName}">${sessionScope.RepName}</a></p>
                        </li>
                        <li>
                            <p class="navbar-text"><a href="/reporter/outLogin">登出</a></p>
                        </li>
                    </ul>
                </c:if>
                <c:if test="${!empty EdiId}">
                    <!--主编已登陆-->
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <p class="navbar-text"><a href="/">首页</a></p>
                        </li>
                        <li>
                            <p class="navbar-text"><a href="/editor/member/${sessionScope.EdiName}">${sessionScope.EdiName}</a></p>
                        </li>
                        <li>
                            <p class="navbar-text"><a href="${Rpath}/editor/outLogin">登出</a></p>
                        </li>
                    </ul>
                </c:if>
            </div>
        </div>
    </nav>
</header>
<!-- 注册窗口 -->
<div id="Rsignup" class="modal fade" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <button class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-title">
                <h1 class="text-center">成为记者</h1>
            </div>
            <div class="modal-body">
                <form class="form-group" action="<%=Rpath %>/reporter/signUp" method="post">
                    <div class="form-group">
                        <label for="name">姓名</label>
                        <input class="form-control" type="text" id="name" required name="name">
                        <span id="nameInfo"></span>
                    </div>
                    <div class="form-group">
                        <label for="password">密码</label>
                        <input class="form-control" type="password" placeholder="至少6位字母或数字" id="password" name="password">
                        <span id="passwordInfo"></span>
                    </div>
                    <div class="form-group">
                        <label for="rpassword">再次输入密码</label>
                        <input class="form-control" type="password" placeholder="至少6位字母或数字" id="rpassword" name="rpassword">
                        <span id="rpasswordInfo"></span>
                    </div>
                    <div class="form-group">
                        <label>性别</label><br>
                        <label for="male">男</label>
                        <input type="radio" name="gender" id="male" value="男">
                        <label for="female">女</label>
                        <input type="radio" name="gender" id="female" value="女">
                    </div>
                    <div class="form-group">
                        <label for="idNumber">证件号</label>
                        <input class="form-control" type="text" required id="idNumber" name="idNumber">
                        <span id="idNumberInfo"></span>
                    </div>
                    <div class="form-group">
                        <label for="age">出生日期</label>
                        <input class="form-control" type="date" required id="age" name="age">
                    </div>
                    <div class="form-group">
                        <label for="">地址</label>
                        <div id="city">
                            <select class="prov" ></select>
                            <select class="city" disabled="disabled"></select>
                            <select class="dist" disabled="disabled"></select>
                        </div>
                        <input type="hidden" name="address" id="address" >
                    </div>
                    <div class="form-group">
                        <label for="phoneNum">手机号码</label>
                        <input class="form-control" type="text" required id="phoneNum" name="phoneNum">
                        <span id="phoneNumInfo"></span>
                    </div>
                    <div class="form-group">
                        <label for="email">邮箱</label>
                        <input class="form-control" type="email" placeholder="例如:123@123.com" id="email" name="email">
                        <span id="emailInfo"></span>
                    </div>
                    <div class="form-group">
                        <label for="detail">介绍你自己</label>
                        <input class="form-control" type="text" id="detail" name="detail">
                    </div>
                    <div class="text-right">
                        <button class="btn btn-primary submit" type="submit" onclick="return check(), test()" >提交</button>
                        <button class="btn btn-danger" data-dismiss="modal">取消</button>
                    </div>
                    <a href="" data-toggle="modal" data-dismiss="modal" data-target="#Rsignin">已有账号？点我登录</a>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 登录窗口 -->
<div id="Rsignin" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <button class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-title">
                <h1 class="text-center">登录</h1>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="LoginID">证件号</label>
                        <input class="form-control" type="text" placeholder="请输入证件号" id="LoginID" required>
                    </div>
                    <div class="form-group">
                        <label for="Loginpwd">密码</label>
                        <input class="form-control" type="password" placeholder="请输入密码" id="Loginpwd" required>
                    </div>
                    <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
                    <div class="text-right">
                        <button class="btn btn-primary" type="button" id="loginButton" >登录</button>
                        <button class="btn btn-danger" data-dismiss="modal">取消</button>
                    </div>
                    <a href="" data-toggle="modal" data-dismiss="modal" data-target="#Rsignup">还没有账号？点我注册</a>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>

<script>
    function signout_confirm()
    {
        var r=confirm("确定退出?")
        if (r==true)
        {window.location.href="/reporter/outLogin";}
        else
        {}
    }
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
                url:"${Rpath}/reporter/login",
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

    $("#city").citySelect({
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