var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
var regexPhone = /^[0]{1}[0-9]{9,13}$/;
$(document).ready(function () {
    setMenuBanner();

    $.validator.addMethod("validatePhone", function (value, element) {
        return regexPhone.test(value);
    }, "Số điện thoại sai định dạng");

    $.validator.addMethod("validateEmail", function (value, element) {
        return regexEmail.test(value);
    }, "Email sai định dạng");

    $.validator.addMethod("validateRepassword", function (value, element) {
        return value == $("#newPassword").val();
    }, "Nhập lại mật khẩu phải trùng với mật khẩu mới");

    $("#form-infor").submit(function (e) {
        e.preventDefault();
    }).validate({
        rules: {
            fullname: "required",
            address: "required",
            phone: {
                required: true,
                validatePhone: true
            },
        },

        messages: {
            fullname: "Vui lòng nhập họ tên",
            address: "Vui lòng nhập địa chỉ",
            phone: {
                required: "Vui lòng nhập số điện thoại",
            },
        },

        submitHandler: function (form) {
            var data = new FormData(form);
            data.append("email", $("#email").val());
            $.post({
                enctype: 'multipart/form-data',
                url: "/perfume-shop/add-update-account",
                data: data,
                processData: false, //prevent jQuery from automatically transforming the data into a query string
                contentType: false,
                success: function (data) {
                    showAlertMessage("Đổi thông tin thành công!", true);
                    window.location.href = '/perfume-shop/my-account.html';
                },
                error: function (e) {
                    console.log("ERROR : ", e);
                }
            });
        }
    });

    $("#changePasswordForm").submit(function (e) {
        e.preventDefault();
    }).validate({
        rules: {
            oldPassword: "required",
            newPassword: "required",
            confirmPassword: {
                required: true,
                validateRepassword: true
            },
        },

        messages: {
            oldPassword: "Vui lòng nhập mật khẩu cũ",
            newPassword: "Vui lòng nhập mật khẩu mới",
            confirmPassword: {
                required: "Vui lòng nhập lại mật khẩu",
            },
        },

        submitHandler: function (form) {
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/perfume-shop/update-password",
                data: new FormData(form),
                processData: false, //prevent jQuery from automatically transforming the data into a query string
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (jsonResult) {
                    if (jsonResult == true) {
                        showAlertMessage("Đổi mật khẩu thành công!", true);
                        window.location.href = '/perfume-shop/my-account.html';
                    } else {
                        $('#errMsg').text("Sai mật khẩu!");
                        showAlertMessage("Đổi mật khẩu thất bại!", false);
                    }
                },
                error: function (e) {}
            });
        }
    });
});


function setMenuBanner() {
    var titlebanner = '';
    $("#img-banner").html('<img class="avatar rounded-circle" src="' + $('#output').attr('src') + '" alt="">');
    titlebanner += '<h2>Thông tin tài khoản</h2>';
    titlebanner += '<p> Trang chủ <span>></span> Thông tin tài khoản </p>';
    $("#title-banner").html(titlebanner);
    $("#mainNav li").removeClass("my-menu-active");
}


const loadFile = (event) => {
    let image = document.getElementById('output');
    image.src = URL.createObjectURL(event.target.files[0]);
};

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
                        `<button style="border:unset" type="button" class="btn_1 btn_billAccount" 
                            onclick="viewOrder(${order.id})" value="Chi tiết">Chi tiết đơn hàng</button>`;
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