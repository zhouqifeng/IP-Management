<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>添加订单-后台管理系统-Admin 1.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/treeselect.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <%--<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/treeselect.js" charset="utf-8"></script>--%>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="weadmin-body">
    <form class="layui-form" lay-filter="formTest">
        <div class="layui-form-item">
            <label for="title" class="layui-form-label">
                <span class="we-red">*</span>商品标题
            </label>
            <div class="layui-input-inline">
                <input type="text" id="title" name="title" required="" lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label for="sellPoint" class="layui-form-label">商品卖点</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入卖点" id="sellPoint" name="sellPoint" class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="price" class="layui-form-label">
                <span class="we-red">*</span>商品价格
            </label>
            <div class="layui-input-inline">
                <input type="text" id="price" name="price" required="" lay-verify="number" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="num" class="layui-form-label">
                <span class="we-red">*</span>商品库存
            </label>
            <div class="layui-input-inline">
                <input type="text" id="num" name="num" required="" lay-verify="number" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="barcode" class="layui-form-label">
                <span class="we-red">*</span>条形码
            </label>
            <div class="layui-input-inline">
                <input type="text" id="barcode" name="barcode" required="" lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">
                <span class="we-red">*</span>商品类别
            </label>
            <div class="layui-input-inline">
                <select name="cid" lay-verify="" required>
                    <option value="000">请选择一个类别</option>
                    <option value="111">军事</option>
                    <option value="222">手机</option>
                    <option value="333">文艺</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="add" class="layui-form-label">
            </label>
            <button id="add" class="layui-btn" lay-filter="add" lay-submit="">增加</button>
        </div>
    </form>
</div>
<script>
    layui.extend({
        admin: '{/}../../static/js/admin',
        treeselect: '{/}../../static/js/treeselect'
    });
    layui.use(['form', 'admin','layer', 'jquery','layedit', 'treeselect'], function () {
        var form = layui.form,
            admin = layui.admin,
            layer = layui.layer,
            // layedit = layui.layedit,
            $ = layui.jquery;

        //第二步
        //初始化富文本编辑器
        // layedit.build('itemDesc', {
        //     height: 100,//设置编辑器高度
        //     uploadImage:{
        //         url:'../../uploadImage',
        //         type:'post'
        //     }
        // });

        //监听提交
        form.on('submit(add)', function (data) {
            console.log(data);
            var da = JSON.stringify(data.field);
            console.log(da);
            //发异步，把数据提交
            $.ajax({
                url : '../../items/add',
                data : da,
                contentType : "application/json",
                type : "post",
                dataType : 'json',
                success : function (data) {

                    layer.alert("增加成功", {
                        icon: 6
                    }, function () {
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                        //刷新父页面
                        window.parent.location.reload();
                    });
                }
            });
            return false;
        });
    });
</script>
</body>

</html>