<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="<%=path %>/static/js/jquery-3.4.1.min.js"></script>
    <script src="<%=path %>/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <script src="<%=path %>/static/js/my_function.js"></script>
    <title>管理员</title>
</head>
<body>
<%@ include file="adminHeader.jsp"%>
<div class="container-fluid">
    <div class="row">
       <%@include file="adminPanel.jsp"%>
</div>
</div>
</body>
</html>
