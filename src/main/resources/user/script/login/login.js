$(document).ready(function () {
    setMenuBanner();
    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });

    let searchParams = new URLSearchParams(window.location.search);
    if (searchParams.has('login_error')) {
        let param = searchParams.get('login_error');
        if (param) {
            showAlertMessage("Sai tên đăng nhập hoặc mật khẩu!", false);
        }
    }

    $('#username').keydown(function () {
        $('#usernameMessage').hide();
    });

    $('#password').keydown(function () {
        $('#passwordMessage').hide();
    });

    $('#username').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#usernameMessage').find('.message-content').text("Tên đăng nhập không được rỗng!");
            $('#usernameMessage').show();
        } else {
            $('#usernameMessage').hide();
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

});

function validationForm() {
    var result = true;

    if ($('#username').val() == "" || $('#username').val() == null) {
        $('#usernameMessage').find('.message-content').text("Tên đăng nhập không được rỗng!");
        $('#usernameMessage').show();
        result = false;
    } else {
        $('#usernameMessage').hide();
    }

    if ($('#password').val() == "" || $('#password').val() == null) {
        $('#passwordMessage').find('.message-content').text("Mật khẩu không được rỗng!");
        $('#passwordMessage').show();
        result = false;
    } else {
        $('#passwordMessage').hide();
    }

    return result;
}

function runScript(e) {
    if (e.keyCode == 13) {
        call_Login();
    }
}

function call_Login() {
    if (validationForm()) {
        $('#form-login').submit();
    }
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