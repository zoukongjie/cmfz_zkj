<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script charset="utf-8" src="${path}/kindeditor/kindeditor-all-min.js"></script>
<script charset="utf-8" src="${path}/kindeditor/lang/zh-CN.js"></script>
<script>
    $(function () {
        $("#article-show-table").jqGrid({
            url: "${path}/user/selectAll",
            datatype: "json",
            colNames: ['编号', '用户名', '昵称', '省份', '市区', '性别'],
            colModel: [
                {name: 'id'},
                {name: 'username'},
                {name: 'nickname'},
                {name: 'province'},
                {name: 'city'},
                {name: 'sex'}
            ],

            styleUI: "Bootstrap",
            autowidth: true,
            height: 250,
            rowNum: 3,
            rowList: [3, 6, 9],
            pager: '#article-page',
            viewrecords: true,
            caption: "用户列表",
            editurl: "someurl.php"
        }).navGrid("#article-page", {edit: false, add: false, del: false, search: false});
    })

</script>


<ul class="nav nav-tabs">
    <li role="presentation" class="active"><a href="#">所有用户信息</a></li>
    <li role="presentation"><a href="${path}/user/export">下载用户信息</a></li>
</ul>
<table id="article-show-table"></table>
<div id="article-page" style="height: 40px"></div>



