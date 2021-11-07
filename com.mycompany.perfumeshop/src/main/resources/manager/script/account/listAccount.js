/**
 * 
 */
$(document).ready(function () {
    setActiveMenu();
    loadStaff(1);
});

function setActiveMenu() {
    $(".navbar__list li").each(function () {
        $(this).removeClass("active");
    });
    $(".list-unstyled li").each(function () {
        $(this).removeClass("active");
    });
    $('.list-unstyled #menu--account').addClass("active");
    $('.navbar__list #menu--account').addClass("active");
}

function loadStaff(page) {
    var update_role = $("#update_role").val();
    var type = 0;
    $.ajax({
        url: '/admin/list-account',
        type: "GET",
        data: {
            type: type,
            page: page
        },
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            var html = '';
            $.each(result.users, function (i, item) {
                html += '<tr class="tr-shadow">';
                html += '    <td class="number_order">' + item.username + '</td>';
                if (item.avatar != null) {
                    html += '		<td class="block-image">';
                    html += '			<img src="${base}/upload/' + item.avatar + '" alt="" />';
                    html += '		</td>';
                } else {
                    html += '		<td class="block-image">';
                    html += '			<img src="${base}/manager/images/noAvatar.png" alt="" />';
                    html += '		</td>';
                }
                html += '    <td>';
                html += '         <span>' + item.fullname + '</span>';
                html += '    </td>';
                html += '    <td>';
                html += '         <span>' + item.email + '</span>';
                html += '    </td>';
                html += '     <td>';
                html += '         <span>' + item.phone + '</span>';
                html += '     </td>';
                html += '     <td>';
                html += '          <span>' + item.address + '</span>';
                html += '     </td>';
                html += '		<td>';
                if (item.status) {
                    html += '<span class="status--process">Hoạt động</span>';
                } else {
                    html += '<span class="status--denied">Vô hiệu hóa</span>';
                }
                html += '		</td>';
                html += '		<td>';
                html += '			<div class="table-data-feature">';
                if (update_role == 'true') {
                    html += '				<button class="item" title="Phân quyền" onclick="decentralization(' + item.id + ')">';
                    html += '					<i class="fas fa-user-tag"></i>';
                    html += ' 			</button>';
                    html += '				<button class="item" title="Vô hiệu hóa" onclick="changeStatusActive(' + item.id + ',0,0)" >';
                    html += '					<i class="fas fa-ban"></i>';
                    html += '				</button>';
                    html += '				<button class="item" title="Kích hoạt" onclick="changeStatusActive(' + item.id + ',1,0)" >';
                    html += '					<i class="fas fa-check-circle"></i>';
                    html += '				</button>';
                    html += '			</div>';
                    html += '		</td>'
                }
                html += '</tr>';
                html += '<tr class="spacer"></tr>';
            });

            var totalPage = result.totalPage;
            var currentPage = result.currentPage;
            var pagination_string = '';
            if (currentPage > 1) {
                var previousPage = currentPage - 1;
                pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + previousPage + '><i class="fas fa-angle-double-left" style="font-size:18px"></i></a></li>';
            }

            for (i = 1; i <= totalPage; i++) {
                if (i == currentPage) {
                    pagination_string += '<li class="page-item active"><a href="" class="page-link" data-page=' + i + ' >' + currentPage + '</a></li>';
                } else if (i >= currentPage - 3 && i <= currentPage + 4) {
                    pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + i + '>' + i + '</a></li>';
                }
            }

            if (currentPage > 0 && currentPage < totalPage) {
                var nextPage = currentPage + 1;
                pagination_string += '<li class="page-item"><a href="" class="page-link"  data-page=' + nextPage + '><i class="fas fa-angle-double-right" style="font-size:18px"></i></a></li>';
            }

            $('#staff-list').html(html);
            $('#paged--list--staff').html(pagination_string);
        }
    });
}

