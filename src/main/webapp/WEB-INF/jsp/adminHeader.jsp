<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="utf-8"  %>
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#example-navbar-collapse">
                <span class="sr-only">切换导航</span>
            </button>
            <a class="navbar-brand" href="#">
                <img src="/images/admin.jpg" height="100%" />
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
                <li><a href="/admin/outLogin">安全退出</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

