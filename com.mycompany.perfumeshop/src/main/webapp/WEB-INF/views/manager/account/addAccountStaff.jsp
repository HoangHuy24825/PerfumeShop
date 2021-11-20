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
    <meta name="description" content="au theme template">
    <meta name="author" content="Hau Nguyen">
    <meta name="keywords" content="au theme template">

    <!-- Title Page-->
    <title>Tài khoản | ${tileWebsite}</title>
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
                                <!-- DATA TABLE -->
                                <div class="d-flex">
                                    <a href="${base}/admin/account" class="btn_back_list"><i
                                            class="fa fa-arrow-left"></i></a> &nbsp
                                    <h3 class="title-5 m-b-35">Thêm tài khoản nhân viên</h3>
                                </div>
                                <div class="">
                                    <div class="bg-light p-4">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <form id="form--upload" enctype="multipart/form-data">

                                                    <input name="id" id="id" type="number" hidden="true"
                                                        value="${id_product}" />

                                                    <div class="form-group">
                                                        <label for="username">Tên đăng nhập <span
                                                                class="required_field">*</span></label>
                                                        <input autocomplete="off" type="text" class="form-control"
                                                            id="username" name="username" placeholder="Tên đăng nhập"
                                                            required="required"></input>
                                                        <p class="text-danger" id="username_error"></p>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="fullname">Họ tên nhân viên <span
                                                                class="required_field">*</span></label>
                                                        <input autocomplete="off" type="text" class="form-control"
                                                            id="fullname" name="fullname" placeholder="Họ tên nhân viên"
                                                            required="required"></input>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="password">Mật khẩu <span
                                                                class="required_field">*</span></label>
                                                        <input type="password" autocomplete="off" class="form-control"
                                                            id="pasword" name="password" placeholder="Mật khẩu"
                                                            required="required"></input>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="email">Email <span
                                                                class="required_field">*</span></label>
                                                        <input type="email" autocomplete="off" class="form-control"
                                                            id="email" name="email" placeholder="email"
                                                            required="required"></input>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="phone">Số điện thoại <span
                                                                class="required_field">*</span> </label>
                                                        <input type="number" autocomplete="off" class="form-control"
                                                            id="phone" name="phone" placeholder="Số điện thoại"
                                                            required="required"></input>
                                                    </div>
                                                    <div class="form-group">
                                                        <a class="btn btn-secondary"
                                                            href="${base}/admin/account">Hủy</a>
                                                        <button type="button" class="btn btn-primary"
                                                            onclick="saveOrUpdate()">Lưu</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <jsp:include page="/WEB-INF/views/manager/layout/footer.jsp"></jsp:include>
                    </div>
                </div>
            </div>
        </div>
        <!-- END PAGE CONTAINER-->
    </div>

    <!-- START NOTIFY MODAL -->
    <jsp:include page="/WEB-INF/views/manager/layout/notify.jsp"></jsp:include>
    <!-- START NOTIFI MODAL -->

    <!-- START MESSAGE TO USER -->
    <jsp:include page="/WEB-INF/views/manager/layout/message-to-user.jsp"></jsp:include>
    <!-- START MESSAGE TO USER -->

    <!-- JS-->
    <jsp:include page="/WEB-INF/views/manager/layout/script.jsp"></jsp:include>
    <script type="text/javascript" src="${base }/manager/script/account/addAccount.js"></script>
</body>

</html>
<!-- end document-->