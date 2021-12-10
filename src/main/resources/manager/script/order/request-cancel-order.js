$(document).ready(function () {
    setActiveMenu("#menu--cancel-order");
    loadData();
});

function loadData() {
    $.get({
        url: "/perfume-shop/admin/list-request-cancel-order",
        dataType: "json",
        success: function (response) {
            var html = '';
            $.each(response.listRequest, function (indexInArray, request) {
                html += `  
                <tr class="tr-shadow" >
                    <td>${request.customerName }</td>
                    <td>
                        <span>${ request.createdDate }</span>
                    </td>
                    <td>
                        <span>${ request.codeOrder }</span>
                    </td>
                    <td>
                        <span>${ request.reason }</span>
                    </td>
                    <td>
                         <span id="${request.id}">${ request.processingStatus==true?'Đã xử lý':'Chưa xử lý' }</span>
                    </td>
                    <td>
                        <input type="button" class="btn btn-outline-info" value="Xem" onclick="viewOrder(${request.id_order})">
                        <input type="button" class="btn btn-outline-success" value="Không hủy đơn" ${update_role == '    true'?"":"hide"}
                            onclick="rejectCancelOrderRequest(${request.id_order},${request.id})">
                        <input type="button" class="btn btn-outline-danger" value="Hủy đơn" ${update_role == 'true'?"":"hide"} 
                            onclick="cancelOrderFromRequest(${request.id_order},${request.id})">
                        <input type="button" class="btn btn-outline-danger" value="Xóa" ${update_role == 'true'?"":"hide"} 
                            onclick="deleteRequest(${request.id})">
                    </td>
                </tr>
                <tr class="spacer"></tr>`;
            });
            $("#table_data").html(html);
        }
    });
};

function deleteRequest(idRequest) {
    $('#btnAgree').attr("onclick", "deleteRequestConfirmed(" + idRequest + ")");
    showConfirm("Bạn chắc chắn muốn xóa yêu cầu hủy này?", "Có", "Không", true);
}

function deleteRequestConfirmed(idRequest) {
    $('#modalCustomerConfirm').modal('hide');
    $.post({
        url: "/perfume-shop/admin/delete-request/" + idRequest,
        success: function (response) {
            if (response == true) {
                showAlertMessage("Xóa thành công!", true);
                loadData();
            } else {
                showAlertMessage("Xóa thất bại!", false);
            }
        }
    });
}

function rejectCancelOrderRequest(idOrder, idRequest) {
    $('#notify-detail-modal').modal('hide');
    $('#btn_confirm_reject').attr("onclick", "rejectCancelOrderRequestConfirmed(" + idOrder + "," + idRequest + ")");
    $('#modal-reason-reject').modal('show');
}

function rejectCancelOrderRequestConfirmed(idOrder, idRequest) {
    $("#" + idRequest).html('Đã xử lý');
    $('#modal-reason-reject').modal('hide');
    showAlertMessage("Email từ chối đề nghị hủy đơn đã được gửi!", true);
    sentEmailConfirm(idOrder, 0, $('#input-reason-reject').val(), idRequest);
}

function cancelOrderFromRequest(idOrder, idRequest) {
    $('#notify-detail-modal').modal('hide');
    $('#notify-modal').modal('hide');
    $('#btnAgree').attr("onclick", "cancelOrderRequestConfirmed(" + idOrder + "," + idRequest + ")");
    showConfirm("Bạn chắc chắn muốn hủy đơn hàng này ?", "Có", "Không", true);
}

function cancelOrderRequestConfirmed(idOrder, idRequest) {
    $.post({
        url: '/perfume-shop/admin/cancel-order-request/' + idOrder,
        success: function (result) {
            showAlertMessage("Hủy đơn hàng thành công!", true);
            $('#modalCustomerConfirm').modal('hide');
            $("#" + idRequest).html('Đã xử lý');
            sentEmailConfirm(idOrder, 1, null, idRequest);
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 
            showAlertMessage("Hủy đơn hàng thất bại!", false);
        }
    });
}

function sentEmailConfirm(idOrder, status, content, idRequest) {
    $.ajax({
        url: '/perfume-shop/admin/sent-email-confirm?idOrder=' + idOrder + '&&status=' + status + '&&content=' + content + "&&idRequest=" + idRequest,
        type: "POST",
        data: {},
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            if (result == false) {
                showAlertMessage("Không thể gửi email cho khách hàng!", false);
            }
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 

        }
    });
}