<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="utf-8">
    <title>忘记密码</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
<div class="jumbotron">
    <div class="container">
        <form action="${pageContext.request.contextPath}/frontLogin/updatePWD" method="post">
            <fieldset>
                <div>
                    <input id="email" placeholder="E-mail" name="email" type="email" required="" autofocus="" />
                    <a href="javascript:void" style="float:center" onclick="getEmail()">发送验证码</a>
                </div>
                <div >
                    <input placeholder="验证码" name="code" type="text" required="" />
                </div>
                <div >
                    <input placeholder="密码" id="pwd1" name="password" type="password" required="" onkeyup="checkLength()" />
                            <span id="spanLen"></span>
                </div>
                <div >
                    <input placeholder="确认密码" id="pwd2" name="password2" type="password" required="" onblur="checkPSW()" />
                    <span id="pswInfo" style="color: #c41a15;"></span>
                </div>
                <a href="#" onClick="javascript :history.go(-1);">返回上一页</a>
                <font size="4" color="red"> ${loginError} </font>
                <button id="btforget" type="submit" >更新密码</button>
            </fieldset>
        </form>
    </div>
</div>

<script type="text/javascript">
    function getEmail(){
        var email = document.getElementById("email").value;
        if(email != ''){
            window.location.href = "/frontRegister/registerCode?email="+email;
        }else{
            alert("邮箱不能为空");
        }}
</script>

</body>
</html>



