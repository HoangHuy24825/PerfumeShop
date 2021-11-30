var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
var regexPhone = /^[0]{1}[0-9]{9,13}$/;
$(document).ready(function () {
    setMenuBanner();

    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });

    $('#error_full_name').hide();
    $('#error_address').hide();
    $('#error_email').hide();
    $('#error_phone').hide();
    $('#error_old_password').hide();
    $('#error_new_password').hide();
    $('#error_confirm_password').hide();

    $('#input-request-cancel').keydown(function () {
        $('#request-cancel-message').hide();
    });

    $('#fullname').keydown(function () {
        $('#error_full_name').hide();
    });
    $('#address').keydown(function () {
        $('#error_address').hide();
    });
    $('#email').keydown(function () {
        $('#error_email').hide();
    });
    $('#phone').keydown(function () {
        $('#error_phone').hide();
    });

    $('#OldPassword').keydown(function () {
        $('#error_old_password').hide();
    });

    $('#NewPassword').keydown(function () {
        $('#error_new_password').hide();
    });

    $('#ConfirmPassword').keydown(function () {
        $('#error_confirm_password').hide();
    });

    $("#fullname").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_full_name").text("Tên người dùng không được trống!");
            $("#error_full_name").show();
        } else {
            $("#error_full_name").hide();
        }
    })

    $("#address").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_address").text("Địa chỉ người dùng không được trống!");
            $("#error_address").show();
        } else {
            $("#error_address").hide();
        }
    })

    $("#email").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_email").text("Email người dùng không được trống!");
            $("#error_email").show();
        } else {
            if (!regexEmail.test($(this).val())) {
                $("#error_email").text("Email người dùng không hợp lệ!");
                $("#error_email").show();
            } else {
                $('#error_email').hide();
            }
        }
    })

    $("#phone").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_phone").text("Số điện thoại người dùng không được trống!");
            $("#error_phone").show();
        } else {
            if (!regexPhone.test($(this).val())) {
                $("#error_phone").text("Số điện thoại không hợp lệ!");
                $("#error_phone").show();
            } else {
                $('#error_phone').hide();
            }
        }
    })

    $("#OldPassword").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_old_password").text("Mật khẩu hiện tại không được trống!");
            $("#error_old_password").show();
        } else {
            $("#error_old_password").hide();
        }
    })

    $("#NewPassword").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_new_password").text("Mật khẩu mới không được trống!");
            $("#error_new_password").show();
        } else {
            $("#error_new_password").hide();
        }
    })

    $("#ConfirmPassword").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_confirm_password").text("Vui lòng nhập lại mật khẩu mới!");
            $("#error_confirm_password").show();
        } else {
            $("#error_confirm_password").hide();
        }
    })
});


function setMenuBanner() {
    var titlebanner = '';
    $("#img-banner").html('<img class="avatar rounded-circle" src="' + $('#output').attr('src') + '" alt="">');
    titlebanner += '<h2>Thông tin tài khoản</h2>';
    titlebanner += '<p> Trang chủ <span>></span> Thông tin tài khoản </p>';
    $("#title-banner").html(titlebanner);

    $("#mainNav li").each(function (index) {
        $(this).removeClass("my-menu-active");
    });

}

function validateFormInfor() {
    var result = true;

    if ($("#fullname").val() == null || $("#fullname").val() == "") {
        $("#error_full_name").text("Tên người dùng không được trống!");
        $("#error_full_name").show();
        result = false;
    }

    if ($("#address").val() == null || $("#address").val() == "") {
        $("#error_address").text("Địa chỉ người dùng không được trống!");
        $("#error_address").show();
        result = false;
    }

    if ($("#email").val() == null || $("#email").val() == "") {
        $("#error_email").text("Email người dùng không được trống!");
        $("#error_email").show();
        result = false;
    } else {
        if (!regexEmail.test($("#email").val())) {
            $("#error_email").text("Email người dùng không hợp lệ!");
            $("#error_email").show();
            result = false;
        }
    }

    if ($("#phone").val() == null || $("#phone").val() == "") {
        $("#error_phone").text("Số điện thoại người dùng không được trống!");
        $("#error_phone").show();
        result = false;
    } else {
        if (!regexPhone.test($("#phone").val())) {
            $("#error_phone").text("Số điện thoại không hợp lệ!");
            $("#error_phone").show();
            result = false;
        }
    }
    return result;
}

