<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>主编邮箱验证</title>
</head>
<body>
<form action="/editor/reSetPassword"  method="post">
    <table width="250" border="1">
        <tr>
            <td>邮 箱:</td>
            <td><input type="text" name="email"/></td>
            <td><input type="submit" name="submit" value="提交"/></td>
        </tr>
    </table>
</form>
</body>
</html>



