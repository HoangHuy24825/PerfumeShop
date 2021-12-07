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
    <title>Đơn hàng | ${tileWebsite}</title>
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
                            <div class="col-md-12" id="content_page">
                                <!-- CONTENT PAGE -->
                                <h3 class="title-5">Danh sách yêu cầu</h3>
                                <div class="table-data__tool">
                                    <div class="table-data__tool-left">

                                    </div>
                                    <div class="table-data__tool-right">
                                        <input id="update_role" value="${orderRole.update}" type="text"
                                            style="display: none" />
                                        <input id="delete_role" value="${orderRole.delete}" type="text"
                                            style="display: none" />
                                    </div>
                                </div>
                                <table class="table table-data2">
                                    <thead>
                                        <tr>
                                            <th>Tên khách hàng</th>
                                            <th>Ngày yêu cầu</th>
                                            <th>Mã đơn hàng</th>
                                            <th>Lý do</th>
                                            <th>Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody id="table_data">


                                    </tbody>
                                </table>
                                <div class="my-3">
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination justify-content-center " id="paged--list">

                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <!-- END CONTENT PAGE -->
                        </div>
                    </div>
                    <jsp:include page="/WEB-INF/views/manager/layout/footer.jsp"></jsp:include>
                </div>
            </div>
        </div>
    </div>
    <!-- END PAGE CONTAINER-->


    <!--START MODAL DETAIL -->
    <div class="modal fade" id="detail-modal" tabindex="-1" role="dialog" aria-labelledby="mediumModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="mediumModalLabel">
                        Đơn hàng mã: <span id="code-order"></span> - <span id="status-orders"> Chưa xác nhận
                        </span><br /> ID: <span id="id-order"></span>
                    </h5>
                    <br />
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="order--information">
                        <div class="p-4">
                            <h4 style="margin-left: -25px;">Trạng thái đơn hàng</h4>
                            <br />
                            <ul class="text-muted" id="status--order">
                                <li style="list-style-type:none" id="status--4" class="d-none text-danger"><i
                                        class="fas fa-hand-point-right"></i> Đơn hàng đã bị hủy</li>
                                <li style="list-style-type:none" id="status--3"><i class="fas fa-hand-point-right"></i>
                                    Giao hàng thành công</li>
                                <li style="list-style-type:none" id="status--2"><i class="fas fa-hand-point-right"></i>
                                    Đang giao hàng</li>
                                <li style="list-style-type:none" id="status--1"><i class="fas fa-hand-point-right"></i>
                                    Đã tiếp nhận đơn hàng</li>
                                <li style="list-style-type:none" id="status--0"><i class="fas fa-hand-point-right"></i>
                                    Chưa tiếp nhận đơn hàng</li>
                            </ul>
                            <hr />
                        </div>
                        <h4>Thông tin người nhận</h4>
                        <br>
                        <table class="table table-bordered font-weight-bold">
                            <tr>
                                <td>Họ tên</td>
                                <td id="fullname" class="text-primary"></td>
                            </tr>
                            <tr>
                                <td>Email</td>
                                <td id="email" class="text-primary"></td>
                            </tr>
                            <tr>
                                <td>Số điện thoại</td>
                                <td id="phone" class="text-primary"></td>
                            </tr>
                            <tr>
                                <td>Địa chỉ</td>
                                <td id="address" class="text-primary"></td>
                            </tr>
                            <tr>
                                <td>Ngày mua</td>
                                <td id="createdDate" class="text-primary"></td>
                            </tr>
                            <tr>
                                <td>Tổng tiền thanh toán</td>
                                <td id="total" class="text-primary"></td>
                            </tr>
                        </table>
                        <hr />
                        <h4 class="mb-3">Chi tiết sản phẩm</h4>
                        <div id="list--product--order">

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="In" type="button" class="btn btn-warning">In thông tin đơn hàng</button>
                </div>
            </div>
        </div>
    </div>
    <!--END MODAL DETAIL -->

    <!-- START NOTIFY MODAL -->
    <jsp:include page="/WEB-INF/views/manager/layout/notify.jsp"></jsp:include>
    <!-- START NOTIFI MODAL -->

    <!-- START MESSAGE TO USER -->
    <jsp:include page="/WEB-INF/views/manager/layout/message-to-user.jsp"></jsp:include>
    <!-- START MESSAGE TO USER -->

    <!-- JS-->
    <jsp:include page="/WEB-INF/views/manager/layout/script.jsp"></jsp:include>
    <script type="text/javascript" src="${base }/manager/script/order/request-cancel-order.js"></script>
    <script type="text/javascript" src="${base }/manager/script/order/order.js"></script>
</body>

</html>
<!-- end document-->