function clickUpdateInfo() {
    if (validateFormInfor()) {
        var form = $('#form-infor')[0];
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/perfume-shop/add-update-account",
            data: new FormData(form),
            processData: false, //prevent jQuery from automatically transforming the data into a query string
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                showAlertMessage("Đổi thông tin thành công!", true);
                window.location.href = '/perfume-shop/my-account.html';
            },
            error: function (e) {
                console.log("ERROR : ", e);
            }
        });
    }
}


function validateFormChangePassword() {
    var result = true;

    if ($("#OldPassword").val() == null || $("#OldPassword").val() == "") {
        $("#error_old_password").text("Mật khẩu hiện tại không được trống!");
        $("#error_old_password").show();
        result = false;
    }

    if ($("#NewPassword").val() == null || $("#NewPassword").val() == "") {
        $("#error_new_password").text("Mật khẩu mới không được trống!");
        $("#error_new_password").show();
        result = false;
    }

    if ($("#ConfirmPassword").val() == null || $("#ConfirmPassword").val() == "") {
        $("#error_confirm_password").text("Vui lòng nhập lại mật khẩu!");
        $("#error_confirm_password").show();
        result = false;
    }
    return result;
}

function changePassword() {
    if (validateFormChangePassword()) {
        var oldPassword = $("#OldPassword").val();
        var newPassword = $("#NewPassword").val();
        var reNewPassword = $("#ConfirmPassword").val();

        if (newPassword != reNewPassword) {
            $("#error_confirm_password").text("Nhập lại mật khẩu mới phải trùng mới mật khẩu mới!");
            $("#error_confirm_password").show();
        } else {
            $.post({
                url: "/perfume-shop/update-password",
                data: {
                    oldPassword: oldPassword,
                    newPassword: newPassword
                },
                success: function (jsonResult) {
                    if (jsonResult == true) {
                        showAlertMessage("Đổi mật khẩu thành công!", true);
                        window.location.href = '/perfume-shop/my-account.html';
                    } else {
                        $('#error_old_password').text("Sai mật khẩu!");
                        $('#error_old_password').show();
                        showAlertMessage("Đổi mật khẩu thất bại!", false);
                    }
                },
                error: function (e) {}
            });
        }
    }
}

const loadFile = (event) => {
    let image = document.getElementById('output');
    image.src = URL.createObjectURL(event.target.files[0]);
};

function LoadBillModal(idOrder) {
    $.ajax({
        url: '/perfume-shop/order',
        data: {
            idOrder: idOrder
        },
        type: "GET",
        success: function (jsonResult) {
            $('#id-orders').text(jsonResult.saleOrder.id);
            switch (jsonResult.saleOrder.processingStatus) {
                case 0:
                    $('#status-orders').text("Chưa tiếp nhận");
                    break;
                case 1:
                    $('#status-orders').text("Đã tiếp nhận");
                    break;
                case 2:
                    $('#status-orders').text("Đang giao hàng");
                    break;
                default:
                    break;
            }
            $('#FullRecieverName').text(jsonResult.saleOrder.customerName);
            $('#RecieverEmail').text(jsonResult.saleOrder.customerEmail);
            $('#RecieverPhone').text(jsonResult.saleOrder.customerPhone);
            $('#RecieverAddress').text(jsonResult.saleOrder.customerAddress);
            $('#SumPrice').text(jsonResult.saleOrder.total.toLocaleString('it-IT', {
                style: 'currency',
                currency: 'VND'
            }));
            /* ID_Bill_Modal = ID_Bill; */
            loadSaleOrderProduct(idOrder, true);
        }
    });
};

