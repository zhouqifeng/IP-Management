<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>增加信息-IP后台管理系统</title>
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
            <label for="departid" class="layui-form-label">
                <span class="we-red">*</span>所属部门
            </label>
            <div class="layui-input-inline">
                <select name="departid"  id="departid" lay-verify="required">
                    <c:if test="${user.isadmin == 1}">
                        <option value="">请选择部门</option>
                        <c:forEach items="${departs}" var="depart" varStatus="status">
                            <option value="${depart.id}">${depart.departname}</option>
                        </c:forEach>
                    </c:if>
                    <c:if test="${user.isadmin == 0}">
                        <option value="${user.oskey}">${user.departname}</option>
                    </c:if>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="room" class="layui-form-label">
                <span class="we-red">*</span>所在地点
            </label>
            <div class="layui-input-inline">
                <input type="text" id="room" name="room" lay-verify="required|room" autocomplete="" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                如:[2009]
            </div>
        </div>
        <div class="layui-form-item">
            <label for="user" class="layui-form-label">
                <span class="we-red">*</span>当前使用者
            </label>
            <div class="layui-input-inline">
                <input type="text" id="user" name="user" lay-verify="required" value="公用机" autocomplete="" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                默认:[公用机]
            </div>
        </div>
        <div class="layui-form-item">
            <label for="tel" class="layui-form-label">
                <span class="we-red">*</span>联系方式
            </label>
            <div class="layui-input-inline">
                <input type="text" id="tel" name="tel" lay-verify="required|phone" autocomplete="" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                如:[2288,87661686]
            </div>
        </div>
        <div class="layui-form-item">
            <label for="ip" class="layui-form-label">
                <span class="we-red">*</span>IP地址
            </label>
            <div class="layui-input-inline">
                <input type="text" id="ip" name="ip" lay-verify="required|ip" autocomplete="" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="mac" class="layui-form-label">
                <span class="we-red">*</span>MAC地址
            </label>
            <div class="layui-input-inline">
                <input type="text" id="mac" name="mac" lay-verify="required|mac" autocomplete="" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                格式:[00E0-4CFA-C7AC]
            </div>
        </div>
        <div class="layui-form-item">
            <label for="type" class="layui-form-label">
                <span class="we-red">*</span>设备类型
            </label>
            <div class="layui-input-inline">
                <select name="type"  id="type" lay-verify="required">
                    <option>请选择</option>
                    <option value="台式机">台式机</option>
                    <option value="笔记本">笔记本</option>
                    <option value="路由器">路由器</option>
                    <option value="服务器">服务器</option>
                    <option value="打印机">打印机</option>
                    <option value="传真机">传真机</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="specifications" class="layui-form-label">
                计算机型号
            </label>
            <div class="layui-input-inline">
                <input type="text" id="specifications" name="specifications" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="buytime" class="layui-form-label">
                购买时间
            </label>
            <div class="layui-input-inline">
                <input type="text" id="buytime" name="buytime" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                格式:[2010-12]
            </div>
        </div>
        <div class="layui-form-item">
            <label for="others" class="layui-form-label">
                备注
            </label>
            <div class="layui-input-inline">
                <input type="text" id="others" name="others" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                20个字符以内
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">
            </label>
            <input type="hidden" name="adder" value="${user.username}" />
            <button class="layui-btn" lay-filter="add" lay-submit="">确定</button>
        </div>
    </form>
</div>
<script>
    layui.extend({
        admin: '{/}./static/js/admin'
    });
    layui.use(['form', 'jquery','util','admin', 'layer'], function() {
        var form = layui.form,
            $ = layui.jquery,
            util = layui.util,
            admin = layui.admin,
            layer = layui.layer;

        //自定义验证规则
        form.verify({
            others: function(value) {
                if(value.length > 20) {
                    return '备注不能超过20个字符';
                }
            },
            buytime: [/^((?:19|20)\d\d)-(0[1-9]|1[012])$/,'不符合格式'],
            room: [/^([0-2]{1})([0-9]{3})$/,'不符合格式'],
            phone: [/[0-2][0-9][0-9][0-9]\W[1-9]{1}[0-9]{5,8}$/,'不符合格式'],
            ip: [/(?=(\b|\D))(((\d{1,2})|(1\d{1,2})|(2[0-4]\d)|(25[0-5]))\.){3}((\d{1,2})|(1\d{1,2})|(2[0-4]\d)|(25[0-5]))(?=(\b|\D))$/,'不符合格式'],
            mac: [/[A-Za-z0-9]{4}\-[A-Za-z0-9]{4}\-[A-Za-z0-9]{4}/,'不符合格式']
        });
        //失去焦点时判断值为空不验证，一旦填写必须验证
        $('input[name="buytime"]').blur(function(){
            //这里是失去焦点时的事件
            if($('input[name="buytime"]').val()){
                $('input[name="buytime"]').attr('lay-verify','buytime');
            }else{
                $('input[name="buytime"]').removeAttr('lay-verify');
            }
        });

        $('input[name="ip"]').blur(function(){
            if($('input[name="ip"]').val() != ''){
                $.ajax({
                    type: 'post',
                    url: './searchIp', // ajax请求路径
                    data: {
                        'id':${user.id},
                        'ip':$('input[name="ip"]').val(),
                    },
                    dataType: "json",
                    success : function(result) {
                        if (result.status == '1') {
                            $('#ip').val("ip已存在");
                        }else if(result.status == '2'){
                            $('#ip').val("无权添加此ip");
                        }
                    }
                });
            }
        });

        //监听提交
        form.on('submit(add)', function(data) {
            //console.log(data.field);
            var f = data.field;
            console.log(JSON.stringify(f));
            //console.log(f.sex);
            //var sex = $('input:radio[name="sex"]:checked').val();

            //发异步，把数据提交给后台
            $.ajax({
                type: 'post',
                url: './addIp', // ajax请求路径
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
            });
            return false;
        });
    });
</script>
</body>

</html>