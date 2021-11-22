$(document).ready(function () {
    loadProduct(null, 1); //load page 1
    loadCategory(); //load category to filter
    setActiveMenu();

    $("body").on("change", ".btnChangeStatus", function (e) {
        e.preventDefault();
        var status = $(this).prop("checked") == true ? 1 : 0;
        var type = 0;
        var id = $(this).data("id-item");
        $.post({
            url: "/admin/change-detail-product",
            data: {
                status: status,
                id: id,
                type: type
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

    $("body").on("change", ".btnChangeHot", function (e) {
        e.preventDefault();
        var isHot = $(this).prop("checked") == true ? 1 : 0;
        var id = $(this).data("id-item");
        var type = 1;
        $.post({
            url: "/admin/change-detail-product",
            data: {
                isHot: isHot,
                id: id,
                type: type
            },
            dataType: "json",
            success: function (response) {
                if (response.message == true) {
                    showAlertMessage("Cập nhật sản phẩm thành công!", true);
                } else {
                    showAlertMessage("Cập nhật sản phẩm thất bại!", false);
                }
            }
        });
    });

    $("body").on("click", "#btn_search_header", function () {
        $("#filter-status").val("0");
        $("#select-category").val("0");
        var txtSearch = $("#input-search-header").val();
        if (txtSearch != "") {
            loadProduct(txtSearch, 1, null, null);
        } else {
            loadProduct(null, 1, null, null);
        }
    });


    $("body").on("change", "#select-category", function () {
        var filterType = $("#filter-status").val();
        var id_category = $("#select-category").val();
        if (filterType != 0) {
            loadProduct(null, 1, id_category, filterType);
        } else {
            loadProduct(null, 1, id_category, null);
        }
    });
    /* SELECT CATEGORY END */

    /* SELECT STATUS START */
    $("body").on("change", "#filter-status", function () {
        var txtSearch = $("#input-search-header").val();
        var filterType = $("#filter-status").val();
        var id_category = $("#select-category").val();
        if (filterType != 0) {
            loadProduct(txtSearch, 1, id_category, filterType);
        } else {
            loadProduct(txtSearch, 1, id_category, null);
        }
    });
    /* SELECT STATUS END */

    /* PAGING CLICK START */
    $("body").on("click", ".pagination li a", function (event) {
        event.preventDefault();
        var currentPage = $(this).attr('data-page');
        var txtSearch = $("#input-search-header").val();
        var filterType = $("#filter-status").val();
        var id_category = $("#select-category").val();
        console.log(txtSearch);
        console.log(filterType);
        console.log(id_category);
        //load event pagination
        loadProduct(txtSearch, currentPage, id_category, filterType);
    });
    /* PAGING CLICK END */
    
    $("body").on("keydown","#input-search-header", function (e) {
        if (e.keyCode == 13) {
            $('#btn_search_header').click();
        }
    });


});

function loadCategory() {
    $.ajax({
        url: "/admin/all-category-active",
        type: "get",
        contentType: "application/json",
        data: "",
        dataType: "json", // kieu du lieu tra ve tu controller la json
        success: function (result) {
            var html = '';
            html += '<option value="' + 0 + '">Danh mục sản phẩm</option>';
            $.each(result, function (index, value) {
                html += '<option value="' + value.id + '">' + value.name + '</option>';
            });
            $('#select-category').html(html);
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 

        }
    });
}

/* LOAD PRODUCT START */
function loadProduct(keySearch, currentPage, idCategory, status) {
    var update_role = $("#update_role").val();
    var delete_role = $("#delete_role").val();
    $.ajax({
        url: "/admin/all-product",
        type: "get",
        contentType: "application/json",
        data: {
            currentPage: currentPage,
            idCategory: idCategory,
            status: status,
            keySearch: keySearch
        },
        dataType: "json", // kieu du lieu tra ve tu controller la json
        success: function (result) {
            var html = '';
            $.each(result.products, function (index, value) {
                html += `<tr class="tr-shadow">
                            <td class="block-image">
                                <img src="/upload/${value.avatar}" alt="Hình Ảnh Sản Phẩm" />
                            </td>
                            <td>
                                 <span class="block-name-product">${value.title}</span>
                            </td>
                            <td>
                                <span class="text-primary font-weight-bold">${value.trademark}</span>
                            </td>
                            <td>
                                 <span class="text-primary font-weight-bold">${value.fragrant}</span>
                            </td>
                            <td>
                                <span>
                                    <!-- Rounded switch -->
                                    <label class="switch">
                                        <input type="checkbox" class="btnChangeStatus" data-id-item="${value.id}" ${value.status==true? "checked" : ""}>
                                        <span class="slider round"></span>
                                    </label>    
                                </span>
                            </td>
                            <td>
                                <span>
                                    <!-- Rounded switch -->
                                    <label class="switch">
                                        <input type="checkbox" class="btnChangeHot" data-id-item="${value.id}" ${value.isHot==true? "checked" : ""}>
                                        <span class="slider round"></span>
                                    </label>    
                                </span>
                            </td>
                            <td>
                                <div class="table-data-feature">
                                    <button class="item" title="Xem" onclick="detail(${value.id})">
                                        <input type="hidden" id="view_${value.id}" name="custId" value="${value.seo}">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="item" title="Sửa" hide="${update_role}">
                                        <i class="fas fa-pencil-alt" onclick="edit(${value.id})"></i>
                                        <input type="hidden" id="edit_${value.id}" name="custId" value="${value.seo}">
                                    </button>
                                    <button class="item" title="Xóa" onclick="deleteProduct(${value.id})" hide="${delete_role}">
                                        <i class="fas fa-trash-alt"></i>';
                                    </button>
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

/* LOAD PRODUCT END */


function detail(id) {
    window.location.href = '/admin/product-detail/' + $('#view_' + id).val();
}

function edit(id) {
    window.location.href = '/admin/edit-product/' + $('#edit_' + id).val();
}

function setActiveMenu() {
    $(".navbar__list li").each(function () {
        $(this).removeClass("active");
    });
    $(".list-unstyled li").each(function () {
        $(this).removeClass("active");
    });
    $('.list-unstyled #menu--product').addClass("active");
    $('.navbar__list #menu--product').addClass("active");
}

function deleteProduct(idProduct) {
    $('#btnAgree').attr("onclick", "deleteConfirmed(" + idProduct + ")");
    showConfirm("Bạn có chắc chắn muốn xóa sản phẩm này?", "Có", "Không", true);
};

function deleteConfirmed(idProduct) {
    $('#modalCustomerConfirm').modal('hide');
    $.ajax({
        url: '/admin/delete-product?idProduct=' + idProduct,
        type: "POST",
        data: {},
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            if (result.message == true) {
                showAlertMessage("Xóa sản phẩm thành công!", true);
                loadProduct(null, 1, null, null);
            } else {
                showAlertMessage("Không thể xóa sản phẩm này!", false);
            }
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 
            showAlertMessage("Không thể xóa sản phẩm này!", false);
        }
    });
}