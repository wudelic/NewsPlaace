<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<c:if test="${empty RepId}">
    <c:if test="${empty EdiId}">
        <!-- 未登录 -->
        <div class="panel panel-default" id="sidebar2" style="width: 20%;margin:1% 2% 1% 0%;float: right">
            <div class="panel-heading" style="background-color: white;text-align: center">
                <div class="input-group">
                    <input type="text" class="form-control NTopic topic" placeholder="输入想看的新闻">
                    <span class="input-group-btn">
                    <button class="btn btn-default searchByTopic" type="button">搜索</button>
                    </span>
                </div>
                <div class="searchBox" style="position: absolute;z-index: 9999; background: #ffffff; width: 167.6px; border: 1px solid #ccc; display: none" >

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
                <a href="/reporter/member/${sessionScope.RepName}">${sessionScope.RepName}</a>
        </div>
        <ul class="list-group" style="width: 100%">
            <li class="list-group-item"><a href="/new">写新闻</a></li>
            <div class="input-group">
                <input type="text" class="form-control" placeholder="输入想看的新闻">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button">搜索</button>
                    </span>
            </div>
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
            <li class="list-group-item"><a href="/Edi/Nn">查看审核列表</a></li>
            <div class="input-group">
                <input type="text" class="form-control" placeholder="输入想看的新闻">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button">搜索</button>
                    </span>
            </div>
        </ul>
    </div>
</c:if>


<script>
    $(".searchByTopic").click(function(){
        var newsTopic = $(".topic").val();
        if (newsTopic == ""){
            alert("搜索不能为空");
            return false;
        }
        window.location.href="/n/newsTopic/"+ newsTopic;
    })
    function overFn(obj){
        $(obj).css("background", "#DBEAF9")
    }
    function outFn(obj){
        $(obj).css("background", "#fff")
    }
    function clickFn(obj){
        $(".topic").val($(obj).html());
        $(".searchBox").css("display", "none");
    }
    $(".NTopic").keyup(function () {
        var newsTopic = $(this).val();//新闻标题
        var content = "";
        if(newsTopic == ""){
            $(".searchBox").css("display","none");
            return ;
        }
        $.ajax({
            type:"get",
            url:"/news/getByTopic",
            cache:false,
            data:{newsTopic: newsTopic},
            success: function (data) {
                if(data.length>0){
                    for (var i=0;i<data.length;i++){
                        content += "<div style='text-align:left;padding: 5px;cursor: pointer; ' onclick='clickFn(this)' onmouseover='overFn(this)' onmouseout='outFn(this)'>"+data[i]+"</div>";
                    }
                    $(".searchBox").html(content);
                    $(".searchBox").css("display","block");
                }

            }
        })
    })
</script>

