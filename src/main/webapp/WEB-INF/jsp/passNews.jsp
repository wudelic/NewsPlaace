<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Genesis › <c:if test="${!empty userInfo}">${userInfo.username}</c:if><c:if test="${!empty errorInfo}">会员未找到</c:if></title>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default" id="main" style="">
        <%@include file="panel.jsp"%>

        <div class="panel-body"><ul class="list-group" style="width: 100%">
            <c:forEach items="${news}" var="news">
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
            </c:forEach>
        </ul>
        </div>
    </div>
</div>

<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

</body>
</html>