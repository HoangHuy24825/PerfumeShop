$(document).ready(function () {
    loadBlog(null, 1);
    setActiveMenu("#menu--blog");
    showNotifyHeader();

    $("body").on("click", ".pagination li a", function (event) {
        event.preventDefault();
        var currentPage = $(this).attr('data-page');
        var txtSearch = $("#input-search-header").val();
        //load event pagination
        loadBlog(txtSearch, currentPage);
    });

    /* ENVENT KEY ENTER INPUT SEARCH START */
    $('#input-search-header').on('keydown', function (e) {
        if (e.keyCode == 13) {
            $('#btn_search_header').click();
        }
    });
    /* ENVENT KEY ENTER INPUT SEARCH END */

    /* SEARCH HEADER START */
    $("#btn_search_header").click(function () {
        var txtSearch = $("#input-search-header").val();
        if (txtSearch != "") {
            loadBlog(txtSearch, 1);
        } else {
            loadBlog(null, 1);
        }
    });

    $("body").on("change", ".btnChangeStatus", function (e) {
        e.preventDefault();
        var status = $(this).prop("checked") == true ? 1 : 0;
        var type = 0;
        var id = $(this).data("id-item");
        $.post({
            url: "/perfume-shop/admin/change-detail-blog",
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

    $("body").on("change", ".btnChangeHot", function (e) {
        e.preventDefault();
        var isHot = $(this).prop("checked") == true ? 1 : 0;
        var id = $(this).data("id-item");
        var type = 1;
        $.post({
            url: "/perfume-shop/admin/change-detail-blog",
            data: {
                isHot: isHot,
                id: id,
                type: type
            },
            dataType: "json",
            success: function (response) {
                if (response == true) {
                    showAlertMessage("Cập nhật blog thành công!", true);
                } else {
                    showAlertMessage("Cập nhật blog thất bại!", false);
                }
            }
        });
    });




});

function loadBlog(keySearch, currentPage) {
    var update_role = $("#update_role").val();
    var delete_role = $("#delete_role").val();
    $.ajax({
        url: "/perfume-shop/admin/all-blog",
        type: "get",
        contentType: "application/json", // kieu du lieu gui len server la json
        data: {
            currentPage: currentPage,
            keySearch: keySearch
        },
        dataType: "json", // kieu du lieu tra ve tu controller la json
        success: function (result) {
            var html = '';
            $.each(result.listBlog, function (index, value) {
                html += `<tr class="tr-shadow">
                            <td class="block-image">
                                <img src="/upload/${ value.avatar }" alt="Hình Ảnh Sản Phẩm" />
                            </td>
                            <td>
                                <span class="block-name-product">${ value.name }</span>
                            </td>
                            <td>
                                <span class="block-name-product">${ value.description }</span>
                            </td>
                            <td>
                                <span class="block-name-product">${ value.seo }</span>
                            </td>
                            <td>
                                <span>
                                <!-- Rounded switch -->
                                    <label class="switch" ${update_role=='false'?'data-toggle="tooltip" data-placement="top" title="Bạn không có quyền truy cập chức năng này"':''}>
                                        <input type="checkbox" class="btnChangeStatus" data-id-item="${value.id}" ${value.status==true? "checked" : ""} 
                                            ${update_role=='true'?"":"disabled"}>
                                        <span class="slider round"></span>
                                    </label>    
                                </span>
                            </td>
                            <td>
                                <span>
                                    <!-- Rounded switch -->
                                    <label class="switch" data-toggle="${update_role=='false'?'tooltip':''}" data-placement="top" title="Bạn không có quyền truy cập chức năng này">
                                        <input type="checkbox" class="btnChangeHot" data-id-item="${value.id}" ${value.isHot==true? "checked" : ""} 
                                            ${update_role=='true'?"":"disabled"}>
                                        <span class="slider round"></span>
                                    </label>    
                                </span>
                            </td>

                            <td>
                                <div class="table-data-feature pr-4">
                                    <input type="hidden" id="view_${ value.id }" name="custId" value="${ value.seo }">
                                    <input type="hidden" id="edit_${ value.id }" name="custId" value="${ value.seo }">
                                    <input type="button" class="btn btn-outline-info mx-1" value="Xem" onclick="detail(${value.id})">
                                    <input type="button" class="btn btn-outline-success mx-1" value="Sửa" onclick="edit(${value.id})"
                                        ${update_role=='true'?"":"disabled"} data-toggle="${update_role=='false'?'tooltip':''}" 
                                        data-placement="top" title="Bạn không có quyền truy cập chức năng này">
                                    <input type="button" class="btn btn-outline-danger mx-1" value="Xóa" onclick="deleteBlog(${value.id})"
                                        ${delete_role=='true'?"":"disabled"} data-toggle="${delete_role=='false'?'tooltip':''}" 
                                        data-placement="top" title="Bạn không có quyền truy cập chức năng này">
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
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 

        }
    });
}





function detail(id) {
    window.location.href = '/perfume-shop/admin/blog-detail/' + $('#view_' + id).val();
}

function edit(id) {
    window.location.href = '/perfume-shop/admin/edit-blog/' + $('#edit_' + id).val();
}

function deleteBlog(idBlog) {
    $('#btnAgree').attr("onclick", "deleteConfirmed(" + idBlog + ")");
    showConfirm("Bạn chắc chắn muốn xóa blog này ?", "Có", "Không", true);
};

function deleteConfirmed(idBlog) {
    $('#modalCustomerConfirmContent').modal('hide');
    $.post({
        url: '/perfume-shop/admin/delete-blog',
        type: "POST",
        data: {
            idBlog: idBlog
        },
        success: function (result) {
            if (result == true) {
                showAlertMessage("Xóa danh mục thành công!", true);
                loadBlog(null, 1);
            } else {
                showAlertMessage("Không thể xóa danh mục này!", false);
            }
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 
            showAlertMessage("Không thể xóa danh mục này!", false);
        }
    });
}