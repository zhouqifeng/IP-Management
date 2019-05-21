<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>打印列表-IP后台管理系统</title>
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
        <a><cite>打印管理</cite></a>
        <a><cite>打印列表</cite></a>
    </span>
    <a id="flash" class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">&#x1002;</i></a>
</div>
<div class="weadmin-body">
    <form class="layui-form" onsubmit="return false;">
        <div class="layui-form-item">
            <label class="layui-form-label">选择单位</label>
            <div class="layui-input-block" style="width:200px";>
                <select name="departid" lay-verify="required"  lay-search>
                    <c:if test="${user.isadmin == 1}">
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
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="formDemo">生成打印页</button>
                <span>（默认A4，横打，每页20行）</span>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    layui.extend({
        admin: '{/}../../static/js/admin'
    });
    layui.use(['admin','form'], function(){
        var form = layui.form,
        admin = layui.admin;

        //监听提交
        form.on('submit(formDemo)', function(data){

            //layer.msg(JSON.stringify(data.field));
            top.location.href="./printIpTable?departid=" + data.field.departid;
            return false;
        });
    });

</script>
</body>

</html>