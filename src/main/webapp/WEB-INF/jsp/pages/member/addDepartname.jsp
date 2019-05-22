<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>添加部门-IP后台管理系统</title>
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
<div class="weadmin-body">
    <form class="layui-form">
        <div class="layui-form-item">
            <label for="L_departname" class="layui-form-label">
                <span class="we-red">*</span>部门
            </label>
            <div class="layui-input-inline">
                <input type="text" id="L_departname" name="departname" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_color" class="layui-form-label">
                <span class="we-red">*</span>颜色
            </label>
            <div class="layui-input-inline">
                <input type="text" id="L_color" name="color" lay-verify="required" placeholder="#000000" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">
            </label>
            <button class="layui-btn" lay-filter="add" lay-submit="">确定</button>
        </div>
    </form>
</div>
<script>
    layui.extend({
        admin: '{/}../../static/js/admin'
    });
    layui.use(['form', 'jquery','util','admin', 'layer'], function() {
        var form = layui.form,
            $ = layui.jquery,
            util = layui.util,
            admin = layui.admin,
            layer = layui.layer;

        //自定义验证规则
        form.verify({
            rgb: [/^#[0-9a-fA-F]{6}$/,'不符合格式'],
        });

        //监听提交
        form.on('submit(add)', function(data) {
            //console.log(data.field);
            var f = data.field;
            // console.log(f);
            // console.log(JSON.stringify(f));
            // console.log(f.username);
            // console.log(f.sex);
            // var sex = $('input:radio[name="sex"]:checked').val();
            // 发异步，把数据提交给后台
            $.post(
                '../../addDepartname',
                {
                    'departname':f.departname,
                    'color':f.color
                },
                //success:异步请求执行成功之后的回调函数
                function(data){
                if(data === 1){
                    layer.alert("增加成功", {
                        icon: 6
                    }, function() {
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                        parent.layui.table.reload('articleList');
                    });
                }else if(data === 2){
                    layer.alert("部门已存在", {
                        icon: 5
                    }, function() {
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                        parent.layui.table.reload('articleList');
                    });
                }else if(data === 3){
                    layer.alert("颜色已存在", {
                        icon: 5
                    }, function() {
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                        parent.layui.table.reload('articleList');
                    });
                }
            });
            return false;
        });
    });
</script>
</body>

</html>