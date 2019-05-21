<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>IP后台管理系统</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>

</head>
<body class="login-bg">

<div class="login">
    <div class="message">IP管理系统-后台登录</div>
    <div id="darkbannerwrap"></div>

    <form method="post" class="layui-form" >
        <input name="username" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
        <hr class="hr15">
        <input name="passwd" placeholder="密码" type="password" lay-verify="required" class="layui-input">
        <hr class="hr15">
        <input class="loginin" value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
        <hr class="hr20" >
        <%--<div>--%>
            <%--前端静态展示，请随意输入，即可登录。--%>
        <%--</div>--%>
    </form>
</div>

<script type="text/javascript">

    if (window != top){
        top.location.href = location.href;
    }

    layui.extend({
        admin: '{/}./static/js/admin'
    });
    layui.use(['jquery','form','admin'], function(){
        var form = layui.form
            ,$ = layui.$
            ,admin = layui.admin;
        //监听提交
        form.on('submit(login)', function(data){
            var f = data.field;
            $.ajax({
                type: 'post',
                url: './Adminlogin', // ajax请求路径
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(f),
                dataType:"TEXT",
                success: function(data){
                    if(data.trim()=="ok")
                    {
                        location.href='./index';
                    }
                    else
                    {
                        layer.alert("用户名或密码错误");
                    }
                }
            });
            return false;
        });
    });
</script>
<!-- 底部结束 -->
</body>
</html>
