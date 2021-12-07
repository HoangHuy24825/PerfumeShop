$(document).ready(function () {

    setMenuBanner();


    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });


    $('#customerNameMessage').hide();
    $('#customerEmailMessage').hide();
    $('#customerPhoneMessage').hide();
    $('#customerAddressMessage').hide();

    $('#customerName').keydown(function () {
        $('#customerNameMessage').hide();
    });

    $('#customerEmail').keydown(function () {
        $('#customerEmailMessage').hide();
    });

    $('#customerPhone').keydown(function () {
        $('#customerPhoneMessage').hide();
    });

    $('#customerAddress').keydown(function () {
        $('#customerAddressMessage').hide();
    });

    $('#customerName').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#customerNameMessage').find('.message-content').text(
                "Tên người nhận không được trống!");
            $('#customerNameMessage').show();
            $('#btn_submit').attr("type", "button");
        } else {
            $('#customerNameMessage').hide();

        }
    });

    $('#customerEmail').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#customerEmailMessage').find('.message-content').text(
                "Email người nhận không được trống!");
            $('#customerEmailMessage').show();
            $('#btn_submit').attr("type", "button");
        } else {
            var expr = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!expr.test($(this).val())) {
                $('#customerEmailMessage').find('.message-content').text(
                    "Email người nhận không hợp lệ!");
                $('#customerEmailMessage').show();
                $('#btn_submit').attr("type", "button");
            } else {
                $('#customerEmailMessage').hide();

            }
        }

    });

    $('#customerPhone').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#customerPhoneMessage').find('.message-content').text(
                "Số điện thoại người nhận không được trống!");
            $('#customerPhoneMessage').show();
            $('#btn_submit').attr("type", "button");
        } else {
            var val = /^[0]{1}[0-9]{9,13}$/;
            if (!val.test($(this).val())) {
                $('#customerPhoneMessage').find('.message-content').text(
                    "Số điện thoại người nhận không hợp lệ!");
                $('#customerPhoneMessage').show();
                $('#btn_submit').attr("type", "button");
            } else {
                $('#customerPhoneMessage').hide();
            }
        }

    });

    $('#customerAddress').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#customerAddressMessage').find('.message-content').text(
                "Địa chỉ người nhận không được trống!");
            $('#customerAddressMessage').show();
            $('#btn_submit').attr("type", "button");
        } else {
            $('#customerAddressMessage').hide();

        }
    });

    preLoad();
});

function setMenuBanner() {
    $("#img-banner").html('<img src="/user/img/my-image/banner/buy.png" alt="" width="200">');
    var titlebanner = '';
    titlebanner += '<h2>Đặt hàng</h2>';
    titlebanner += '<p>Trang chủ <span>></span>Đặt hàng</p>';
    $("#title-banner").html(titlebanner);


    $("#mainNav li").each(function (index) {
        $(this).removeClass("my-menu-active");
    });
}

function preLoad() {
    var username = $('#title-infor-customer').attr("data-useraccount-login").toString();
    if (username != null && username != "") {
        if ($('#customerName').val() == "" || $('#customerName').val() == null) {
            $('#customerNameMessage').find('.message-content').text("Tên người nhận không được trống!");
            $('#customerNameMessage').show();
            $('#btn_submit').attr("type", "button");
        } else {
            $('#customerNameMessage').hide();

        }

        if ($('#customerEmail').val() == "" || $('#customerEmail').val() == null) {
            $('#customerEmailMessage').find('.message-content').text("Email người nhận không được trống!");
            $('#customerEmailMessage').show();
            $('#btn_submit').attr("type", "button");
        } else {
            var expr = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!expr.test($('#customerEmail').val())) {
                $('#customerEmailMessage').find('.message-content').text("Email người nhận không hợp lệ!");
                $('#customerEmailMessage').show();
                $('#btn_submit').attr("type", "button");
            } else {
                $('#customerEmailMessage').hide();

            }
        }

        if ($('#customerPhone').val() == "" || $('#customerPhone').val() == null) {
            $('#btn_submit').attr("type", "button");
        }

        if ($('#customerAddress').val() == "" || $('#customerAddress').val() == null) {
            $('#btn_submit').attr("type", "button");
        } else {
            $('#customerAddressMessage').hide();
        }
    }
}

function validationAfterClick() {

    var result = true;
    if ($('#customerName').val() == "" || $('#customerName').val() == null) {
        $('#customerNameMessage').find('.message-content').text("Tên người nhận không được trống!");
        $('#customerNameMessage').show();
        result = false;
    }

    if ($('#customerEmail').val() == "" || $('#customerEmail').val() == null) {
        $('#customerEmailMessage').find('.message-content').text("Email người nhận không được trống!");
        $('#customerEmailMessage').show();
        result = false;
    } else {
        var expr = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if (!expr.test($('#customerEmail').val())) {
            $('#customerEmailMessage').find('.message-content').text("Email người nhận không hợp lệ!");
            $('#customerEmailMessage').show();
            result = false;
        }
    }

    if ($('#customerPhone').val() == "" || $('#customerPhone').val() == null) {
        $('#customerPhoneMessage').find('.message-content').text("Số điện thoại người nhận không được trống!");
        $('#customerPhoneMessage').show();
        result = false;
    } else {
        var val = /^[0]{1}[0-9]{9,13}$/;
        if (!val.test($('#customerPhone').val())) {
            $('#customerPhoneMessage').find('.message-content').text("Số điện thoại người nhận không hợp lệ!");
            $('#customerPhoneMessage').show();
            result = false;
        }
    }

    if ($('#customerAddress').val() == "" || $('#customerAddress').val() == null) {
        $('#customerAddressMessage').find('.message-content').text("Địa chỉ người nhận không được trống!");
        $('#customerAddressMessage').show();
        result = false;
    }
    return result;
}


function CallSubmit() {
    if (validationAfterClick()) {
        var arrIdProductStr = '';
        var amount = 0;
        if ($('.item-product').length == 1) {
            arrIdProductStr = ($('.item-product').data("id-product") + ";");
            amount = parseInt($('.item-product').data("amount-product"));
        } else {
            $('.item-product').each(function () {
                arrIdProductStr += ($(this).data("id-product") + ";");
            })
        }

        var form = $('#form-upload')[0];
        var data = new FormData(form);
        $.ajax({
            url: "/perfume-shop/order?strIdProduct=" + arrIdProductStr + "&&amount=" + amount,
            type: "POST",
            enctype: 'multipart/form-data',
            data: data,
            processData: false, //prevent jQuery from automatically transforming the data into a query string
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (jsonResult) {
                $(location).attr('href', "/perfume-shop/recent-order?idSaleOrder=" + jsonResult.idOrder);
            },
            error: function (e) {
                showAlertMessage("Đặt hàng không thành công!", false);
            }
        });
    }
}