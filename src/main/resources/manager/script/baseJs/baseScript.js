/**
 * 
 */

$(document).ready(function () {
    $("body").on('click', ".close-btn-alert", function () {
        $('.alert-success').removeClass("show");
        $('.alert-success').addClass("hide");
        $('.alert-fail').removeClass("show");
        $('.alert-fail').addClass("hide");
    });
});

function showAlertMessage(message, messageState) {
    $('.msg').text(message);
    if (messageState) {
        $('.alert-success').addClass("show");
        $('.alert-success').removeClass("hide");
        $('.alert-success').addClass("showAlert");
    } else {
        $('.alert-fail').addClass("show");
        $('.alert-fail').removeClass("hide");
        $('.alert-fail').addClass("showAlert");
    }
    setTimeout(function () {
        $('.alert-success').removeClass("show");
        $('.alert-success').addClass("hide");
        $('.alert-fail').removeClass("show");
        $('.alert-fail').addClass("hide");
    }, 1500);
};

function showConfirm(message, btnConfirm, btnClose, danger) {
    $('#modalCustomerConfirmContent').text(message);
    $('#btnCloseConfirm').text(btnClose);
    $('#btnAgree').show();
    $('#btnAgree').text(btnConfirm);
    if (danger) {
        $('#btnAgree').addClass("btn btn-danger");
        $('#btnCloseConfirm').addClass("btn btn-primary");
    } else {
        $('#btnAgree').addClass("btn btn-primary");
        $('#btnCloseConfirm').addClass("btn btn-secondary");
    }
    $('#modalCustomerConfirm').modal('show');
}

// function to add imput image product
$(".imgAdd").click(function () {
    $(this).closest(".row").find('.imgAdd').before('<div class="col-sm-2 imgUp"><div class="imagePreview image--product" data-id-image=""></div><label class="btn btn-primary btn--upload-image">Upload<input type="file" class="uploadFile img" name="images" accept="image/png, image/jpeg, image/jpg" style="width:0px;height:0px;overflow:hidden;"></label><i class="fa fa-times del"></i></div>');
});
$(document).on("click", "i.del", function () {
    $(this).parent().remove();
});
//function to add preview image
$(function () {
    $(document).on("change", ".uploadFile", function () {
        var uploadFile = $(this);
        var files = !!this.files ? this.files : [];
        if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support

        if (/^image/.test(files[0].type)) { // only image file
            var reader = new FileReader(); // instance of the FileReader
            reader.readAsDataURL(files[0]); // read the local file

            reader.onloadend = function () { // set image data as background of div
                //alert(uploadFile.closest(".upimage").find('.imagePreview').length);
                uploadFile.closest(".imgUp").find('.imagePreview').css("background-image", "url(" + this.result + ")");
            }
        }

    });
});

function setActiveMenu(currentTag) {
    $(".navbar__list li").removeClass("active");
    $(".list-unstyled li").removeClass("active");
    $('.list-unstyled ' + currentTag).addClass("active");
    $('.navbar__list ' + currentTag).addClass("active");
}

function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [day, month, year].join('-');
}

function formatDateType2(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}

function addCommas(nStr) {
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}

/* NOTIFY CONTENT START */
function showNotifyHeader() {
    $.ajax({
        url: "/perfume-shop/admin/load-top-three-notify",
        type: "get",
        contentType: "application/json",

        dataType: "json", // kieu du lieu tra ve tu controller la json
        success: function (jsonResult) {
            var html = '';
            $("#quanlity_notify").text(jsonResult.amountUnread);
            html += '<div class="notifi__title">';
            html += '	<p>Bạn có ' + jsonResult.amountUnread + ' thông báo mới</p>';
            html += '</div>';
            $.each(jsonResult.notifies, function (index, value) {
                if (value.status == 0) {
                    html += '<div class="notifi__item unread" onclick="viewOrderNotify(' + value
                        .id + ',' + value.id_order + ',1)">';
                } else {
                    html += '<div class="notifi__item" onclick="viewOrderNotify(' + value.id +
                        ',' + value.id_order + ',1)">';
                }
                html += '<div class="bg-c1 img-cir img-40">';
                html += '    <i class="zmdi zmdi-email-open"></i>';
                html += '</div>';
                html += '<div class="content">';
                html += `    <p> ${value.message}
                                <span class="text-secondary"> 
                                    (${(value.status==1&&value.processingStatus==1)?'Đã xử lý':''})
                                </span>
                            </p>`;
                html += '    <span class="date">' + value.createdDate + '</span>';
                html += ' </div>';
                html += '</div>';
            });
            html += '<div class="notifi__footer">';
            html +=
                '	<button id="btn_show_nofity" style="width: 100%; padding: 15px 15px; color: blue" onclick="showAllNotify()">Tất cả thông báo</button>';
            html += '</div>';
            $('#notify_content').html(html);
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 

        }
    });
}

