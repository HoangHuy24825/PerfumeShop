$(document).ready(function () {
    loadProduct(1);//load page 1
    loadCategory();//load category to filter
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
            $.each(result, function (index, value) {
                html += '<option value="' + value.id + '">' + value.name + '</option>';
            });
            $('#select-category').html(html);
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 

        }
    });
}

function loadProduct(currentPage) {
    $.ajax({
        url: "/admin/all-product",
        type: "get",
        contentType: "application/json",
        data: { currentPage: currentPage },
        dataType: "json", // kieu du lieu tra ve tu controller la json
        success: function (result) {
            var html = '';
            $.each(result.products, function (index, value) {
                html += '<tr class="tr-shadow">';
                html += '<td class="block-image">';
                html += '<img src="/upload/' + value.avatar + '" alt="Hình Ảnh Sản Phẩm" />';
                html += '</td>';
                html += '<td>';
                html += '<span class="block-name-product">' + value.title + '</span>';
                html += '</td>';
                html += '<td>';
                html += '<span class="text-primary font-weight-bold">';
                html += value.price.toLocaleString('it-IT', { style: 'currency', currency: 'VND' });
                html += '</span>';
                html += '</td>';
                html += '<td>';
                html += '<span class="text-primary font-weight-bold">';
                if (value.priceSale != null) {
                    html += value.priceSale.toLocaleString('it-IT', { style: 'currency', currency: 'VND' });
                } else {
                    html += 'Chưa có giảm giá';
                }
                html += '</span>';
                html += '</td>';
                html += '<td>';

                if (value.status) {
                    html += '<span class="status--process">Hiển thị</span>';
                } else {
                    html += '<span class="status--denied">Ẩn</span>';
                }
                html += '</td>';
                html += '<td>';

                if (value.isHot) {
                    html += '<span class="status--process">Hot</span>';
                } else {
                    html += '<span>Bình thường</span>';
                }
                html += '</td>';
                html += '<td>';
                html += '<div class="table-data-feature">';
                html += '<button class="item" title="Xem" onclick="detail('+value.id+')">';
                html += '<i class="fas fa-eye"></i>';
                html += '</button>';
                html += '<button class="item" title="Sửa">';
                html += '<i class="fas fa-pencil-alt" onclick="edit('+value.id+')"></i>';
                html += ' </button>';
                html += '<button class="item" title="Xóa">';
                html += '<i class="fas fa-trash-alt"></i>';
                html += '</button>';
                html += '</div>';
                html += '</td>';
                html += '</tr>';
                html += '<tr class="spacer"></tr>';
            });
            var totalPage = result.listPage[0].totalPage;
            var currentPage = result.listPage[0].currentPage;
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
    //load event pagination
    loadProduct(currentPage);
});


function detail(id){
    window.location.href='/admin/product-detail/'+id;
}

function edit(id){
    window.location.href='/admin/edit-product/'+id;
}