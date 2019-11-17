<%--
  Created by IntelliJ IDEA.
  User: wu canlin
  Date: 2019/9/14/0014
  Time: 15:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员登陆界面</title>
</head>
<body>
    <center>

    <form action="/admin/checkLogin" method="post">
        用户名：<input type="text" name="username"><br>
        密码：  <input type="password" name="password"><br>
        <input type="submit" value="登陆">
    </form>
    </center>
<script>
    var errorMsg = '${errorMsg}';
    if(errorMsg != null && errorMsg != undefined && errorMsg != "")
        alert(errorMsg);
</script>
</body>
</html>
