$(document).ready(function () {
    setMenuBanner();
    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });
    loadPage();
});

function setMenuBanner() {
    var titlebanner = '';
    $("#img-banner").html('<img src="/user/img/my-image/banner/about-us.png" alt="" width="300">');
    titlebanner += '<h2>Giới thiệu</h2>';
    titlebanner += '<p> Trang chủ <span>></span> Giới thiệu </p>';
    $("#title-banner").html(titlebanner);

    $("#mainNav li").each(function (index) {
        $(this).removeClass("my-menu-active");
    });

    $("#menu-introduce").addClass("my-menu-active");
}

function loadPage() {
    $.ajax({
        url: '/perfume-shop/load-introduce',
        type: "GET",
        data: {},
        dataType: "json",
        contentType: "application/json",
        success: function (jsonResult) {
            $("#content-page-introduce").html(jsonResult.content.detail);
        },
        error: function (jqXhr, textStatus, errorMessage) { // error callback 

        }
    });
}