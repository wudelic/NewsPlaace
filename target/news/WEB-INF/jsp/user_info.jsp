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
    <link rel="stylesheet" type="text/css" href="/static/css/bootstrap.min.css">
    <script src="/static/js/jquery-3.4.1.min.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
    <title>News › <c:if test="${!empty userInfo}">${userInfo.username}</c:if><c:if test="${!empty errorInfo}">会员未找到</c:if></title>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default" id="main" style="">
       <%@include file="panel.jsp"%>
        <div class="panel-body">
            <c:if test="${!empty RepInfo}">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${RepInfo.name}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${RepInfo.gender}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">身份证</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${RepInfo.idNumber}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">地址</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${RepInfo.address}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${RepInfo.email}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">联系电话</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${RepInfo.phoneNum}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${RepInfo.detail}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">创建时间</label>
                        <div class="col-sm-10">
                            <fmt:formatDate value="${RepInfo.createTime}" type="date" dateStyle="long"></fmt:formatDate>
                        </div>
                    </div>
                </form>
            </c:if>

            <c:if test="${!empty EdiInfo}">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${EdiInfo.name}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${EdiInfo.gender}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">身份证</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${EdiInfo.idNumber}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">地址</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${EdiInfo.address}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${EdiInfo.email}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">联系电话</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${EdiInfo.phoneNum}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${EdiInfo.detail}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">创建时间</label>
                        <div class="col-sm-10">
                            <fmt:formatDate value="${EdiInfo.createTime}" type="date" dateStyle="long"></fmt:formatDate>
                        </div>
                    </div>
                </form>
            </c:if>
        </div>
    </div>
</div>

<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

</body>
</html>