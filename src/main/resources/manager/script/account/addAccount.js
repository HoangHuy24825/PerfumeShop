/**
 * 
 */

$(document).ready(function () {
    setActiveMenu();
    $("#username_error").hide();
    $("#username").keydown(function () {
        $("#username_error").hide();
    });
});


function setActiveMenu() {
    console.log("call");
    $(".navbar__list li").each(function () {
        $(this).removeClass("active");
    });
    $(".list-unstyled li").each(function () {
        $(this).removeClass("active");
    });
    $('.list-unstyled #menu--account').addClass("active");
    $('.navbar__list #menu--account').addClass("active");
}


//function to add new product
function saveOrUpdate() {
    var form = $('#form--upload')[0];
    var typeAccount = 1;
    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: "/perfume-shop/admin/add-update-account?typeAccount=" + typeAccount,
        data: new FormData(form),
        processData: false, //prevent jQuery from automatically transforming the data into a query string
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (jsonResult) {
            if (jsonResult.result == true) {
                showAlertMessage("Thêm thành công!", true);
                $(location).attr('href', "/perfume-shop/admin/account.html");
            } else {
                showAlertMessage("Thêm thất bại!", false);
                $("#username_error").text(jsonResult.message + '');
                $("#username_error").show();
            }
        },
        error: function (e) {
            console.log("ERROR : ", e);
        }
    });
}
