/**
 * 
 */

var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
var regexPhone = /^[0]{1}[0-9]{9,13}$/;
$(document).ready(function () {
    $('#error_full_name').hide();
    $('#error_address').hide();
    $('#error_email').hide();
    $('#error_phone').hide();
    $('#error_old_password').hide();
    $('#error_new_password').hide();
    $('#error_confirm_password').hide();

    $('#fullname').keydown(function () {
        $('#error_full_name').hide();
    });
    $('#address').keydown(function () {
        $('#error_address').hide();
    });
    $('#email').keydown(function () {
        $('#error_email').hide();
    });
    $('#phone').keydown(function () {
        $('#error_phone').hide();
    });

    $('#OldPassword').keydown(function () {
        $('#error_old_password').hide();
    });

    $('#NewPassword').keydown(function () {
        $('#error_new_password').hide();
    });

    $('#ConfirmPassword').keydown(function () {
        $('#error_confirm_password').hide();
    });

    $("#fullname").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_full_name").text("Tên người dùng không được trống!");
            $("#error_full_name").show();
        } else {
            $("#error_full_name").hide();
        }
    })

    $("#address").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_address").text("Địa chỉ người dùng không được trống!");
            $("#error_address").show();
        } else {
            $("#error_address").hide();
        }
    })

    $("#email").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_email").text("Email người dùng không được trống!");
            $("#error_email").show();
        } else {
            if (!regexEmail.test($(this).val())) {
                $("#error_email").text("Email người dùng không hợp lệ!");
                $("#error_email").show();
            } else {
                $('#error_email').hide();
            }
        }
    })

    $("#phone").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_phone").text("Số điện thoại người dùng không được trống!");
            $("#error_phone").show();
        } else {
            if (!regexPhone.test($(this).val())) {
                $("#error_phone").text("Số điện thoại không hợp lệ!");
                $("#error_phone").show();
            } else {
                $('#error_phone').hide();
            }
        }
    })

    $("#OldPassword").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_old_password").text("Mật khẩu hiện tại không được trống!");
            $("#error_old_password").show();
        } else {
            $("#error_old_password").hide();
        }
    })

    $("#NewPassword").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_new_password").text("Mật khẩu mới không được trống!");
            $("#error_new_password").show();
        } else {
            $("#error_new_password").hide();
        }
    })

    $("#ConfirmPassword").focusout(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $("#error_confirm_password").text("Vui lòng nhập lại mật khẩu mới!");
            $("#error_confirm_password").show();
        } else {
            $("#error_confirm_password").hide();
        }
    })

});


function validateFormInfor() {
    var result = true;

    if ($("#fullname").val() == null || $("#fullname").val() == "") {
        $("#error_full_name").text("Tên người dùng không được trống!");
        $("#error_full_name").show();
        result = false;
    }

    if ($("#address").val() == null || $("#address").val() == "") {
        $("#error_address").text("Địa chỉ người dùng không được trống!");
        $("#error_address").show();
        result = false;
    }

    if ($("#email").val() == null || $("#email").val() == "") {
        $("#error_email").text("Email người dùng không được trống!");
        $("#error_email").show();
        result = false;
    } else {
        if (!regexEmail.test($("#email").val())) {
            $("#error_email").text("Email người dùng không hợp lệ!");
            $("#error_email").show();
            result = false;
        }
    }

    if ($("#phone").val() == null || $("#phone").val() == "") {
        $("#error_phone").text("Số điện thoại người dùng không được trống!");
        $("#error_phone").show();
        result = false;
    } else {
        if (!regexPhone.test($("#phone").val())) {
            $("#error_phone").text("Số điện thoại không hợp lệ!");
            $("#error_phone").show();
            result = false;
        }
    }
    return result;
}

function clickUpdateInfo() {
    if (validateFormInfor()) {
        var form = $('#form-infor')[0];
        var data = new FormData(form);
        for (var value of data.values()) {
            console.log(value);
        }
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/admin/add-update-account",
            data: data,
            processData: false, //prevent jQuery from automatically transforming the data into a query string
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                showAlertMessage("Đổi thông tin thành công!", true);
                window.location.href = '/admin/my-account';
            },
            error: function (e) {
                console.log("ERROR : ", e);
            }
        });
    }
}

const loadFile = (event) => {
    let image = document.getElementById('output');
    image.src = URL.createObjectURL(event.target.files[0]);
};


function validateFormChangePassword() {
    var result = true;

    if ($("#OldPassword").val() == null || $("#OldPassword").val() == "") {
        $("#error_old_password").text("Mật khẩu hiện tại không được trống!");
        $("#error_old_password").show();
        result = false;
    }

    if ($("#NewPassword").val() == null || $("#NewPassword").val() == "") {
        $("#error_new_password").text("Mật khẩu mới không được trống!");
        $("#error_new_password").show();
        result = false;
    }

    if ($("#ConfirmPassword").val() == null || $("#ConfirmPassword").val() == "") {
        $("#error_confirm_password").text("Vui lòng nhập lại mật khẩu!");
        $("#error_confirm_password").show();
        result = false;
    }
    return result;
}

function changePassword() {
    if (validateFormChangePassword()) {
        var oldPassword = $("#OldPassword").val();
        var newPassword = $("#NewPassword").val();
        var reNewPassword = $("#ConfirmPassword").val();

        if (newPassword != reNewPassword) {
            $("#error_confirm_password").text("Nhập lại mật khẩu mới phải trùng mới mật khẩu mới!");
            $("#error_confirm_password").show();
        } else {
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/admin/update-password?oldPass=" + oldPassword + "&&newPass=" + newPassword,
                data: {},
                processData: false, //prevent jQuery from automatically transforming the data into a query string
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (jsonResult) {
                    if (jsonResult.message == true) {
                        showAlertMessage("Đổi mật khẩu thành công!", true);
                        window.location.href = '/admin/my-account';
                    } else {
                        $('#error_old_password').text("Sai mật khẩu!");
                        $('#error_old_password').show();
                        showAlertMessage("Đổi mật khẩu thất bại!", false);
                    }
                },
                error: function (e) {}
            });
        }
    }
}