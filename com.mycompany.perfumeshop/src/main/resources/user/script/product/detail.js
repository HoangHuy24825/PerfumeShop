$(document).ready(function () {

    setMenuBanner();
    loadData();
    // loadNewProduct();

    $("body").on("click", ".btnChoseCapacity", function () {
        var currentChose = $(".chose-capacity-container").find(".shadow");
        currentChose.removeClass("border-danger");
        currentChose.removeClass("shadow");
        $(this).addClass("shadow");
        $(this).addClass("border-danger");
        var price = $(this).data("price");
        var priceSale = $(this).data("priceSale");
        var htmlPirce = '';
        var idAttr = $(this).data("id");
        var maxOrder = $(this).data("maxOrder");
        $('#numberProductOrder').data("id-product", idAttr);
        $('#numberProductOrder').data("max-order", maxOrder);
        if (priceSale != null && priceSale != 0) {
            htmlPirce += `
                    <tr>
                        <td>Giá: </td>
                        <td> 
                            <h4 style="color:red" class="font-weight-bold mb-0 mr-3">${priceSale.toLocaleString('it-IT', {tyle: 'currency',currency: 'VND'})} &#8363;</h4>
                        </td>
                        <td>
                            <h5 class="text-muted mb-0" style="text-decoration:line-through">${price.toLocaleString('it-IT', {tyle: 'currency',currency: 'VND'})} &#8363;</h5>
                        </td>
                    </tr>                    
                    `;
        } else {
            htmlPirce += `
            <tr>
                <td>Giá: </td>
                <td> 
                    <h4 style="color:red" class="font-weight-bold mb-0">${price.toLocaleString('it-IT', {tyle: 'currency',currency: 'VND'})} &#8363;</h4>
                </td>
            </tr>
                `;
        }
        $("#price-product").find("table").html(htmlPirce);
    });

    showInitPrice();
});

function loadData() {
    var id_product = $("#id_detail_product").val();
    $.get({
        url: "/detail-product-loading",
        data: {
            id_product: id_product
        },
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function (jsonResult) {
            /* $("#image-product").attr("src", "/upload/"+result.avatar);*/
            $("#name-product").html(jsonResult.product.title);
            // $("#price-product").html(jsonResult.product.price.toLocaleString('it-IT', {
            //     style: 'currency',
            //     currency: 'VND'
            // }));
            $("#trademark-product").html(jsonResult.product.trademark);
            $("#manufactureYear-product").html(jsonResult.product.manufactureYear);
            $("#origin-product").html(jsonResult.product.origin);
            $("#fragrant-product").html(jsonResult.product.fragrant);
            $("#short-description-product").html(jsonResult.product.description);

            $("#detail-product").html(jsonResult.product.detail);

            var htmlCapacity = '';
            $.each(jsonResult.product.attrs, function (indexInArray, item) {
                var price = 0;
                if (item.priceSale != null && item.priceSale != 0) {
                    price = item.priceSale.toLocaleString('it-IT', {
                        tyle: 'currency',
                        currency: 'VND'
                    });
                } else {
                    price = item.price.toLocaleString('it-IT', {
                        tyle: 'currency',
                        currency: 'VND'
                    });
                }
                htmlCapacity += `
                                <button class="col-4 text-center p-2 m-2 border rounded bg-white btnChoseCapacity"
                                data-price="${item.price}" data-price-sale="${item.priceSale}" data-id="${item.id}" data-min-price="${jsonResult.product.minPrice}"
                                 data-amount="${item.amount}">
                                    <div class="capacityProduct">${item.capacity} ML</div>
                                    <div class="priceProduct font-weight-bold" >${price} &#8363;</div>
                                </button>
                                `;
            });
            $(".chose-capacity-container").html(htmlCapacity);

            document.title = jsonResult.product.title;
            $('#add-product-to-cart').click(function () {
                addProductToCart();
            });
            $('#buy-now').click(function () {
                payNow(jsonResult.product.id);
            });

            var ol_image_slide =
                '<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>';
            var image_slide = '';
            image_slide += '<div class="carousel-item active">';
            image_slide += '	<img class="d-block mw-100" src="/upload/' +
                jsonResult.product.avatar + '" alt="First slide">';
            image_slide += '</div>';
            if (jsonResult.images != null) {
                var i = 0;
                $.each(jsonResult.images, function (key, value) {
                    image_slide += '<div class="carousel-item">';
                    image_slide +=
                        '	<img class="d-block mw-100 mx-auto" style="max-height:600px" src="/upload/' +
                        value.path + value.title + '" alt="First slide">';
                    image_slide += '</div>';
                    i++;
                    ol_image_slide +=
                        '<li data-target="#carouselExampleIndicators" data-slide-to="' +
                        i + '" class=""></li>';
                });
            }
            $('#ol-img-slide').html(ol_image_slide);
            $('#img-slide').html(image_slide);
        }
    });
}

