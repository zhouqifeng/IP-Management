<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-IP后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>

</head>

<body>
<div class="weadmin-nav">
        <span class="layui-breadcrumb">
        <a><cite>首页</cite></a>
        <a><cite>使用详情</cite></a>
      </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="weadmin-body">
    <blockquote class="layui-elem-quote">欢迎使用IP后台管理系统！</blockquote>
    <div class="layui-fluid" style="overflow: hidden;">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-xs4 layui-col-sm4 layui-col-md4">
                <div class="layui-card">
                    <div class="layui-card-header">
                        部门分类
                    </div>
                    <div class="layui-card-body">
                        <ul id="nav">
                            <c:if test="${user.isadmin == 1}">
                                <c:forEach items="${departs}" var="depart" varStatus="status">
                                    <li><a href="./member/indexlistdepart?departid=${depart.id}">${depart.departname}</a><br></li>
                                </c:forEach>
                            </c:if>
                            <c:if test="${user.isadmin == 0}">
                                <li><a href="./member/indexlistdepart?departid=${user.oskey}">${user.departname}</a><br></li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
            <%--class="layui-col-md5"--%>
            <div class="layui-col-xs5 layui-col-sm5 layui-col-md5">
                <div class="layui-card">
                    <div class="layui-card-header">
                        目前共有以下网段
                    </div>
                    <div class="layui-card-body">
                        <c:forEach items="${ips}" var="ip" varStatus="status">
                            <a href="./member/indexlistip?ip=${ip}">查看--<span class="we-red">${ip}</span>--网段IP使用情况>>></a><br>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
<script type="text/javascript">
    layui.extend({
        admin: '{/}../static/js/admin',
    });
    layui.use(['jquery', 'element', 'admin', 'carousel'], function() {
        var element = layui.element,
            $ = layui.jquery,
            carousel = layui.carousel,
            admin = layui.admin;
        //建造实例
        carousel.render({
            elem: '.weadmin-shortcut'
            ,width: '100%' //设置容器宽度
            ,arrow: 'none' //始终显示箭头
            ,trigger: 'hover'
            ,autoplay:false
        });
    });
</script>

</html>
