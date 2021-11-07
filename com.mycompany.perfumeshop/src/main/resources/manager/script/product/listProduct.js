$(document).ready(function () {
    loadProduct(null, 1); //load page 1
    loadCategory(); //load category to filter
    setActiveMenu();
});


$('#input-search-header').on('keydown', function (e) {
    if (e.keyCode == 13) {
        $('#btn_search_header').click();
    }
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
                                        <input type="checkbox" id="btnChangeStatus" ${value.status==true? "checked" : ""}>
                                        <span class="slider round"></span>
                                    </label>    
                                </span>
                            </td>
                            <td>
                                <span>
                                    <!-- Rounded switch -->
                                    <label class="switch">
                                        <input type="checkbox" id="btnChangeHot" ${value.isHot==true? "checked" : ""}>
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

/* SEARCH HEADER START */
$("#btn_search_header").click(function () {
    $("#filter-status").val("0");
    $("#select-category").val("0");
    var txtSearch = $("#input-search-header").val();
    if (txtSearch != "") {
        loadProduct(txtSearch, 1, null, null);
    } else {
        loadProduct(null, 1, null, null);
    }
});



/*  $("#input-search-header").keyup(function(event) {
     $("#filter-status").val("0");
     $("#select-category").val("0");
     $('#btn_search_header').click();
 }); */
/* SEARCH HEADER END */

/* SELECT CATEGORY START */
$("#select-category").change(function () {
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
$("#filter-status").change(function () {
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

function deleteProduct(idProduct) {
    $('#btn_save').attr("onclick", "deleteConfirmed(" + idProduct + ")");
    $('#modalConfirmOderContent').text("Bạn chắc chắn muốn xóa sản phẩm này ?");
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

function deleteConfirmed(idProduct) {
    $('#modalConfirmOder').modal('hide');
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