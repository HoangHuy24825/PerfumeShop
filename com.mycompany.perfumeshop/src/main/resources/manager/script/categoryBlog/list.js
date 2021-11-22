$(document).ready(function () {
    loadCategory(null, 1);
    setActiveMenu('#menu--category--blog');
});

/* ENVENT KEY ENTER INPUT SEARCH START */
$('#input-search-header').on('keydown', function (e) {
    if (e.keyCode == 13) {
        $('#btn_search_header').click();
    }
});
/* ENVENT KEY ENTER INPUT SEARCH END */

function loadCategory(keySearch, currentPage) {
    var update_role = $("#update_role").val();
    var delete_role = $("#delete_role").val();
    $.ajax({
        url: "/admin/all-category-blog",
        type: "get",
        contentType: "application/json", // kieu du lieu gui len server la json
        data: {
            currentPage: currentPage,
            keySearch: keySearch
        },
        dataType: "json", // kieu du lieu tra ve tu controller la json
        success: function (result) {
            var html = '';
            $.each(result.listEntity, function (index, value) {
                html += '<tr class="tr-shadow">';
                html += '   <td class="block-image">';
                html += '       <img src="/upload/' + value.avatar +
                    '" alt="Hình Ảnh Sản Phẩm" />';
                html += '   </td>';
                html += '    <td>';
                html += '        <span class="block-name-product">' + value.name + '</span>';
                html += '    </td>';
                html += '    <td>';
                html += '        <span class="block-name-product">' + value.seo + '</span>';
                html += '    </td>';
                html += '    <td>';
                if (value.status == true) {
                    html += '               <span class="status--process">Hiển thị</span>';
                } else {
                    html += '               <span class="status--denied">Ẩn</span>';
                }
                html += '   </td>';
                html += '   <td>';
                html += '       <div class="table-data-feature">';
                html += '           <button class="item" title="Xem" onclick="detail(' + value
                    .id + ')">';
                html += '                <input type="hidden" id="view_' + value.id +
                    '" name="custId" value="' + value.seo + '">';
                html += '               <i class="fas fa-eye"></i>';
                html += '           </button>';
                if (update_role == 'true') {
                    html += '          <button class="item" title="Sửa">';
                    html += '             <input type="hidden" id="edit_' + value.id +
                        '" name="custId" value="' + value.seo + '">';
                    html += '              <i class="fas fa-pencil-alt" onclick="edit(' + value
                        .id + ')"></i>';
                    html += '           </button>';
                }
                if (delete_role == 'true') {
                    html +=
                        '           <button class="item" title="Xóa" onclick="deleteCategory(' +
                        value.id + ')">';
                    html += '               <i class="fas fa-trash-alt"></i>';
                    html += '           </button>';
                }
                html += '       </div>';
                html += '   </td>';
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
            $("#input-search-header").val(keySearch);
            $("#paged--list").html(pagination_string);
            $('#table_data').html(html);
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 

        }
    });
}


$("body").on("click", ".pagination li a", function (event) {
    event.preventDefault();
    var txtSearch = $("#input-search-header").val();
    var currentPage = $(this).attr('data-page');
    //load event pagination
    loadCategory(txtSearch, currentPage);
});

/* SEARCH HEADER START */
$("#btn_search_header").click(function () {
    var txtSearch = $("#input-search-header").val();
    if (txtSearch != "") {
        loadCategory(txtSearch, 1);
    } else {
        loadCategory(null, 1);
    }
});
/* SEARCH HEADER END */

function detail(id) {
    window.location.href = '/admin/category-blog-detail/' + $('#view_' + id).val();
}

function edit(id) {
    window.location.href = '/admin/edit-category-blog/' + $('#edit_' + id).val();
}

function deleteCategory(idCategory) {
    $('#btnAgree').attr("onclick", "deleteConfirmed(" + idCategory + ")");
    showConfirm("Bạn có muốn xóa danh mục này không?", "Có", "Không", true);
};

function deleteConfirmed(idCategory) {
    $("#modalCustomerConfirmContent").modal("hide");
    $.post({
        url: '/admin/delete-category-blog',
        data: {
            idCategory: idCategory
        },
        success: function (result) {
            if (result == true) {
                showAlertMessage("Xóa danh mục thành công!", true);
                loadCategory(null, 1);
            } else {
                showAlertMessage("Không thể xóa danh mục này!", false);
            }
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 
            showAlertMessage("Không thể xóa danh mục này!", false);
        }
    });
}