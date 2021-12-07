$(document).ready(function () {
    setActiveMenu("#menu--review-product");
    loadData(null, 1, null);

    $("body").on("change", ".btnChangeApprove", function (e) {
        e.preventDefault();
        var status = $(this).prop("checked") == true ? 1 : 0;
        var type = 0;
        var id = $(this).data("id-item");
        $.post({
            url: "/perfume-shop/admin/change-detail-review",
            data: {
                status: status,
                id: id,
                type: type
            },
            dataType: "json",
            success: function (response) {
                if (response == true) {
                    showAlertMessage("Cập nhật trạng thái thành công!", true);
                } else {
                    showAlertMessage("Cập nhật trạng thái thất bại!", false);
                }
            }
        });
    });

    $("body").on("change", ".btnChangeHide", function (e) {
        e.preventDefault();
        var isHide = $(this).prop("checked") == true ? 0 : 1;
        var id = $(this).data("id-item");
        var type = 1;
        $.post({
            url: "/perfume-shop/admin/change-detail-review",
            data: {
                isHide: isHide,
                id: id,
                type: type
            },
            dataType: "json",
            success: function (response) {
                if (response == true) {
                    showAlertMessage("Cập nhật review thành công!", true);
                } else {
                    showAlertMessage("Cập nhật review thất bại!", false);
                }
            }
        });
    });

    $("body").on("click", "#btn_search_header", function () {
        $("#filter-status").val("0");
        var txtSearch = $("#input-search-header").val();
        if (txtSearch != "") {
            loadData(txtSearch, 1, null);
        } else {
            loadData(null, 1, null);
        }
    });

    /* SELECT STATUS START */
    $("body").on("change", "#filter-status", function () {
        var txtSearch = $("#input-search-header").val();
        var status = $("#filter-status").val();
        console.log(status);
        if (status != null) {
            loadData(txtSearch, 1, status);
        } else {
            loadData(txtSearch, 1, null);
        }
    });
    /* SELECT STATUS END */

    /* PAGING CLICK START */
    $("body").on("click", ".pagination li a", function (event) {
        event.preventDefault();
        var currentPage = $(this).attr('data-page');
        var txtSearch = $("#input-search-header").val();
        var status = $("#filter-status").val();
        //load event pagination
        loadData(txtSearch, currentPage, status);
    });
    /* PAGING CLICK END */

    $("body").on("keydown", "#input-search-header", function (e) {
        if (e.keyCode == 13) {
            $('#btn_search_header').click();
        }
    });


});



/* LOAD PRODUCT START */
function loadData(keySearch, currentPage, status) {
    var update_role = $("#update_role").val();
    var delete_role = $("#delete_role").val();
    $.get({
        url: "/perfume-shop/admin/reviews",
        data: {
            currentPage: currentPage,
            status: status,
            keySearch: keySearch
        },
        dataType: "json", // kieu du lieu tra ve tu controller la json
        success: function (result) {
            var html = '';
            if (result.listReviews.length == 0) {
                $('#table_data').html(
                    `
                    <tr class="tr-shadow">
                        <td colspan="7"><h4 class="text-primary">Danh sách đánh giá trống!</h4></td>
                    </tr>

                    `
                );
                $("#paged--list").html("");
            } else {
                $.each(result.listReviews, function (index, review) {
                    html += `<tr class="tr-shadow">
                                <td>
                                    <span>${review.customerName}</span>
                                </td>
                                <td>
                                     <span>${review.product.title}</span>
                                </td>
                                <td>
                                    <span class="fa fa-star ${review.numberStar>=1?"checked-rating":""}"></span>
                                    <span class="fa fa-star ${review.numberStar>=2?"checked-rating":""}"></span>
                                    <span class="fa fa-star ${review.numberStar>=3?"checked-rating":""}"></span>
                                    <span class="fa fa-star ${review.numberStar>=4?"checked-rating":""}"></span>
                                    <span class="fa fa-star ${review.numberStar==5?"checked-rating":""}"></span>
                                </td>
                                <td>
                                     <span>${review.content}</span>
                                </td>
                                <td>
                                    <span>${formatDate(review.createdDate)}</span>
                                </td>
                                <td>
                                    <span>
                                    <!-- Rounded switch -->
                                        <label class="switch">
                                            <input type="checkbox" class="btnChangeHide" data-id-item="${review.id}" ${!review.isHide? "checked" : ""}>
                                            <span class="slider round"></span>
                                        </label>    
                                    </span>
                                </td>
                                <td>
                                    <span>
                                    <!-- Rounded switch -->
                                        <label class="switch">
                                            <input type="checkbox" class="btnChangeApprove" data-id-item="${review.id}" ${review.status? "checked" : ""}>
                                            <span class="slider round"></span>
                                        </label>    
                                    </span>
                                </td>
                                <td>
                                    <div class="table-data-feature pr-4">
                                        <input type="button" class="btn btn-outline-danger mx-1" value="Xóa" ${update_role == 'true'?"":"hide"} 
                                            onclick="deleteReview(${review.id})">
                                    </div>
                                </td>
                            </tr>
                            <tr class="spacer"></tr>`;
                });
                var totalPage = result.totalPage;
                var currentPage = result.currentPage;
                var pagination_string = '';
                if (currentPage > 1) {
                    var previousPage = currentPage - 1;
                    pagination_string += `  <li class="page-item">
                                                <a href="" class="page-link" data-page="${previousPage}">
                                                    <i class="fas fa-angle-double-left" style="font-size:18px"></i>
                                                </a>
                                            </li>`;
                }

                for (i = 1; i <= totalPage; i++) {
                    if (i == currentPage) {
                        pagination_string += `  <li class="page-item active">
                                                    <a href="" class="page-link" data-page="${i}">${currentPage}</a>
                                                </li>`;
                    } else if (i >= currentPage - 3 && i <= currentPage + 4) {
                        pagination_string += `  <li class="page-item">
                                                    <a href="" class="page-link" data-page="${i}">${i}</a>
                                                </li>`;
                    }
                }

                if (currentPage > 0 && currentPage < totalPage) {
                    var nextPage = currentPage + 1;
                    pagination_string += `  <li class="page-item">
                                                <a href="" class="page-link"  data-page=${nextPage}>
                                                    <i class="fas fa-angle-double-right" style="font-size:18px"></i>
                                                </a>
                                            </li>`;
                }
                $("#input-search-header").val(keySearch);
                $("#paged--list").html(pagination_string);
                $('#table_data').html(html);
            }
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 

        }
    });
}

function deleteReview(idReview) {
    $('#btnAgree').attr("onclick", "deleteConfirmed(" + idReview + ")");
    showConfirm("Bạn có chắc chắn muốn xóa đánh giá này?", "Có", "Không", true);
};

function deleteConfirmed(idReview) {
    $('#modalCustomerConfirm').modal('hide');
    $.ajax({
        url: '/perfume-shop/review/' + idReview,
        type: "DELETE",
        success: function (result) {
            if (result == true) {
                showAlertMessage("Xóa đánh giá thành công!", true);
                loadData(null, 1, null);
            } else {
                showAlertMessage("Không thể xóa đánh giá này!", false);
            }
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 
            showAlertMessage("Không thể xóa đánh giá này!", false);
        }
    });
}