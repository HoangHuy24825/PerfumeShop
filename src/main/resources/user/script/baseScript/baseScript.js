/**
 * 
 */
$(document).ready(function () {

    $("body").on('click', ".close-btn-alert", function () {
        $('.alert-success').removeClass("show");
        $('.alert-success').addClass("hide");
        $('.alert-fail').removeClass("show");
        $('.alert-fail').addClass("hide");
    });

    $("body").on("click", ".btnChoseCapacityModal", function () {
        var currentChose = $("#modal-capacity-list").find(".shadow");
        currentChose.removeClass("border-danger");
        currentChose.removeClass("shadow");
        $(this).addClass("shadow");
        $(this).addClass("border-danger");
        $("#numberOrderInModal").attr("max", $(this).data("amount"));
        $("#numberOrderInModal").val(1);
    });

    $("body").on("click", "#btnAgreeOrder", function () {
        var quantity = $("#numberOrderInModal").val();
        var id = $("#modal-capacity-list").find(".shadow").data("id");
        if (quantity == 0) {
            $("#modalCustomerOrder").modal("hide");
            showAlertMessage("Vui lòng nhập số lượng bạn muốn thêm vào giỏ!", false);
        } else if (id == null || id == "") {
            $("#modalCustomerOrder").modal("hide");
            showAlertMessage("Vui lòng chọn dung tích muốn thêm vào giỏ!", false);
        } else {
            addProductToCartAfterConfirm(id, quantity);
        }
    });
});

function addProductToCartAfterConfirm(idAttr, quantity) {
    $("#modalCustomerOrder").modal("hide");
    let data = {
        attrProductId: parseInt(idAttr),
        quantity: parseInt(quantity)
    }
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

function showAlertMessage(message, messageState) {
    $('.msg').text(message);
    if (messageState) {
        $('.alert-success').addClass("show");
        $('.alert-success').removeClass("hide");
        $('.alert-success').addClass("showAlert");
    } else {
        $('.alert-fail').addClass("show");
        $('.alert-fail').removeClass("hide");
        $('.alert-fail').addClass("showAlert");
    }
    setTimeout(function () {
        $('.alert-success').removeClass("show");
        $('.alert-success').addClass("hide");
        $('.alert-fail').removeClass("show");
        $('.alert-fail').addClass("hide");
    }, 1500);
};

function showConfirm(message, btnConfirm, btnClose, danger) {
    $('#modalCustomerConfirmContent').text(message);
    $('#btnCloseConfirm').text(btnClose);
    $('#btnAgree').show();
    $('#btnAgree').text(btnConfirm);
    if (danger) {
        $('#btnAgree').addClass("btn btn-danger");
        $('#btnCloseConfirm').addClass("btn btn-primary");
    } else {
        $('#btnAgree').addClass("btn btn-primary");
        $('#btnCloseConfirm').addClass("btn btn-secondary");
    }
    $('#modalCustomerConfirm').modal('show');
}

function showConfirm(message, btnClose) {
    $('#modalCustomerConfirmContent').text(message);
    $('#btnCloseConfirm').text(btnClose);
    $('#btnCloseConfirm').addClass("btn btn-primary");
    $('#btnAgree').hide();
    $('#modalCustomerConfirm').modal('show');
}

function addProductToCart(id_product) {
    $.get({
        url: "/perfume-shop/detail-product-loading",
        data: {
            id_product: parseInt(id_product)
        },
        // dataType: "json",
        contentType: "application/json",
        success: function (jsonResult) {
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
                                <button class="col-4 text-center p-2 m-2 border rounded bg-white btnChoseCapacityModal"
                                    data-price="${item.price}" data-price-sale="${item.priceSale}" data-id="${item.id}"
                                    data-min-price="${jsonResult.product.minPrice}"data-amount="${item.amount}"
                                     data-product-name="${jsonResult.product.title}" data-capacity="${jsonResult.product.capacity}">
                                    <div class="capacityProduct">${item.capacity} ML</div>
                                    <div class="priceProduct font-weight-bold" >${price} &#8363;</div>
                                 </button>
                                `
            });
            $("#modal-capacity-list").html(htmlCapacity);
            $("#currentCapacityModal").html(
                `
                    Sản phẩm bạn đang chọn: ${jsonResult.product.title}
                `);
            $("#modalCustomerOrder").modal("show");
        },
        error: function (jqXhr, textStatus, errorMessage) {

        }
    });
}