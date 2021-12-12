/**
 * 
 */
var status_all_notify_modal = false;

$(document).ready(function () {
    setActiveMenu();
    LoadNewOrder(1);

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


/* NOTIFY CONTENT END */

function setActiveMenu() {
    $(".navbar__list li").removeClass("active");
    $(".list-unstyled li").removeClass("active");
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
                                <input type="button" class="btn btn-outline-success" value="Nhận đơn" onclick="changeStatusOrder(${item.id},1,0)"
                                    ${update_role=='true'?"":"disabled"} 
                                    ${update_role=='false'?'data-toggle="tooltip" data-placement="top" title="Bạn không có quyền truy cập chức năng này"':''}>
                                <input type="button" class="btn btn-outline-danger" value="Hủy đơn" onclick="cancelBill(${item.id})"
                                    ${delete_role=='true'?"":"disabled"} 
                                    ${delete_role=='false'?'data-toggle="tooltip" data-placement="top" title="Bạn không có quyền truy cập chức năng này"':''}>
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
                        ');" style="font-size: 14px;color: #808080;width: 177px" class="custom-select" name="status">';

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
                html += `         <div class="table-data-feature pr-4">
                                   <input type="button" class="btn btn-outline-info mx-1" 
                                            value="Xem" onclick="viewOrder(${item.id})">
                                   </div> `;
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
                html += `           <div class="table-data-feature pr-4">
                                      <input type="button" class="btn btn-outline-info mx-1" 
                                            value="Xem" onclick="viewOrder(${item.id})">`;

                if (status == 4 && update_role == 'true') {
                    html += ` <input type="button" class="btn btn-outline-success mx-1" value="Quay lại" ${update_role == '    true'?"":"hide"}
                                onclick="rollBackOrder(${item.id},0,4)">`
                }
                html += `   </div>
                         </td>
                    </tr>
                <tr class="spacer"></tr>`;
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
                html += '        <h5>' + item.productName + ' ' + item.capacity + 'ml </h5>';
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