$(document).ready(function () {
    showListContact(" ", 1);

    $("body").on("click", "#pagedListRevenueByDate li", function (e) {
        e.preventDefault();
        var currentPage = $(this).data("page");
        var keySearch = $("#btn_search_header").val();
        showListContact(keySearch, currentPage);
    });

    $("body").on("click", "#btn_search_header", function () {
        var keySearch = $("#input-search-header").val();
        showListContact(keySearch, 1);
    });
});

function showListContact(keySearch, currentPage) {
    var update_role = $("#update_role").val();
    var delete_role = $("#delete_role").val();
    $.get({
        url: "/perfume-shop/admin/contact/" + keySearch + "/" + currentPage,
        success: function (response) {
            if (response.listContact.length == 0) {
                $('#table_data').html(
                    `
                    <tr class="tr-shadow">
                        <td colspan="7"><h4 class="text-primary font-weight-bold">Danh sách liên hệ trống!</h4></td>
                    </tr>

                    `
                );
                $("#paged--list").html("");
            } else {
                var html = '';
                var i = 1;
                $.each(response.listContact, function (index, value) {
                    html += `
                    <tr class="tr-shadow">
                        <td>
                            ${i}
                        </td>
                        <td>
                            ${value.customerName}
                        </td>
                        <td >
                            ${value.subject}
                        </td>
                        <td>
                            ${formatDate(value.createdDate)}
                        </td>
                        <td>
                            <div class="table-data-feature pr-4">
                                <input type="button" class="btn btn-outline-info mx-1" value="Xem" onclick="detail(${value.id})">
                                <input type="button" class="btn btn-outline-danger mx-1" value="Xóa" onclick="deleteContact(${value.id})"
                                    ${delete_role=='true'?"":"disabled"}
                                    ${delete_role=='false'?'data-toggle="tooltip" data-placement="top" title="Bạn không có quyền truy cập chức năng này"':''}>
                            </div>
                        </td>
                    </tr>
                    <tr class="spacer"></tr>`;
                });
                var htmlPaging = '';
                var totalPage = response.totalPage;
                var currentPage = response.currentPage;

                htmlPaging = `
                    <li class="page-item" data-page="${currentPage-1}">
                        <a href="#" class="page-link" data-page="${currentPage-1}" ${currentPage==1?'hidden':''}>
                            <i class="fas fa-angle-double-left" style="font-size:18px"></i>
                        </a>
                    </li>`;
                for (i = 1; i <= totalPage; i++) {
                    if (i > currentPage - 3 && i < currentPage + 4) {
                        htmlPaging += `
                                <li class="page-item ${currentPage==i?'active':''}"  data-page="${i}">
                                    <a href="#" class="page-link">${i}</a>
                                </li>
                                `;
                    }
                }
                htmlPaging += `
                    <li class="page-item" data-page="${currentPage+1}">
                        <a href="#" class="page-link" data-page="${currentPage+1}" ${currentPage==totalPage?'hidden':''}>
                            <i class="fas fa-angle-double-right" style="font-size:18px"></i>
                        </a>
                    </li>`;
                $("#paged--list").html(htmlPaging);
                $('#table_data').html(html);
            }
        }
    });
}

function detail(idOrder) {
    $.get({
        url: "/perfume-shop/admin/contact/" + idOrder,
        success: function (response) {
            $("#fullname").html(response.customerName);
            $("#email").html(response.customerEmail);
            $("#phone").html(response.customerPhone);
            $("#createdDate").html(formatDate(response.createdDate));
            $("#subject").html(response.subject);
            $("#content").html(response.content);
            $("#detailModalContact").modal('show');
        }
    });
}

function deleteContact(id) {
    $('#btnAgree').attr("onclick", "deleteConfirmed(" + id + ")");
    showConfirm("Bạn có chắc chắn muốn xóa liên hệ này?", "Có", "Không", true);
};

function deleteConfirmed(id) {
    $('#modalCustomerConfirm').modal('hide');
    $.ajax({
        url: '/perfume-shop/admin/contact/' + id,
        type: "DELETE",
        success: function (result) {
            if (result == true) {
                showAlertMessage("Xóa liên hệ thành công!", true);
                showListContact(" ", 1);
            } else {
                showAlertMessage("Không thể xóa liên hệ này!", false);
            }
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 
            showAlertMessage("Không thể xóa sản phẩm này!", false);
        }
    });
}