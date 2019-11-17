<%--
  Created by IntelliJ IDEA.
  User: wu canlin
  Date: 2019/9/14/0014
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!-- 引入样式文件和动态控制 -->

    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="<%=path %>/static/js/jquery-3.4.1.min.js"></script>
    <script src="<%=path %>/static/js/bootstrap.js"></script>
    <script src="<%=path %>/static/js/my_function.js"></script>
    <title>管理员</title>
</head>
<body>
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#example-navbar-collapse">
                <span class="sr-only">切换导航</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">
                <img src="<%=path %>/images/admin.jpg" height="100%" />
            </a>
        </div>
        <div class="collapse navbar-collapse" id="example-navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a class="icon-bar" href="#">管理员</a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a>欢迎您,${sessionScope.admin.username}</a>
                </li>
                <li><a href="<%=path %>/admin/outLogin">安全退出</a>
                </li>
            </ul>
        </div>
    </div>
</nav>


<div class="container-fluid">
    <div class="row">
        <div class="col-sm-2">
            <button class="list-group-item active dropdown-toggle"><span class="glyphicon glyphicon-cog" ></span>人员管理
            </button>
            <div id="hide">
            <a href="<%=path %>/jsp/ManagementR.jsp" class="list-group-item">
                <span class="glyphicon glyphicon-align-left" aria-hidden="true">
                    </span>记者管理</a>
            <a href="<%=path %>/jsp/ManagementE.jsp" class="list-group-item">
                        <span class="glyphicon glyphicon-align-left" aria-hidden="true">
                    </span>主编管理</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