function loadSaleOrderProduct(idOrder, status) {
    $.ajax({
        url: '/perfume-shop/sale-order-product-id-order',
        data: {
            idOrder: idOrder
        },
        type: "GET",
        success: function (jsonResult) {
            if (status) {
                $('.sp').remove();
            }
            var html1 = '';
            var html2 = '';
            $.each(jsonResult.orderDetails, function (i, item) {
                if (status) {
                    html1 += '<div class="sp">';
                    html1 += '<br>';
                    html1 += '<div class="d-flex flex-row">';
                    html1 += '<img class="border" src="/upload/' + item.avatar +
                        '" alt="" width="100" height="100">';
                    html1 += '<div class="ml-2">';
                    html1 += '<h5>' + item.productName + '</h5>';
                    html1 += '<p>Giá: ' + item.price.toLocaleString('it-IT', {
                        style: 'currency',
                        currency: 'VND'
                    }) + '</p>';
                    html1 += '<p>Số lượng: ' + item.quantity + '</p>';
                    html1 += '</div>';
                    html1 += '</div>';
                    html1 += '</div>';
                    $('#list-product-detail').html(html1);
                } else {
                    html2 += '<div class="sp_bill">';
                    html2 += '<br>';
                    html2 += '<div class="d-flex flex-row">';
                    html2 += '<img class="border" src="/upload/' + item.avatar +
                        '" alt="" width="100" height="100">';
                    html2 += '<div class="ml-2">';
                    html2 += '<h5>' + item.productName + '</h5>';
                    html2 += '<p>Giá: ' + item.price.toLocaleString('it-IT', {
                        style: 'currency',
                        currency: 'VND'
                    }) + '</p>';
                    html2 += '<p>Số lượng: ' + item.quantity + '</p>';
                    html2 += '</div>';
                    html2 += '</div>';
                    html2 += '</div>';
                    $('#' + idOrder).html(html2);
                }
            });
        }
    });
}


