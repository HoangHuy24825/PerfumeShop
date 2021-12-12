<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- SPRING FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags-->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Title Page-->
    <title>Dashboard | ${tileWebsite}</title>
    <link rel="icon" href="${base}/manager/images/logo-asp.net.png">

    <jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/views/manager/layout/style.jsp"></jsp:include>

</head>

<body class="">
    <div class="page-wrapper">
        <!-- HEADER MOBILE-->
        <jsp:include page="/WEB-INF/views/manager/layout/header_mobile.jsp"></jsp:include>
        <!-- END HEADER MOBILE-->

        <!-- MENU SIDEBAR-->
        <jsp:include page="/WEB-INF/views/manager/layout/left_sidebar.jsp"></jsp:include>
        <!-- END MENU SIDEBAR-->

        <!-- PAGE CONTAINER-->
        <div class="page-container">
            <!-- HEADER DESKTOP-->
            <jsp:include page="/WEB-INF/views/manager/layout/header.jsp"></jsp:include>
            <!-- HEADER DESKTOP-->

            <!-- MAIN CONTENT-->
            <div class="main-content">
                <div class="section__content section__content--p30">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="overview-wrap">
                                    <h2 class="title-2">Tổng Quan</h2>
                                </div>
                            </div>
                        </div>
                        <div class="row m-t-25">
                            <div class="col-sm-6 col-lg-3">
                                <div class="overview-item overview-item--c1">
                                    <div class="overview__inner">
                                        <div class="overview-box clearfix">
                                            <div class="icon">
                                                <i class="zmdi zmdi-account-o"></i>
                                            </div>
                                            <div class="text">
                                                <h2>${totalOrderRecentMonth} đơn hàng</h2>
                                                <span>Đơn hàng tháng gần đây</span>
                                            </div>
                                        </div>
                                        <div class="overview-chart">
                                            <canvas id="widgetChart1"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-lg-3">
                                <div class="overview-item overview-item--c2">
                                    <div class="overview__inner">
                                        <div class="overview-box clearfix">
                                            <div class="icon">
                                                <i class="zmdi zmdi-shopping-cart"></i>
                                            </div>
                                            <div class="text">
                                                <h2>
                                                    <fmt:formatNumber type="number" maxFractionDigits="0"
                                                        value="${productQuantity}" /> sản phẩm
                                                </h2>
                                                <span>Số sản phẩm</span>
                                            </div>
                                        </div>
                                        <div class="overview-chart">
                                            <canvas id="widgetChart4"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-lg-3">
                                <div class="overview-item overview-item--c3">
                                    <div class="overview__inner">
                                        <div class="overview-box clearfix">
                                            <div class="icon">
                                                <i class="zmdi zmdi-calendar-note"></i>
                                            </div>
                                            <div class="text">
                                                <h2>
                                                    <fmt:formatNumber value="${revenueRecentWeek}" type="number"
                                                        minFractionDigits="0" />₫
                                                </h2>
                                                <span>Doanh thu tuần gần Đây</span>
                                            </div>
                                        </div>
                                        <div class="overview-chart">
                                            <canvas id="widgetChart3"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-lg-3">
                                <div class="overview-item overview-item--c4">
                                    <div class="overview__inner">
                                        <div class="overview-box clearfix">
                                            <div class="icon">
                                                <i class="zmdi zmdi-money"></i>
                                            </div>
                                            <div class="text">
                                                <h2>
                                                    <fmt:formatNumber value="${revenueRecentMonth}" type="number"
                                                        minFractionDigits="0" />₫
                                                </h2>
                                                <span>Doanh thu tháng gần đây</span>
                                            </div>
                                        </div>
                                        <div class="overview-chart">
                                            <canvas id="widgetChart2"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6    ">
                                <div class="au-card recent-report">
                                    <div class="au-card-inner">
                                        <h3 class="title-2 m-b-40">Doanh thu</h3>
                                        <canvas id="sales-chart"></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="au-card chart-percent-card">
                                    <div class="au-card-inner">
                                        <h3 class="title-2 tm-b-5">Biểu Đồ Đơn Hàng(%)</h3>
                                        <div class="row no-gutters">
                                            <div class="col-xl-6">
                                                <div class="chart-note-wrap">
                                                    <div class="chart-note mr-0 d-block">
                                                        <span class="dot dot--blue"></span>
                                                        <span>Đơn hàng giao thành công</span>
                                                    </div>
                                                    <div class="chart-note mr-0 d-block">
                                                        <span class="dot dot--red"></span>
                                                        <span>Đơn hàng bị hủy</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-6">
                                                <div class="percent-chart">
                                                    <canvas id="percent-chart"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <h2 class="title-2 m-b-25">Doanh Thu</h2>
                                <form action="" method="post" class="px-5" id="formStatistical">
                                    <span class="px-5 py-5" style="color:red" id="errMsgDate"></span>
                                    <div class="form-row px-5">
                                        <div class="form-group col-md-6">
                                            <label for="startDate">Ngày bắt đầu</label>
                                            <input type="date" class="form-control rounded date-picker" id="startDate"
                                                placeholder="Ngày bắt đầu">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="endDate">Ngày kết thúc</label>
                                            <input type="date" class="form-control rounded date-picker" id="endDate"
                                                placeholder="Ngày kết thúc">
                                        </div>
                                    </div>
                                </form>
                                <div class="table-responsive table--no-card m-b-40">
                                    <table class="table table-borderless table-striped table-earning">
                                        <thead>
                                            <tr>
                                                <th>Ngày</th>
                                                <th class="text-right">Số lượng đơn hàng</th>
                                                <th class="text-right">Số Lượng đơn hàng hủy</th>
                                                <th class="text-right">Số lượng sản phẩm</th>
                                                <th class="text-right">Doanh thu</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tableRevenueByDate">


                                        </tbody>
                                    </table>
                                    <div class="my-3">
                                        <nav aria-label="Page navigation example page-revenue">
                                            <ul class="pagination justify-content-center " id="pagedListRevenueByDate">

                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <h2 class="title-2 m-b-25">Sản phẩm bán chạy</h2>
                                <div class="col-4 my-3">
                                    <select class="custom-select" name="property" id="selectCategory">
                                        <option value="not value">Danh mục sản phẩm</option>
                                        <c:forEach var="category" items="${listCategory}">
                                            <option value="${category.id}">${category.name }</option>';
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="table-responsive table--no-card m-b-40">
                                    <table class="table table-borderless table-striped table-earning">
                                        <thead>
                                            <tr>
                                                <th>Ảnh</th>
                                                <th>Tên sản phẩm</th>
                                                <th class="text-right">Số lượng bán</th>
                                                <th class="text-right">Tổng tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tableBestSale">

                                        </tbody>
                                    </table>
                                    <div class="my-3">
                                        <nav aria-label="Page navigation example page-best-sale">
                                            <ul class="pagination justify-content-center " id="pagedListBestSale">

                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="copyright">
                                    <p>Copyright © 2021. All rights reserved. Template by <b>Hạ Hoàng Huy</b>.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END MAIN CONTENT-->
        </div>
    </div>

    <!-- START NOTIFY MODAL -->
    <jsp:include page="/WEB-INF/views/manager/layout/notify.jsp"></jsp:include>
    <!-- START NOTIFI MODAL -->
    <!-- END PAGE CONTAINER-->
    <!-- JS-->
    <jsp:include page="/WEB-INF/views/manager/layout/script.jsp"></jsp:include>
    <script src="${base }/manager/script/dashboard/dashboard.js"></script>
</body>

</html>
<!-- end document-->