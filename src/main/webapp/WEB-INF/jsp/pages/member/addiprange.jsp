<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>添加IP段-IP后台管理系统</title>
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
            <label for="L_iprange" class="layui-form-label">
                <span class="we-red">*</span>ip段
            </label>
            <div class="layui-input-inline" style="width: 125px;">
                <input type="text" id="L_iprange" name="iprange" autocomplete="off" class="layui-input" lay-verify="required|iprange">
                <%--隐藏的创建者--%>
                <input type="hidden" name="id" value="${id}" />
            </div>
            <div class="layui-form-mid layui-word-aux">
                例:192.168.110.
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">
                    <span class="we-red">*</span>ip范围
                </label>
                <div class="layui-input-inline" style="width: 50px;">
                    <input type="text" id="L_ipstart" name="ipstart" autocomplete="off" class="layui-input" lay-verify="required|ipstart">
                </div>
                <div class="layui-form-mid">-</div>
                <div class="layui-input-inline" style="width: 50px;">
                    <input type="text" id="L_ipend" name="ipend"  autocomplete="off" class="layui-input" lay-verify="required|ipend">
                </div>
                <div class="layui-form-mid layui-word-aux">
                    1 <= start <= end <=255
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">
            </label>
            <button class="layui-btn" lay-filter="add" lay-submit="">添加</button>
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
            iprange: [/(?=(\b|\D))(((\d{1,2})|(1\d{1,2})|(2[0-4]\d)|(25[0-5]))\.){3}$/,'ip段不符合格式'],
            ipstart: [/(?=(\b|\D))(((\d{1,2})|(1\d{1,2})|(2[0-4]\d)|(25[0-5])))$/,'ip范围不符合格式'],
            ipend: [/(?=(\b|\D))(((\d{1,2})|(1\d{1,2})|(2[0-4]\d)|(25[0-5])))$/,'ip范围不符合格式']
        });

        //监听提交
        form.on('submit(add)', function(data) {
            console.log(data.field);
            var f = data.field;
            //console.log(f);
            //console.log(JSON.stringify(f));
            //console.log(f.username);
            //console.log(f.sex);
            //var sex = $('input:radio[name="sex"]:checked').val();

            //发异步，把数据提交给后台
            $.ajax({
                type: 'post',
                url: '../../modifyiprange', // ajax请求路径
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

        $('input[name="ipstart"]').blur(function(){
            if($('input[name="ipstart"]').val() != '' && $('input[name="ipend"]').val() != ''){
                if(parseInt($('input[name="ipstart"]').val()) > parseInt($('input[name="ipend"]').val())){

                    layer.alert("ip范围不符合格式", {
                        icon: 5
                    });
                    $('input[name="ipstart"]').val('');
                    $('input[name="ipend"]').val('');
                }
            }
        });

        $('input[name="ipend"]').blur(function(){
            if($('input[name="ipstart"]').val() != '' && $('input[name="ipend"]').val() != ''){
                if(parseInt($('input[name="ipstart"]').val()) > parseInt($('input[name="ipend"]').val())){

                    layer.alert("ip范围不符合格式", {
                        icon: 5
                    });
                    $('input[name="ipstart"]').val('');
                    $('input[name="ipend"]').val('');
                }
            }
        });

    });
</script>
</body>

</html>