function showAllNotify() {
    $('.modal-backdrop').show();
    $.get({
        url: "/perfume-shop/admin/load-all-notify",
        contentType: "application/json",
        dataType: "json",
        success: function (jsonResult) {
            var html = '';
            $.each(jsonResult.notifies, function (index, value) {
                if (value.status == 0) {
                    html += '<div class="au-message__item unread" onclick="viewOrderNotify(' +
                        value.id + ',' + value.id_order + ',2)">';
                } else {
                    html += '<div class="au-message__item" onclick="viewOrderNotify(' + value.id +
                        ',' + value.id_order + ',2)">';
                }

                html += '    <div class="au-message__item-inner">';
                html += '        <div class="au-message__item-text">';
                html += '            <div class="avatar-wrap">';
                html += '                <div class="bg-c1 img-cir img-40">';
                html += '                     <i class="zmdi zmdi-email-open"></i>';
                html += '                </div>';
                html += '            </div>';
                html += '            <div class="text">';
                html += '                <h5 class="name">' + value.email + '</h5>';
                html += `                <p>
                                            ${value.firstName} ${value.lastName} yêu cầu ${value.requestType} có mã 
                                            <b> ${value.codeOrder} </b>. 
                                            <span class="text-secondary"> ${(value.status==1&&value.processingStatus==1)?'Đã xử lý':''}</span>
                                            </p>`;
                html += '                <span class="date">' + value.createdDate + '</span>';
                html += '            </div>';
                html += '        </div>';
                html +=
                    '        <button class="item" title="Xóa" onclick="event.stopPropagation(); delete_notify(' +
                    value.id + ')">';
                html += '        	<i class="fas fa-trash-alt"></i>';
                html += '        </button>';
                html += '    </div>';
                html += '</div>';
            });

            $("#notify_detail_title").text("Bạn có " + jsonResult.amountUnread + " thông báo mới.");
            $("#list-detail-notify").html(html);
            $("#notify-modal").modal('show');
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 

        }
    });
}



function delete_notify(idNotify) {
    $("#notify-modal").modal('hide');
    $('#btnAgree').attr("onclick", "deleteNotifyConfirmed(" + idNotify + ")");
    showConfirm("Bạn chắc chắn muốn xóa thông báo này ?", "Có", "Không", true);
}

function closeDeleteConfirm() {
    $('#modalCustomerConfirm').modal('hide');
    showAllNotify();
}

function deleteNotifyConfirmed(idNotify) {
    $('#modalCustomerConfirm').modal('show');
    $.post({
        url: "/perfume-shop/admin/delete-notify/" + idNotify,
        success: function (result) {
            if (result == true) {
                showAlertMessage("Xóa thành công!", true);
                showAllNotify();
                showNotifyHeader();
            } else {
                showAlertMessage("Xóa thất bại!", false);
            }
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 
            showAlertMessage("Xóa thất bại!", false);
        }
    });
}

function changeStyleStatusNotify(status) {
    for (var i = 0; i <= 4; i++) {
        $('#status--' + i + '--notify').removeClass("text-success");
        $('#status-orders').removeClass("text-dark");
        $('#status-orders').removeClass("text-success");
        $('#status-orders').removeClass("text-danger");
    }
    if (status != 4) {
        $('#status--4').addClass("d-none");
        for (var i = 0; i <= status; i++) {
            $('#status--' + i + '--notify').removeClass("d-none");
            $('#status--' + i + '--notify').addClass("text-success");
        }
        if (status == 3) {
            $('#status-orders').addClass("text-success");
        } else {
            $('#status-orders').addClass("text-dark");
        }
    } else {
        for (var i = 0; i < status; i++) {
            $('#status--' + i + '--notify').addClass("d-none");
        }
        $('#status--4--notify').removeClass("d-none");
        $('#status-orders').addClass("text-danger");
    }
}

function viewOrderNotify(idNotify, idOrder, status_all_notify_modal_1) {
    $.ajax({
        url: "/perfume-shop/admin/detail-order-notify/" + idOrder + "/" + idNotify,
        success: function (result) {
            $('#fullname-notify').text(result.order.customerName);
            $('#email-notify').text(result.order.customerEmail);
            $('#phone-notify').text(result.order.customerPhone);
            $('#address-notify').text(result.order.customerAddress);
            $('#createdDate-notify').text(result.order.createdDate);
            $('#total-notify').text(result.order.total.toLocaleString('it-IT', {
                style: 'currency',
                currency: 'VND'
            }));
            $('#code-order-notify').text(result.order.code);
            $('#id-order-notify').text(result.order.id);
            switch (result.order.processingStatus) {
                case 0:
                    $('#status-orders-notify').addClass("text-dark");
                    changeStyleStatusNotify(0);
                    break;
                case 1:
                    $('#status-orders-notify').text('Đã tiếp nhận');
                    changeStyleStatusNotify(1);
                    break;
                case 2:
                    $('#status-orders-notify').text('Đang giao');
                    changeStyleStatusNotify(2);
                    break;
                case 3:
                    $('#status-orders-notify').text('Giao thành công');
                    changeStyleStatusNotify(3);
                    break;
                case 4:
                    $('#status-orders-notify').text('Đã hủy');
                    changeStyleStatusNotify(4);
                    break;
                default:
                    break;
            }

            $("reason-notify").text(result.notify.reason);


            var html = '';
            $.each(result.order.orderDetails, function (i, item) {
                html += '<div class="d-flex flex-row">';
                html += '    <img class="" src="/upload/' + item.avatar + '" alt="' + item
                    .productName + '"';
                html += '        width="100" height="100">';
                html += '    <div class="ml-4">';
                html += '        <h5>' + item.productName + '</h5>';
                html += '        <p>Giá: ' + item.price.toLocaleString('it-IT', {
                    style: 'currency',
                    currency: 'VND'
                }) + '</p>';
                html += '        <p>Số lượng: ' + item.quantity + '</p>';
                html += '    </div>';
                html += '</div>';
                html += '<br>';
            });
            $('#list--product--order-notify').html(html);
            $('#notify-detail-modal').modal('show');
            $('#btn_cancel_order').attr("onclick", "cancelOrderFromRequest(" + idOrder + ")");
            $('#btn_not_cancel_order').attr("onclick", "rejectCancelOrderRequest(" + idOrder + ")");
        }
    });

    if (status_all_notify_modal_1 == 1) {
        status_all_notify_modal = false;
    } else {
        status_all_notify_modal = true;
    }
}