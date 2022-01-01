$(document).ready(function () {
    var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    var regexPhone = /^[0]{1}[0-9]{9,13}$/;

    $.validator.addMethod("validatePhone", function (value, element) {
        return regexPhone.test(value);
    }, "Số điện thoại sai định dạng");

    $.validator.addMethod("validateEmail", function (value, element) {
        return regexEmail.test(value);
    }, "Email sai định dạng");


    $("#contactForm").submit(function (e) {
        e.preventDefault();
    }).validate({
        rules: {
            subject: "required",
            customerName: "required",
            customerEmail: {
                required: true,
                validateEmail: true
            },
            customerPhone: {
                required: true,
                validatePhone: true
            },
            content: {
                required: true,
            }
        },

        messages: {
            subject: "Vui lòng nhập chủ đề",
            customerName: "Vui lòng nhập tên của bạn",
            customerEmail: {
                required: "Vui lòng nhập địa chỉ email của bạn",
            },
            customerPhone: {
                required: "Vui lòng nhập số điện thoại của bạn",
            },
            content: "Vui lòng nhập nội dung"
        },

        submitHandler: function (form) {
            var formData = new FormData(form);
            for (var pair of formData.entries()) {
                console.log(pair[0], pair[1]);
            }
            $.post({
                url: "/perfume-shop/contact",
                enctype: 'multipart/form-data',
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    if (response) {
                        $("#infoMsg").html(`Liên hệ của bạn đã được gửi. Vui lòng kiểm tra email thường xuyên để nhận được phản hồi từ phía chúng tôi.`);
                        $("#contactForm").trigger("reset");
                    } else {
                        $("#errMsg").html(`Liên hệ của bạn đã chưa được gửi. Vui lòng thử lại sau.`);
                    }
                }
            });
        }
    });

    setMenuBanner("#menu--contact");
});

function setMenuBanner() {
    var titlebanner = '';
    $("#img-banner").html('<img src="/user/img/my-image/banner/contact.png" alt="" width="350">');
    titlebanner += '<h2>Liên hệ</h2>';
    titlebanner += '<p> Trang chủ <span>></span> Liên hệ </p>';
    $("#title-banner").html(titlebanner);
    $("#mainNav li").removeClass("my-menu-active");
    $("#menu-contact").addClass("my-menu-active");
}