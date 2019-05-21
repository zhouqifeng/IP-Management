<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>IP后台管理系统-Admin 1.0</title>
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
        <a><cite>用户管理</cite></a>
        <a><cite>用户列表</cite></a>
      </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">&#x1002;</i></a>
</div>
<div class="weadmin-body">
    <c:if test = "${user.isadmin == 1}">
        <div class="weadmin-block demoTable">
            <button class="layui-btn layui-btn-danger" data-type="getCheckData"><i class="layui-icon"></i>删除</button>
            <button class="layui-btn" onclick="WeAdminShow('添加用户','./add',655,500)"><i class="layui-icon"></i>添加用户</button>
        </div>
    </c:if>
    <%--表格容器--%>
    <table class="layui-hide" lay-filter="test" id="articleList" ></table>

</div>
<script type="text/html" id="barlist">
    <a class="layui-btn layui-btn-xs" lay-event="edit">授权ip段</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">清空</a>
</script>
<script type="text/javascript">
    layui.extend({
        admin: '{/}../../static/js/admin'
    });
    layui.use(['jquery','admin','table'], function() {
        var $ = layui.jquery,
            admin = layui.admin,
            table = layui.table;

        //定义了一个空对象
        var active = {
            getCheckData: function () {
                var data = table.checkStatus("articleList").data;
                //console.log(data.length);
                if (data.length > 0) {
                    //有被选中的行
                    //定义空数组
                    var ids = [];
                    //遍历选中行，取出里面的id设值到数组中
                    for (var i = 0; i < data.length; i++) {
                        ids.push(data[i].id);
                    }
                    //异步请求
                    $.post(
                        '../../delAdmin',
                        {
                            'ids':ids
                        },
                        //success:异步请求执行成功之后的回调函数
                        function(data){
                            //至少删除一条记录
                            if (data > 0) {
                                //停留在原来页面刷新,使用的是分页按钮
                                $('.layui-laypage-btn').click();
                                layer.msg("恭喜，删除成功！", {icon: 1});
                            }else if(data == -1){
                                $('.layui-laypage-btn').click();
                                layer.msg("主管理员无法删除", {icon: 7});
                            }
                        }
                    );
                } else {
                    //没有选中行
                    layer.msg("请至少选中一行", {icon: 5});
                }
            },
            reload: function () {
                var title = $('#title').val();
                if(title != null && $.trim(title).length > 0){
                    //带条件重新加载表格
                    table.reload('articleList',{
                        //page
                        page: {curr:1},
                        //where
                        where:{title:title}
                    });
                }else if($.trim(title).length == 0){
                    //点击刷新按钮进行页面刷新
                    //$('#flash')[0].click();
                    //表格刷新
                    table.reload('articleList',{
                        page: {curr:1},
                        where:{
                            title:''
                        }
                    });
                }
            }
        };

        //批量删除按钮的点击事件
        $('.demoTable .layui-btn-danger').click(function () {
            //获取按钮的data-type的值
            //getCheckData
            var type = $(this).data('type');
            //在js存在一个对象，对象叫active
            active[type] ? active[type].call(this) : '';
        });

        if(${user.isadmin == 1}){
            table.render({
                //elem\url\cols表格属性
                //type\field\title 表头属性
                //将数据绑定到这个容器上
                elem: '#articleList',
                //发送这个异步请求到后台
                url:'../../Admin',
                //表头
                cols:[[
                    //10.30
                    {type: 'checkbox'},
                    {field: 'id', title: 'ID',sort: true},
                    {field: 'username', title: '账号',sort: true},
                    {field: 'passwd', title: '密码'},
                    {field: 'departname', title: '所管部门'},
                    {field: 'iprange', title: '授权IP段'},
                    //{field: 'creater', title: '创建人'},
                    {field: 'createtime', title: '创建时间'},
                    {fixed: 'right',title:'操作',width:"15%",align:'center',toolbar:"#barlist"}
                ]],
                page: true,
                limits: [5,10,20,50],
                // 10.30,后期渲染
                // done: function (res, curr, count) {
                //     $("[data-field='status']").children().each(function (i) {
                //         //text() html() val()
                //         if ($(this).text() == '1') {
                //             $(this).text('正常');
                //         } else if ($(this).text() == '2') {
                //             $(this).text('下架');
                //         } else if ($(this).text() == '3') {
                //             $(this).text('删除');
                //         }
                //     });
                // }
            });
        }else{
            table.render({
                elem: '#articleList',
                url:'../../Admin',
                cols:[[
                    //10.30
                    {type: 'checkbox'},
                    {field: 'id', title: 'ID',sort: true},
                    {field: 'username', title: '账号',sort: true},
                    {field: 'passwd', title: '密码',edit: 'text'},
                    {field: 'departname', title: '所管部门'},
                    {field: 'iprange', title: '授权IP段'},
                    {field: 'createtime', title: '创建时间'},
                ]],
                page: true,
                limits: [5,10,20,50],
            });
        }

        table.on('edit(test)', function(obj){
            var value = obj.value //得到修改后的值
                ,data = obj.data //得到所在行所有键值
                ,field = obj.field; //得到字段
            //console.log('[ID: '+ data.id +'] ' + field + ' 字段更改为：'+ value);
            if(data.id == ${user.id}){
                $.post(
                    '../../modifyAdmin',
                    {
                        'id': data.id,
                        'newpasswd': value
                    },
                    //success:异步请求执行成功之后的回调函数
                    function(data){
                        //至少删除一条记录
                        if (data > 0) {
                            //停留在原来页面刷新,使用的是分页按钮
                            $('.layui-laypage-btn').click();
                            layer.msg("恭喜，更新成功！", {icon: 1});
                        }
                    }
                );
            }else{
                //停留在原来页面刷新,使用的是分页按钮
                $('.layui-laypage-btn').click();
                layer.msg("权限不足,只能修改自己的密码!", {icon: 7});
            }

        });

        table.on('tool(test)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'del') {
                layer.confirm('确认清空吗?', {icon: 3, title:'提示'}, function(index){
                    //异步请求
                    $.post(
                        '../../delIPs',
                        {
                            'id' : data.id
                        },
                        //success:异步请求执行成功之后的回调函数
                        function(data){
                            //至少删除一条记录
                            if (data > 0) {
                                //停留在原来页面刷新,使用的是分页按钮
                                $('.layui-laypage-btn').click();
                                layer.msg("清空成功！", {icon: 6});
                            }
                        }
                    );
                    layer.close(index);
                });

            }else if (layEvent === 'edit') {

                WeAdminShow('添加ip段','./addiprange?id='+data.id,500,250);

                //layer.msg('ID：' + data.id + ' 的查看操作');

            };
        });
    });

</script>
</body>

</html>