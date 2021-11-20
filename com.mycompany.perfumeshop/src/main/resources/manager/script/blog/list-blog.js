$(document).ready(function () {
    loadBlog(null, 1);
    setActiveMenu();
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

function setActiveMenu() {
    console.log("call");
    $(".navbar__list li").each(function () {
        $(this).removeClass("active");
    });
    $(".list-unstyled li").each(function () {
        $(this).removeClass("active");
    });
    $('.list-unstyled #menu--blog').addClass("active");
    $('.navbar__list #menu--blog').addClass("active");
}

function loadBlog(keySearch, currentPage) {
    var update_role = $("#update_role").val();
    var delete_role = $("#delete_role").val();
    $.ajax({
        url: "/admin/all-blog",
        type: "get",
        contentType: "application/json", // kieu du lieu gui len server la json
        data: {
            currentPage: currentPage,
            keySearch: keySearch
        },
        dataType: "json", // kieu du lieu tra ve tu controller la json
        success: function (result) {
            var html = '';
            $.each(result.baseVo.listEntity, function (index, value) {
                html += '<tr class="tr-shadow">';
                html += '   <td class="block-image">';
                html += '       <img src="/upload/' + value.avatar + '" alt="Hình Ảnh Sản Phẩm" />';
                html += '   </td>';
                html += '    <td>';
                html += '        <span class="block-name-product">' + value.name + '</span>';
                html += '    </td>';
                html += '    <td>';
                html += '        <span class="block-name-product">' + value.description + '</span>';
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

                html += '<td>';
                if (value.isHot) {
                    html += '<span class="status--process">Hot</span>';
                } else {
                    html += '<span>Bình thường</span>';
                }
                html += '</td>';

                html += '   <td>';
                html += '       <div class="table-data-feature">';
                html += '           <button class="item" title="Xem" onclick="detail(' + value.id + ')">';
                html += '                <input type="hidden" id="view_' + value.id + '" name="custId" value="' + value.seo + '">';
                html += '               <i class="fas fa-eye"></i>';
                html += '           </button>';
                if (update_role == 'true') {
                    html += '          <button class="item" title="Sửa">';
                    html += '              <i class="fas fa-pencil-alt" onclick="edit(' + value.id + ')"></i>';
                    html += '             <input type="hidden" id="edit_' + value.id + '" name="custId" value="' + value.seo + '">';
                    html += '           </button>';
                }
                if (delete_role == 'true') {
                    html += '           <button class="item" title="Xóa" onclick="deleteCategory(' + value.id + ')">';
                    html += '               <i class="fas fa-trash-alt"></i>';
                    html += '           </button>';
                }
                html += '       </div>';
                html += '   </td>';
                html += '</tr>';
                html += '<tr class="spacer"></tr>';
            });



            var totalPage = result.baseVo.totalPage;
            var currentPage = result.baseVo.currentPage;
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
    var currentPage = $(this).attr('data-page');
    var txtSearch = $("#input-search-header").val();
    //load event pagination
    loadBlog(txtSearch, currentPage);
});


function detail(id) {
    window.location.href = '/admin/blog-detail/' + $('#view_' + id).val();
}

function edit(id) {
    window.location.href = '/admin/edit-blog/' + $('#edit_' + id).val();
}

function deleteCategory(idBlog) {
    $('#btnAgree').attr("onclick", "deleteConfirmed(" + idBlog + ")");
    showConfirm("Bạn chắc chắn muốn xóa blog này ?", "Có", "Không", true);
};

function deleteConfirmed(idBlog) {
    $('#modalConfirmOder').modal('hide');
    $.ajax({
        url: '/admin/delete-blog?idBlog=' + idBlog,
        type: "POST",
        data: {},
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            if (result.message == true) {
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