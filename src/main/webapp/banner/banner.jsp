<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script>
    $(function () {
        jQuery("#bntable").jqGrid({
            url: '${path}/banner/findAll',
            editurl: "${path}/banner/edit",
            datatype: "json",
            rowNum: 5,//每页展示条数
            rowList: [5, 10, 15],
            styleUI: "Bootstrap",
            pager: '#bnpage',//分页工具栏
            viewrecords: true,//显示总条数
            autowidth: true,//自动宽度
            height: 210,
            colNames: ['ID', '名称', '图片', '状态', '描述', '上传时间'],
            colModel: [
                {name: 'id', width: 55, hidden: true, editable: false},
                {name: 'name', editable: true, width: 90},
                {
                    name: 'cover', editable: true, edittype: "file", width: 100, align: "center", edittype: "file",
                    formatter: function (cellvalue) {
                        return "<img src='${path}/bootstrap/img/" + cellvalue + "' style='width:100px;height:60px'>"
                    }
                },
                {
                    name: 'status',
                    editable: true,
                    edittype: "select",
                    editoptions: {value: "正常:正常;冻结:冻结"},
                    width: 80,
                    align: "right"
                },
                {name: 'description', editable: true, width: 80, align: "right"},
                {name: 'createDate', width: 80, align: "right"}

            ]
        });
        //处理增删改查操作
        jQuery("#bntable").jqGrid('navGrid', '#bnpage', {
                edit: true,
                add: true,
                del: true,
                addtext: "添加",
                edittext: "修改",
                deltext: "删除"
            },
            {
                //修改后关闭
                closeAfterEdit: true,
                beforeShowForm: function (fmt) {
                    fmt.find("#cover").attr("disabled", true);
                }

            },//执行添加后的额外配置
            {
                closeAfterAdd: true,
                afterSubmit: function (data) {
                    console.log(data);
                    var status = data.responseJSON.status;
                    var id = data.responseJSON.message;
                    if (status) {
                        $.ajaxFileUpload({
                            url: "${pageContext.request.contextPath}/banner/upload",
                            type: "post",
                            fileElementId: "cover",
                            data: {id: id},
                            success: function (response) {
                                //自动刷新jqgrid表格
                                $("#bntable").trigger("reloadGrid");
                            }
                        });
                    }
                    return "222";
                }

            },//执行添加后的额外配置
            {}//执行删除后额外配置
        );
    });
</script>
<%-- 初始化面板--%>
<div class="panel panel-info">
    <div class="panel panel-heading">
        <h2>轮播图信息</h2>
    </div>
    <ul class="nav nav-tabs">
        <li class="active"><a href="#">轮播图信息</a>
        </li>
    </ul>
    <%--初始化表单--%>
    <table id="bntable">
    </table>
    <%-- 分页工具栏--%>
    <div id="bnpage"></div>
</div>
