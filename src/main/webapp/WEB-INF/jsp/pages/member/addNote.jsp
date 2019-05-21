<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>添加公告-IP后台管理系统</title>
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
            <label for="L_bulletin" class="layui-form-label">
                <span class="we-red">*</span>公告内容
            </label>
            <div class="layui-input-inline">
                <input type="text" id="L_bulletin" name="bulletin" lay-verify="required" autocomplete="off" class="layui-input">
                <input type="hidden" name="creater" value="${user.username}" />
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

        //监听提交
        form.on('submit(add)', function(data) {
            //console.log(data.field);
            var f = data.field;
            console.log(f);
            console.log(JSON.stringify(f));
            //console.log(f.username);
            //console.log(f.sex);
            //var sex = $('input:radio[name="sex"]:checked').val();
            //发异步，把数据提交给后台
            $.ajax({
                type: 'post',
                url: '../../addNote', // ajax请求路径
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(f),
                dataType: "json"
            });
            layer.alert("增加成功", {
                icon: 6
            }, function() {
                // 获得frame索引
                var index = parent.layer.getFrameIndex(window.name);
                //关闭当前frame
                parent.layer.close(index);
                parent.layui.table.reload('articleList');
            });
            return false;
        });

    });
</script>
</body>

</html>