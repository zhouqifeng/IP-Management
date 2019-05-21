<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>查询列表-IP后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
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
        <a><cite>查询管理</cite></a>
        <a><cite>查询列表</cite></a>
      </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="weadmin-body">
    <div class="layui-row">
        <form class="layui-form" onsubmit="return false;">
            <div class="layui-inline">
                <input type="text" id="keyword" name="keyword" placeholder="关键字" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-input-inline">
                <select name="searchItem" id="searchItem">
                    <option value="ip">IP地址</option>
                    <option value="mac">MAC地址</option>
                    <option value="room">所在地点</option>
                    <option value="user">使用者</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select name="departname"  id="departname">
                    <c:if test="${user.isadmin == 1}">
                        <option value="">请选择部门</option>
                        <c:forEach items="${departs}" var="depart" varStatus="status">
                            <option value="${depart.departname}">${depart.departname}</option>
                        </c:forEach>
                    </c:if>
                    <c:if test="${user.isadmin == 0}">
                        <option value="${user.departname}">${user.departname}</option>
                    </c:if>
                </select>
            </div>
            <button class="layui-btn" id="findButton" data-type="reload" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </form>
    </div>
    <%--表格容器--%>
    <table class="layui-hide" lay-filter="test" id="articleList" ></table>

</div>
<script type="text/html" id="barlist">
    <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">删除</a>
</script>
<script>
    layui.extend({
        admin: '{/}../../static/js/admin'
    });
    layui.use(['jquery','admin','table'], function() {
        var $ = layui.jquery,
            admin = layui.admin;
            table = layui.table;

        table.render({
            //elem\url\cols表格属性
            //type\field\title 表头属性
            //将数据绑定到这个容器上
            elem: '#articleList',
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
                {field: 'mac', title: 'MAC地址'},
                {fixed: 'right',title:'操作',width:"13%",align:'center',toolbar:"#barlist"}
            ]],
            page: true,
            limits: [10,20,50,100]
        });

        //定义了一个空对象
        var active = {
            reload: function () {
                //带条件重新加载表格
                var keyword = $('#keyword').val();
                var searchItem = $('#searchItem').val();
                var departname = $('#departname').val();

                table.reload('articleList',{

                    //发送这个异步请求到后台,从上面移下来的
                    url:'../../find',
                    //where
                    where:{
                        keyword:keyword,
                        searchItem:searchItem,
                        departname:departname
                    },
                    page: {
                        curr: 1
                    }
                });
            }
        };

        //搜索按钮的点击事件
        $('#findButton').click(function () {
            //获取按钮的data-type的值
            //find
            var type = $(this).data('type');
            //在js存在一个对象，对象叫active
            active[type] ? active[type].call(this) : '';
        });

        table.on('edit(test)', function(obj){
            var value = obj.value //得到修改后的值
                ,data = obj.data //得到所在行所有键值
                ,field = obj.field; //得到字段
            //layer.msg('[ID: '+ data.id +'] ' + field + ' 字段更改为：'+ value);
            $.post(
                '../../modifyIpconfig',
                {
                    'id' : data.id,
                    'field' : field,
                    'value' : value
                },
                //success:异步请求执行成功之后的回调函数
                function(data){
                    //至少更新一条记录
                    if (data > 0) {
                        //停留在原来页面刷新,使用的是分页按钮
                        $('.layui-laypage-btn').click();
                        layer.msg("更新成功！", {icon: 6});
                    }
                }
            );
        });

        table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象

            if(layEvent === 'edit'){ //查看
                //do somehing
                //layer.msg('ID：' + data.id + ' 的编辑操作');
                location.href="../../showIpFind?ip=" + data.ip;
            }else if(layEvent === 'delete'){
                layer.confirm('确认删除吗?', {icon: 3, title:'提示'}, function(index){
                    $.post(
                        '../../deleteIpconfig',
                        {
                            'id' : data.id
                        },
                        //success:异步请求执行成功之后的回调函数
                        function(data){
                            //至少更新一条记录
                            if (data > 0) {
                                //停留在原来页面刷新,使用的是分页按钮
                                $('.layui-laypage-btn').click();
                                layer.msg("删除成功！", {icon: 6});
                            }
                        }
                    );
                    layer.close(index);
                });
            }
        });
    });

</script>
</body>

</html>