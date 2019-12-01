<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style type="text/css">
    table{
        width:100%;
        border-collapse: collapse;
        table-layout:fixed;/* 只有定义了表格的布局算法为fixed，下面td的定义才能起作用。 */
        border:1px solid;

    }
    td{
        border:1px solid;
        overflow:hidden;		/* 内容超出宽度时隐藏超出部分的内容 */
        white-space:nowrap;		/* 不换行 */
        text-overflow:ellipsis;	/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/

    }
    th{
        border:1px solid;
    }
</style>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link href="${path}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=path %>/static/js/jquery-3.4.1.min.js"></script>
    <script src="<%=path %>/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <script src="<%=path %>/static/js/Editor.js"></script>
    <script src="<%=path %>/static/js/jquery.cityselect.js"></script>
    <script src = "/static/js/colResizable-1.6.js" ></script>
    <script src="/static/js/Editor.js"></script>
    <title>管理员</title>
</head>
<body>
<%@include file="adminHeader.jsp"%>

<div class="container-fluid">
    <div class="row">
        <%@include file="adminPanel.jsp"%>
        <div class="col-sm-10">
            <div class="panel panel-default">
                <div class="panel-heading">
                    搜索
                </div>
                <div class="panel-body">
                    <form  role="form" class="form-inline"><!--处理-->
                        <div class="form-group">
                            <input type="text" autocomplete="off" style="width: 170px" class="form-control SearchIdN"  name="idNumber" placeholder="请输入证件号" id="idN">
                            <div id="searchBox" style="position:absolute; z-index:9999; background:#ffffff; width: 170px; border: 1px solid #ccc;display: none">

                            </div>
                        </div>
                        <div class="form-group">
                            <input type="button" class="btn btn-default" id="searchByIdNumber" value="开始搜索"/>
                            <input type="button" class="btn btn-default" value="搜索全部" id="searchAll" />
                        </div>
                    </form>
                    <div class="col-md-4 col-md-offset-8">
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addEditor" href="">新增</button>
                        <button type="button" class="btn btn-danger" id="deleteAll-btn">批量删除</button>
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table style="table-layout: fixed" class="table table-striped" id="editor_table">
                    <thead>
                    <tr>
                        <th><input type="checkbox"  id="check_all"/></th>
                        <th>编号</th>
                        <th>姓名</th>
                        <th>密码</th>
                        <th>出生日期</th>
                        <th>性别</th>
                        <th>证件号</th>
                        <th>地址</th>
                        <th>电话</th>
                        <th>邮箱</th>
                        <th>介绍</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
            <!--分页-->
            <div class="row">
                <div class="col-md-6" id="page_info_area">

                </div>
                <div class="col-md-6" id="page_nav_area">

                </div>

            </div>
        </div>
        </div>
    </div>

