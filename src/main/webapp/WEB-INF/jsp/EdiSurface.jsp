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
    <title>Genesis › <c:if test="${!empty userInfo}">${userInfo.username}</c:if><c:if test="${!empty errorInfo}">会员未找到</c:if></title>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default" id="main" style="">
        <%@include file="panel.jsp"%>
        <div class="panel-body"><ul class="list-group" style="width: 100%">
            <!--审核过的新闻视图-->
            <c:if test="${A==1}">
                <c:forEach items="${news}" var="news">
                    <li class="list-group-item">
                        <div style="height: 50px">
                            <div style="width: 89%;float: left">
                                <a href="/n/${news.id}">${news.topic}</a><br/>
                                <div>
                                    <span class="label label-default" >${news.tab.tabName}</span>
                                    <fmt:formatDate value="${news.createTime}" type="date" dateStyle="long"></fmt:formatDate>
                                </div>
                            </div>
                            <div style="width: 13%;float: right;text-align: center">
                                <span class="glyphicon glyphicon-hand-right" aria-hidden="true"></span>点击量：${news.click}
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </c:if>
            <!--待审核的新闻-->
            <c:if test="${N==1}">
                <c:forEach items="${news}" var="news">
                    <li class="list-group-item">
                        <div style="height: 65px">
                            <div style="float: left">
                                <a href="/n/${news.id}">${news.topic}</a><br/>
                                <div>
                                    <span class="label label-default" >${news.tab.tabName}</span>&nbsp;&nbsp;&nbsp;
                                    <fmt:formatDate value="${news.createTime}" type="date" dateStyle="long"></fmt:formatDate>
                                </div>
                            </div>
                            <div style="float: right;">
                                <button type="button" class="btn btn-primary" id="passbtn" aria-label="Left Align">
                                    <span class="glyphicon glyphicon-ok" aria-hidden="true">通过</span>
                                </button>
                                <button type="button" class="btn btn-danger" id="unpassbtn" aria-label="Left Align">
                                    <span class="glyphicon glyphicon-remove" aria-hidden="true">不通过</span>
                                </button>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </c:if>
            <!--审核通过的新闻-->
            <c:if test="${P==1}">
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
                            <div style="width: 10%;float: right;text-align: center">
                                通过审核
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </c:if>
            <!--审核不通过的新闻-->
            <c:if test="${R==1}">
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
                            <div style="width: 10%;float: right;text-align: center">
                                审核不通过
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
        </div>
    </div>
</div>

<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>
<script>
    <!--ajax通过-->
    $(document).on("click","#passbtn",function(){
        var newsTopic = $(this).parent().prev().children("a").text();
        if(confirm("确定通过审核吗？")){
            $.ajax({
                url:"/news/pass",
                type:"GET",
                data:{newsTopic:newsTopic, Eid:${EdiId}},
                success:function(result){
                    alert("审核通过");
                    location.reload();
                },
                error:function () {
                    alert("审核失败");
                }
            })
        }
    });
    $(document).on("click","#unpassbtn",function(){
        var newsTopic = $(this).parent().prev().children("a").text();
        if(confirm("确定不允许该新闻发布吗？")){
            $.ajax({
                url:"/news/unpass",
                type:"get",
                data:{newsTopic:newsTopic, Eid:${EdiId}},
                success:function(result){
                    alert("成功");
                    location.reload();
                },
                error:function () {
                    alert("失败");
                }
            })
        }
    })
</script>
</body>

</html>