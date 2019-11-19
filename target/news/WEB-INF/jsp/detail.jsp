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
    <link rel="stylesheet" href="<%=path %>/static/bootstrap-3.3.7-dist/css/bootstrap.css">
    <script src="<%=path %>/static/js/jquery-3.4.1.min.js"></script>
    <script src="<%=path %>/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>${news.topic} - NEWS </title>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>
<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default" id="main" style="">
        <div class="panel-heading" style="background-color: white">
            <%@include file="panel.jsp"%>
            <div>
                <div class="panel-heading" style="background-color: white">
                    <h3>${news.topic}</h3><br/>
                </div>
                <div>
                    <c:set var="aaaa">${news.editor.name}</c:set>
                    <c:if test="${aaaa==1}">
                        <span><strong>主编：未审核</strong></span><br>
                    </c:if>
                    <c:if test="${aaaa!=1}">
                        <span><strong>主编：${news.editor.name}</strong></span><br>
                    </c:if>
                    <a href="/member/${news.reporter.name}"><span ><strong>记者：${news.reporter.name}</strong></span></a><br>
                </div>
            </div>
            <div style="float: right;margin-top: -100px" >
                <fmt:formatDate value="${news.createTime}" type="date" dateStyle="long"></fmt:formatDate><br>
                <small class="text-muted">${news.click}次点击</small>

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
<script>
    alert(typeof (${news.editor.name}));
</script>
</body>
</html>