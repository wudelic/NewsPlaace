<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/static/css/bootstrap.min.css">
    <script src="/static/js/jquery-3.4.1.min.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
    <title>${news.topic} - NEWS </title>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>
<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default" id="main" style="">
        <div class="panel-heading" style="background-color: white">
            <div>
                <a href="#" onClick="javascript :history.back(-1);">返回上一页</a>
                <div class="panel-heading" style="background-color: white">
                    <h3>${news.topic}</h3><br/>
                </div>
                <div>
                    <c:if test="${not empty news.editor.name}">
                        <span><strong>主编：${news.editor.name}</strong></span><br>
                    </c:if>
                        <span ><strong>记者：${news.reporter.name}</strong></span><br>
                </div>
            </div>
            <div style="float: right;margin-top: -100px" >
                <fmt:formatDate value="${news.createTime}" type="date" dateStyle="long"></fmt:formatDate><br>
                <c:if test="${not empty news.editor.name}">
                <small class="text-muted">${news.click}次点击</small>
                </c:if>

            </div>
        </div>
        <ul class="list-group" style="width: 100%">
            <li class="list-group-item">
                ${news.content}
            </li>
        </ul>
    </div>
</div>
<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>
</body>
</html>