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
    $("#img-banner").html('<img src="/user/img/my-image/banner/cart.png" alt="" width="300">');
    var titlebanner = '';
    titlebanner += '<h2>Giỏ hàng</h2>';
    titlebanner += '<p>Trang chủ <span>></span>Giỏ hàng</p>';
    $("#title-banner").html(titlebanner);

    $("#mainNav li").each(function (index) {
        $(this).removeClass("my-menu-active");
    });

}

function deleteRecord(id_product) {
    $('#btnAgree').attr("onclick", "deleteRecordConfirmed(" + id_product + ")");
    showConfirm("Bạn có thực sự muốn xóa sản phẩm này khỏi giỏ hàng?", "Có", "Không", true);
}

function deleteRecordConfirmed(id_product) {
    $('#modalCustomerConfirmContent').modal("hide");
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
        $('#btnAgree').attr("onclick", "deleteRecordConfirmed(" + id + ")");
        showConfirm("Bạn có thực sự muốn xóa sản phẩm này khỏi giỏ hàng?", "Có", "Không", true);
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
            $('#btnAgree').attr("onclick", "deleteRecordConfirmed(" + id + ")");
            showConfirm("Bạn có thực sự muốn xóa sản phẩm này khỏi giỏ hàng?", "Có", "Không", true);
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
    $("#btnAgree").attr("onclick", "deleteAllRecordConfirmed()");
    showConfirm("Bạn có thực sự muốn xóa các sản phẩm đã chọn khỏi giỏ hàng?", "Có", "Không", true);
};

function deleteAllRecordConfirmed() {
    $('#modalCustomerConfirmContent').modal('hide');
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
        quantity: amount
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
        quantity: amount
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
            '<img src="/user/myImages/shopping_cart.png" alt="Chưa có sản phẩm nào trong giỏ!" style="width:200px;height:auto" />';
        html += ' <p style="margin: 15px 0px 30px; ">Không có sản phẩm nào trong giỏ hàng của bạn.</p>';
        html += ' <a class="btn_1" href="/product">Tiếp tục mua hàng</a>';
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