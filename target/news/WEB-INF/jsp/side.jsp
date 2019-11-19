<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>


<c:if test="${empty RepId}">
    <c:if test="${empty EdiId}">
        <!-- 未登录 -->
        <div class="panel panel-default" id="sidebar2" style="width: 20%;margin:1% 2% 1% 0%;float: right">
            <div class="panel-heading" style="background-color: white;text-align: center">
                <div class="input-group">
                    <input type="text" class="form-control" style=""value="输入想要找的新闻">
                    <span class="input-group-addon btn btn-primary glyphicon glyphicon-search" ></span>
                </div>
            </div>
            <ul class="list-group" style="width: 100%">
                <li class="list-group-item">
                    <a href="/signup" class="btn btn-default btn-block">成为主编</a>
                    <a href="/signin" class="btn btn-primary btn-block">登录</a>
                </li>
            </ul>
        </div>
    </c:if>

</c:if>

<c:if test="${!empty RepId}">
    <!-- 记者已登录 -->
    <div class="panel panel-default" id="sidebar2" style="width: 20%;margin:1% 2% 1% 0%;float: right">
        <div class="panel-heading" style="background-color: white;text-align: center">
                <a href="/member/${sessionScope.RepName}">${sessionScope.RepName}</a>
        </div>
        <ul class="list-group" style="width: 100%">
            <li class="list-group-item"><a href="/new">写新闻</a></li>
        </ul>
    </div>
</c:if>

<c:if test="${!empty EdiId}">
    <!-- 主编已登录-->
    <div class="panel panerl-defalut" id="sidebar3" style="width: 20%;margin:1% 2% 1% 0%;float: right">
        <div class="panel-heading" style="background-color: white;text-align: center">
            <a href="/editor/member/${sessionScope.EdiName}">${sessionScope.EdiName}</a>
        </div>
        <ul class="list-group" style="width: 100%">
            <li class="list-group-item"><a href="/new">查看审核列表</a></li>
            <li class="list-group-item"><a href="">查看</a></li>
        </ul>
    </div>
</c:if>




