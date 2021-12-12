$(document).ready(function () {

});

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
                html += '        <h5>' + item.productName +' '+item.capacity +'ml</h5>';
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