function loadCustomer(page) {
    var update_role = $("#update_role").val();
    var type = 1;
    $.ajax({
        url: '/admin/list-account',
        type: "GET",
        data: {
            type: type,
            page: page
        },
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            var html = '';
            $.each(result.users, function (i, item) {
                html += '<tr class="tr-shadow">';
                html += '    <td class="number_order">' + item.username + '</td>';
                if (item.avatar != null) {
                    html += '		<td class="block-image">';
                    html += '			<img src="${base}/upload/' + item.avatar + '" alt="" />';
                    html += '		</td>';
                } else {
                    html += '		<td class="block-image">';
                    html += '			<img src="${base}/manager/images/noAvatar.png" alt="" />';
                    html += '		</td>';
                }
                html += '    <td>';
                html += '         <span>' + item.fullname + '</span>';
                html += '    </td>';
                html += '    <td>';
                html += '         <span>' + item.email + '</span>';
                html += '    </td>';
                html += '     <td>';
                html += '         <span>' + item.phone + '</span>';
                html += '     </td>';
                html += '     <td>';
                html += '          <span>' + item.address + '</span>';
                html += '     </td>';
                html += '		<td>';
                if (item.status) {
                    html += '<span class="status--process">Hoạt động</span>';
                } else {
                    html += '<span class="status--denied">Vô hiệu hóa</span>';
                }
                html += '		</td>';
                if (update_role == 'true') {
                    html += '		<td>';
                    html += '			<div class="table-data-feature">';
                    html += '				<button class="item" title="Vô hiệu hóa" onclick="changeStatusActive(' + item.id + ',0,1)" >';
                    html += '					<i class="fas fa-ban"></i>';
                    html += '				</button>';
                    html += '				<button class="item" title="Kích hoạt" onclick="changeStatusActive(' + item.id + ',1,1)" >';
                    html += '					<i class="fas fa-check-circle"></i>';
                    html += '				</button>';
                    html += '			</div>';
                    html += '		</td>';
                }
                html += '</tr>';
                html += '<tr class="spacer"></tr>';
            });

            var totalPage = result.totalPage;
            var currentPage = result.currentPage;
            var pagination_string = '';
            if (currentPage > 1) {
                var previousPage = currentPage - 1;
                pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + previousPage + '><i class="fas fa-angle-double-left" style="font-size:18px"></i></a></li>';
            }

            for (i = 1; i <= totalPage; i++) {
                if (i == currentPage) {
                    pagination_string += '<li class="page-item active"><a href="" class="page-link" data-page=' + i + '>' + currentPage + '</a></li>';
                } else if (i >= currentPage - 3 && i <= currentPage + 4) {
                    pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + i + '>' + i + '</a></li>';
                }
            }

            if (currentPage > 0 && currentPage < totalPage) {
                var nextPage = currentPage + 1;
                pagination_string += '<li class="page-item"><a href="" class="page-link"  data-page=' + nextPage + '><i class="fas fa-angle-double-right" style="font-size:18px"></i></a></li>';
            }

            $('#customer-list').html(html);
            $('#paged--list--customer').html(pagination_string);
        }
    });
}

$("body").on("click", "#paged--list--staff li a", function (event) {
    event.preventDefault();
    var currentPage = parseInt($(this).attr('data-page'));
    loadStaff(currentPage);
});

$("body").on("click", "#paged--list--customer li a", function (event) {
    event.preventDefault();
    var currentPage = parseInt($(this).attr('data-page'));
    loadCustomer(currentPage);
});

function showAlertMessage(message, messageState) {
    if (messageState) {
        $('#alert_message').css({
            "background": "#C5F3D7",
            "border-left": "8px solid #2BD971"
        });
        $("#icon-alert-message").html('<i class="fas fa-check-circle"></i>');
        $("#icon-alert-message").find('i').css({
            "color": "#2BD971"
        });
        $(".msg").css({
            "color": "#24AD5F"
        });
        $(".close-btn-alert").css({
            "background": "#2BD971",
            "color": "#24AD5F"
        });
        $(".close-btn-alert").find('.fas').css({
            "color": "#24AD5F"
        });
        $(".close-btn-alert").hover(function (e) {
            $(this).css("background-color", e.type === "mouseenter" ? "#38F5A3" : "#2BD971")
        })
    } else {
        $('#alert_message').css({
            "background": "#FFE1E3",
            "border-left": "8px solid #FF4456"
        });
        $("#icon-alert-message").html('<i class="fas fa-exclamation-circle"></i>');
        $("#icon-alert-message").find('i').css({
            "color": "#FE4950"
        });
        $(".msg").css({
            "color": "#F694A9"
        });
        $(".close-btn-alert").css({
            "background": "#FF9CA4",
            "color": "#FD4653"
        });
        $(".close-btn-alert").find('.fas').css({
            "color": "#FD4653"
        });
        $(".close-btn-alert").hover(function (e) {
            $(this).css("background-color", e.type === "mouseenter" ? "#FFBDC2" : "#FF9CA4")
        })
    }

    $('.msg').text(message);
    $('.alert').addClass("show");
    $('.alert').removeClass("hide");
    $('.alert').addClass("showAlert");
    setTimeout(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    }, 3000);
};


function decentralization(idAccount) {
    window.location.href = '/admin/decentralization-account/' + idAccount;
}

function changeStatusActiveConfirmed(idAccount, status, typeAccount) {
    console.log(status);
    $('#modalConfirmOder').modal('hide');
    $.ajax({
        url: '/admin/change-status-account?idAccount=' + idAccount + "&&status=" + status,
        type: "POST",
        data: {},
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            if (result.message == true) {
                showAlertMessage("Thay đổi trạng thái tài khoản thành công!", true);
                if (typeAccount == 0) {
                    loadStaff(1);
                } else {
                    loadCustomer(1);
                }
            } else {
                showAlertMessage("Thay đổi trạng thái tài khoản thất bại!", false);
            }
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 
            showAlertMessage("Thay đổi trạng thái tài khoản thất bại!", false);
        }
    });
}

function changeStatusActive(idAccount, status, typeAccount) {
    $('#btn_save').attr("onclick", "changeStatusActiveConfirmed(" + idAccount + "," + status + "," + typeAccount + ")");
    if (status == 0) {
        $('#modalConfirmOderContent').text("Bạn chắc chắn muốn vô hiệu hóa tài khoản này?");
    } else {
        $('#modalConfirmOderContent').text("Bạn chắc chắn muốn kích hoạt lại tài khoản này?");
    }
    $('#btn_save').show();
    $('#btn_save').text("Có");
    $('#btn_close').css({
        "background-color": "#007bff",
        "border": "1px solid #007bff",
        "width": "200px"
    })
    $('#btn_save').css({
        "background-color": "rgb(255, 66, 78)",
        "border": "1px solid rgb(255, 66, 78)",
        "width": "200px"
    });
    $('#modalConfirmOder').modal('show');
};