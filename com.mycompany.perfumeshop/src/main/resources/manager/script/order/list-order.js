/**
 * 
 */
var status_all_notify_modal = false;

$(document).ready(function () {
    setActiveMenu();
    LoadNewOrder(1);
    // showNotifyHeader();

    /*  FUNCTION WHEN MODAL NOTIFY CLOSING */
    // $("#notify-detail-modal").on('hide.bs.modal', function () {
    //     showNotifyHeader();
    //     if (status_all_notify_modal) {
    //         showAllNotify();
    //     } else {
    //         showAllNotify;
    //         $('#notify-modal').modal('hide');
    //     }
    // });


    $("body").on("click", "#paged--list--new--order li a", function (event) {
        event.preventDefault();
        var currentPage = parseInt($(this).attr('data-page'));
        LoadNewOrder(currentPage);
    });

    $("body").on("click", "#paged--list--order--process li a", function (event) {
        event.preventDefault();
        var currentPage = parseInt($(this).attr('data-page'));
        LoadOrderProcess(currentPage);
    });

    $("body").on("click", "#paged--list--order--success li a", function (event) {
        event.preventDefault();
        var currentPage = parseInt($(this).attr('data-page'));
        LoadOrderSuccessOrDeleted(3, currentPage);
    });

    $("body").on("click", "#paged--list--order--deleted li a", function (event) {
        event.preventDefault();
        var currentPage = parseInt($(this).attr('data-page'));
        LoadOrderSuccessOrDeleted(4, currentPage);
    });
});

