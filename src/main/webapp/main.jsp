<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>持明法州后台管理系统</title>
    <link rel="icon" href="${path}/bootstrap/img/arrow-up.png" type="image/x-icon">
    <link rel="stylesheet" href="${path}/bootstrap/css/bootstrap.css">

    <%--引入jqgrid中主题css--%>
    <link rel="stylesheet" href="${path}/bootstrap/jqgrid/css/css/hot-sneaks/jquery-ui-1.8.16.custom.css">
    <link rel="stylesheet" href="${path}/bootstrap/jqgrid/boot/css/trirand/ui.jqgrid-bootstrap.css">
    <%--引入js文件--%>
    <script src="${path}/bootstrap/js/jquery.min.js"></script>
    <script src="${path}/bootstrap/js/bootstrap.js"></script>
    <script src="${path}/bootstrap/jqgrid/js/i18n/grid.locale-cn.js"></script>
    <script src="${path}/bootstrap/jqgrid/boot/js/trirand/jquery.jqGrid.min.js"></script>
    <script src="${path}/bootstrap/js/ajaxfileupload.js"></script>

</head>
<body>

<h1 align="center"></h1>
<!--顶部导航-->
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <%-- 标题--%>
        <div class="navbar-header">
            <div class="navbar-brand">后台管理系统
                <small>v1.0</small>
            </div>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">欢迎<span class="text-primary">${sessionScope.loginAdmin.username}</span></a></li>
                <li class="dropdown">
                    <a href="${path}/admin/logout">退出登录 <span class="glyphicon glyphicon-log-out"></span></a>
                </li>
            </ul>

        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>

<!--栅格系统-->
<div class="container-fluid">
    <div class="row">
        <%--左边手风琴部分--%>
        <div class="col-md-2">
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true" align="center">
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="headingOne">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne"
                               aria-expanded="true" aria-controls="collapseOne">
                                轮播图管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOne">
                        <div class="panel-body">
                            <ul class="nav nav-pills nav-stacked">
                                <li class="btn btn-info"><a
                                        href="javaScript:$('#mainId').load('${path}/banner/banner.jsp')">展示轮播图</a></li>
                                <br>
                            </ul>

                        </div>
                    </div>
                </div>
                <br>
                <div class="panel panel-success">
                    <div class="panel-heading" role="tab" id="headingTwo">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                               href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                专辑管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                        <div class="panel-body">
                            <ul class="nav nav-pills nav-stacked">
                                <li class="btn btn-success"><a
                                        href="javaScript:$('#mainId').load('${path}/album/album.jsp')">专辑信息</a></li>
                                <br>
                            </ul>
                        </div>
                    </div>
                </div>
                <br>
                <div class="panel panel-danger">
                    <div class="panel-heading" role="tab" id="headingThree">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                               href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                文章管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel"
                         aria-labelledby="headingThree">
                        <div class="panel-body">
                            <ul class="nav nav-pills nav-stacked">
                                <li class="btn btn-danger"><a
                                        href="javascript:$('#mainId').load('${path}/article/article.jsp')"
                                        class="btn btn-danger">文章信息</a></li>
                                <br>
                            </ul>

                        </div>
                    </div>
                </div>
                <br>
                <div class="panel panel-warning">
                    <div class="panel-heading" role="tab" id="headingfour">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                               href="#collapsefour" aria-expanded="false" aria-controls="collapseThree">
                                用户管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapsefour" class="panel-collapse collapse" role="tabpanel"
                         aria-labelledby="headingfour">
                        <div class="panel-body">
                            <ul class="nav nav-pills nav-stacked">
                                <li class="btn btn-warning"><a
                                        href="javascript:$('#mainId').load('${path}/user/user.jsp')"
                                        class="btn btn-warning">用户信息</a></li>
                                <br>
                                <li class="btn btn-warning"><a
                                        href="javascript:$('#mainId').load('${path}/user/user-count.jsp')"
                                        class="btn btn-warning">注册用户统计</a></li>
                                <br>
                                <li class="btn btn-warning"> 用户分布</li>
                                <br>
                            </ul>
                        </div>
                    </div>
                </div>
                <br>
                <div class="panel panel-primary">
                    <div class="panel-heading" role="tab" id="headingfive">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                               href="#collapsefive" aria-expanded="false" aria-controls="collapsefive">
                                明星管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapsefive" class="panel-collapse collapse" role="tabpanel"
                         aria-labelledby="headingfive">
                        <div class="panel-body">
                            <ul class="nav nav-pills nav-stacked">
                                <li class="btn btn-primary"><a
                                        href="javascript:$('#mainId').load('${path}/star/star-show.jsp')"
                                        class="btn btn-default">所有明星</a></li>
                                <br>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>

        </div>
        <div class="col-md-10" id="mainId">
            <!--巨幕开始-->
            <div class="jumbotron">
                <h4> 欢迎登陆持明法州后台管理系统！</h4>
            </div>
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                </ol>

                <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox">
                    <div class="item active" align="center">
                        <img src="${path}/bootstrap/img/7.png" alt="...">
                        <div class="carousel-caption">
                            ...
                        </div>
                    </div>
                    <div class="item" align="center">
                        <img src="${path}/bootstrap/img/8.png" alt="...">
                        <div class="carousel-caption">
                            ...
                        </div>
                    </div>
                    <div class="item" align="center">
                        <img src="${path}/bootstrap/img/9.png" alt="...">
                        <div class="carousel-caption">
                            ...
                        </div>
                    </div>
                    ...
                </div>

                <!-- Controls -->
                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <%--页脚--%>
            <div class="panel panel-footer">
                <div>持明法州后台管理系统@百知教育2019.10.25</div>
            </div>
        </div>


    </div>
</div>


</body>
</html>
