<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="Content-Type"  content="text/html;charset=utf-8">
    <meta name="keywords" content="Newsssss">
    <title>新闻发布平台</title>
    <link rel="stylesheet" href="<%=path %>/static/bootstrap-3.3.7-dist/css/bootstrap.css">
    <script src="<%=path %>/static/js/jquery-3.4.1.min.js"></script>
    <script src="<%=path %>/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
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
<%@ include file="header.jsp"%>
<div class="panel panel-default" id="main" style="width: 70%;margin:1% 2% 5% 5%;float: left;">
    <div class="panel-heading" style="background-color: white">
        <a style="margin-right: 2%">近期</a>
    </div>
    <ul class="list-group" style="width: 100%">
    <c:forEach items="${news}" var="news">
        <c:if test="${news.status == 1}">
    <li class="list-group-item">
        <div style="height: 50px">
            <div style="width: 89%;float: left">
                <a href="/n/${news.id}">${news.topic}</a><br/>
                <div>
                    <a><span class="label label-default" >${news.tab.tabName}</span></a>&nbsp;&nbsp;&nbsp;
                    <fmt:formatDate value="${news.createTime}" type="date" dateStyle="long"></fmt:formatDate>
                </div>
            </div>
            <div style="width: 5%;float: right;text-align: center">
                <span class="badge">${news.click}</span>

            </div>
        </div>
    </li>
    </c:if>
    </c:forEach>
</ul>

</div>
<%@ include file="side.jsp"%>
<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

</body>
</html>