/* NOTIFY CONTENT START */
function showNotifyHeader() {
    $.ajax({
        url: "/perfume-shop/admin/load-top-three-notify",
        type: "get",
        contentType: "application/json",
        data: "",
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
                html += '    <p>' + value.message + '</p>';
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
    $.ajax({
        url: "/perfume-shop/admin/load-all-notify",
        type: "get",
        contentType: "application/json",
        data: "",
        dataType: "json", // kieu du lieu tra ve tu controller la json
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
                html += '                <p>' + value.firstName + ' ' + value.lastName +
                    ' yêu cầu ' + value.requestType + ' có mã <b>' + value.codeOrder +
                    '</b>.</p>';
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
    $.ajax({
        url: "/perfume-shop/admin/delete-notify?id-notify=" + idNotify,
        type: "POST",
        data: {},
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            if (result.message == true) {
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
        url: '/perfume-shop/admin/detail-order-notify',
        type: "GET",
        data: {
            idOrder: idOrder,
            idNotify: idNotify
        },
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            $('#fullname-notify').text(result.saleOrder.customerName);
            $('#email-notify').text(result.saleOrder.customerEmail);
            $('#phone-notify').text(result.saleOrder.customerPhone);
            $('#address-notify').text(result.saleOrder.customerAddress);
            $('#createdDate-notify').text(result.saleOrder.createdDate);
            $('#total-notify').text(result.saleOrder.total.toLocaleString('it-IT', {
                style: 'currency',
                currency: 'VND'
            }));
            $('#code-order-notify').text(result.saleOrder.code);
            $('#id-order-notify').text(result.saleOrder.id);
            switch (result.saleOrder.processingStatus) {
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
            $.each(result.saleOrderProduct, function (i, item) {
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

function rejectCancelOrderRequest(idOrder) {
    $('#notify-detail-modal').modal('hide');
    $('#btn_confirm_reject').attr("onclick", "rejectCancelOrderRequestConfirmed(" + idOrder + ")");
    $('#modal-reason-reject').modal('show');
}

function rejectCancelOrderRequestConfirmed(idOrder) {
    $('#modal-reason-reject').modal('hide');
    showAlertMessage("Email từ chối đề nghị hủy đơn đã được gửi!", true);
    sentEmailConfirm(idOrder, 0, $('#input-reason-reject').val());
}

function cancelOrderFromRequest(idOrder) {
    $('#notify-detail-modal').modal('hide');
    $('#notify-modal').modal('hide');
    $('#btnAgree').attr("onclick", "cacelOrderRequestConfirmed(" + idOrder + ")");
    showConfirm("Bạn chắc chắn muốn hủy đơn hàng này ?", "Có", "Không", true);
}

function cacelOrderRequestConfirmed(idOrder) {
    var idOrder1 = parseInt(idOrder);
    $.ajax({
        url: '/perfume-shop/admin/cancel-order-request?idOrder=' + idOrder,
        type: "POST",
        data: {},
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            showAlertMessage("Hủy đơn hàng thành công!", true);
            $('#modalCustomerConfirm').modal('hide');
            sentEmailConfirm(idOrder, 1, null);
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 
            showAlertMessage("Hủy đơn hàng thất bại!", false);
        }
    });
}

function sentEmailConfirm(idOrder, status, content) {
    $.ajax({
        url: '/perfume-shop/admin/sent-email-confirm?idOrder=' + idOrder + '&&status=' + status + '&&content=' + content,
        type: "POST",
        data: {},
        dataType: "json",
        contentType: "application/json",
        success: function (result) {

        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 

        }
    });
}


/* NOTIFY CONTENT END */

function setActiveMenu() {
    $(".navbar__list li").each(function () {
        $(this).removeClass("active");
    });
    $(".list-unstyled li").each(function () {
        $(this).removeClass("active");
    });
    $('.list-unstyled #menu--order').addClass("active");
    $('.navbar__list #menu--order').addClass("active");
}

function LoadNewOrder(page) {
    var update_role = $("#update_role").val();
    var delete_role = $("#delete_role").val();
    var status = 0;
    $.ajax({
        url: '/perfume-shop/admin/list-order',
        type: "GET",
        data: {
            status: status,
            page: page
        },
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            var html = '';
            $.each(result.listOrder, function (i, item) {
                html += `  <tr class="tr-shadow">
                            <td class="number_order">${item.id }</td>
                            <td>
                                <span>${ item.code }</span>
                             </td>
                             <td>
                                <span>${ item.customerName }</span>
                             </td>
                            <td>
                                <span>${ item.customerAddress }</span>
                            </td>
                            <td>
                                <span class="text-primary font-weight-bold">
                                    ${item.total.toLocaleString('it-IT', {style: 'currency',currency: 'VND'})}
                                </span>
                            </td>
                            <td>
                                <span class="block-name-product">${ item.createdDate}</span>
                            </td>
                            <td>
                                <input type="button" class="btn btn-outline-info" value="Xem" onclick="viewOrder(${item.id})">
                                <input type="button" class="btn btn-outline-success" value="Nhận đơn" ${update_role == '    true'?"":"hide"}
                                    onclick="changeStatusOrder(${item.id},1,0)">
                                <input type="button" class="btn btn-outline-danger" value="Hủy đơn" ${update_role == 'true'?"":"hide"} 
                                    onclick="cancelBill(${item.id})">
                            </td>
                        </tr>
                        <tr class="spacer"></tr>`;
            });

            var totalPage = result.totalPage;
            var currentPage = result.currentPage;
            var pagination_string = '';
            if (currentPage > 1) {
                var previousPage = currentPage - 1;
                pagination_string += `
                                    <li class="page-item">
                                        <a href="" class="page-link" data-page=${previousPage} data-type-list=${result.listOrder[0].processingStatus}>
                                            <i class="fas fa-angle-double-left" style="font-size:18px"></i>
                                        </a>
                                    </li>`;
            }

            for (i = 1; i <= totalPage; i++) {
                if (i == currentPage) {
                    pagination_string += `
                                        <li class="page-item active">
                                            <a href="" class="page-link" data-page=${i} data-type-list=${result.listOrder[0].processingStatus}>
                                                ${currentPage}
                                            </a>
                                        </li>`;
                } else if (i >= currentPage - 3 && i <= currentPage + 4) {
                    pagination_string += `
                                        <li class="page-item">
                                            <a href="" class="page-link" data-page=${i} data-type-list=${result.listOrder[0].processingStatus}>
                                                ${i}
                                            </a>
                                        </li>`;
                }
            }

            if (currentPage > 0 && currentPage < totalPage) {
                var nextPage = currentPage + 1;
                pagination_string += `
                                        <li class="page-item">
                                            <a href="" class="page-link" data-page=${ nextPage} data-type-list=${result.listOrder[0].processingStatus}>
                                                <i class="fas fa-angle-double-right" style="font-size:18px"></i>
                                            </a>
                                        </li>`;
            }

            $('#newBill').html(html);
            $('#paged--list--new--order').html(pagination_string);
        }
    });
}


function LoadOrderProcess(page) {
    var status = 1;
    var update_role = $("#update_role").val();
    var delete_role = $("#delete_role").val();
    $.ajax({
        url: '/perfume-shop/admin/list-order',
        type: "GET",
        data: {
            status: status,
            page: page
        },
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            var html = '';
            $.each(result.listOrder, function (i, item) {
                html += '<tr class="tr-shadow">';
                html += '    <td class="number_order">' + item.id + '</td>';
                html += '    <td>';
                html += '        <span>' + item.code + '</span>';
                html += '    </td>';
                html += '    <td>';
                html += '         ' + item.customerName;
                html += '    </td>';
                html += '    <td>';
                html += '         ' + item.customerAddress;
                html += '    </td>';
                html += '     <td>';
                html += '          <span class="text-primary font-weight-bold">' + item.total
                    .toLocaleString('it-IT', {
                        style: 'currency',
                        currency: 'VND'
                    }) + '</span>';
                html += '     </td>';
                html += '     <td>';
                html += '          <span class="block-name-product">' + item.createdDate +
                    '</span>';
                html += '     </td>';
                html += '     <td>';
                html += '          <span class="block-name-product">' + item.updatedDate +
                    '</span>';
                html += '     </td>';
                if (update_role == 'true') {
                    html += '		<td>';
                    html += '			<div class="rs-select2--light rs-select2--md">';
                    html += '				<select id="' + item.id + '"  onchange="changeSelect(' + item
                        .id +
                        ');" style="font-size: 14px;color: #808080;width: 177px" class="form-control " name="status">';

                    switch (item.processingStatus) {
                        case 1:
                            html += '					<option value="1" selected="true">Đã nhận đơn</option>';
                            html += '					<option value="2">Giao cho ĐVVC</option>';
                            break;
                        case 2:
                            html += '					<option value="1">Đã nhận đơn</option>';
                            html +=
                                '					<option value="2" selected="true">Giao cho ĐVVC</option>';
                            html += '					<option value="3">Giao thành công</option>';
                            break;
                        case 3:
                            html += '					<option value="1">Đã nhận đơn</option>';
                            html += '					<option value="2">Giao cho ĐVVC</option>';
                            html +=
                                '					<option value="3" selected="true">Giao thành công</option>';
                            break;
                        default:
                            break;
                    }
                    html += '				</select>';
                    html += '				<div class="dropDownSelect2"></div>';
                    html += '			</div>';
                    html += '		</td>';
                }
                html += '     <td>';
                html += '         <div class="table-data-feature">';
                html += '            <button class="item" title="Xem" onclick="viewOrder(' + item
                    .id + ')">';
                html += '               <i class="fas fa-eye"></i>';
                html += '            </button>';
                html += '     </td>';
                html += '</tr>';
                html += '<tr class="spacer"></tr>';
            });

            var totalPage = result.totalPage;
            var currentPage = result.currentPage;
            var pagination_string = '';
            if (currentPage > 1) {
                var previousPage = currentPage - 1;
                pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' +
                    previousPage +
                    '><i class="fas fa-angle-double-left" style="font-size:18px"></i></a></li>';
            }

            for (i = 1; i <= totalPage; i++) {
                if (i == currentPage) {
                    pagination_string +=
                        '<li class="page-item active"><a href="" class="page-link" data-page=' + i + '>' +
                        currentPage + '</a></li>';
                } else if (i >= currentPage - 3 && i <= currentPage + 4) {
                    pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' +
                        i + '>' + i + '</a></li>';
                }
            }

            if (currentPage > 0 && currentPage < totalPage) {
                var nextPage = currentPage + 1;
                pagination_string += '<li class="page-item"><a href="" class="page-link"  data-page=' +
                    nextPage +
                    '><i class="fas fa-angle-double-right" style="font-size:18px"></i></a></li>';
            }

            $('#billProcess').html(html);
            $('#paged--list--order--process').html(pagination_string);
        }
    });
}


function LoadOrderSuccessOrDeleted(status, page) {
    var update_role = $("#update_role").val();
    var delete_role = $("#delete_role").val();
    $.ajax({
        url: '/perfume-shop/admin/list-order',
        type: "GET",
        data: {
            status: status,
            page: page
        },
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            var html = '';
            $.each(result.listOrder, function (i, item) {
                html += '<tr class="tr-shadow">';
                html += '    <td class="number_order">' + item.id + '</td>';
                html += '    <td>';
                html += '        <span>' + item.code + '</span>';
                html += '    </td>';
                html += '    <td>';
                html += '         <span>' + item.customerName + '</span>';
                html += '    </td>';
                html += '    <td>';
                html += '         <span>' + item.customerAddress + '</span>';
                html += '    </td>';
                html += '     <td>';
                html += '          <span class="text-primary font-weight-bold">' + item.total
                    .toLocaleString('it-IT', {
                        style: 'currency',
                        currency: 'VND'
                    }) + '</span>';
                html += '     </td>';
                html += '     <td>';
                html += '          <span class="block-name-product">' + item.createdDate +
                    '</span>';
                html += '     </td>';
                html += '     <td>';
                html += '          <span class="block-name-product">' + item.updatedDate +
                    '</span>';
                html += '     </td>';
                html += '     <td>';
                html += '         <div class="table-data-feature">';
                html += '            <button class="item" title="Xem" onclick="viewOrder(' + item
                    .id + ')">';
                html += '               <i class="fas fa-eye"></i>';
                html += '            </button>';
                if (status == 4 && update_role == 'true') {
                    html +=
                        '            <button class="item" title="Xem" onclick="rollBackOrder(' +
                        item.id + ',0,4)">';
                    html += '               <i class="fas fa-undo"></i>';
                    html += '            </button>';
                }
                html += '     </td>';
                html += '</tr>';
                html += '<tr class="spacer"></tr>';
            });

            var totalPage = result.totalPage;
            var currentPage = result.currentPage;
            var pagination_string = '';
            if (currentPage > 1) {
                var previousPage = currentPage - 1;
                pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' +
                    previousPage +
                    '><i class="fas fa-angle-double-left" style="font-size:18px"></i></a></li>';
            }

            for (i = 1; i <= totalPage; i++) {
                if (i == currentPage) {
                    pagination_string +=
                        '<li class="page-item active"><a href="" class="page-link" data-page=' + i + '>' +
                        currentPage + '</a></li>';
                } else if (i >= currentPage - 3 && i <= currentPage + 4) {
                    pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' +
                        i + '>' + i + '</a></li>';
                }
            }

            if (currentPage > 0 && currentPage < totalPage) {
                var nextPage = currentPage + 1;
                pagination_string += '<li class="page-item"><a href="" class="page-link"  data-page=' +
                    nextPage +
                    '><i class="fas fa-angle-double-right" style="font-size:18px"></i></a></li>';
            }

            if (status == 3) {
                $('#billReceived').html(html);
                $('#paged--list--order--success').html(pagination_string);
            } else {
                $('#billDeleted').html(html);
                $('#paged--list--order--deleted').html(pagination_string);
            }
        }
    });
}



function viewOrder(idOrder) {
    $.ajax({
        url: '/perfume-shop/admin/detail-order',
        type: "GET",
        data: {
            idOrder: idOrder
        },
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            $('#fullname').text(result.order.customerName);
            $('#email').text(result.order.customerEmail);
            $('#phone').text(result.order.customerPhone);
            $('#address').text(result.order.customerAddress);
            $('#createdDate').text(result.order.createdDate);
            $('#total').text(result.order.total.toLocaleString('it-IT', {
                style: 'currency',
                currency: 'VND'
            }));
            $('#code-order').text(result.order.code);
            $('#id-order').text(result.order.id);
            switch (result.order.processingStatus) {
                case 0:
                    $('#status-orders').addClass("text-dark");
                    changeStyleStatus(0);
                    break;
                case 1:
                    $('#status-orders').text('Đã tiếp nhận');
                    changeStyleStatus(1);
                    break;
                case 2:
                    $('#status-orders').text('Đang giao');
                    changeStyleStatus(2);
                    break;
                case 3:
                    $('#status-orders').text('Giao thành công');
                    changeStyleStatus(3);
                    break;
                case 4:
                    $('#status-orders').text('Đã hủy');
                    changeStyleStatus(4);
                    break;
                default:
                    break;
            }


            var html = '';
            $.each(result.order.orderDetails, function (i, item) {
                html += '<div class="d-flex flex-row">';
                html += '    <img class="" src="/upload/' + item.avatar + '" alt="' + item.productName + '"';
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
            $('#list--product--order').html(html);
            $('#detail-modal').modal('show');
        }
    });

}

function changeStatusOrder(idOrder, status, previousStatus) {
    var status1 = parseInt(status);
    var idOrder1 = parseInt(idOrder);
    $.ajax({
        url: '/perfume-shop/admin/status-order?status=' + status + '&&idOrder=' + idOrder,
        type: "POST",
        data: {},
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            switch (previousStatus) {
                case 0:
                    LoadNewOrder(1);
                    $('#modalCustomerConfirm').modal('hide');
                    break;
                case 1:
                case 2:
                    LoadOrderProcess(1);
                    break;
                case 3:
                    LoadOrderSuccessOrDeleted(3, 1);
                    break;
                case 4:
                    LoadOrderSuccessOrDeleted(4, 1);
                    $('#modalCustomerConfirm').modal('hide');
                    break;
                default:
                    break;
            }
            showAlertMessage("Thay đổi trạng thái đơn hàng thành công!", true);
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 
            showAlertMessage("Thay đổi trạng thái đơn hàng thất bại!", false);
        }
    });
}

function changeStyleStatus(status) {
    for (var i = 0; i <= 4; i++) {
        $('#status--' + i).removeClass("text-success");
        $('#status-orders').removeClass("text-dark");
        $('#status-orders').removeClass("text-success");
        $('#status-orders').removeClass("text-danger");
    }
    if (status != 4) {
        $('#status--4').addClass("d-none");
        for (var i = 0; i <= status; i++) {
            $('#status--' + i).removeClass("d-none");
            $('#status--' + i).addClass("text-success");
        }
        if (status == 3) {
            $('#status-orders').addClass("text-success");
        } else {
            $('#status-orders').addClass("text-dark");
        }
    } else {
        for (var i = 0; i < status; i++) {
            $('#status--' + i).addClass("d-none");
        }
        $('#status--4').removeClass("d-none");
        $('#status-orders').addClass("text-danger");
    }
}

function cancelBill(id_bill) {
    $('#btnAgree').attr("onclick", "changeStatusOrder(" + id_bill + ",4,0)");
    showConfirm("Bạn chắc chắn muốn hủy đơn hàng này ?", "Có", "Không", true);
};

function rollBackOrder(idOrder, status, previousStatus) {
    $('#btnAgree').attr("onclick", "changeStatusOrder(" + idOrder + "," + status + "," + previousStatus + ")");
    showConfirm("Bạn chắc chắn muốn lấy lại đơn hàng này ?", "Có", "Không", false);
};

function changeSelect(idOrder) {
    changeStatusOrder(idOrder, $("tr #" + idOrder).val(), 1);
};