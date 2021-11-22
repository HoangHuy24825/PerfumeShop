$(document).ready(function () {
    setActiveMenu();
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