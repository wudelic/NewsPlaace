<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>主编设置新密码</title>
</head>
<body>
<form action="/editor/setPassword"  method="post">
    <table width="250" border="1">
        <h1>已发送验证码到您的邮箱</h1>
        <tr>
            <td>验证码</td>
            <td><input type="text" name="securityCode"/></td>
        </tr>
        <tr>
            <td>新密码:</td>
            <td><input type="password" name="password"/></td>
        </tr>
        <tr>
            <td>邮 箱:</td>
            <td><input type="text" name="email"/></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" name="submit" value="重置密码"/></td>
        </tr>
    </table>
</form>
</body>
</html>