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
    <script src="<%=path %>/static/js/bootstrap.min.js"></script>
    <title>Genesis › <c:if test="${!empty userInfo}">${userInfo.username}</c:if><c:if test="${!empty errorInfo}">会员未找到</c:if></title>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default" id="main" style="">
        <%@include file="panel.jsp"%>

        <div class="panel-body"><ul class="list-group" style="width: 100%">

            <!--所有发布的新闻视图-->
            <c:if test="${A==1}">
                <c:forEach items="${news}" var="news">
                    <li class="list-group-item">
                        <div style="height: 50px">
                            <div style="width: 75%;float: left">
                                <a href="/n/${news.id}">${news.topic}</a><br/>
                                <div>
                                    <span class="label label-default" >${news.tab.tabName}</span>
                                    <fmt:formatDate value="${news.createTime}" type="date" dateStyle="long"></fmt:formatDate>
                                </div>
                            </div>
                            <c:if test="${news.status==1}">
                                <div style="width: 15%;float: left;">
                                    <span>通过审核</span><br>
                                    <span class="glyphicon glyphicon-hand-right" aria-hidden="true"></span>点击量：${news.click}
                                   <div style="width: 5%;float: right">
                                       <button type="button" class="btn btn-danger deletebtn" aria-label="Left Align">
                                           <span class="glyphicon glyphicon-trash" aria-hidden="true">删除</span>
                                       </button>
                                   </div>
                                </div>
                            </c:if>
                            <c:if test="${news.status==0}">
                                <div style="width: 15%;float: left;">
                                    <span>审核中</span><br>
                                    <div style="width: 5%;float: right">
                                        <button type="button" class="btn btn-danger deletebtn" aria-label="Left Align">
                                            <span class="glyphicon glyphicon-trash" aria-hidden="true">删除</span>
                                        </button>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${news.status==2}">
                                <div style="width: 15%;float: left;">
                                    <span>审核未通过</span><br>
                                    <div style="width: 5%;float: right">
                                        <button type="button" class="btn btn-danger deletebtn" aria-label="Left Align">
                                            <span class="glyphicon glyphicon-trash" aria-hidden="true">删除</span>
                                        </button>
                                    </div>
                                </div>
                            </c:if>

                        </div>
                    </li>
                </c:forEach>
            </c:if>
            <!--待审核的新闻-->
            <c:if test="${N==1}">
                <c:forEach items="${news}" var="news">
                    <li class="list-group-item">
                        <div style="height: 50px">
                            <div style="float: left">
                                <a href="/n/${news.id}">${news.topic}</a><br/>
                                <div>
                                    <span class="label label-default" >${news.tab.tabName}</span>&nbsp;&nbsp;&nbsp;
                                    <fmt:formatDate value="${news.createTime}" type="date" dateStyle="long"></fmt:formatDate>
                                </div>
                            </div>
                            <div style="float: right;">
                                <span>审核中</span>
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
    $(document).on("click",".deletebtn",function(){
        var newsTopic = $(this).parent().parent().prev().children("a").text();
        if (confirm("确定要删除该新闻吗？")){
            $.ajax({
                url:"/news/delete",
                type:"get",
                data:{newsTopic:newsTopic},
                success:function (result) {
                    alert("删除成功");
                    location.reload();
                },
                error:function(){
                    alert("删除失败");
                }
            })
        }
    })
</script>
</body>
</html>