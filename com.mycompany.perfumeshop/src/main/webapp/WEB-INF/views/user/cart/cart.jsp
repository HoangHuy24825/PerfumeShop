<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- SPRING FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="zxx">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Giỏ hàng | Electronic Device</title>
    <link rel="icon" href="${base }/user/img/my-logo/logo-asp.net.png">
    <!--::style part start::-->
    <jsp:include page="/WEB-INF/views/user/layout/style.jsp"></jsp:include>
    <!--::style part end::-->
</head>

<body>
    <!--::header part start::-->
    <jsp:include page="/WEB-INF/views/user/layout/header.jsp"></jsp:include>
    <!-- Header part end-->

    <!--================Home Banner Area =================-->
    <!-- breadcrumb start-->
    <jsp:include page="/WEB-INF/views/user/layout/banner.jsp"></jsp:include>
    <!-- breadcrumb start-->

    <!--================Cart Area =================-->
    <section class="cart_area mt-3">
        <div class="container bg-white p-4">
            <div class="cart_inner">
                <div class="table-responsive" id="content-cart-page">
                    <c:if test="${cart==null}">
                        <div style="text-align:center">
                            <img src="${base }/user/myImages/shopping_cart.png" alt="Chưa có sản phẩm nào trong giỏ!"
                                style="width:200px;height:auto" />
                            <p style="margin: 15px 0px 30px; ">Không có sản phẩm nào trong giỏ hàng của bạn.</p>
                            <a class="btn_1" href="${base }/product">Tiếp tục mua hàng</a>
                        </div>
                    </c:if>
                    <c:if test="${cart!=null}">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col"><input type="checkbox" id="selectAll" onclick="selectAllRecord()">
                                    </th>
                                    <th scope="col">Sản phẩm</th>
                                    <th scope="col">Giá</th>
                                    <th scope="col">Số lượng</th>
                                    <th scope="col" width="150px">Thành tiền</th>
                                    <th scope="col" data-toggle="tooltip" title="Xóa các mục đã chọn!"
                                        id="btn-delete-selected" onclick="deleteRecordSelected()"><i
                                            class="fas fa-trash-alt"></i></th>
                                </tr>
                            </thead>
                            <tbody id="cart-container">
                                <c:forEach var="cartItem" items="${cart.cartItems}">
                                    <tr class="data-table" id="${cartItem.productId }">
                                        <td scope="col"><input type="checkbox"
                                                onclick="changeStatus(${cartItem.productId})"></td>
                                        <td>
                                            <div class="media">
                                                <div class="d-flex">
                                                    <img src="/upload/${cartItem.avatarProduct}" alt="" width="150" />
                                                </div>
                                                <div class="media-body">
                                                    <p>${cartItem.productName}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <h5 id="price">
                                                <fmt:setLocale value="vi_VN" />
                                                <fmt:formatNumber value="${cartItem.priceUnit}" minFractionDigits="0"
                                                    type="currency" currencySymbol="&#8363;" />
                                            </h5>
                                        </td>
                                        <td>
                                            <div class="d-flex flex-row">
                                                <div class="up-down decrease"
                                                    onclick="alterProductOrder('decrease',${cartItem.maxOrder},${cartItem.productId})">
                                                    <i class="fas fa-minus"></i>
                                                </div>
                                                <div class="number_product_order">
                                                    <input class="text-center" id="number_order"
                                                        onkeypress="return isNumberKey(event)"
                                                        onfocusout="focusOut(${cartItem.productId})"
                                                        onfocus="getOldValue(${cartItem.productId})"
                                                        onkeyup="checkValid(${cartItem.maxOrder},${cartItem.productId})"
                                                        onchange="totalMoney(${cartItem.productId})" type="text"
                                                        value="${cartItem.quanlity}">
                                                </div>
                                                <div class="up-down increment"
                                                    onclick="alterProductOrder('increment', ${cartItem.maxOrder},${cartItem.productId})">
                                                    <i class="fas fa-plus"></i>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <h5 id="totalProductItem">
                                                <!--total money to pay product item-->
                                            </h5>
                                        </td>
                                        <td onclick="deleteRecord(${cartItem.productId})"><i
                                                class="fas fa-trash-alt"></i></td>
                                    </tr>
                                </c:forEach>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>
                                        <h5>Tổng tiền</h5>
                                    </td>
                                    <td>
                                        <h5 id="totalPay">
                                            <!--total pay-->
                                        </h5>
                                    </td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="checkout_btn_inner float-right">
                            <a class="btn_1" href="${base }/product">Tiếp tục mua hàng</a>
                            <div class="btn_1 checkout_btn_1" id="btn_pay" onclick="payNow()">Mua hàng</div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </section>


    <!--modal confirm delete product-->
    <!-- Modal -->
    <div class="modal fade" id="modalConfirmOder" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body " id="modalConfirmOderContent" style="font-size:22px ">
                    <!--content-->
                </div>
                <div class="modal-footer mx-auto" style="border:unset">
                    <button type="button" id="btn_close" class="btn btn-secondary" data-dismiss="modal">
                        <!--Button Close-->
                    </button>
                    <button type="button" id="btn_save" onclick="deleteRecordConfirmed()" class="btn btn-primary">
                        <!--Button Save-->
                    </button>
                </div>
            </div>
        </div>
    </div>



    <!-- product_list part start-->
    <jsp:include page="/WEB-INF/views/user/layout/new-product.jsp"></jsp:include>
    <!-- product_list part end-->

    <!--::footer_part start::-->
    <jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
    <!--::footer_part end::-->

    <!--::message_part start::-->
    <div class="alert hide" id="alert_message">
        <div id="icon-alert-message"><i class="fas fa-exclamation-circle"></i></div>
        <span class="msg">Warning: This is a warning alert!</span>
        <div class="close-btn-alert">
            <span class="fas fa-times"></span>
        </div>
    </div>
    <!--::message_part end::-->

    <!-- jquery plugins here-->
    <jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
    <script type="text/javascript">
        $(document).ready(function () {

            setMenuBanner();

            $('#totalPay').text((0).toLocaleString('it-IT', {
                style: 'currency',
                currency: 'VND'
            }));
            $('tr').each(function () {
                totalMoney($(this).attr('id'));
            });

            $('.close-btn-alert').click(function () {
                $('.alert').removeClass("show");
                $('.alert').addClass("hide");
            });
            loadTotalMustPay();
        });


        function setMenuBanner() {
            $("#img-banner").html('<img src="${base}/user/img/my-image/banner/cart.png" alt="" width="300">');
            var titlebanner = '';
            titlebanner += '<h2>Giỏ hàng</h2>';
            titlebanner += '<p>Trang chủ <span>></span>Giỏ hàng</p>';
            $("#title-banner").html(titlebanner);

            $("#mainNav li").each(function (index) {
                $(this).removeClass("my-menu-active");
            });

        }

        function deleteRecord(id_product) {
            $('#btn_save').attr("onclick", "deleteRecordConfirmed(" + id_product + ")");
            $('#modalConfirmOderContent').text("Bạn muốn xóa sản phẩm này?");
            $('#btn_close').text("Không");
            $('#btn_save').show();
            $('#btn_save').text("Xóa");
            $('#btn_close').css({
                "background-color": "#007bff",
                "border": "1px solid #007bff",
                "width": "200px"
            })
            $('#btn_save').css({
                "background-color": "rgb(255, 66, 78)",
                "border": "1px solid rgb(255, 66, 78)",
                "width": "200px"
            });
            $('#modalConfirmOder').modal('show');
        }

        function deleteRecordConfirmed(id_product) {
            $('#modalConfirmOder').modal("hide");
            $.ajax({
                url: "/Cart/DeleteCart?id_product=" + id_product,
                type: "post",
                data: {},
                dataType: "json",
                contentType: "application/json",
                success: function (jsonResult) {
                    showAlertMessage(jsonResult.message, true);
                    $('#' + id_product).remove();
                    loadTotalMustPay();
                },
                error: function (jqXhr, textStatus, errorMessage) { // error callback 
                    showAlertMessage("Xóa thất bại", false);
                }
            });
        };

        function focusOut(id) {

            if ($('#' + id).find('#number_order').val() == '' || $('#' + id).find('#number_order').val() == null) {
                showAlertMessage("Số lượng không được trống!", false);
                $('#' + id).find('#number_order').val(1);
                totalMoney(id);
                var element = $('#' + id).find('input[type="checkbox"]');
                if (element.prop("checked")) {
                    var numberOrder = parseInt($('#' + id).find('#number_order').val());
                    var oldMoney = parseFloat($('#totalPay').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
                    var price = parseFloat($('#' + id).find('#price').text().trim().replace(/([,.€])+/g, '').split(' ')[
                        0]);
                    $('#totalPay').text(new Intl.NumberFormat('it-IT', {
                        style: 'currency',
                        currency: 'VND'
                    }).format(oldMoney + price * numberOrder));
                }
                $('#' + id).find('#number_order').data('val', $('#' + id).find('#number_order').val());
                var id_account = window.location.href.split("=")[1];
                addProductToCartSilent(id, parseInt($('#' + id).find('#number_order').val()));
            }
        };

        /*function to change status selected of record when click ckeck box for all record */
        function selectAllRecord() {
            if ($('#selectAll').prop("checked")) {
                $('#totalPay').text((0).toLocaleString('it-IT', {
                    style: 'currency',
                    currency: 'VND'
                }));
                $('tr[class="data-table"]').each(function () {
                    $(this).find('input[type="checkbox"]').prop("checked", true);
                    changeStatus($(this).attr('id'));
                });
            } else {
                $('#totalPay').text((0).toLocaleString('it-IT', {
                    style: 'currency',
                    currency: 'VND'
                }));
                $('tr[class="data-table"]').each(function () {
                    $(this).find('input[type="checkbox"]').prop("checked", false);
                });
            }
        };


        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        };

        function getOldValue(id) {
            var element = $('#' + id).find('#number_order');
            element.data('val', element.val());
        };

        /* function to check value order number when typping*/
        function checkValid(maxOrder, id) {

            var oldNumberOrder = $('#' + id).find('#number_order').data('val');
            var numberOrder = parseInt($('#' + id).find('#number_order').val());
            var element = $('#' + id).find('input[type="checkbox"]');
            var price = parseFloat($('#' + id).find('#price').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
            var oldMoney = parseFloat($('#totalPay').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);


            if ($('#' + id).find('#number_order').val() == '' || $('#' + id).find('#number_order').val() == null) {
                if (element.prop("checked") && parseInt($('#' + id).find('#totalProductItem').text().trim().replace(
                        /([,.€])+/g, '').split(' ')[0]) != 0) {
                    $('#totalPay').text(new Intl.NumberFormat('it-IT', {
                        style: 'currency',
                        currency: 'VND'
                    }).format(oldMoney - price * oldNumberOrder));
                }
                $('#' + id).find('#totalProductItem').text(new Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND'
                }).format(0));
                $('#' + id).find('#number_order').data('val', 0);
                return;
            }

            if (numberOrder > maxOrder) {
                showAlertMessage("Số lượng mua tối đa cho sản phẩm này là " + maxOrder, false);

                $('#' + id).find('#number_order').val(maxOrder);
            } else if (numberOrder < 1) {
                $('#modalConfirmOderContent').text("Bạn muốn xóa sản phẩm này?");
                $('#btn_close').text("Không");
                $('#btn_save').show();
                $('#btn_save').text("Xóa");
                $('#btn_close').css({
                    "background-color": "#007bff",
                    "border": "1px solid #007bff",
                    "width": "200px"
                })
                $('#btn_save').css({
                    "background-color": "rgb(255, 66, 78)",
                    "border": "1px solid rgb(255, 66, 78)",
                    "width": "200px"
                });
                $('#btn_save').attr("onclick", "deleteRecordConfirmed(" + id + ")");
                //$('#btn_save').data('id_product', id);
                //$('#btn_save').data('id_account', id_account);


                $('#modalConfirmOder').modal("show");
                $('#' + id).find('#number_order').val(1);
            }
            numberOrder = parseInt($('#' + id).find('#number_order').val());
            totalMoney(id);
            addProductToCartSilent(id, numberOrder);
            if (element.prop("checked")) {
                $('#totalPay').text(new Intl.NumberFormat('it-IT', {
                    style: 'currency',
                    currency: 'VND'
                }).format(oldMoney + price * (numberOrder - oldNumberOrder)));
            }
            $('#' + id).find('#number_order').data('val', $('#' + id).find('#number_order').val());
        };

        /*function to alter value order number when click up or down*/
        function alterProductOrder(status, maxOrder, id) {
            var numberOrder = parseInt($('#' + id).find('#number_order').val());
            var oldMoney = parseFloat($('#totalPay').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
            var price = parseFloat($('#' + id).find('#price').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
            var element = $('#' + id).find('input[type="checkbox"]');
            if (status == 'decrease') {
                if (numberOrder > 1) {
                    $('#' + id).find('#number_order').val(numberOrder - 1);
                    if (element.prop("checked")) {
                        $('#totalPay').text(new Intl.NumberFormat('it-IT', {
                            style: 'currency',
                            currency: 'VND'
                        }).format(oldMoney - price));
                    }
                } else {
                    $('#modalConfirmOderContent').text("Bạn muốn xóa sản phẩm này?");
                    $('#btn_close').text("Không");
                    $('#btn_save').show();
                    $('#btn_save').text("Xóa");
                    $('#btn_close').css({
                        "background-color": "#007bff",
                        "border": "1px solid #007bff",
                        "width": "200px"
                    })
                    $('#btn_save').css({
                        "background-color": "rgb(255, 66, 78)",
                        "border": "1px solid rgb(255, 66, 78)",
                        "width": "200px"
                    });

                    $('#btn_save').attr("onclick", "deleteRecordConfirmed(" + id + ")");
                    //$('#btn_save').data('id_product', id);
                    //$('#btn_save').data('id_account', id_account);


                    $('#modalConfirmOder').modal("show");
                    $('#' + id).find('#number_order').val(1);

                }
            } else {
                if (numberOrder < maxOrder) {
                    $('#' + id).find('#number_order').val(numberOrder + 1);
                    if (element.prop("checked")) {
                        $('#totalPay').text(new Intl.NumberFormat('it-IT', {
                            style: 'currency',
                            currency: 'VND'
                        }).format(oldMoney + price));
                    }
                } else {
                    showAlertMessage("Số lượng mua tối đa cho sản phẩm này là " + maxOrder, false);
                    $('#' + id).find('#number_order').val(maxOrder);
                }
            }
            totalMoney(id);
            addProductToCartSilent(id, parseInt($('#' + id).find('#number_order').val()));
        };

        /*function to change status selected of record when click ckeck box*/
        function changeStatus(id) {
            var element = $('#' + id).find('input[type="checkbox"]');
            var oldMoney = parseFloat($('#totalPay').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
            var elementMoney = parseFloat($('#' + id).find('#totalProductItem').text().trim().replace(/([,.€])+/g, '')
                .split(' ')[0]);
            if (element.prop("checked")) {
                if (checkAllRecordChecked()) {
                    $('.table').find('thead').find('input[type="checkbox"]').prop("checked", true);
                }
                $('#totalPay').text(new Intl.NumberFormat('it-IT', {
                    style: 'currency',
                    currency: 'VND'
                }).format(oldMoney + elementMoney));
            } else {
                $('#selectAll').prop("checked", false);
                $('#totalPay').text(new Intl.NumberFormat('it-IT', {
                    style: 'currency',
                    currency: 'VND'
                }).format(oldMoney - elementMoney));
            }
        };

        /*function to set value of total price of a record*/
        function totalMoney(id) {
            var numberOrder = parseInt($('#' + id).find('#number_order').val());
            var price = parseFloat($('#' + id).find('#price').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
            //$('#' + id).find('#totalProductItem').text((numberOrder * price).toLocaleString('it-IT', { style: 'currency', currency: 'VND' }));
            $('#' + id).find('#totalProductItem').text(new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(numberOrder * price));
        };

        function showAlertMessage(message, messageState) {
            if (messageState) {
                $('#alert_message').css({
                    "background-color": "#C5F3D7",
                    "border-left": "8px solid #2BD971"
                });
                $("#icon-alert-message").html('<i class="fas fa-check-circle"></i>');
                $("#icon-alert-message").find('i').css({
                    "color": "#2BD971"
                });
                $(".msg").css({
                    "color": "#24AD5F"
                });
                $(".close-btn-alert").css({
                    "background": "#2BD971",
                    "color": "#24AD5F"
                });
                $(".close-btn-alert").find('.fas').css({
                    "color": "#24AD5F"
                });
                $(".close-btn-alert").hover(function (e) {
                    $(this).css("background-color", e.type === "mouseenter" ? "#38F5A3" : "#2BD971")
                })
            } else {
                $('#alert_message').css({
                    "background-color": "#FFE1E3",
                    "border-left": "8px solid #FF4456"
                });
                $("#icon-alert-message").html('<i class="fas fa-exclamation-circle"></i>');
                $("#icon-alert-message").find('i').css({
                    "color": "#FE4950"
                });
                $(".msg").css({
                    "color": "#F694A9"
                });
                $(".close-btn-alert").css({
                    "background": "#FF9CA4",
                    "color": "#FD4653"
                });
                $(".close-btn-alert").find('.fas').css({
                    "color": "#FD4653"
                });
                $(".close-btn-alert").hover(function (e) {
                    $(this).css("background-color", e.type === "mouseenter" ? "#FFBDC2" : "#FF9CA4")
                })
            }

            $('.msg').text(message);
            $('.alert').addClass("show");
            $('.alert').removeClass("hide");
            $('.alert').addClass("showAlert");
            setTimeout(function () {
                $('.alert').removeClass("show");
                $('.alert').addClass("hide");
            }, 3000);
        };

        /*check all record is checked*/
        function checkAllRecordChecked() {
            var result = true;;
            $('#cart-container>tr').each(function () {
                if ($(this).find('input[type="checkbox"]').prop("checked") == false) {
                    result = false;
                    return;
                }
            });
            return result;
        };

        function deleteRecordSelected() {
            $('#modalConfirmOderContent').text("Bạn muốn xóa sản phẩm đang chọn?");
            $('#btn_close').text("Không");
            $('#btn_save').show();
            $('#btn_save').text("Xóa");
            $('#btn_close').css({
                "background-color": "#007bff",
                "border": "1px solid #007bff",
                "width": "200px"
            })
            $('#btn_save').css({
                "background-color": "rgb(255, 66, 78)",
                "border": "1px solid rgb(255, 66, 78)",
                "width": "200px"
            });
            $("#btn_save").attr("onclick", "deleteAllRecordConfirmed()");

            $('#modalConfirmOder').modal('show');
        };

        function deleteAllRecordConfirmed() {
            $('#modalConfirmOder').modal('hide');
            var arrIdProductStr = '';
            $('#cart-container>tr').each(function () {
                if ($(this).find('input[type="checkbox"]').prop("checked") == true) {
                    arrIdProductStr += ($(this).attr('id') + ";");
                }
            })

            var arrIdProduct = arrIdProductStr.split(";");

            $.ajax({
                url: "/Cart/DeleteSelectedCart?id_product=" + arrIdProductStr,
                type: "POST",
                dataType: 'json',
                data: {},
                contentType: "application/json",
                success: function (jsonResult) {
                    showAlertMessage(jsonResult.message, true);
                    for (var i = 0; i <= arrIdProduct.length; i++) {
                        $('#' + arrIdProduct[i]).remove();
                    }
                    loadTotalMustPay();
                },
                error: function (jqXhr, textStatus, errorMessage) { // error callback 

                    showAlertMessage("Xóa thất bại", false);
                }
            });
        };

        function addProductToCart(id_product, amount) {
            let data = {
                productId: id_product,
                quanlity: amount
            }
            $.ajax({
                url: "/cart/add",
                type: "post",
                data: JSON.stringify(data),
                dataType: "json",
                contentType: "application/json",
                success: function (jsonResult) {
                    showAlertMessage("Thêm vào giỏ hàng thành công!", true);
                    $('#icon-cart-header').find($('#amount_cart')).text(jsonResult.totalItems);
                },
                error: function (jqXhr, textStatus, errorMessage) {
                    showAlertMessage("Không thêm được sản phẩm vào giỏ hàng!", false);
                }
            });
        };


        function addProductToCartSilent(id_product, amount) {
            let data = {
                productId: id_product,
                quanlity: amount
            }
            $.ajax({
                url: "/cart/add-product",
                type: "post",
                data: JSON.stringify(data),
                dataType: "json",
                contentType: "application/json",
                success: function (jsonResult) {
                    /* showAlertMessage("Thêm vào giỏ hàng thành công!",true); */
                    $('#icon-cart-header').find($('#amount_cart')).text(jsonResult.totalItems);
                },
                error: function (jqXhr, textStatus, errorMessage) {
                    /* showAlertMessage("Không thêm được sản phẩm vào giỏ hàng!",false); */
                }
            });
        };

        function loadTotalMustPay() {
            var total = 0;
            $('#cart-container>tr').each(function () {
                if ($(this).find('input[type="checkbox"]').prop("checked") == true) {
                    var id = $(this).attr("id");
                    var numberOrder = parseInt($('#' + id).find('#number_order').val());
                    var price = parseFloat($('#' + id).find('#price').text().trim().replace(/([,.€])+/g, '')
                        .split(' ')[0]);
                    total += numberOrder * price;
                }
            });
            $('#totalPay').text(new Intl.NumberFormat('it-IT', {
                style: 'currency',
                currency: 'VND'
            }).format(total));

            if ($('#cart-container>tr').length <= 1) {
                var html = '';
                html += '<div style="text-align:center">';
                html +=
                    '<img src="${base}/user/myImages/shopping_cart.png" alt="Chưa có sản phẩm nào trong giỏ!" style="width:200px;height:auto" />';
                html += ' <p style="margin: 15px 0px 30px; ">Không có sản phẩm nào trong giỏ hàng của bạn.</p>';
                html += ' <a class="btn_1" href="${base}/product">Tiếp tục mua hàng</a>';
                html += '</div>';
                $('#content-cart-page').html(html);
            }
        };

        function payNow() {
            var arrIdProduct = new Array();
            $('#cart-container>tr').each(function () {
                if ($(this).find('input[type="checkbox"]').prop("checked") == true) {
                    arrIdProduct.push($(this).attr('id'));
                }
            });

            if (arrIdProduct.length > 0) {
                var listIdProduct = '';
                for (var i = 0; i < arrIdProduct.length; i++) {
                    listIdProduct += arrIdProduct[i] + ";";
                }
                window.location.href = '/bill-cart?strIdProduct=' + listIdProduct;
            } else {
                showAlertMessage("Chưa có sản phẩm nào được chọn mua!", false);
            }
        };
    </script>
    <!--::footer_part end::-->
</body>

</html>