function loadSaleOrder(idAccount) {
    $.ajax({
        url: '/perfume-shop/order-by-account',
        data: {
            idAccount: idAccount
        },
        type: "GET",
        success: function (jsonResult) {
            var html = '';
            var html2 = '';
            $.each(jsonResult.orders, function (index, order) {
                if (order.processingStatus == 1 || order.processingStatus == 2 || order
                    .processingStatus == 0) {
                    var status;
                    if (order.processingStatus == 1)
                        status = "Đã tiếp nhận";
                    else if (order.processingStatus == 2)
                        status = "Giao cho đơn vị vận chuyển";
                    else if (order.processingStatus == 0)
                        status = "Đơn hàng mới";

                    html += '<div class="row' + order.id + '">';
                    html += '<div class="col-md-12">';
                    html += '<div class="card">';
                    html += '<div class="card-header">';
                    html += '<ul class="blog-info-link">';
                    html += '<li><a href="#"><i class="far fa-clock"></i>' + order
                        .createdDate + '</a></li>';
                    html += '<li>';
                    html += '<a href="#" class="text-success">';
                    html += '<i class="fas fa-shipping-fast"></i>';
                    html += '<span>' + status + '</span?';
                    html += '</a>';
                    html += '</li>';
                    html += '</ul>';
                    html += '</div>';
                    html += '<div class="card-body">';
                    html += '<div class=" ">';
                    $.each(order.orderDetails, function (indexInArray, detail) {
                        html +=
                            `
                            <div class="sp_bill px-4">
                                <br>
                                <div class="d-flex flex-row">
                                    <img class="border" src="/upload/${detail.avatar}" alt="" width="100" height="100">
                                    <div class="ml-3">
                                    <h5>${detail.productName}</h5>
                                    <p>
                                        Giá: ${detail.price.toLocaleString('it-IT', {style: 'currency',currency: 'VND'})}
                                    </p>
                                    <p>Số lượng: ${detail.quantity}</p>
                                    </div>
                                </div>
                            </div>
                            `
                    });
                    html += '<div class="px-4 pt-2">';
                    html += '<h4 class="text-success font-weight-bold float-right">Tổng tiền: ' + order.total
                        .toLocaleString('it-IT', {
                            style: 'currency',
                            currency: 'VND'
                        }) + '</h4>';
                    html += '<br>';
                    html += '<hr>';
                    html += '<div class=" float-right">';
                    html += '<div class="checkout_btn_inner float-right">';
                    html +=
                        '<button style="border:unset" type="button" class="btn_1 btn_billAccount" onclick="LoadBillModal(' +
                        order.id +
                        ')" value="Chi tiết" data-toggle="modal" data-target="#modal-bill-detail">Chi tiết đơn hàng</button>';
                    html +=
                        `<button style="border:unset" type="button" class="btn_1 btn_billAccount btn_pay" data-id-order="${order.id}" >Hủy đơn hàng</button>`;
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';
                    html += '</div >';
                    html += '</div >';
                    html += '</div ></br>';
                }
            });
            $('#newBill').html(html);
            $.each(jsonResult.orders, function (index, order) {
                if (order.processingStatus == 3 || order.processingStatus == 4) {
                    var status = "";
                    if (order.processingStatus == 3) {
                        status = "Đã giao thành công";
                    } else if (order.processingStatus == 4) {
                        status = "Đã hủy";
                    }
                    html2 += '<tr>';
                    html2 += '<th scope="row">' + order.code + '</th>';
                    html2 += '<td>' + order.createdDate + '</td>';
                    html2 += '<td id = "billBelow' + order.id + '">';
                    $.each(order.orderDetails, function (indexInArray, detail) {
                        html2 +=
                            `
                            <span>${detail.productName}</span>
                        
                        `
                    });
                    html2 += '</td >';
                    html2 += '<td>' + order.total.toLocaleString('it-IT', {
                        style: 'currency',
                        currency: 'VND'
                    }) + '</td>';

                    if (order.processingStatus == 4)
                        html2 += '<td id="statusBill" style="color:red">' + status + '</td>';
                    else if (order.processingStatus == 3)
                        html2 += '<td id="statusBill" style="color:green">' + status +
                        '</td>';
                    html2 += '</tr>';
                    $('#oldBill').html(html2);
                    if (order.Status == 4)
                        $('#statusBill' + order.id).css("color", "red");
                    if (order.Status == 3)
                        $('#statusBill' + order.id).css("color", "green");
                }
            });
        }
    });

    $("body").on("click", ".btn_pay", function () {
        var idOrder = parseInt($(this).data("id-order"));
        $("#modal-confirm").modal("show");
        $.get({
            url: "/perfume-shop/get-code-cancel-bill/" + null + "/" + null,
            success: function (jsonResult) {
                $(".btnSendCode").data("code-confirm", jsonResult.codeConfirm);
                $(".btnSendCode").data("id-order", idOrder);
            },
            error: function (e) {

            }
        });
    });


    $("body").on("click", ".btnSendCode", function () {
        if ($(this).data("code-confirm") == $("#code-confirm").val()) {
            $("#modal-confirm").modal("hide");
            cancelOrder($(this).data("id-order"));
            console.log($(this).data("id-order"));
            $(this).data("code-confirm", "");
        } else {
            $("#code-confirm-message").text("Nhập sai mã! Vui lòng nhập lại!");
            $("#code-confirm-message").show();
        }
    });
}

function cancelOrder(idOrder) {
    $('#btn_request-cancel').attr("onclick", "cancelOrderNotifyConfirmed(" + idOrder + ")");
    $('#modal-request-cancel').modal('show');
}

function cancelOrderNotifyConfirmed(idOrder) {
    var reason = $('#input-request-cancel').val().trim();
    console.log(reason);
    if (reason != '' && reason != null) {
        $('#modal-request-cancel').modal('hide');
        $.ajax({
            url: '/perfume-shop/request-cancel-order',
            data: {
                idOrder: idOrder,
                reason: reason
            },
            type: "GET",
            success: function (jsonResult) {
                if (jsonResult == true) {
                    showConfirm("Chúng tôi đã nhận được yêu cầu hủy đơn hàng của bạn." +
                        "Vui lòng kiểm tra email thường xuyên để nhận được thông báo về việc hủy đơn hàng!",
                        "Đóng");
                } else {
                    showAlertMessage("Gửi yêu cầu thất bại!", false);
                }
            }
        });
    } else {
        $('#request-cancel-message').text('Vui lòng nhập lý do hủy đơn!');
        $('#request-cancel-message').show();
    }
}