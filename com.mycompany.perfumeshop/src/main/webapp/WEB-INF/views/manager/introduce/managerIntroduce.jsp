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
    <title>Sản phẩm | ${tileWebsite}</title>
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
                                <h3 class="title-5 m-b-35">Giới thiệu thông tin công ty</h3>
                                <div class="table-data__tool">
                                    <div class="table-data__tool-left">

                                    </div>
                                    <div class="table-data__tool-right">
                                        <c:if test="${notifyRole.update ==true}">
                                            <button class="au-btn au-btn-icon au-btn--green au-btn--small"
                                                onclick="location.href='${base}/admin/edit-introduce'">
                                                <i class="fas fa-plus"></i>Cập nhật
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="table-responsive  bg-white text-dark p-3">
                                    ${introduce.detail}
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

    <!-- START NOTIFY MODAL -->
    <jsp:include page="/WEB-INF/views/manager/layout/notify.jsp"></jsp:include>
    <!-- START NOTIFI MODAL -->

    <!-- JS-->
    <jsp:include page="/WEB-INF/views/manager/layout/script.jsp"></jsp:include>
    <script src="${base }/manager/script/introduce/manageIntroduce.js"></script>
</body>

</html>
<!-- end document-->