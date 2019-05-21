<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>部门列表-IP后台管理系统</title>
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
    <style type="text/css">
        .layui-form-switch {
            width: 55px;
        }
        .layui-form-switch em {
            width: 40px;
        }
        .layui-form-onswitch i {
            left: 45px;
        }
        body{overflow-y: scroll;}
    </style>
</head>

<body>
<div class="weadmin-nav">
        <span class="layui-breadcrumb">
        <a><cite>首页</cite></a>
        <a><cite>部门管理</cite></a>
        <a><cite>部门列表</cite></a>
      </span>
    <a id="flash" class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">&#x1002;</i></a>
</div>
<div class="weadmin-body">
    <c:if test="${user.isadmin == 1}">
        <div class="weadmin-block demoTable">
            <%--<button class="layui-btn layui-btn-danger" data-type="getCheckData"><i class="layui-icon">&#xe640;</i>删除</button>--%>
            <button class="layui-btn" onclick="WeAdminShow('添加部门','./addDepartname',400,200)"><i class="layui-icon">&#xe61f;</i>添加部门</button>
            <span class="we-red">*注意,删除操作会删去部门管理员信息,请谨慎!!</span>
        </div>
    </c:if>
    <%--表格容器--%>
    <table class="layui-hide" lay-filter="test" id="articleList" ></table>

    <%--<script type="text/html" id="shelfTpl">--%>
        <%--<form class="layui-form">--%>
            <%--<input type="checkbox" name="itemstatus" lay-filter="itemstatus" lay-skin="switch" lay-text="正常|下架" {{1==d.status?'checked':''}}/>--%>
        <%--</form>--%>
    <%--</script>--%>
    <script type="text/html" id="barlist">
        <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">删除</a>
    </script>
    <script>
        layui.extend({
            admin: '{/}../../static/js/admin'
        });
        layui.use(['admin','layer','table','jquery','form'], function(){
            var table = layui.table,
                layer = layui.layer,
                $ = layui.jquery;

            if(${user.isadmin == 1}){
                table.render({
                    //elem\url\cols表格属性
                    //type\field\title 表头属性
                    //将数据绑定到这个容器上
                    elem: '#articleList',
                    //发送这个异步请求到后台
                    url:'../../departname',
                    //表头
                    cols:[[
                        {field: 'id', title: '部门ID'},
                        {field: 'departname', title: '部门名称',edit: 'text'},
                        {field: 'addtime', title: '创建时间'},
                        {fixed: 'right',title:'操作',width:"8%",align:'center',toolbar:"#barlist"}
                        // ,
                        // {fixed: 'right', title:'操作', toolbar: '#operateTpl', width:150}
                    ]],
                    page: true,
                    limits: [5,10,20,50]
                });
            }else{
                table.render({
                    elem: '#articleList',
                    url:'../../departname',
                    //表头
                    cols:[[
                        {field: 'id', title: '部门ID'},
                        {field: 'departname', title: '部门名称',edit: 'text'},
                        {field: 'addtime', title: '创建时间'},
                    ]],
                    page: true,
                    limits: [5,10,20,50]
                });
            }


            table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象

                if(layEvent === 'delete'){

                    if(data.id == 1){
                        layer.msg("集团本部不允许删除！", {icon: 5});
                    }else{
                        layer.confirm('确认删除吗?', {icon: 3, title:'提示'}, function(index){
                            $.post(
                                '../../delDepartname',
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
                                    }else if(data == 0){
                                        layer.msg("有关联信息,无法删除！", {icon: 5});
                                    }
                                }
                            );
                            layer.close(index);
                        });

                    }
                }
            });

            table.on('edit(test)', function(obj){
                var value = obj.value //得到修改后的值
                    ,data = obj.data //得到所在行所有键值
                    ,field = obj.field; //得到字段
                //layer.msg('[ID: '+ data.id +'] ' + field + ' 字段更改为：'+ value);
                $.post(
                    '../../modifyDepartname',
                    {
                        'id': data.id,
                        'newName': value
                    },
                    //success:异步请求执行成功之后的回调函数
                    function(data){
                        //至少删除一条记录
                        if (data == 1) {
                            //停留在原来页面刷新,使用的是分页按钮
                            $('.layui-laypage-btn').click();
                            layer.msg("更新成功！", {icon: 6});
                        }else if(data == 2){
                            $('.layui-laypage-btn').click();
                            layer.msg("部门已存在,无法更新!", {icon: 5});
                        }
                    }
                );
            });

            //定义了一个空对象
            // var active = {
            //     getCheckData: function () {
            //         var data = table.checkStatus("articleList").data;
            //         //console.log(data.length);
            //         if (data.length > 0) {
            //             //有被选中的行
            //             //定义空数组
            //             var ids = [];
            //             //遍历选中行，取出里面的id设值到数组中
            //             for (var i = 0; i < data.length; i++) {
            //                 ids.push(data[i].id);
            //             }
            //             //异步请求
            //             $.post(
            //                 '../../delDepartname',
            //                 {'ids':ids},
            //                 //success:异步请求执行成功之后的回调函数
            //                 function(data){
            //                     //至少删除一条记录
            //                     if (data > 0) {
            //                         //停留在原来页面刷新,使用的是分页按钮
            //                         $('.layui-laypage-btn').click();
            //                         layer.msg("恭喜，删除成功！", {icon: 1});
            //                     }
            //                 }
            //             );
            //         } else {
            //             //没有选中行
            //             layer.msg("请至少选中一行", {icon: 5});
            //         }
            //     },
            //     reload: function () {
            //         var title = $('#title').val();
            //         if(title != null && $.trim(title).length > 0){
            //             //带条件重新加载表格
            //             table.reload('articleList',{
            //                 //page
            //                 page: {curr:1},
            //                 //where
            //                 where:{title:title}
            //             });
            //         }else if($.trim(title).length == 0){
            //             //点击刷新按钮进行页面刷新
            //             //$('#flash')[0].click();
            //             //表格刷新
            //             table.reload('articleList',{
            //                 page: {curr:1},
            //                 where:{
            //                     title:''
            //                 }
            //             });
            //         }
            //     }
            // };
            //
            // //批量删除按钮的点击事件
            // $('.demoTable .layui-btn-danger').click(function () {
            //     //type需要在第一个function下初始化
            //     var type = $(this).data('type');
            //     layer.confirm('确认删除吗?', {icon: 3, title:'提示'}, function(index){
            //         active[type] ? active[type].call(this) : '';
            //         layer.close(index);
            //     });
            // });
        });

    </script>

</div>
</body>

</html>