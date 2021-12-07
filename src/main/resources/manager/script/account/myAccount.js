/**
 * 
 */

var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
var regexPhone = /^[0]{1}[0-9]{9,13}$/;
$(document).ready(function () {

    setActiveMenu("#menu--my-account");

    $.validator.addMethod("validatePhone", function (value, element) {
        return regexPhone.test(value);
    }, "Số điện thoại sai định dạng");

    $.validator.addMethod("validateEmail", function (value, element) {
        return regexEmail.test(value);
    }, "Email sai định dạng");

    $.validator.addMethod("validateRepassword", function (value, element) {
        return value == $("#NewPassword").val();
    }, "Nhập lại mật khẩu phải trùng với mật khẩu mới");

    $("#form-infor").submit(function (e) {
        e.preventDefault();
    }).validate({
        rules: {
            fullname: "required",
            address: "required",
            phone: {
                required: true,
                validatePhone: true
            },
        },

        messages: {
            fullname: "Vui lòng nhập họ tên",
            address: "Vui lòng nhập địa chỉ",
            phone: {
                required: "Vui lòng nhập số điện thoại",
            },
        },

        submitHandler: function (form) {
            var data = new FormData(form);
            data.append("email", $("#email").val());
            $.post({
                enctype: 'multipart/form-data',
                url: "/perfume-shop/admin/add-update-account",
                data: data,
                processData: false, //prevent jQuery from automatically transforming the data into a query string
                contentType: false,
                success: function (data) {
                    showAlertMessage("Đổi thông tin thành công!", true);
                    window.location.href = '/perfume-shop/admin/my-account.html';
                },
                error: function (e) {
                    console.log("ERROR : ", e);
                }
            });
        }
    });

    $("#changePasswordForm").submit(function (e) {
        e.preventDefault();
    }).validate({
        rules: {
            OldPassword: "required",
            NewPassword: "required",
            ConfirmPassword: {
                required: true,
                validateRepassword: true
            },
        },

        messages: {
            OldPassword: "Vui lòng nhập mật khẩu cũ",
            NewPassword: "Vui lòng nhập mật khẩu mới",
            ConfirmPassword: {
                required: "Vui lòng nhập lại mật khẩu",
            },
        },

        submitHandler: function (form) {
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/perfume-shop/admin/update-password",
                data: new FormData(form),
                processData: false, //prevent jQuery from automatically transforming the data into a query string
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (jsonResult) {
                    if (jsonResult == true) {
                        showAlertMessage("Đổi mật khẩu thành công!", true);
                        window.location.href = '/perfume-shop/admin/my-account.html';
                    } else {
                        $('#errMsg').text("Sai mật khẩu!");
                        showAlertMessage("Đổi mật khẩu thất bại!", false);
                    }
                },
                error: function (e) {}
            });
        }
    });

});

const loadFile = (event) => {
    let image = document.getElementById('output');
    image.src = URL.createObjectURL(event.target.files[0]);
};