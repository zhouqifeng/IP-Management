<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>IP后台管理系统</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>

</head>

<body>
<!-- 顶部开始 -->
<div class="container">
    <div class="logo">
        <a href="./index">欢迎您，${user.username}！</a>
    </div>
    <div class="left_open">
        <i title="展开左侧栏" class="iconfont">&#xe699;</i>
    </div>
    <ul class="layui-nav left fast-add" lay-filter="">
        <li class="layui-nav-item">
            <a onclick="WeAdminShow('增加信息','./add',550,550)">+增加信息</a>
        </li>
    </ul>
    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item">
            <c:if test="${user.isadmin == 1}">
                <a href="javascript:;">管理员</a>
            </c:if>
            <c:if test="${user.isadmin == 0}">
                <a href="javascript:;">普通用户</a>
            </c:if>
            <dl class="layui-nav-child">
                <!-- 二级菜单 -->
                <dd>
                    <a class="loginout" href="./logout">退出</a>
                </dd>
            </dl>
        </li>
    </ul>

</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav">
    <div id="side-nav">
        <ul id="nav">
            <li>
                <a _href="./pages/welcome">
                    <i class="layui-icon layui-icon-home"></i>
                    <cite>首页</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
            </li>
            <li>
                <a _href="./pages/member/list">
                    <i class="layui-icon layui-icon-user"></i>
                    <cite>用户管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
            </li>
            <li>
                <a _href="./pages/member/departlist">
                    <i class="layui-icon layui-icon-read"></i>
                    <cite>部门管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
            </li>
            <li>
                <a _href="./pages/member/findlist">
                    <i class="layui-icon layui-icon-search"></i>
                    <cite>高级查找</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
            </li>
            <c:if test="${user.isadmin == 1}">
                <li>
                    <a _href="./pages/member/notelist">
                        <i class="layui-icon layui-icon-component"></i>
                        <cite>公告管理</cite>
                        <i class="iconfont nav_right">&#xe697;</i>
                    </a>
                </li>
            </c:if>
            <li>
                <a _href="./pages/member/print">
                    <i class="layui-icon layui-icon-about"></i>
                    <cite>打印输出</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
            </li>
        </ul>
    </div>
    <div class="layui-carousel" id="test1" style="margin-top: 50px;">
        <div carousel-item="">
            <c:forEach items="${notes}" var="note" varStatus="status">
               <div><br><br><br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;${note}</div>
            </c:forEach>
        </div>
    </div>
</div>
<!-- <div class="x-slide_left"></div> -->
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
    <div class="layui-tab tab" lay-filter="wenav_tab" id="WeTabTip" lay-allowclose="true">
        <ul class="layui-tab-title">
            <li lay-id="1">首页</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src='./pages/welcome' tab-id="1" frameborder="0" scrolling="yes" class="weIframe"></iframe>
            </div>
        </div>
    </div>
</div>
<div class="page-content-bg"></div>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->
<!-- 底部开始 -->
<div class="footer">
    <div class="copyright" style="text-align:center;">2009～2012&nbsp;&nbsp;版权所有©&nbsp;浙江农资集团&nbsp;&nbsp;地址：中国杭州市滨江区泰安路199号农资大厦</div>
</div>
<!-- 底部结束 -->
<script type="text/javascript">

    layui.extend({
        admin: '{/}./static/js/admin'
    });
    layui.use(['carousel','jquery','admin'], function(){
        var carousel = layui.carousel
            , $ = layui.jquery;
        $(function(){
            var login = JSON.parse(localStorage.getItem("login"));
            if(login){
                if(login=0){
                    window.location.href='./login';
                    return false;
                }else{
                    return false;
                }
            }else{
                window.location.href='./login';
                return false;
            }
        });

        //改变下时间间隔、动画类型、高度
        carousel.render({
            elem: '#test1'
            ,interval: 2500
            ,arrow: 'hover'
            ,anim: 'updown'
            ,indicator: 'none'
            ,height: '200px'
            ,width: '220px'
        });
    });

</script>
</body>
<!--Tab菜单右键弹出菜单-->
<ul class="rightMenu" id="rightMenu">
    <li data-type="fresh">刷新</li>
    <li data-type="current">关闭当前</li>
    <li data-type="other">关闭其它</li>
    <li data-type="all">关闭所有</li>
</ul>

</html>