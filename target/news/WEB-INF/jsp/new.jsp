<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script type="text/javascript" src="<%=path %>/static/js/wangEditor.js"></script>
    <title>发布新闻</title>
</head>
<body>
<%@ include file="header.jsp"%>
    <div style="width: 90%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default" id="main" style="">
        <div class="panel-heading" style="background-color: white">
            <a href="/">News</a> › 发布新闻
        </div>
        <div class="panel-body">
            <form action="/news/add" method="post" id="replyForm" >
                <div class="form-group">
                    <label for="tab">发布板块</label><br/>
                    <div class="col-sm-10" style="width: 15%">
                        <select class="form-control" id="tab" name="tab">
                            <c:forEach items="${tabs}" var="tab">
                                <option value="${tab.id}">${tab.tabName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div><br/>
                <div class="form-group">
                    <label for="topic">新闻标题</label>
                    <input type="text" class="form-control" id="topic" name="topic" placeholder="请输入主题标题" >
                    <span id="topicInfo" />
                </div>
                <div id="editor">
                    <p>请输入新闻内容</p>
                </div>
                <input class="input-xlarge focused hidden" name="content" type="text" id="information" >
                <br><input type="submit" class="btn btn-default btn-sm" id="submitbtn" value="发布新闻" onclick="return check();">
            </form>
        </div>
    </div>
</div>
<%@ include file="footer.jsp"%>
<script type="text/javascript">
    var E = window.wangEditor;
    var editor = new E('#editor');
   //使用base64保存图片
    // editor.customConfig.uploadImgShowBase64 = true;
    //开启debug模式
    editor.debug = location.href.indexOf('wangeditor_debug_mode=1') > 0;
    //忽略粘贴内容中的图片
    editor.customConfig.pasteIgnoreImg = true;
    //关闭粘贴内容中的样式
    editor.customConfig.pasteFilterStyle =  false;

    editor.customConfig.uploadFileName = 'Image';
    editor.customConfig.uploadImgServer = '/upload';
    editor.customConfig.uploadImgMaxSize = 3 * 1024 * 1024;
    //上传图片事件
    editor.customConfig.uploadImgHooks = {
        before : function(xhr, editor, files){

        },
        success : function (xhr, editor, result) {
            console.log("上传成功");
        },
        fail : function(xhr, editor, result){
            console.log("上传失败，原因是" + result);
        },
        error : function(xhr, editor){
            console.log("上传出错");
        },
        timeout : function(xhr, editor) {
            console.log("上传超时");
        }
    }
    editor.create();

    function check(){
        var topic = $("#topic").val();
        if (topic == ""){
            $("#topic").css("border-color", "red");
            $("#topicInfo").html("标题不能为空");
            return false;
        }
        if (topic != ""){
            $("#topic").css("border-color", "green");
            $("#topicInfo").html("");
            if(confirm("确定上传该新闻吗？")){
                var info = editor.txt.html();
                document.getElementById("information").value = info;
            }
        }


    }
</script>
</body>
</html>