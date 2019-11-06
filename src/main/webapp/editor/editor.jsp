<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script charset="utf-8" src="${path}/kindeditor/kindeditor-all-min.js"></script>
<script charset="utf-8" src="${path}/kindeditor/lang/zh-CN.js"></script>
<script>
    KindEditor.ready(function (K) {
        window.editor = K.create('#editor_id');
    });
</script>
<textarea id="editor_id" name="content" style="width:700px;height:300px;">
    hello world
&lt;strong&gt;HTML内容&lt;/strong&gt;
</textarea>