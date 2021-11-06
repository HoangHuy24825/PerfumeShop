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
    <title>Sản phẩm | Admin Electronic Device</title>
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
                                    <a href="${base}/admin/product/index" class="btn_back_list"><i
                                            class="fa fa-arrow-left"></i></a> &nbsp
                                    <h3 class="title-5 m-b-35" id="title-page-add-update">Thêm sản phẩm</h3>
                                </div>
                                <div class="">
                                    <div class="bg-light p-4">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <form id="form--upload" enctype="multipart/form-data">
                                                    
                                                    <input name="id" id="id" type="number" hidden="true"
                                                        value="${id_product}" />
                                                    
                                                    <div class="form-row">
                                                        <div class="form-group col-6">
                                                            <label for="category">Danh mục <span
                                                                    class="required_field">*</span></label>
                                                            <select class="form-control " id="select-category"
                                                                name="id_category">
    
                                                            </select>
                                                        </div>
    
                                                        <div class="form-group col-6">
                                                            <label for="title">Tên sản phẩm <span
                                                                    class="required_field">*</span></label>
                                                            <input autocomplete="off" type="text" class="form-control"
                                                                id="title" name="title" placeholder="Tên sản phẩm"
                                                                required="required"></input>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="fileProductAvatar">Avatar <span
                                                                class="required_field">*</span></label>
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

                                                    <div class="form-group">
                                                        <label for="price">Giá <span
                                                                class="required_field">*</span></label>
                                                        <input type="number" autocomplete="off" class="form-control"
                                                            id="price" name="price" placeholder="Giá sản phẩm"
                                                            required="required"></input>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="priceSale">Giảm giá </label>
                                                        <input type="number" autocomplete="off" class="form-control"
                                                            id="priceSale" name="priceSale"
                                                            placeholder="Giảm giá"></input>
                                                    </div>

                                                    <!--   <div class="form-group">
                                                        <label for="seo">Seo </label>
                                                        <input type="text" autocomplete="off" class="form-control" id="seo" name="seo" placeholder="Seo"></input>
                                                    </div> -->

                                                    <div class="form-group">
                                                        <label for="model">Model </label>
                                                        <input type="text" autocomplete="off" class="form-control"
                                                            id="model" name="model" placeholder="model"></input>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="origin">Xuất xứ </label>
                                                        <input type="text" autocomplete="off" class="form-control"
                                                            id="origin" name="origin" placeholder="Xuất xứ"></input>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="amount">Số lượng </label>
                                                        <input type="number" autocomplete="off" class="form-control"
                                                            id="amount" name="amount" placeholder="Số lượng"></input>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="guarantee">Bảo hành (tháng) </label>
                                                        <input type="number" autocomplete="off" class="form-control"
                                                            id="guarantee" name="guarantee"
                                                            placeholder="Bảo hành"></input>
                                                    </div>

                                                    <div class="form-group">
                                                        <label>Sản phẩm hot</label>&nbsp;&nbsp;&nbsp;
                                                        <input type="radio" name="isHot" id="hot1" value="true"
                                                            class="radio-button-form" />
                                                        <label for="hot1"
                                                            class="label-radio-button">Hot</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <input type="radio" name="isHot" id="hot2" value="false"
                                                            class="radio-button-form" />
                                                        <label for="hot2" class="label-radio-button">Bình thường</label>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="short_description">Mô tả ngắn <span
                                                                class="required_field">*</span></label>
                                                        <textarea autocomplete="off" class="form-control"
                                                            placeholder="Short Description" id="description"
                                                            name="description" rows="8" required="required"></textarea>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="fileProductPictures">Hình ảnh </label>
                                                        <%-- <input id="fileProductPictures" name="uploadImages" type="file" class="form-control-file" multiple="multiple"> --%>
                                                        <div class="row mt-4">
                                                            <div class="col-sm-2 imgUp">
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
                                                            </div><!-- col-2 -->
                                                            <i class="fa fa-plus imgAdd"></i>
                                                        </div><!-- row -->
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="detail">Chi tiết <span
                                                                class="required_field">*</span></label>
                                                        <textarea row=5 autocomplete="off"
                                                            class="form-control summernote" id="detail" name="detail"
                                                            required="required">
                                                        </textarea>
                                                    </div>

                                                    <div class="form-group">
                                                        <label>Trạng thái <span
                                                                class="required_field">*</span></label>&nbsp;&nbsp;&nbsp;
                                                        <input type="radio" name="status" id="status1" value="true"
                                                            class="radio-button-form" />
                                                        <label for="status1" class="label-radio-button">Hiển
                                                            thị</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <input type="radio" name="status" id="status2" value="false"
                                                            class="radio-button-form" />
                                                        <label for="status2" class="label-radio-button">Ẩn</label>
                                                    </div>

                                                    <div class="form-group">
                                                        <a class="btn btn-secondary"
                                                            href="${base}/admin/product/index">Hủy</a>
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

    <!-- JS-->
    <jsp:include page="/WEB-INF/views/manager/layout/script.jsp"></jsp:include>
    <%-- <script type="text/javascript" src="${base }/manager/js/productScript/addOrUpdateProduct.js"></script> --%>
    <script type="text/javascript">
        var editor = '';
        $(document).ready(function () {
            editor = CKEDITOR.replace('detail', {
                width: ['100%'],
                height: ['400px']
            });

            loadProduct(); //load data to select category for product

            var id_product = $('#id').val();
            if (id_product != null && id_product != "") {
                loadDetailForEdit(id_product);
                $("#title-page-add-update").text("Cập nhật sản phẩm");
            }
            setActiveMenu();

        });

        function setActiveMenu() {
            console.log("call");
            $(".navbar__list li").each(function () {
                $(this).removeClass("active");
            });
            $(".list-unstyled li").each(function () {
                $(this).removeClass("active");
            });
            $('.list-unstyled #menu--product').addClass("active");
            $('.navbar__list #menu--product').addClass("active");
        }

        // function to add imput image product
        $(".imgAdd").click(function () {
            $(this).closest(".row").find('.imgAdd').before(
                '<div class="col-sm-2 imgUp"><div class="imagePreview image--product" data-id-image=""></div><label class="btn btn-primary btn--upload-image">Upload<input type="file" class="uploadFile img" name="images" accept="image/png, image/jpeg, image/jpg" style="width:0px;height:0px;overflow:hidden;"></label><i class="fa fa-times del"></i></div>'
            );
        });
        $(document).on("click", "i.del", function () {
            $(this).parent().remove();
        });
        //function to add preview image
        $(function () {
            $(document).on("change", ".uploadFile", function () {
                var uploadFile = $(this);
                var files = !!this.files ? this.files : [];
                if (!files.length || !window.FileReader)
                    return; // no file selected, or no FileReader support

                if (/^image/.test(files[0].type)) { // only image file
                    var reader = new FileReader(); // instance of the FileReader
                    reader.readAsDataURL(files[0]); // read the local file

                    reader.onloadend = function () { // set image data as background of div
                        //alert(uploadFile.closest(".upimage").find('.imagePreview').length);
                        uploadFile.closest(".imgUp").find('.imagePreview').css("background-image",
                            "url(" + this.result + ")");
                    }
                }

            });
        });

        //function to add new product
        function saveOrUpdate() {
            var form = $('#form--upload')[0];
            var data = new FormData(form);
            var detailCkEditor = editor.getData();
            data.append('detail', detailCkEditor);

            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/admin/add-update-product",
                data: data,
                processData: false, //prevent jQuery from automatically transforming the data into a query string
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    alert("Thành công!");
                    $(location).attr('href', "/admin/product");
                },
                error: function (e) {
                    console.log("ERROR : ", e);
                }
            });
        }

        //function to add category for selecting
        function loadProduct() {
            $.ajax({
                url: "/admin/all-category-active",
                type: "get",
                contentType: "application/json", //set data send to server is json
                data: "",
                dataType: "json", //set data return is json
                success: function (result) {
                    var html = '';
                    $.each(result, function (index, value) {
                        html += '<option value="' + value.id + '">' + value.name + '</option>';
                    });
                    $('#select-category').html(html);
                },
                error: function (jqXhr, textStatus, errorMessage) {
                    //show error
                }
            });
        }

        function loadDetailForEdit(id_product) {
            $.ajax({
                url: "/admin/detail-product",
                type: "get",
                contentType: "application/json", //set data send to server is json
                data: {
                    idProduct: id_product
                },
                dataType: "json", //set data return is json
                success: function (result) {

                    $('#id').val(result.product[0].id);
                    $('#title').val(result.product[0].title);
                    $('#select-category').val(result.product[0].id_category);
                    $('.img--avatar').css("background-image", "url(/upload/" + result.product[0].avatar +
                        ")");
                    $('#price').val(result.product[0].price);
                    $('#priceSale').val(result.product[0].priceSale);
                    $('#seo').val(result.product[0].seo);
                    $('#description').val(result.product[0].description);

                    $('#model').val(result.product[0].model);
                    $('#origin').val(result.product[0].origin);
                    $('#guarantee').val(result.product[0].guarantee);
                    $('#amount').val(result.product[0].amount);

                    editor.setData(result.product[0].detail);

                    if (result.product[0].status == true) {
                        $('#status1').attr("checked", true);
                    } else {
                        $('#status2').attr("checked", true);
                    }

                    if (result.product[0].isHot == true) {
                        $('#isHot1').attr("checked", true);
                    } else {
                        $('#isHot2').attr("checked", true);
                    }

                    $('i.del').parent().remove();

                    $.each(result.productImages, function (index, value) {
                        $(".imgAdd").closest(".row").find('.imgAdd').before(
                            '<div class="col-sm-2 imgUp"><div class="imagePreview image--product" data-id-image="" ></div><label class="btn btn-primary btn--upload-image">Upload<input type="file" class="uploadFile img" name="images" accept="image/png, image/jpeg, image/jpg" style="width:0px;height:0px;overflow:hidden;"></label><i class="fa fa-times del"></i></div>'
                        );
                        $(".image--product").last().css("background-image", "url(/upload/" + value
                            .path + value.title + ")");
                        $(".image--product").last().attr("data-id-image", value.id);
                    });
                },
                error: function (jqXhr, textStatus, errorMessage) {
                    //show error
                }
            });
        }
    </script>
</body>

</html>
<!-- end document-->