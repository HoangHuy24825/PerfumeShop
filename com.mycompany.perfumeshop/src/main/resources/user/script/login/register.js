var regexPhone = /^[0]{1}[0-9]{9,13}$/;
var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
$(document).ready(function () {

    setMenuBanner();
    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });

    $('#username').keydown(function () {
        $('#usernameMessage').hide();
    });
    $('#password').keydown(function () {
        $('#passwordMessage').hide();
    });
    $('#re_password').keydown(function () {
        $('#re_passwordMessage').hide();
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
    $('#address').keydown(function () {
        $('#addressMessage').hide();
    });

    $('#code-confirm').keydown(function () {
        $("#code-confirm-message").hide();
    });


    $('#username').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#usernameMessage').find('.message-content').text("Tên đăng nhập không được trống!");
            $('#usernameMessage').show();
        } else {
            var username = $("#username").val();
            console.log(username);
            $.ajax({
                type: "GET",
                url: "/check-username",
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
    $('#password').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#passwordMessage').find('.message-content').text("Mật khẩu không được trống!");
            $('#passwordMessage').show();
        } else {
            $('#passwordMessage').hide();
        }
    });

    $('#re_password').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#re_passwordMessage').find('.message-content').text("Vui lòng nhập lại mật khẩu!");
            $('#re_passwordMessage').show();
        } else {
            $('#re_passwordMessage').hide();
        }
    });
    $('#fullname').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#fullnameMessage').find('.message-content').text("Vui lòng nhập họ và tên!");
            $('#fullnameMessage').show();
        } else {
            $('#fullnameMessage').hide();
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
    $('#address').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#addressMessage').find('.message-content').text("Vui lòng nhập địa chỉ!");
            $('#addressMessage').show();
        } else {
            $('#addressMessage').hide();
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
            url: "/check-username",
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

    if ($("#re_password").val() == "" || $("#re_password").val() == null) {
        $('#re_passwordMessage').find('.message-content').text("Vui lòng nhập lại mật khẩu!");
        $('#re_passwordMessage').show();
        result = false;
    }

    if ($("#re_password").val() != $('#password').val()) {
        $('#re_passwordMessage').find('.message-content').text("Nhập lại mật khẩu không trùng với mật khẩu mới. Vui lòng nhập lại!");
        $('#re_passwordMessage').show();
        result = false;
    }

    if ($("#address").val() == "" || $("#address").val() == null) {
        $('#addressMessage').find('.message-content').text("Vui lòng nhập địa chỉ!");
        $('#addressMessage').show();
        result = false;
    }

    return result;
}


function call_Login() {
    if (validationForm()) {
        $('#form-login').submit();
    }
}

function setMenuBanner() {
    var titlebanner = '';
    $("#img-banner").html('<img src="/user/img/my-image/banner/sign-up.png" alt="" width="200">');
    titlebanner += '<h2>Đăng nhập</h2>';
    titlebanner += '<p> Trang chủ <span>></span> Đăng ký tài khoản </p>';
    $("#title-banner").html(titlebanner);

    $("#mainNav li").each(function (index) {
        $(this).removeClass("my-menu-active");
    });

}

function register() {
    if (validationForm()) {
        $("#modal-confirm").modal("show");
        var email = $("#email").val();
        var fullname = $("#fullname").val();
        $.ajax({
            type: "GET",
            enctype: 'multipart/form-data',
            url: "/code-confirm",
            data: {
                email: email,
                fullname: fullname
            },
            contentType: JSON,
            timeout: 600000,
            success: function (jsonResult) {
                $("#code-from-server").val(jsonResult.codeConfirm);
            },
            error: function (e) {
                console.log("ERROR : ", e);
            }
        });
    }
}

function sendCodeConfirm() {
    var code_confirm = $("#code-from-server").val();
    var code_enter = $("#code-confirm").val();
    if ($("#code-from-server").val() == $("#code-confirm").val()) {
        $("#code-confirm").val("");
        var form = $('#form-register')[0];
        var data = new FormData(form);
        $("#modal-confirm").modal("hide");
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/register-account",
            data: data,
            processData: false, //prevent jQuery from automatically transforming the data into a query string
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (jsonResult) {
                if (jsonResult.message == true) {
                    alert("Đăng ký tài khoản thành thông!");
                    $(location).attr('href', "/login");
                } else {
                    alert("Đăng ký tài khoản thất bại!");
                    $(location).attr('href', "/register");
                }
            },
            error: function (e) {
                console.log("ERROR : ", e);
            }
        });
    } else {
        $("#code-confirm-message").text("Nhập sai mã! Vui lòng nhập lại!");
        $("#code-confirm-message").show();
    }
}

