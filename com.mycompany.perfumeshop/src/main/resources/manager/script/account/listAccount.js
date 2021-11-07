/**
 * 
 */
$(document).ready(function () {
    setActiveMenu();
    loadStaff(1);

    $("body").on("change", ".btnChangeStatus", function (e) {
        e.preventDefault();
        var status = $(this).prop("checked") == true ? 1 : 0;
        var id = $(this).data("id-item");
        $.post({
            url: "/admin/change-status-account",
            data: {
                status: status,
                id: id
            },
            dataType: "json",
            success: function (response) {
                if (response.message == true) {
                    showAlertMessage("Cập nhật trạng thái thành công!", true);
                } else {
                    showAlertMessage("Cập nhật trạng thái thất bại!", false);
                }
            }
        });
    });
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
                html += `   <tr class="tr-shadow">
                                <td class="number_order">${ item.username }</td>
                                <td class="block-image">
                                    <img src="/upload/${item.avatar!=null ? item.avatar : "noAvatar.png" }" alt="" />
                                </td>
                                <td>
                                    <span>${ item.fullname }</span>
                                </td>
                                <td>
                                    <span>${ item.email }</span>
                                </td>
                                <td>
                                    <span>${ item.phone }</span>
                                </td>
                                <td>
                                    <span>${ item.address }</span>
                                </td>
                                <td>
                                    <span>
                                    <!-- Rounded switch -->
                                        <label class="switch">
                                            <input type="checkbox" data-id-item="${item.id}" class="btnChangeStatus" 
                                            ${item.status==true? "checked" : ""} disabled="${update_role}">
                                            <span class="slider round"></span>
                                        </label>    
                                    </span>
               		            </td>
                		        <td>
                                    <div class="table-data-feature">
                                        <button class="item" title="Phân quyền" onclick="decentralization(${ item.id })" hide="${update_role}">
                                            <i class="fas fa-user-tag"></i>
                                        </button>
                                    </div>
                    		    </td>'
                            </tr>
                            <tr class="spacer"></tr>`;
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
                html += `   <tr class="tr-shadow">
                                 <td class="number_order">${item.username}</td>
                            <td class="block-image">
                                <img src="/upload/${item.avatar!=null ? item.avatar : "noAvatar.png" }" alt="" />
                            </td>
                            <td>
                                <span>${item.fullname}</span>
                            </td>
                            <td>
                                <span>${ item.email }</span>
                            </td>
                            <td>
                                <span>${ item.phone }</span>
                            </td>
                            <td>
                                <span>${ item.address }</span>
                            </td>
                            <td>
                                <span>
                                <!-- Rounded switch -->
                                    <label class="switch">
                                        <input type="checkbox" data-id-item="${item.id}" disabled="${update_role}" class="btnChangeStatus" 
                                        ${item.status==true? "checked" : ""}>
                                        <span class="slider round"></span>
                                    </label>    
                                </span>
               		        </td>
                         </tr>
                        <tr class="spacer"></tr>`;
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

function decentralization(idAccount) {
    window.location.href = '/admin/decentralization-account/' + idAccount;
}