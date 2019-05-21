<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>使用列表-IP后台管理系统</title>
    <meta name="Description" content="基于layUI数据表格操作"/>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <%--<script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <%--<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/itemlist.js" charset="utf-8"></script>--%>

    <!--<script type="text/javascript" src="../../static/js/admin.js"></script>-->
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="weadmin-nav">
        <span class="layui-breadcrumb">
        <a><cite>首页</cite></a>
        <a><cite>使用详情</cite></a>
        <a><cite>按部门</cite></a>
      </span>
    <a id="window-comeback" class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" title="返回上一页">
        <i class="layui-icon" style="line-height:30px">&#xe65c;</i></a>
</div>

<div class="weadmin-body">
    <%--表格容器--%>
    <table class="layui-hide" lay-filter="test" id="articleList" ></table>

</div>
<%--<script type="text/html" id="shelfTpl">--%>
        <%--<form class="layui-form">--%>
            <%--<input type="checkbox" name="itemstatus" lay-filter="itemstatus" lay-skin="switch" lay-text="正常|下架" {{1==d.status?'checked':''}}/>--%>
        <%--</form>--%>
    <%--</script>--%>
    <script>
        layui.extend({
            admin: '{/}../../static/js/admin'
        });
        layui.use(['admin','table','jquery'], function(){
            var table = layui.table,
                $ = layui.jquery;
            var windowComeback = document.getElementById('window-comeback');

            windowComeback.addEventListener('click', function () {
                window.history.back(-1);
            });
            table.render({
                //elem\url\cols表格属性
                //type\field\title 表头属性
                //将数据绑定到这个容器上
                elem: '#articleList',
                //发送这个异步请求到后台
                url:'../../indexdepart',
                //表头
                cols:[[
                    //10.30
                    {field: 'id', title: '序号',sort: true},
                    {field: 'departname', title: '所在部门'},
                    {field: 'room', title: '所在地',sort: true},
                    {field: 'user', title: '使用者'},
                    {field: 'type', title: '设备类型'},
                    {field: 'tel', title: '联系方式'},
                    {field: 'ip', title: 'IP地址',sort: true},
                    {field: 'mac', title: 'MAC地址'}
                ]],
                page: true,
                limits: [10,20,50,100],
                where:{
                    departid : ${departid}
                }
            });

        });

    </script>

</div>
</body>

</html>