<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>使用列表-IP后台管理系统</title>
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
<style>
    table td {
        border: 8px solid #ffffff;
    }
</style>
<body>
<div class="weadmin-nav">
        <span class="layui-breadcrumb">
        <a><cite>首页</cite></a>
        <a><cite>使用详情</cite></a>
        <a><cite>按IP段</cite></a>
      </span>
    <a id="window-comeback" class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" title="返回上一页">
        <i class="layui-icon" style="line-height:30px">&#xe65c;</i></a>
</div>

<div class="weadmin-body">

    <table width="98%" align="center">
        <tr>
            <td align="center"><span class="we-red">${ip}</span>--网段详细使用情况</td>
        </tr>
        <tr>
            <td align="center">
                <table align='center' width="100%">
                    <tr>
                    <c:forEach items="${list}" var="map" varStatus="st">
                        <c:if test="${map.ip % 15 == 1 && map.ip > 15 && map.ip < 255}">
                            </tr><tr>
                        </c:if>
                        <c:if test="${map.departid != null && user.isadmin == 1}">
                            <td height="28" align='center' bgcolor="${map.color}"><a href="../../showIp?ip=${ip}.${map.ip}">${map.ip}</a></td>
                        </c:if>
                        <c:if test="${map.departid != null && user.isadmin != 1 && map.departid == user.oskey }">
                            <td height="28" align='center' bgcolor="${map.color}"><a href="../../showIp?ip=${ip}.${map.ip}">${map.ip}</a></td>
                        </c:if>
                        <c:if test="${map.departid != null && user.isadmin != 1 && map.departid != user.oskey }">
                            <td height="28" align='center' bgcolor="${map.color}">${map.ip}</td>
                        </c:if>
                        <c:if test="${map.departid == null}">
                            <td height="28" align='center' bgcolor="${map.color}">${map.ip}</td>
                        </c:if>
                    </c:forEach>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table align='center' width="100%">
                    <tr>
                        <c:forEach items="${listDepart}" var="map" varStatus="st">
                            <c:if test="${st.index % 5 == 0 && st.index > 4}">
                                </tr><tr>
                            </c:if>
                            <td width="20%">
                                <table>
                                    <tr>
                                        <td height="28" width="28" align='left' bgcolor="${map.color}"></td>
                                        <td height="28" align="left">${map.departname}</td>
                                    </tr>
                                </table>
                            </td>
                        </c:forEach>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

</div>

</body>
<script>
    layui.extend({
        admin: '{/}../../static/js/admin'
    });
    layui.use(['admin','layer'], function(){

        var layer = layui.layer;

        var windowComeback = document.getElementById('window-comeback');
        windowComeback.addEventListener('click', function () {
            window.history.back(-1);
        });

    });

</script>
</html>