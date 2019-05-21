<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>网络IP地址使用详细情况表打印</title>
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
<!--media=print 这个属性可以在打印时有效-->
<style type="text/css" media=print>
    .Noprint{
        display:none;
        font-family: "宋体";
        font-size: 9pt;
    }
    .PageNext{
        page-break-after: always;
    }
</style>
<style>
    .tdp {
        border-bottom: 0px solid #000000;
        border-left: 0px solid #000000;
        border-right: 0px solid #ffffff;
        border-top: 0px solid #ffffff;
        text-align: center;
    }
    .tabp {
        border-color: #000000;
        border-style: solid;
        border-top-width: 2px;
        border-right-width: 1px;
        border-bottom-width: 2px;
        border-left-width: 1px;
    }
    td {
        font-family: "宋体";
        font-size: 9pt;
        line-height: 200%;
    }
</style>

<body>
<c:forEach items="${ipTable.data}" var="list" varStatus="st">
    <table width="100%" border="0" cellspacing="2" cellpadding="5">
        <tr>
            <td width="940" align="center"><div align="center"><font size="4"><b>${ipTable.year}年度${user.departname}网络IP地址使用详细情况表</b></font></div></td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="2" cellspacing="0" class="tabp">
        <tr>
            <td width="5%"  class="tdp"><div align="center"><b>序号</b></div></td>
            <td width="15%" class="tdp"><div align="center"><b>用户名称</b></div></td>
            <td width="10%" class="tdp"><div align="center"><b>所在房间</b></div></td>
            <td width="15%" class="tdp"><div align="center"><b>联系方式</b></div></td>
            <td width="15%" class="tdp"><div align="center"><b>设备类型</b></div></td>
            <td width="20%" class="tdp"><div align="center"><b>IP地址</b></div></td>
            <td width="20%" class="tdp"><div align="center"><b>MAC地址</b></div></td>
        </tr>
        <c:forEach items="${list}" var="ip" varStatus="status">
            <tr>
                <td class="tdp"><div align="center"><b>${ip.id}</b></div></td>
                <td class="tdp"><div align="center"><b>${ip.user}</b></div></td>
                <td class="tdp"><div align="center"><b>${ip.room}</b></div></td>
                <td class="tdp"><div align="center"><b>${ip.tel}</b></div></td>
                <td class="tdp"><div align="center"><b>${ip.type}</b></div></td>
                <td class="tdp"><div align="center"><b>${ip.ip}</b></div></td>
                <td class="tdp"><div align="center"><b>${ip.mac}</b></div></td>
            </tr>
        </c:forEach>
    </table>
    <table width="100%" border="0" cellspacing="2" cellpadding="5">
        <tr>
            <td width="32">&nbsp;</td>
            <td width="177">IP地址总数：${ipTable.count}</td>
            <td width="199">填报负责人：${user.username}</td>
            <td width="171">填报时间：${ipTable.time}</td>
            <td width="102">页码：${st.count}/${ipTable.pages}</td>
        </tr>
    </table>
    <hr style="border:1px solid orangered;align-content: center;width: 100%"  noshade="noshade" class="Noprint">
    <!--分页符号-->
    <div class="PageNext"></div>
</c:forEach>
<center class="Noprint" >
    <input type=button name="button_print" value="打印" onClick=javascript:window.print()>
    <input type=button name="button_fh"    value="返回" onClick=javascript:window.history.back(-1);>
</center>
</body>
</html>