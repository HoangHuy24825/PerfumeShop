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

    <link rel="stylesheet" href="${base}/manager/css/product-style.css">

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
                                    <h3 class="title-5 " id="title-page-add-update">Thêm sản phẩm</h3>
                                </div>
                                <div class="">
                                    <div class="bg-light p-4">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <form id="formDetailProduct" enctype="multipart/form-data" type="post">

                                                    <input name="id" id="id" type="number" hidden="true"
                                                        value="${id_product}" />

                                                    <input name="status" id="status" type="checkbox" hidden="true" />

                                                    <div class="form-row">
                                                        <div class="form-group col-6">
                                                            <label for="category" class="font-weight-bold">Danh mục
                                                                <span class="required">*</span></label>
                                                            <select class="custom-select" id="select-category"
                                                                name="id_category">

                                                            </select>
                                                        </div>

                                                        <div class="form-group col-6">
                                                            <label for="title" class="font-weight-bold">Tên sản phẩm
                                                                <span class="required">*</span></label>
                                                            <input autocomplete="off" type="text" class="form-control"
                                                                id="title" name="title" placeholder="Tên sản phẩm"
                                                                required="required"></input>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="avatar" class="font-weight-bold">Avatar <span
                                                                class="required">*</span></label>
                                                        <div class="row d-flex justify-content-center mt-4">
                                                            <div class="col-sm-4 imgUp">
                                                                <div class="imagePreview img--avatar"></div>
                                                                <label class="btn btn-primary btn--upload-image">Upload
                                                                    <input type="file"
                                                                        class="uploadFile img uploadAvatar"
                                                                        name="avatar"
                                                                        accept="image/png, image/jpeg, image/jpg"
                                                                        style="width: 0px;height: 0px;overflow: hidden;">
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-row my-2">
                                                        <div class="card col-12 attribute-card">
                                                            <h5 class="card-header font-weight-bold">Dung tích nước hoa
                                                            </h5>

                                                            <div class="card-body row detail-attribute-card">
                                                                <div class="item-attribute row col-12">
                                                                    <input name="idAttribute" class="idAttribute"
                                                                        type="number" hidden="true"
                                                                        value="${id_product}" />

                                                                    <div class="form-group col-3">
                                                                        <label for="capacity"
                                                                            class="font-weight-bold">Dung tích <span
                                                                                class="required">*</span></label>
                                                                        <input type="number" autocomplete="off"
                                                                            class="form-control capacity"
                                                                            name="capacity"
                                                                            placeholder="Dung tích"></input>
                                                                    </div>

                                                                    <div class="form-group col-3">
                                                                        <label for="price" class="font-weight-bold">Giá
                                                                            <span class="required">*</span></label>
                                                                        <input type="number" autocomplete="off"
                                                                            class="form-control price" name="price"
                                                                            placeholder="Giá sản phẩm"
                                                                            required="required"></input>
                                                                    </div>

                                                                    <div class="form-group col-3">
                                                                        <label for="priceSale"
                                                                            class="font-weight-bold">Giảm giá <span
                                                                                class="required">*</span></label>
                                                                        <input type="number" autocomplete="off"
                                                                            class="form-control priceSale"
                                                                            name="priceSale"
                                                                            placeholder="Giảm giá"></input>
                                                                    </div>

                                                                    <div class="form-group col-3">
                                                                        <label for="amount" class="font-weight-bold">Số
                                                                            lượng <span
                                                                                class="required">*</span></label>
                                                                        <input type="number" autocomplete="off"
                                                                            class="form-control amount" name="amount"
                                                                            placeholder="Số lượng"></input>
                                                                    </div>

                                                                    <div class="btn-delete-attribute"><i
                                                                            class="fas fa-times"></i></div>
                                                                </div>
                                                            </div>
                                                            <div class="btn-add-attribute"><i class="fas fa-plus"></i>
                                                            </div>
                                                        </div>


                                                    </div>

                                                    <div class="form-row my-2">
                                                        <div class="form-group col">
                                                            <label for="trademark" class="font-weight-bold">Thương hiệu
                                                                <span class="required">*</span> </label>
                                                            <input type="text" autocomplete="off" class="form-control"
                                                                id="trademark" name="trademark"
                                                                placeholder="Thương hiệu"></input>
                                                        </div>

                                                        <div class="form-group col">
                                                            <label for="origin" class="font-weight-bold">Xuất xứ <span
                                                                    class="required">*</span></label>
                                                            <input type="text" autocomplete="off" class="form-control"
                                                                id="origin" name="origin" placeholder="Xuất xứ"></input>
                                                        </div>
                                                    </div>

                                                    <div class="form-row my-2">
                                                        <div class="form-group col">
                                                            <label for="manufactureYear" class="font-weight-bold">Năm
                                                                sản xuất <span class="required">*</span></label>
                                                            <input type="number" autocomplete="off" class="form-control"
                                                                id="manufactureYear" name="manufactureYear"
                                                                placeholder="Năm sản xuất"></input>
                                                        </div>

                                                        <div class="form-group col">
                                                            <label for="fragrant" class="font-weight-bold">Mùi hương
                                                                <span class="required">*</span> </label>
                                                            <input type="text" autocomplete="off" class="form-control"
                                                                id="fragrant" name="fragrant"
                                                                placeholder="Mùi hương"></input>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="short_description" class="font-weight-bold">Mô tả
                                                            ngắn <span class="required">*</span></label>
                                                        <textarea autocomplete="off" class="form-control"
                                                            placeholder="Short Description" id="description"
                                                            name="description" rows="8" required="required"></textarea>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="fileProductPictures" class="font-weight-bold">Hình
                                                            ảnh </label>
                                                        <div class="row mt-4">
                                                            <div class="col-sm-2 imgUp">
                                                                <input name="idImage" id="idImage" type="number"
                                                                    hidden="true" value="${idImage}" />
                                                                <div class="imagePreview image--product"
                                                                    data-id-image=""></div>
                                                                <label class="btn btn-primary btn--upload-image">Upload
                                                                    <input type="file"
                                                                        class="uploadFile img uploadImages"
                                                                        name="images"
                                                                        accept="image/png, image/jpeg, image/jpg"
                                                                        style="width: 0px;height: 0px;overflow: hidden;">
                                                                </label>
                                                                <i class="fa fa-times del"></i>
                                                            </div>
                                                            <i class="fa fa-plus imgAdd"></i>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="detail" class="font-weight-bold">Chi tiết</label>
                                                        <textarea row=5 autocomplete="off"
                                                            class="form-control summernote" id="detail" name="detail"
                                                            required="required">
                                                        </textarea>
                                                    </div>

                                                    <div class="form-group">
                                                        <a class="btn btn-secondary"
                                                            href="${base}/perfume-shop/admin/product.html">Hủy</a>
                                                        <!-- <button type="button" class="btn btn-primary"
                                                            onclick="saveOrUpdate()">Lưu</button> -->
                                                        <button type="submit" class="btn btn-primary">Lưu</button>
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
    <script type="text/javascript" src="${base }/manager/script/product/addOrUpdateProduct.js"></script>
</body>

</html>
<!-- end document-->