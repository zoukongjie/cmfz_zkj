<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script>
    $(function () {
        $("#star-show-table").jqGrid({
            url: '${path}/star/selectAll',
            editurl: "${path}/star/edit",
            datatype: "json",
            height: 250,
            colNames: ['编号', '艺名', '真名', '照片', '性别', '生日'],
            colModel: [
                {name: 'id', hidden: true, editable: false},
                {name: 'nickname', editable: true},
                {name: 'realname', editable: true},
                {
                    name: 'photo', editable: true, edittype: "file", formatter: function (value, option, rows) {
                        return "<img style='width:100px;height:70px' src='${pageContext.request.contextPath}/star/img/" + rows.photo + "'>";
                    }
                },
                {name: 'sex', editable: true},
                {name: 'bir', editable: true}
            ],
            styleUI: 'Bootstrap',
            autowidth: true,
            rowNum: 4,
            rowList: [2, 4, 6],
            pager: '#star-page',
            viewrecords: true,
            subGrid: true,
            //caption : "所有明星列表",
            subGridRowExpanded: function (subgrid_id, id) {
                var subgrid_table_id, pager_id;
                subgrid_table_id = subgrid_id + "_t";
                pager_id = "p_" + subgrid_table_id;
                $("#" + subgrid_id).html(
                    "<table id='" + subgrid_table_id + "' class='scroll'></table>" +
                    "<div id='" + pager_id + "' class='scroll'></div>");
                $("#" + subgrid_table_id).jqGrid(
                    {
                        url: "${pageContext.request.contextPath}/user/selectUsersByStarId?starId=" + id,
                        datatype: "json",
                        colNames: ['编号', '用户名', '昵称', '头像', '电话', '性别', '地址', '签名'],
                        colModel: [
                            {name: "id"},
                            {name: "username"},
                            {name: "nickname"},
                            {
                                name: 'photo',
                                editable: true,
                                edittype: "file",
                                formatter: function (value, option, rows) {
                                    return "<img style='width:100px;height:70px' src='${pageContext.request.contextPath}/star/img/" + rows.photo + "'>";
                                }
                            },
                            {name: "phone"},
                            {name: "sex"},
                            {name: "address"},
                            {name: "sign"}
                        ],
                        styleUI: "Bootstrap",
                        rowNum: 2,
                        pager: pager_id,
                        autowidth: true,
                        height: '100%'
                    });
                jQuery("#" + subgrid_table_id).jqGrid('navGrid',
                    "#" + pager_id, {
                        edit: false,
                        add: false,
                        del: false,
                        search: false
                    });
            },

        }).jqGrid('navGrid', '#star-page', {
                add: true,
                edit: true,
                del: true,
                addtext: "添加",
                edittext: "修改",
                deltext: "删除",
                search: false
            },
            {
                //修改后关闭
                closeAfterEdit: true,
                beforeShowForm: function (fmt) {
                    fmt.find("#photo").attr("disabled", true);
                }

            },
            {
                closeAfterAdd: true,
                afterSubmit: function (data) {
                    console.log(data);
                    var status = data.responseJSON.status;
                    var id = data.responseJSON.message;
                    if (status) {
                        $.ajaxFileUpload({
                            url: "${pageContext.request.contextPath}/star/upload",
                            type: "post",
                            fileElementId: "photo",
                            data: {id: id},
                            success: function (response) {
                                //自动刷新jqgrid表格
                                $("#star-show-table").trigger("reloadGrid");
                            }
                        });
                    }
                    return "222";
                }

            }//执行添加后的额外配置
        );
    })
</script>

<%-- 初始化面板--%>
<div class="panel panel-info">
    <div class="panel panel-heading">
        <h2>明星信息</h2>
    </div>
    <ul class="nav nav-tabs">
        <li class="active"><a href="#">所有明星信息</a>
        </li>
    </ul>
    <%--初始化表单--%>
    <table id="star-show-table">
    </table>
    <%-- 分页工具栏--%>
    <div id="star-page"></div>
</div>
