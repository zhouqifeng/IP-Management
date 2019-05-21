<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>添加用户-IP后台管理系统</title>
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
            <label for="L_username" class="layui-form-label">
                <span class="we-red">*</span>账号
            </label>
            <div class="layui-input-inline">
                <input type="text" id="L_username" name="username" lay-verify="required|nikename" autocomplete="off" class="layui-input">
                <%--隐藏的创建者--%>
                <input type="hidden" name="adder" value="${user.username}" />
            </div>
            <div class="layui-form-mid layui-word-aux">
                请设置至少5个字符，将会成为您唯一的登录名
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_pass" class="layui-form-label">
                <span class="we-red">*</span>密码
            </label>
            <div class="layui-input-inline">
                <input type="password" id="L_pass" name="passwd" lay-verify="required|pass" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                6到16个字符
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
                <span class="we-red">*</span>确认密码
            </label>
            <div class="layui-input-inline">
                <input type="password" id="L_repass" name="repasswd" lay-verify="required|repass" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_oskey" class="layui-form-label">
                <span class="we-red">*</span>负责部门
            </label>
            <div class="layui-input-block" style="width:200px;">
                <select id="L_oskey" name="oskey" lay-verify="required"  lay-search>
                    <option>请选择</option>
                    <c:forEach items="${departs}" var="depart" varStatus="status">
                        <option value="${depart.id}">${depart.departname}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_isadmin" class="layui-form-label">
                <span class="we-red">*</span>权限
            </label>
            <div class="layui-input-block" style="width:100px;">
                <select id="L_isadmin" name="isadmin" lay-verify="required">
                    <option value="0">普通用户</option>
                    <option value="1">管理员</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_iprange" class="layui-form-label">
                <span class="we-red">*</span>ip段
            </label>
            <div class="layui-input-inline"  style="width: 125px;">
                <input type="text" id="L_iprange" name="iprange" autocomplete="off" class="layui-input" lay-verify="required|iprange">
            </div>
            <div class="layui-form-mid layui-word-aux">
                例:192.168.1.
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">
                    <span class="we-red">*</span>ip范围
                </label>
                <div class="layui-input-inline" style="width: 50px;">
                    <input type="text" id="L_ipstart" name="ipstart" autocomplete="off" class="layui-input" lay-verify="required">
                </div>
                <div class="layui-form-mid">-</div>
                <div class="layui-input-inline" style="width: 50px;">
                    <input type="text" id="L_ipend" name="ipend"  autocomplete="off" class="layui-input" lay-verify="required">
                </div>
                <div class="layui-form-mid layui-word-aux">
                    1 <= start <= end <=255
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
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
            nikename: function(value) {
                if(value.length < 5) {
                    return '昵称至少得5个字符';
                }
            },
            pass: [/(.+){6,12}$/, '密码必须6到12位'],
            repass: function(value) {
                if($('#L_pass').val() != $('#L_repass').val()) {
                    return '两次密码不一致';
                }
            },
            iprange: [/(?=(\b|\D))(((\d{1,2})|(1\d{1,2})|(2[0-4]\d)|(25[0-5]))\.){3}$/,'不符合格式'],
            ipstart: [/(?=(\b|\D))(((\d{1,2})|(1\d{1,2})|(2[0-4]\d)|(25[0-5])))$/,'不符合格式'],
            ipend: [/(?=(\b|\D))(((\d{1,2})|(1\d{1,2})|(2[0-4]\d)|(25[0-5])))$/,'不符合格式']
        });
        // 失去焦点时判断值为空不验证，一旦填写必须验证
        // $('input[name="email"]').blur(function(){
        //     //这里是失去焦点时的事件
        //     if($('input[name="email"]').val()){
        //         $('input[name="email"]').attr('lay-verify','email');
        //     }else{
        //         $('input[name="email"]').removeAttr('lay-verify');
        //     }
        // });

        //监听提交
        form.on('submit(add)', function(data) {
            //console.log(data.field);
            var f = data.field;
            //console.log(f);
            //console.log(JSON.stringify(f));
            //console.log(f.username);
            //console.log(f.sex);
            //var sex = $('input:radio[name="sex"]:checked').val();

            if($('#L_username').val() != "用户名已存在"){
                //发异步，把数据提交给后台
                $.ajax({
                    type: 'post',
                    url: '../../addAdmin', // ajax请求路径
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
            }else{
                layer.alert("请修改用户名", {
                    icon: 5
                });
            };

            return false;
        });

        $('input[name="username"]').blur(function(){
            if($('input[name="username"]').val() != ''){
                $.ajax({
                    type: 'post',
                    url: '../../searchUsername', // ajax请求路径
                    data: {'username':$('input[name="username"]').val()},
                    dataType: "json",
                    success : function(result) {
                        if (result.username == '1') {
                            $('#L_username').val("用户名已存在");
                        }
                    }
                });
            }
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