<div id="addEditor" class="modal fade" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <button class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-title">
                <h1 class="text-center">新增</h1>
            </div>
            <div class="modal-body">
                <form class="form-group" >
                    <div class="form-group">
                        <label for="name">姓名</label>
                        <input class="form-control" type="text" id="name" required name="name">
                        <span id="nameInfo"></span>
                    </div>
                    <div class="form-group">
                        <label for="password">密码</label>
                        <input class="form-control" type="password" placeholder="至少6位字母或数字" id="password" name="password">
                        <span id="passwordInfo"></span>
                    </div>
                    <div class="form-group">
                        <label>性别</label><br>
                        <label for="male">男</label>
                        <input type="radio" name="gender" id="editmale" value="男">
                        <label for="female">女</label>
                        <input type="radio" name="gender" id="editfemale" value="女">
                    </div>
                    <div class="form-group">
                        <label for="idNumber">证件号</label>
                        <input class="form-control" type="text" required id="idNumber" name="idNumber">
                        <span id="idNumberInfo"></span>
                    </div>
                    <div class="form-group">
                        <label for="age">出生日期</label>
                        <input class="form-control" type="date" required id="age" name="age">
                    </div>
                    <div class="form-group">
                        <label for="">地址</label>
                        <div id="city">
                            <select class="prov" ></select>
                            <select class="city" disabled="disabled"></select>
                            <select class="dist" disabled="disabled"></select>
                        </div>
                        <input type="hidden" name="address" id="address" >
                    </div>
                    <div class="form-group">
                        <label for="phoneNum">手机号码</label>
                        <input class="form-control" type="text" required id="phoneNum" name="phoneNum">
                        <span id="phoneNumInfo"></span>
                    </div>
                    <div class="form-group">
                        <label for="email">邮箱</label>
                        <input class="form-control" type="email" placeholder="例如:123@123.com" id="email" name="email">
                        <span id="emailInfo"></span>
                    </div>
                    <div class="form-group">
                        <label for="detail">介绍你自己</label>
                        <input class="form-control" type="text" id="detail" name="detail">
                    </div>
                    <div class="text-right">
                        <button class="btn btn-primary submit" type="button" id="addEdi" onclick="test()"  >提交</button>
                        <button class="btn btn-danger" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div id="editEditorModal" class="modal fade" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <button class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-title">
                <h1 class="text-center">修改用户信息</h1>
            </div>
            <div class="modal-body">
                <form class="form-group" >
                    <div class="form-group">
                        <label for="name">姓名</label>
                        <input class="form-control" type="text" id="editname" required name="name">
                        <span id="editnameInfo"></span>
                    </div>
                    <div class="form-group">
                        <label for="password">密码</label>
                        <input class="form-control" type="password"  id="editpassword" name="password" >
                        <span id="editpasswordInfo"></span>
                    </div>
                    <div class="form-group">
                        <label>性别</label><br>
                        <label for="male">男</label>
                        <input type="radio" name="gender" id="male" value="男">
                        <label for="female">女</label>
                        <input type="radio" name="gender" id="female" value="女">
                    </div>
                    <div class="form-group">
                        <label for="idNumber">证件号</label>
                        <input class="form-control" type="text" required id="editidNumber" name="idNumber">
                        <span id="editidNumberInfo"></span>
                    </div>
                    <div class="form-group">
                        <label for="phoneNum">手机号码</label>
                        <input class="form-control" type="text" required id="editphoneNum" name="phoneNum">
                        <span id="editphoneNumInfo"></span>
                    </div>
                    <div class="form-group">
                        <label for="email">邮箱</label>
                        <input class="form-control" type="email"  id="editemail" name="email">
                        <span id="editemailInfo"></span>
                    </div>
                    <div class="text-right">
                        <button class="btn btn-primary submit" type="button" id="saveEdiUpdate">更新</button>
                        <button class="btn btn-danger" data-dismiss="modal">取消</button>
                    </div>
                    <input type="hidden" name="_method" value="PUT"/>
                </form>
            </div>
        </div>
    </div>
