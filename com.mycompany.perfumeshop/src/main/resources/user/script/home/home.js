$(document).ready(function () {
    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });
});


function detail(id) {
    window.location.href = '/detail-product/' + $("#view_" + id).val();
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

function getProductByCategory(idCategory) {
    window.location.href = '/product-category/' + $("#view_category_" + idCategory).val();
}