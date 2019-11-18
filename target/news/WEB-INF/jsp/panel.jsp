<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:if test="${!empty RepId}">
    <!--记者用户-->
<div class="panel-heading" style="background-color: white">
    <a href="/">用户</a>
    › <a href="/reporter/member/${sessionScope.RepName}" style="margin-left: 2%">个人资料</a>
    | <a href="/Rep/An" style="margin-left: 2%">所有新闻</a>
    | <a href="/Rep/Pn" style="margin-left: 2%">过审核的新闻</a>
    | <a href="/Rep/Nn" style="margin-left: 2%">待审核的新闻</a>
    | <a href="/Rep/Rn" style="margin-left: 2%">未通过的新闻</a>
</div>
</c:if>

<c:if test="${!empty EdiId}">
    <!--主编用户-->
    <div class="panel-heading" style="background-color: white">
        <a href="/">用户</a>
        › <a style="margin-left: 2%">个人资料</a>
        | <a style="margin-left: 2%">审核过的新闻</a><!--包括不通过和通过的-->
        | <a style="margin-left: 2%">待审核的新闻</a>
        | <a style="margin-left: 2%">审核通过的新闻</a>
        | <a style="margin-left: 2%">审核不通过的新闻</a>
    </div>
</c:if>