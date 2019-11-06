<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script>
    $(function () {
        jQuery("#altable").jqGrid({
            url: '${path}/album/selectAll',
            editurl: "${path}/album/edit",
            datatype: "json",
            height: 250,
            colNames: ['Id', '专辑名称', '专辑作者', '封面', '音乐数量', '专辑简介', '创建时间'],
            colModel: [
                {name: 'id', hidden: true},
                {name: 'name', editable: true},
                {
                    name: 'starId',
                    editable: true,
                    edittype: "select",
                    editoptions: {dataUrl: "${pageContext.request.contextPath}/star/getAllStarForSelect"},
                    formatter: function (value, option, rows) {
                        return rows.star.nickname;
                    }
                },
                {
                    name: 'cover', editable: true, edittype: "file", formatter: function (cellvalue) {
                        return "<img src='${path}/album/img/" + cellvalue + "' style='width:100px;height:60px'>"
                    }
                },
                {name: 'count'},
                {name: 'brief', editable: true},
                {name: 'createDate', editable: true, edittype: "date"}
            ],
            styleUI: 'Bootstrap',
            autowidth: true,
            rowNum: 3,
            rowList: [3, 6, 9],
            pager: '#alpage',
            viewrecords: true,
            subGrid: true,
            //caption : "",
            subGridRowExpanded: function (subgrid_id, id) {
                var subgrid_table_id, pager_id;
                subgrid_table_id = subgrid_id + "_t";
                pager_id = "p_" + subgrid_table_id;
                $("#" + subgrid_id).html(
                    "<table id='" + subgrid_table_id + "' class='scroll'></table>" +
                    "<div id='" + pager_id + "' class='scroll'></div>");
                $("#" + subgrid_table_id).jqGrid(
                    {
                        url: "${pageContext.request.contextPath}/chapter/selectAll?albumId=" + id,
                        datatype: "json",
                        colNames: ['编号', '名字', '歌手', '大小', '时长', '创建时间', '在线播放'],
                        colModel: [
                            {name: "id", hidden: true},
                            {name: "name", editable: true, edittype: "file"},
                            {name: "singer", editable: true},
                            {name: "size"},
                            {name: "duration"},
                            {name: "createDate"},
                            {
                                name: "operation", width: 300, formatter: function (value, option, rows) {
                                    return "<audio controls>\n" +
                                        "  <source src='${path}/album/music/" + rows.name + "' >\n" +
                                        "</audio>";
                                }
                            }
                        ],
                        styleUI: "Bootstrap",
                        rowNum: 2,
                        pager: pager_id,
                        autowidth: true,
                        height: '100%',
                        editurl: "${path}/chapter/edit?albumId=" + id
                    });
                jQuery("#" + subgrid_table_id).jqGrid('navGrid',
                    "#" + pager_id, {
                        edit: false,
                        add: true,
                        del: false,
                        search: false
                    }, {}, {
                        //    控制添加
                        closeAfterAdd: true,
                        afterSubmit: function (response) {
                            var status = response.responseJSON.status;
                            if (status) {
                                var cid = response.responseJSON.message;
                                $.ajaxFileUpload({
                                    url: "${pageContext.request.contextPath}/chapter/upload",
                                    type: "post",
                                    fileElementId: "name",
                                    data: {id: cid, albumId: id},
                                    success: function () {
                                        /*    $("#" + subgrid_table_id).trigger("reloadGrid");*/
                                    }
                                })
                            }
                            return "123";
                        }
                    });
            }

        }).jqGrid('navGrid', '#alpage', {
            add: true,
            edit: false,
            del: false
        }, {}, {
            closeAfterAdd: true,
            afterSubmit: function (response) {
                var status = response.responseJSON.status;
                var message = response.responseJSON.message;
                if (status) {
                    $.ajaxFileUpload({
                        url: "${pageContext.request.contextPath}/album/upload",
                        type: "post",
                        fileElementId: "cover",
                        data: {id: message},
                        success: function (data) {
                            $("#altable").trigger("reloadGrid");
                        }
                    })
                }
                return "123";
            }
        })
    })

</script>

<%-- 初始化面板--%>
<div class="panel panel-success">
    <div class="panel panel-heading">
        <h2>专辑信息</h2>
    </div>
    <ul class="nav nav-tabs">
        <li class="active"><a href="#">专辑信息</a>
        </li>
    </ul>
    <%--初始化表单--%>
    <table id="altable">
    </table>
    <%-- 分页工具栏--%>
    <div id="alpage"></div>
</div>
