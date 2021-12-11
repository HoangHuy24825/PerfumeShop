var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
var regexPhone = /^[0]{1}[0-9]{9,13}$/;
$(document).ready(function () {

    $('#my-order').hide();
    setMenuBanner();


    $.validator.addMethod("validateEmail", function (value, element) {
        return regexEmail.test(value);
    });
    $.validator.addMethod("validatePhone", function (value, element) {
        return regexPhone.test(value);
    });
    $("#formSearchOrder").submit(function (e) {
        e.preventDefault();
    }).validate({
        rules: {
            name: {
                required: true,
            },
            email: {
                required: true,
                validateEmail: true
            },
            phone: {
                required: true,
                validatePhone: true
            }
        },
        messages: {
            name: {
                required: "Vui lòng nhập họ tên khách hàng",
            },
            email: {
                required: "Vui lòng nhập email",
                validateEmail: "Email sai định dạng"
            },
            phone: {
                required: "Vui lòng nhập số điện thoại",
                validatePhone: "Số điện thoại sai định dạng"
            }
        },
        submitHandler: function (form) {
            $('#my-order').show();
            $.post({
                url: '/perfume-shop/customer-order-searching',
                data: new FormData(form),
                processData: false,
                contentType: false,
                enctype: 'multipart/form-data',
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
                            html += '<span>' + status + '</span>';
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
                                    onclick="viewOrder(${order.id})" value="Chi tiết" >Chi tiết đơn hàng</button>`;
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
        }
    });

    $("body").on("click", ".btn_pay", function () {
        var email = $("#customerEmail").val();
        var customerName = $("#customerName").val();
        var idOrder = parseInt($(this).data("id-order"));
        $("#modal-confirm").modal("show");
        $.get({
            url: "/perfume-shop/get-code-cancel-bill/" + email + "/" + customerName,
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
});




function setMenuBanner() {
    $("#img-banner").html('<img src="/user/img/my-image/banner/bill.png" alt="" width="200">');
    var titlebanner = '';
    titlebanner += '<h2>Tra cứu thông tin đơn hàng</h2>';
    titlebanner += '<p>Trang chủ <span>></span>Tra cứu thông tin đơn hàng</p>';
    $("#title-banner").html(titlebanner);

    $("#mainNav li").each(function (index) {
        $(this).removeClass("my-menu-active");
    });


}



function cancelOrder(idOrder) {
    $('#btn_request-cancel').attr("onclick", "cancelOrderNotifyConfirmed(" + idOrder + ")");
    $("#modal-request-cancel").modal("show");
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