</div>

    <script type="text/javascript">
        var currentPage;
        var total;
        var pn = 1;
        $("#searchByIdNumber").click(function () {
            var idNumber = $("#idN").val();
            if (idNumber ==""){
                alert("搜索不能为空");
                return false;
            }
            to_page(1);
        })
        $("#searchAll").click(function(){
            var idNumber = "";
            to_page(1);
        })
        function to_page(pn){
            var idNumber = $("#idN").val();
            $.ajax({
                url:"${path}/editor/query/EdiByIdNum",
                data:{pn:pn, idNumber:idNumber},
                type:"GET",
                success:function (result) {
                    build_editor_table(result);
                    build_page_info(result);
                    build_page_nav(result);
                }
            })
        }

        function build_editor_table(result){
                    $("#editor_table tbody").empty();

                    var editor = result.extend.pageInfo.list;
                    $.each(editor,function (index, item) {
                        var checkboxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                        var idTd = $("<td></td>").append(item.id);
                        var passwordTd = $("<td></td>").addClass("pwdLength").append(item.password);
                        var nameTd = $("<td></td>").append(item.name);
                        var ageTd = $("<td></td>").append(item.age);
                        var genderTd = $("<td></td>").append(item.gender);
                        var idNumberTd = $("<td></td>").append(item.idNumber);
                        var addressTd = $("<td></td>").append(item.address);
                        var phoneNumTd = $("<td></td>").append(item.phoneNum);
                        var emailTd = $("<td></td>").append(item.email);
                        var detailTd = $("<td></td>").append(item.detail);

                        var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit-btn")
                            .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                        var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete-btn")
                            .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                        var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                            editBtn.attr("edit_id", item.id);
                        $("<tr></tr>").append(checkboxTd)
                            .append(idTd)
                            .append(nameTd)
                            .append(passwordTd)
                            .append(ageTd)
                            .append(genderTd)
                            .append(idNumberTd)
                            .append(addressTd)
                            .append(phoneNumTd)
                            .append(emailTd)
                            .append(detailTd)
                            .append(btnTd)
                            .appendTo("#editor_table tbody");
                    });
                }
        function build_page_info(result){
                    $("#page_info_area").empty();
                    $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+
                        result.extend.pageInfo.pages+"页,总"+
                        result.extend.pageInfo.total+"条记录");
                        currentPage = result.extend.pageInfo.pageNum;
                        total = result.extend.pageInfo.pages;
                }
        function build_page_nav(result){
                    $("#page_nav_area").empty();

                    var ul = $("<ul></ul>").addClass("pagination");

                    //构建元素
                    var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
                    var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
                    if(result.extend.pageInfo.hasPreviousPage == false){
                        firstPageLi.addClass("disabled");
                        prePageLi.addClass("disabled");
                    }else{
                        //为元素添加点击翻页
                        firstPageLi.click(function(){
                            to_page(1);
                        })
                        prePageLi.click(function(){
                            to_page(result.extend.pageInfo.pageNum-1);
                        })
                    }

                    var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
                    var laststPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
                    if(result.extend.pageInfo.hasNextPage == false){
                        nextPageLi.addClass("disabled");
                        laststPageLi.addClass("disabled");
                    }else{
                        //为元素添加点击翻页
                        nextPageLi.click(function(){
                            to_page(result.extend.pageInfo.pageNum+1);
                        })
                        laststPageLi.click(function(){
                            to_page(result.extend.pageInfo.pages);
                        })
                    }
                    //添加首页和前一页的显示
                    ul.append(firstPageLi).append(prePageLi);

                    //1,2,..5遍历给ul中添加页码提示
                    $.each(result.extend.pageInfo.navigatepageNums,function(index,item){

                        var numLi = $("<li></li>").append($("<a></a>").append(item));
                        if(result.extend.pageInfo.pageNum == item){
                            numLi.addClass("active");
                        }
                        numLi.click(function(){
                            to_page(item);
                        })

                        ul.append(numLi);

                    })
                    //添加下一页和末页的提示
                    ul.append(nextPageLi).append(laststPageLi);
                    //把ul加入到nav
                    var navEle = $("<nav></nav>").append(ul);
                    navEle.appendTo("#page_nav_area");

                };

        $(document).on("click",".delete-btn",function(){
            //alert($(this).parents("tr").find("td:eq(1)").text());
            var delete_id = $(this).parents("tr").find("td:eq(1)").text();
            var delete_name = $(this).parents("tr").find("td:eq(2)").text();
            if (confirm("你确认要删除"+delete_name+"吗?")){
                $.ajax({
                    url:"${path}/editor/delete/" + delete_id,
                    type:"GET",
                    success:function(result){
                        to_page(1);
                        alert("删除成功");
                    },
                    error:function(){
                        alert("删除失败");
                    }
                })
            }
        });

        $(document).on("click",".edit-btn",function(){
            var edi_id = $(this).attr("edit_id");
            $("#saveEdiUpdate").attr("edit_id",edi_id);
            $.ajax({
                url:"${path}/editor/"+edi_id,
                type:"GET",
                success:function (result) {
                    $("#editname").val(result.extend.edi.name);
                    $("#editpassword").val(result.extend.edi.password);
                    $("#editEditorModal input[name=gender]").val([result.extend.edi.gender]);
                    $("#editidNumber").val(result.extend.edi.idNumber);
                    $("#editphoneNum").val(result.extend.edi.phoneNum);
                    $("#editemail").val(result.extend.edi.email);
                }
            });
            $('#editEditorModal').modal({
                backdrop:'static'
            })
        });

        $("#saveEdiUpdate").click(function(){
            var edi_id = $(this).attr("edit_id");
            $.ajax({
                url:"${path}/editor/update/" + edi_id,
                type:"PUT",
                data:$("#editEditorModal form").serialize(),
                success:function(result){
                        $("#editEditorModal").modal('hide');
                        to_page(currentPage);
                        alert("修改成功");
                },
                error:function(){
                    alert("修改失败");
                }
            })
        });
        $("#addEdi").click(function () {
            $.ajax({
                url:"${path}/editor/add",
                data:$("#addEditor form").serialize(),
                type:'post',
                success:function(result){
                    $("#addEditor").modal('hide');
                    to_page(total);
                    alert("新增成功");
                },
                error:function(){
                    alert("新增失败");
                }
            })
        });
        $("#city").citySelect({
            prov: "广东",
            city: "珠海",
            dist: "金湾区",
            nodata: "none",
        });
        function test(){
            var prov = $(".prov option:selected");
            var city = $(".city option:selected");
            var dist = $(".dist option:selected");
            var address = prov.val()+city.val()+dist.val();
            $("#address").val(address);
        };
        function overFn(obj){
            $(obj).css("background", "#DBEAF9")
        }
        function outFn(obj){
            $(obj).css("background", "#fff")
        }
        function clickFn(obj){
            $("#idN").val($(obj).html());
            $("#searchBox").css("display", "none");
        }
        $(".SearchIdN").keyup(function(){
            var idNumber = $(this).val();
            var content = "";
            if(idNumber == ""){
                $("#serchBox").css("display","none");
                return ;
            }
            $.ajax({
                type:"GET",
                url:"${path}/editor/getIdNumber",
                cache:false,
                data:{idNumber: idNumber},
                success: function(data){
                    if (data.length>0){
                        for (var i=0;i<data.length;i++){
                            content += "<div style='padding: 5px;cursor: pointer; ' onclick='clickFn(this)' onmouseover='overFn(this)' onmouseout='outFn(this)'>"+data[i]+"</div>";
                        }
                        $("#searchBox").html(content);
                        $("#searchBox").css("display","block");
                    }
                }
            })
        });

        $("#check_all").click(function(){
            var status = $(this).prop("checked");
            $(".check_item").prop("checked",status);
        });
        $(document).on("click",".check_item",function(){
            var check_length = $(".check_item:checked").length;
            var total_length = $(".check_item").length;
            if(check_length == total_length ){
                $("#check_all").prop("checked",true);
            }else{
                $("#check_all").prop("checked",false);
            }
        });
        $("#deleteAll-btn").click(function(){
            var checkNum = $(".check_item:checked").length;
            if (checkNum == 0){
                {
                    alert("请至少选择一个！");
                    return;
                }
            }
            if(confirm("确定删除选中项目?")){
                var checkedList = new Array();
                var ids = '';
                $(".check_item:checkbox").each(function(){
                    if (this.checked == true){
                        checkedList.push($(this).parents("tr").find("td:eq(1)").text());
                    }
                });
                $.ajax({
                    type:"post",
                    url:"${path}/editor/deleteByIds",
                    data:{ids:checkedList.toString()},
                    success:function(){
                        alert("删除成功");
                        to_page(1)
                        $("#check_all").prop("checked",false);
                    },
                    error:function () {
                        alert("删除失败");
                    }
                })
            }
        })
        $(function(){
            //此处实现表格可拖放属性
            $("#editor_table").colResizable({
                liveDrag:true,//实现实时拖动，可看见拖动轨迹
                draggingClass:"dragging", //防止拖动出险虚标线
            });
        });
    </script>
</body>
</html>
