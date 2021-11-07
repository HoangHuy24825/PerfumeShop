$(document).ready(function () {
    setMenuBanner();
    $("#orderBy").val("0");
    $("#filterBy").val("0");
    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });
    $("#orderBy").css({
        "display": "block"
    });
    $("#searchStr").val("");
    $("#filterBy").css({
        "display": "block"
    });
    //load init

    var idCategoryLoad = $("#idCategoryLoad").val();
    if (idCategoryLoad != 0) {
        loadData(null, 1, idCategoryLoad, null, null);
        $("#table-category #" + idCategoryLoad).addClass('chosed');
        $("#table-category #" + idCategoryLoad).addClass('selected-category');
        var title = $("#table-category #" + idCategoryLoad).children('td:nth-child(2)').text();
        $('#title-banner').find('h2').html("Danh mục sản phẩm");
        $('#title-banner').find('p').html("Trang chủ > " + title);
    } else {
        loadData(null, 1, null, null, null);
    }
});

function setMenuBanner() {
    var titlebanner = '';
    $("#img-banner").html('<img src="${base}/user/img/my-image/banner/product1.png" alt="" width="560">');
    titlebanner += '<h2>Sản phẩm</h2>';
    titlebanner += '<p> Trang chủ <span>></span> Sản phẩm </p>';
    $("#title-banner").html(titlebanner);

    $("#mainNav li").each(function (index) {
        $(this).removeClass("my-menu-active");
    });

    $("#menu-product").addClass("my-menu-active");
}

