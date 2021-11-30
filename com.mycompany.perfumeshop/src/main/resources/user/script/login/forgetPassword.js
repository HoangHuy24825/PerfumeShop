var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
$(document).ready(function () {
    $("#form-change-password").hide();
    $("#form-send-requet-get-password").show();
    setMenuBanner();
    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });

    $('#email').bind('keypress keydown keyup', function (e) {
        if (e.keyCode == 13) {
            e.preventDefault();
            requestCode();
        }
    });

    let searchParams = new URLSearchParams(window.location.search);
    if (searchParams.has('login_error')) {
        let param = searchParams.get('login_error');
        if (param) {
            showAlertMessage("Sai tên đăng nhập hoặc mật khẩu!", false);
        }
    }

    $('#email').keydown(function () {
        $('#emailMessage').hide();
    });

    $('#password').keydown(function () {
        $('#passwordMessage').hide();
    });

    $('#email').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#emailMessage').find('.message-content').text("Vui lòng nhập email!");
            $('#emailMessage').show();
        } else {
            if (!regexEmail.test($(this).val())) {
                $('#emailMessage').find('.message-content').text("Email người nhận không hợp lệ!");
                $('#emailMessage').show();
            } else {
                $('#emailMessage').hide();

            }
        }
    });

    $('#password').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#passwordMessage').find('.message-content').text("Mật khẩu không được rỗng!");
            $('#passwordMessage').show();
        } else {
            $('#passwordMessage').hide();
        }
    });

    $('#re-password').keydown(function () {
        $('#re-passwordMessage').hide();
    });

    $('#re-password').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#re-passwordMessage').find('.message-content').text("Vui lòng nhập lại mật khẩu!");
            $('#re-passwordMessage').show();
        } else {
            $('#re-passwordMessage').hide();
        }
    });

    $('#code-confirm').keydown(function () {
        $("#code-confirm-message").hide();
    });
});

function requestCode() {
    if (validationFormRequest()) {

        var email = $("#email").val();
        email = email.replace("@", "-");
        $("#emailHidden").val(email);

        $.ajax({
            type: "GET",
            enctype: 'multipart/form-data',
            url: "/perfume-shop/code-request-forget-password",
            data: {
                email: email
            },
            contentType: JSON,
            timeout: 600000,
            success: function (jsonResult) {
                if (jsonResult.code == 0) {
                    $('#emailMessage').find('.message-content').text(
                        "Email này chưa được đăng ký tài khoản!");
                    $('#emailMessage').show();
                } else {
                    sendEmailCode();
                }
            },
            error: function (e) {
                console.log("ERROR : ", e);
            }
        });
    }
}

function sendEmailCode() {
    $("#modal-confirm").modal("show");
    var email = $("#emailHidden").val();
    $.ajax({
        type: "GET",
        enctype: 'multipart/form-data',
        url: "/perfume-shop/send-email-code-confirm",
        data: {
            email: email
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

function changePassword() {
    if (validationFormNewPass()) {
        var email = $("#emailHidden").val();
        var password = $("#password").val();
        console.log(email);
        if ($("#password").val() == $("#re-password").val()) {
            $.ajax({
                type: "GET",
                enctype: 'multipart/form-data',
                url: "/perfume-shop/change-password-forget",
                data: {
                    email: email,
                    password: password
                },
                contentType: JSON,
                timeout: 600000,
                success: function (jsonResult) {
                    showAlertMessage("Đổi mật khẩu thành công!", true);
                    window.location.href = '/login';
                },
                error: function (e) {
                    console.log("ERROR : ", e);
                }
            });
        } else {
            $('#re-passwordMessage').find('.message-content').text(
                "Vui lòng nhập lại mật khẩu trùng với mật khẩu mới!");
            $('#re-passwordMessage').show();
        }
    }
}

function sendCodeConfirm() {
    var code_confirm = $("#code-from-server").val();
    $("#modal-confirm").modal("hide");
    var code_enter = $("#code-confirm").val();
    if ($("#code-from-server").val() == $("#code-confirm").val()) {
        $("#code-confirm").val("");
        $("#form-change-password").show();
        $("#form-send-requet-get-password").hide();
    } else {
        $("#code-confirm-message").text("Nhập sai mã! Vui lòng nhập lại!");
        $("#code-confirm-message").show();
    }
}

function validationFormNewPass() {
    var result = true;

    if ($('#password').val() == "" || $('#password').val() == null) {
        $('#passwordMessage').find('.message-content').text("Mật khẩu không được rỗng!");
        $('#passwordMessage').show();
        result = false;
    } else {
        $('#passwordMessage').hide();
    }

    if ($("#re-password").val() == "" || $("#re-password").val() == null) {
        $('#re-passwordMessage').find('.message-content').text("Vui lòng nhập lại mật khẩu!");
        $('#re-passwordMessage').show();
        result = false;
    } else {
        $('#re-passwordMessage').hide();
    }

    return result;
}

function validationFormRequest() {
    var result = true;

    if ($("#email").val().trim() == "" || $("#email").val().trim() == null) {
        $('#emailMessage').find('.message-content').text("Vui lòng nhập email!");
        $('#emailMessage').show();
        result = false;
    } else {
        if (!regexEmail.test($("#email").val())) {
            $('#emailMessage').find('.message-content').text("Email người nhận không hợp lệ!");
            $('#emailMessage').show();
            result = false;
        } else {
            $('#emailMessage').hide();

        }
    }

    return result;
}

function setMenuBanner() {
    var titlebanner = '';
    $("#img-banner").html('<img src="/user/img/my-image/banner/login.png" alt="" width="200">');
    titlebanner += '<h2>Đăng nhập</h2>';
    titlebanner += '<p> Trang chủ <span>></span> Đăng nhập </p>';
    $("#title-banner").html(titlebanner);

    $("#mainNav li").each(function (index) {
        $(this).removeClass("my-menu-active");
    });

}