function showInitPrice() {
    var price = $(".btnChoseCapacity").first().data("price");
    var priceSale = $(".btnChoseCapacity").first().data("priceSale");
    var htmlPirce = '';
    var idAttr = $(".btnChoseCapacity").first().data("id");
    var maxOrder = $(".btnChoseCapacity").first().data("maxOrder");
    $(".btnChoseCapacity").first().addClass("shadow");
    $(".btnChoseCapacity").first().addClass("border border-danger");
    if (priceSale != null && priceSale != 0) {
        htmlPirce += `<tr>
                        <td>Giá: </td>
                        <td > 
                            <h4 style="color:red" class="font-weight-bold mb-0 mr-3">${priceSale.toLocaleString('it-IT', {tyle: 'currency',currency: 'VND'})}</h4>
                        </td>
                        <td>
                            <h5 class="text-muted mb-0" style="text-decoration:line-through">${price.toLocaleString('it-IT', {tyle: 'currency',currency: 'VND'})}</h5>                    
                        </td>
                        </tr>
                        `;
    } else {
        htmlPirce += `<tr>
                        <td>Giá: </td>
                        <td> <h4 style="color:red" class="font-weight-bold mb-0">${price.toLocaleString('it-IT', {tyle: 'currency',currency: 'VND'})}</h4>
                        </td>
                    </tr>`;
    }
    $('#numberProductOrder').data("id-product", idAttr);
    $('#numberProductOrder').data("max-order", maxOrder);
    $("#price-product").find("table").html(htmlPirce);
}

function setMenuBanner() {

    $("#img-banner").html('<img src="${base}/user/img/my-image/banner/product1.png" alt="" width="560">');
    var titlebanner = '';
    titlebanner += '<h2>Sản phẩm</h2>';
    titlebanner += '<p>Trang chủ <span>></span>Chi tiết sản phẩm</p>';
    $("#title-banner").html(titlebanner);

    $("#mainNav li").each(function (index) {
        $(this).removeClass("my-menu-active");
    });

    $("#menu-product").addClass("my-menu-active");
}

function addProductToCart(id_product) {
    var amount = $("#numberProductOrder").val();
    var amount = $("#numberProductOrder").data("id-product");
    let data = {
        productId: id_product,
        quanlity: amount
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


function loadNewProduct() {
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

function payNow(idProduct) {
    var maxOrder = parseInt($("#numberProductOrder").attr("data-max-order"));
    var amount = parseInt($("#numberProductOrder").val());
    if (maxOrder == 0) {
        showAlertMessage("Sản phẩm tạm thời hết hàng!", true);
    } else if (maxOrder < amount) {
        showAlertMessage("Số lượng mua vượt quá số lượng hiện có!", false);
    } else {
        window.location.href = '/bill?idProduct=' + idProduct + "&&amount=" + amount;
    }
}


function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function checkValidAmount(status) {
    var numberOrder = parseInt($('#numberProductOrder').val());
    if (status == 'decrease') {
        if (numberOrder == 1) {
            showAlertMessage("Số lượng không được nhỏ hơn 1!", false);
            $('#numberProductOrder').val('1');
        }
    } else {
        var maxOrder = parseInt($('#numberProductOrder').attr('data-max-order'));
        if (numberOrder >= maxOrder) {
            showAlertMessage("Số lượng sản phẩm chỉ còn lại " + maxOrder, false);
            $('#numberProductOrder').val((maxOrder - 1).toString());
        }
    }
}

function checkValidAmountInput() {
    var numberOrder = parseInt($('#numberProductOrder').val());
    var maxOrder = parseInt($('#numberProductOrder').attr('data-max-order'));
    if (numberOrder < 1) {
        showAlertMessage("Số lượng không được nhỏ hơn 1!", false);
        $('#numberProductOrder').val(1);
    }
    if (numberOrder > maxOrder) {
        showAlertMessage("Số lượng sản phẩm chỉ còn lại " + maxOrder, false);
        $('#numberProductOrder').val(maxOrder);
    }
}


function checkValidOutFocus() {
    if ($('#numberProductOrder').val() == "" || $('#numberProductOrder').val() == null) {
        showAlertMessage("Số lượng không được trống!", false);
        $('#numberProductOrder').val(1);
    }
}