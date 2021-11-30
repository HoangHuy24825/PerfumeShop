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
                            <div class="col-md-12">
                                <!-- DATA TABLE -->
                                <div class="d-flex">
                                    <a href="${base}/perfume-shop/admin/product.html" class="btn_back_list"><i
                                            class="fa fa-arrow-left"></i></a> &nbsp
                                    <h3 class="title-5 m-b-35">Chi tiết sản phẩm</h3>
                                </div>
                                <div class="">
                                    <div class="bg-light p-4">
                                        <table class="table table-bordered">
                                            <tr>
                                                <td style="width:250px;">Danh mục sản phẩm</td>
                                                <td>${product.category.name}</td>
                                            </tr>
                                            <tr>
                                                <td>Tên sản phẩm</td>
                                                <td>${product.title}</td>
                                            </tr>
                                           
                                            <tr>
                                                <td>Ảnh đại diện sản phẩm</td>
                                                <td> <img src="/upload/${product.avatar}" width="300" /></td>
                                            </tr>
                                            <tr>
                                                <td>Ngày tạo</td>
                                                <td>
                                                    <fmt:formatDate pattern="dd/MM/yyyy"
                                                        value="${product.createdDate}" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Người tạo</td>
                                                <td>${createdBy.fullname} (${createdBy.username})</td>
                                            </tr>
                                            <tr>
                                                <td>Ngày sửa</td>
                                                <td>
                                                    <fmt:formatDate pattern="dd/MM/yyyy"
                                                        value="${product.updatedDate}" />
                                                </td>
                                            </tr>
                                            <c:if test="${updatedBy!=null }">
                                                <tr>
                                                    <td>Người sửa</td>
                                                    <td>${updatedBy.fullname} (${updatedBy.username })</td>
                                                </tr>
                                            </c:if>
                                            <c:if test="${updatedBy==null }">
                                                <tr>
                                                    <td>Người sửa</td>
                                                    <td>Sản phẩm chưa thực hiện cập nhật.</td>
                                                </tr>
                                            </c:if>
                                            <tr>
                                                <td>Seo</td>
                                                <td> ${product.seo}</td>
                                            </tr>
                                            <tr>
                                                <td>Thương hiệu</td>
                                                <td> ${product.trademark}</td>
                                            </tr>
                                            <tr>
                                                <td>Xuất xứ</td>
                                                <td> ${product.origin}</td>
                                            </tr>
                                            <tr>
                                                <td>Mùi hương</td>
                                                <td> ${product.fragrant}</td>
                                            </tr>
                                            <tr>
                                                <td>Năm phát hành</td>
                                                <td> ${product.manufactureYear}</td>
                                            </tr>
                                            <tr>
                                                <td>Các dung tích</td>
                                                <td>
                                                    <div class="row">
                                                        <table class="table table-striped">
                                                            <thead>
                                                                <tr>
                                                                    <th scope="col">Dung tích</th>
                                                                    <th scope="col">Giá</th>
                                                                    <th scope="col">Giảm giá</th>
                                                                    <th scope="col">Số lượng</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="attr"
                                                                    items="${product.attributeProducts}">
                                                                    <tr>
                                                                        <th>${attr.capacity}</th>
                                                                        <td>${attr.price}</td>
                                                                        <td>${attr.priceSale}</td>
                                                                        <td>${attr.amount}</td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>

                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Hot</td>
                                                <td>
                                                    ${product.isHot==true?"Hot":"Bình thường"}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Trạng thái</td>
                                                <td>
                                                    ${product.status==true?"Hiển thị":"Ẩn"}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Mô tả ngắn</td>
                                                <td>${product.description}</td>
                                            </tr>
                                            <tr>
                                                <td>Hình ảnh sản phẩm</td>
                                                <td>
                                                    <div class="row mt-4">
                                                        <c:forEach var="image" items="${product.productImages}">
                                                            <div class="col-sm-2 imgUp">
                                                                <img class="imagePreview image--product"
                                                                    src="/upload/${image.path}${image.title}" />
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Chi tiết sản phẩm</td>
                                                <td>${product.detail}</td>
                                            </tr>
                                        </table>
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

    <script src="${base }/manager/script/product/detail.js"></script>
</body>

</html>
<!-- end document-->