function loadData(searchStr, page, id_category, typeOrder, filterType) {
    $.ajax({
        url: "/all-product",
        type: "GET",
        data: {
            searchStr: searchStr,
            page: page,
            id_category: id_category,
            typeOrder: typeOrder,
            filterType: filterType
        },
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function (result) {
            var html = '';
            if (result == null) {
                $("#product-container").html(`<h4 class="text-primary">Lỗi kết nối cơ sở dữ liệu</h4>`);
                return;
            }
            if ((result.products.length == 0 || result.products == null) && searchStr != null &&
                searchStr != "") {
                html += `<div style="margin:auto">
                            <img src="${base}/user/img/notFoundProduct.png" width="300" style="margin:auto"/>
                            <br/>
                            <p style="text-align:center; margin: 25px 0px 30px;">Không tìm thấy sản phẩm phù hợp!</p>
                        </div>`;
                $("#load-pagination").html("");
            } else if ((result.products.length == 0 || result.products == null) && id_category != null &&
                id_category != "") {
                html += `<div style="margin:auto">
                            <img src="${base}/user/img/notFoundProduct.png" width="300" style="margin:auto"/>
                            <br/>
                            <p style="text-align:center; margin: 25px 0px 30px;">Không có sản phẩm nào trong danh mục!</p>
                        </div>`;
                $("#load-pagination").html("");
            } else {
                $.each(result.products, function (index, item) {
                    html += `<div class="col-lg-4 col-sm-6 box-single-product" onclick = "detail(${item.id})">
                                <input type="hidden" id="view_${item.id}" name="custId" value="${item.seo}">
                                <div class="single_product_item">
                                    <img class="img-product" src="/upload/${item.avatar}"  alt="">
                                    <div class="single_product_text">
                                        <h4>${item.title}</h4>
                                        <h3>${item.price.toLocaleString('it-IT', {style: 'currency',currency: 'VND'})} </h3>
                                        <div class="my-cart border rounded-circle" title="Thêm sản phẩm vào giỏ" 
                                            onclick="event.stopPropagation();addProductToCart(${item.id})">
                                        <i class="fas fa-shopping-cart"></i>
                                    </div>
                                </div>
                            </div>
                        </div>`;
                });
                //create pagination
                var pagination_string = "";
                var currentPage = result.currentPage;
                var totalPage = result.totalPage;


                if (currentPage > 1) {
                    var previousPage = currentPage - 1;
                    pagination_string += `<li class="page-item">
                                            <a href="" class="page-link" data-page="${previousPage}">
                                                <i class="fas fa-angle-double-left" style="font-size:18px"></i>
                                            </a>
                                        </li>`;
                }

                for (i = 1; i <= totalPage; i++) {
                    if (i == currentPage) {
                        pagination_string += `<li class="page-item active">
                                                <a href="" class="page-link" data-page=${i}>${currentPage}</a>
                                            </li>`;
                    } else if (i >= currentPage - 3 && i <= currentPage + 4) {
                        pagination_string += `<li class="page-item">
                                                <a href="" class="page-link" data-page=${i}>${i}</a>
                                            </li>`;
                    }
                }

                if (currentPage > 0 && currentPage < totalPage) {
                    var nextPage = currentPage + 1;
                    pagination_string += `<li class="page-item">
                                            <a href="" class="page-link"  data-page=${nextPage}>
                                                <i class="fas fa-angle-double-right" style="font-size:18px"></i>
                                            </a>
                                        </li>`;
                }
                $("#load-pagination").html(pagination_string);
            }
            $("#product-container").html(html);
        }

    });
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

function detail(id_product) {
    window.location.href = '/detail-product/' + $('#view_' + id_product).val();
};

function addProductToCart(id_product) {
    let data = {
        productId: id_product,
        quanlity: 1
    }
    $.ajax({
        url: "/cart/add",
        type: "post",
        data: JSON.stringify(data),
        dataType: "json",
        contentType: "application/json",
        success: function (jsonResult) {
            showAlertMessage("Thêm vào giỏ hàng thành công!", true);
            $('#icon-cart-header').find($('#amount_cart')).text(jsonResult.totalItems);
        },
        error: function (jqXhr, textStatus, errorMessage) {
            showAlertMessage("Không thêm được sản phẩm vào giỏ hàng!", false);
        }
    });
}

$("#orderBy").change(function () {
    var txtSearch = $("#searchStr").val();
    var orderType = $("#orderBy").val();
    var filterType = $("#filterBy").val();
    var id_category = $('.table-categoty').find('.chosed').attr('id');
    if (orderType != 0) {
        loadData(txtSearch, 1, id_category, orderType, filterType);
    } else {
        loadData(txtSearch, 1, id_category, null, filterType);
    }
});

$("#filterBy").change(function () {
    var txtSearch = $("#searchStr").val();
    var orderType = $("#orderBy").val();
    var filterType = $("#filterBy").val();
    var id_category = $('.table-categoty').find('.chosed').attr('id');
    if (filterType != 0) {
        loadData(txtSearch, 1, id_category, orderType, filterType);
    } else {
        loadData(txtSearch, 1, id_category, orderType, null);
    }
});

$('.row-left-sidebar').click(function () {
    $("#orderBy").val("0");
    $("#filterBy").val("0");
    $('#searchStr').val("");

    $('.table-categoty').find('.selected-category').removeClass('selected-category');
    $('.table-categoty').find('.chosed').removeClass('chosed');

    var id_category = $(this).attr('id');
    loadData(null, 1, id_category, null, null);
    $(this).addClass('chosed');
    $(this).addClass('selected-category');
    var title = $(this).children('td:nth-child(2)').text();
    $('#title-banner').find('h2').html("Danh mục sản phẩm");
    $('#title-banner').find('p').html("Trang chủ > " + title);
});

$("body").on("click", ".pagination li a", function (event) {
    event.preventDefault();
    var page = $(this).attr('data-page');
    var id_category = $('.table-categoty').find('.chosed').attr('id');

    var txtSearch = $("#searchStr").val();
    if (txtSearch != "") {
        loadData(txtSearch, page, id_category, $("#orderBy").val(), $("#filterBy").val());
    } else {
        loadData(null, page, id_category, $("#orderBy").val(), $("#filterBy").val());
    }

});

$("#search").click(function () {
    $("#orderBy").val("0");
    $("#filterBy").val("0");
    $('.table-categoty').find('.selected-category').removeClass('selected-category');
    var txtSearch = $("#searchStr").val();
    if (txtSearch != "") {
        loadData(txtSearch, 1, null, null, null);
    } else {
        loadData(null, 1, null, null, null);
    }
});

$("#searchStr").keyup(function (event) {
    $("#orderBy").val("0");
    $("#filterBy").val("0");
    $('#search').click();
});

function loadNewProduct() {
    console.log("load new product");
    $.ajax({
        url: "/new-product",
        type: "GET",
        data: {},
        dataType: "json",
        contentType: "application/json",
        success: function (jsonResult) {
            var html = '';
            $.each(jsonResult, function (index, value) {
                html += '<div class="single_product_item" >';
                html += '     <img class="img-product" src="/upload/' + value.avatar + '" alt="' +
                    value.title + '">';
                html += '     <div class="single_product_text">';
                html += '         <h4>' + value.title + '</h4>';
                html += '         <h3>' + value.price.toLocaleString('it-IT', {
                    style: 'currency',
                    currency: 'VND'
                }) + '</h3>';
                html +=
                    '         <div class="my-cart border rounded-circle" title="Thêm sản phẩm vào giỏ">';
                html += '             <i class="fas fa-shopping-cart"></i>';
                html += '         </div>';
                html += '     </div>';
                html += ' </div>';
            });
            $('#list-new-product').html(html);
        },
        error: function (jqXhr, textStatus, errorMessage) {
            console.log(errorMessage);
        }
    });
}