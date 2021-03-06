<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>公告列表-IP后台管理系统</title>
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
        <a><cite>公告管理</cite></a>
        <a><cite>公告列表</cite></a>
      </span>
    <a id="flash" class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">&#x1002;</i></a>
</div>

<div class="weadmin-body">
    <div class="weadmin-block demoTable">
        <button class="layui-btn layui-btn-danger" data-type="getCheckData"><i class="layui-icon"></i>批量删除</button>
        <button class="layui-btn" onclick="WeAdminShow('添加公告','./addNote',400,200)"><i class="layui-icon"></i>添加公告</button>
    </div>
    <%--表格容器--%>
    <table class="layui-hide" lay-filter="test" id="articleList" ></table>

</div>
<%--<script type="text/html" id="shelfTpl">--%>
        <%--<form class="layui-form">--%>
            <%--<input type="checkbox" name="itemstatus" lay-filter="itemstatus" lay-skin="switch" lay-text="正常|下架" {{1==d.status?'checked':''}}/>--%>
        <%--</form>--%>
<%--</script>--%>
<script type="text/html" id="myTpl">
    <div class="layui-form">
        <input type="checkbox" name="status" id="status" value="{{'启用' == d.status ? 0 : 1}}" lay-skin="switch" lay-text="启用|禁用" {{ '启用' == d.status ? 'checked':'' }}/>
    </div>
</script>
<script>
    layui.extend({
        admin: '{/}../../static/js/admin'
    });
    layui.use(['admin','table','jquery','form'], function(){
        var table = layui.table,
            $ = layui.jquery,
            form = layui.form;

        table.render({
            //elem\url\cols表格属性
            //type\field\title 表头属性
            //将数据绑定到这个容器上
            elem: '#articleList',
            //发送这个异步请求到后台
            url:'../../note',
            //表头
            cols:[[
                //10.30
                {type: 'checkbox'},
                {field: 'id', title: '公告ID',width:"15%"},
                {field: 'bulletin', title: '内容',edit: 'text',width:"40%"},
                {field: 'time', title: '创建时间',width:"20%"},
                {field: 'status', title: '公告状态',templet:'#myTpl'}
            ]],
            page: true,
            limits: [5,10]
        });


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
                        '../../delNote',
                        {'ids':ids},
                        //success:异步请求执行成功之后的回调函数
                        function(data){
                            //至少删除一条记录
                            if (data > 0) {
                                //停留在原来页面刷新,使用的是分页按钮
                                $('.layui-laypage-btn').click();
                                layer.msg("恭喜，删除成功！", {icon: 1});
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

        table.on('edit(test)', function(obj){
            var value = obj.value //得到修改后的值
                ,data = obj.data //得到所在行所有键值
                ,field = obj.field; //得到字段
            //layer.msg('[ID: '+ data.id +'] ' + field + ' 字段更改为：'+ value);
            $.post(
                '../../modifyNote',
                {
                    'id': data.id,
                    'newNote': value
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
        });

        form.on('switch', function(data){

            //获取当前控件
            var selectIfKey=data.othis;
            //获取当前所在行
            var parentTr = selectIfKey.parents("tr");
            var dataId = $(parentTr).find("td:eq(1)").find(".layui-table-cell").text();

            console.log(dataId);
            console.log(data.elem); //得到checkbox原始DOM对象
            console.log(data.elem.checked); //开关是否开启，true或者false
            console.log(data.value); //开关value值，也可以通过data.elem.value得到
            console.log(data.othis); //得到美化后的DOM对象

            //异步请求
            $.post(
                '../../modifyBulletin',
                {
                    'id':dataId,
                    'status':data.value
                },
                //success:异步请求执行成功之后的回调函数
                function(result){
                    if (result > 0) {
                        //停留在原来页面刷新
                        //value与checked的值是相反的(禁用-checked,启用-''),因为点击后原来是启用变成禁用,需要发送禁用的值
                        $('.layui-laypage-btn').click();
                        if(data.value == 1){
                            layer.msg("已启用！", {icon: 6});
                        }else{
                            layer.msg("已禁用！", {icon: 5});
                        }
                    }
                }
            );

        });
    });

</script>
</body>
</html>