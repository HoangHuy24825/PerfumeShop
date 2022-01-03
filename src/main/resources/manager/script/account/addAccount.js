/**
 * 
 */
var regexPhone = /^[0]{1}[0-9]{9,13}$/;
var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
$(document).ready(function () {



    setActiveMenu();
    $("#username_error").hide();
    $("#username").keydown(function () {
        $("#username_error").hide();
    });


    $('#username').keydown(function () {
        $('#usernameMessage').hide();
    });
    $('#password').keydown(function () {
        $('#passwordMessage').hide();
    });
    $('#fullname').keydown(function () {
        $('#fullnameMessage').hide();
    });
    $('#email').keydown(function () {
        $('#emailMessage').hide();
    });
    $('#phone').keydown(function () {
        $('#phoneMessage').hide();
    });

    $('#password').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#passwordMessage').find('.message-content').text("Mật khẩu không được trống!");
            $('#passwordMessage').show();
        } else {
            $('#passwordMessage').hide();
        }
    });

    $('#username').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#usernameMessage').find('.message-content').text("Tên đăng nhập không được trống!");
            $('#usernameMessage').show();
        } else {
            var username = $("#username").val();
            $.ajax({
                type: "GET",
                url: "/perfume-shop/check-username",
                data: {
                    username: username
                },
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                timeout: 600000,
                success: function (jsonResult) {
                    if (jsonResult == true) {
                        $('#usernameMessage').find('.message-content').text("Tên đăng nhập đã tồn tại. Vui lòng chọn tên khác!");
                        $('#usernameMessage').show();
                    } else {
                        $('#usernameMessage').hide();
                    }
                },
                error: function (e) {
                    console.log("ERROR : ", e);
                }
            });
        }
    });

    $('#email').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#emailMessage').find('.message-content').text("Vui lòng nhập email!");
            $('#emailMessage').show();
        } else {
            if (!regexEmail.test($('#email').val())) {
                $('#emailMessage').find('.message-content').text("Email không hợp lệ!");
                $('#emailMessage').show();
            } else {
                $('#emailMessage').hide();
                var email = $(this).val();
                $.ajax({
                    type: "GET",
                    url: "/perfume-shop/check-email",
                    data: {
                        email: email
                    },
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    timeout: 600000,
                    success: function (jsonResult) {
                        if (jsonResult == true) {
                            $('#emailMessage').find('.message-content').text("Email đã tồn tại. Vui lòng nhập một email khác!");
                            $('#emailMessage').show();
                        } else {
                            $('#emailMessage').hide();
                        }
                    },
                    error: function (e) {
                        console.log("ERROR : ", e);
                    }
                });
            }
        }
    });

    $('#phone').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#phoneMessage').find('.message-content').text("Vui lòng nhập số điện thoại!");
            $('#phoneMessage').show();
        } else {
            if (!regexPhone.test($('#phone').val())) {
                $('#phoneMessage').find('.message-content').text("Số điện thoại không hợp lệ!");
                $('#phoneMessage').show();
            } else {
                $('#phoneMessage').hide();
            }
        }
    });


});

function validationForm() {
    var result = true;

    if ($('#username').val() == "" || $('#username').val() == null) {
        $('#usernameMessage').find('.message-content').text("Tên đăng nhập không được rỗng!");
        $('#usernameMessage').show();
        result = false;
    } else {
        var username = $("#username").val();
        console.log(username);
        $.ajax({
            type: "GET",
            url: "/perfume-shop/check-username",
            data: {
                username: username
            },
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            timeout: 600000,
            success: function (jsonResult) {
                if (jsonResult.result == false) {
                    $('#usernameMessage').find('.message-content').text("Tên đăng nhập đã tồn tại. Vui lòng chọn tên khác!");
                    $('#usernameMessage').show();
                    result = false;
                }
            },
            error: function (e) {
                console.log("ERROR : ", e);
            }
        });
    }

    if ($('#password').val() == "" || $('#password').val() == null) {
        $('#passwordMessage').find('.message-content').text("Mật khẩu không được rỗng!");
        $('#passwordMessage').show();
        result = false;
    }

    if ($("#email").val() == "" || $("#email").val() == null) {
        $('#emailMessage').find('.message-content').text("Vui lòng nhập email!");
        $('#emailMessage').show();
        result = false;
    } else {
        if (!regexEmail.test($('#email').val())) {
            $('#emailMessage').find('.message-content').text("Email không hợp lệ!");
            $('#emailMessage').show();
            result = false;
        }
    }

    if ($("#phone").val() == "" || $("#phone").val() == null) {
        $('#phoneMessage').find('.message-content').text("Vui lòng nhập số điện thoại!");
        $('#phoneMessage').show();
        result = false;
    } else {
        if (!regexPhone.test($('#phone').val())) {
            $('#phoneMessage').find('.message-content').text("Số điện thoại không hợp lệ!");
            $('#phoneMessage').show();
            result = false;
        }
    }

    if ($("#fullname").val() == "" || $("#fullname").val() == null) {
        $('#fullnameMessage').find('.message-content').text("Vui lòng nhập họ và tên!");
        $('#fullnameMessage').show();
        result = false;
    }

    return result;
}


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
    if (validationForm()) {
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
}