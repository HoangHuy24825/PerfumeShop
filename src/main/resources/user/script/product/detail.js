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
        var maxOrder = $(this).data("amount");
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
        $("#priceProductCurrent").find("table").html(htmlPirce);
    });

    $("body").on("click", "#addProductToCart", function () {
        var quantity = $("#numberProductOrder").val();
        var idAttr = $("#numberProductOrder").data("id-product");
        let data = {
            attrProductId: idAttr,
            quantity: quantity
        }
        var maxOrder = parseInt($("#numberProductOrder").data("max-order"));
        if (maxOrder == 0) {
            showAlertMessage("Sản phẩm tạm thời hết hàng!", true);
        } else if (maxOrder < quantity) {
            showAlertMessage("Số lượng mua vượt quá số lượng hiện có!", false);
        } else {
            $.ajax({
                url: "/perfume-shop/cart/add",
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
    });

    $("body").on("click", "#buyNow", function () {
        var maxOrder = parseInt($("#numberProductOrder").data("max-order"));
        var amount = parseInt($("#numberProductOrder").val());
        var idAttr = $("#numberProductOrder").data("id-product");
        if (maxOrder == 0) {
            showAlertMessage("Sản phẩm tạm thời hết hàng!", true);
        } else if (maxOrder < amount) {
            showAlertMessage("Số lượng mua vượt quá số lượng hiện có!", false);
        } else {
            window.location.href = '/perfume-shop/bill?idAttr=' + idAttr + "&&amount=" + amount;
        }
    });

    $("#formReview").validate({
        rules: {
            content: {
                required: true,
            },
            customerName: {
                required: true,
            },
            customerEmail: {
                required: true,
            },
            customerPhone: {
                required: true,
            },
        },
        messages: {
            content: {
                required: "Vui lòng nhập đánh giá",
            },
            customerName: {
                required: "Vui lòng nhập họ tên",
            },
            customerEmail: {
                required: "Vui lòng nhập Email",
            },
            customerPhone: {
                required: "Vui lòng nhập số điện thoại",
            },
        },
        submitHandler: function (form) {
            var formData = new FormData(form);
            var numberStar = $(".rating-star:checked").val();
            if (typeof numberStar === "undefined") {
                $("#errMsgReview").html("Vui lòng chọn số sao bạn muốn đánh giá!");
                return false;
            }
            formData.append('numberStar', numberStar);
            formData.append('idProduct', $("#id_detail_product").val());
            for (var pair of formData.entries()) {
                console.log(pair[0], pair[1]);
            }
            $("#errMsgReview").html('');
            $.post({
                url: '/perfume-shop/reviews-product',
                enctype: "multipart/form-data",
                processData: false,
                contentType: false,
                data: formData,
                success: function (responseData) {
                    if (responseData.code == 200 && responseData.success == true) {
                        showConfirm1("Đánh giá của bạn đã được ghi nhận! Vui lòng đợi phê duyệt của shop!", "Đóng");
                        $(form).trigger('reset');
                        // $(form).find("input").val("");
                        // $(form).find("textarea").val("");
                        $(".rating-star:checked").removeAttr("checked");
                    } else if (responseData.code == 200 && responseData.success == false) {
                        $("#errMsgReview").html("Bạn chưa thực hiện mua sản phẩm! Vui lòng mua sản phẩm trước khi gửi đánh giá!");
                    }
                }
            });
        }
    });

});

function loadData() {
    var id_product = $("#id_detail_product").val();
    $.get({
        url: "/perfume-shop/detail-product-loading",
        data: {
            id_product: id_product
        },
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function (jsonResult) {
            $(".front-stars").css("width", (jsonResult.product.starReviews == 0 ? 5 : jsonResult.product.starReviews) / 5 * 100 + "%");
            $(".back-stars").attr("title", (jsonResult.product.starReviews == 0 ? 5 : jsonResult.product.starReviews) + "/5");
            $(".rating-title").html((jsonResult.product.starReviews == 0 ? 5 : jsonResult.product.starReviews.toFixed(1)) + "/5 sao");
            $("#name-product").html(jsonResult.product.title);
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

            $(".btnChoseCapacity").first().addClass("shadow");
            $(".btnChoseCapacity").first().addClass("border-danger");
            var priceSaleToShow = jsonResult.product.attrs[0].priceSale;
            var priceToShow = jsonResult.product.attrs[0].price;
            var htmlPirce = '';
            if (priceSaleToShow != null && priceSaleToShow != 0) {
                htmlPirce += `<tr>
                                <td>Giá: </td>
                                <td > 
                                    <h4 style="color:red" class="font-weight-bold mb-0 mr-3">${priceSaleToShow.toLocaleString('it-IT', {tyle: 'currency',currency: 'VND'})} &#8363;</h4>
                                </td>
                                <td>
                                    <h5 class="text-muted mb-0" style="text-decoration:line-through">${priceToShow.toLocaleString('it-IT', {tyle: 'currency',currency: 'VND'})} &#8363;</h5>                    
                                </td>
                                </tr>
                                `;
            } else {
                htmlPirce += `<tr>
                                <td>Giá: </td>
                                <td> <h4 style="color:red" class="font-weight-bold mb-0">${priceToShow.toLocaleString('it-IT', {tyle: 'currency',currency: 'VND'})} &#8363;</h4>
                                </td>
                            </tr>`;
            }
            $('#numberProductOrder').data("id-product", jsonResult.product.attrs[0].id);
            $('#numberProductOrder').data("max-order", jsonResult.product.attrs[0].amount);
            $("#priceProductCurrent").find("table").html(htmlPirce);

            document.title = jsonResult.product.title;

            var ol_image_slide =
                '<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>';
            var image_slide = '';
            image_slide += '<div class="carousel-item active">';
            image_slide += '	<img class="d-block mw-100" src="/upload/' +
                jsonResult.product.avatar + '" alt="First slide">';
            image_slide += '</div>';
            if (jsonResult.product.images != null) {
                var i = 0;
                $.each(jsonResult.product.images, function (key, value) {
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


            var count1Star = 0;
            var count2Star = 0;
            var count3Star = 0;
            var count4Star = 0;
            var count5Star = 0;
            var listReviewHtml = '';
            var numberReview = 0;
            $.each(jsonResult.product.reviews, function (index, review) {
                if (review.status && !review.isHide) {
                    if (numberReview == 31) {
                        return false;
                    }
                    switch (review.numberStar) {
                        case 1:
                            count1Star++;
                            break;
                        case 2:
                            count2Star++;
                            break;
                        case 3:
                            count3Star++;
                            break;
                        case 4:
                            count4Star++;
                            break;
                        case 5:
                            count5Star++;
                            break;
                    }
                    listReviewHtml +=
                        `
                        <div class="review_item px-5">
                            <div class="media">
                                <div class="d-flex">
                                    <img class="rounded-circle" width="60" height="60" 
                                    src="${(review.user == null) ? '/user/img/no-avatar.png' : '/upload/'+review.user.avatar}" 
                                    alt="" />
                                </div>
                                <div class="media-body">
                                    <h4>${review.user==null?review.customerName:review.user.fullname}</h4>
                                    <i class="fa fa-star ${review.numberStar<1?'text-secondary':''} "></i>
                                    <i class="fa fa-star ${review.numberStar<2?'text-secondary':''}"></i>
                                    <i class="fa fa-star ${review.numberStar<3?'text-secondary':''}"></i>
                                    <i class="fa fa-star ${review.numberStar<4?'text-secondary':''}"></i>
                                    <i class="fa fa-star ${review.numberStar<5?'text-secondary':''}"></i>
                                    <p>
                                    ${review.content}
                                    </p>
                                </div>
                            </div>
                            
                        </div>
                        `
                    numberReview++;
                }
            });
            if (jsonResult.product.reviews.length > 30) {
                listReviewHtml += `<div class="text-center text-primary" type="button">Xem thêm...</div>`
            }
            $("#numstar1").html(`(${count1Star})`);
            $("#numstar2").html(`(${count2Star})`);
            $("#numstar3").html(`(${count3Star})`);
            $("#numstar4").html(`(${count4Star})`);
            $("#numstar5").html(`(${count5Star})`);
            $(".review_list").html(listReviewHtml);
        }
    });
}

function showInitPrice() {
    var price = $(".btnChoseCapacity").first().data("price");
    var priceSale = $(".btnChoseCapacity").first().data("priceSale");
    var htmlPirce = '';
    var idAttr = $(".btnChoseCapacity").first().data("id");
    var maxOrder = $(".btnChoseCapacity").first().data("maxOrder");

}

function setMenuBanner() {
    $("#img-banner").html('<img src="/user/img/my-image/banner/product1.png" alt="" width="350">');
    var titlebanner = '';
    titlebanner += '<h2>Sản phẩm</h2>';
    titlebanner += '<p>Trang chủ <span>></span>Chi tiết sản phẩm</p>';
    $("#title-banner").html(titlebanner);

    $("#mainNav li").each(function (index) {
        $(this).removeClass("my-menu-active");
    });

    $("#menu-product").addClass("my-menu-active");
}

function loadNewProduct() {
    $.ajax({
        url: "/perfume-shop/new-product",
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
    var maxOrder = parseInt($('#numberProductOrder').data("max-order"));
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