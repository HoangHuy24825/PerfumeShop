$(document).ready(function () {
    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });
});


function detail(id) {
    window.location.href = '/detail-product/' + $("#view_" + id).val();
};

function getProductByCategory(idCategory) {
    window.location.href = '/product-category/' + $("#view_category_" + idCategory).val();
}