$(document).ready(function () {
    setMenuBanner();
    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });
    showAlertMessage("Đặt hàng thành công!", true);
});

function getMyOrder() {
    window.location.href = '/perfume-shop/my-account.html';
}

function searchOrder() {
    window.location.href = '/perfume-shop/search-order.html';
}

function setMenuBanner() {
    $("#img-banner").html('<img src="/user/img/my-image/banner/bill.png" alt="" width="250">');
    var titlebanner = '';
    titlebanner += '<h2>Hóa đơn đặt hàng</h2>';
    titlebanner += '<p>Trang chủ <span>></span>Hóa đơn đặt hàng</p>';
    $("#title-banner").html(titlebanner);
    $("#mainNav li").each(function (index) {
        $(this).removeClass("my-menu-active");
    });
}