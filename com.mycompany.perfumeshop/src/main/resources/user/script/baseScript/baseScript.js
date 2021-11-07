/**
 * 
 */
$(document).ready(function () {
    function showAlertMessage(message, messageState) {
        if (messageState) {
            $('#alert_message').css({
                "background": "#C5F3D7",
                "border-left": "8px solid #2BD971"
            });
            $("#icon-alert-message").html('<i class="fas fa-check-circle"></i>');
            $("#icon-alert-message").find('i').css({
                "color": "#2BD971"
            });
            $(".msg").css({
                "color": "#24AD5F"
            });
            $(".close-btn-alert").css({
                "background": "#2BD971",
                "color": "#24AD5F"
            });
            $(".close-btn-alert").find('.fas').css({
                "color": "#24AD5F"
            });
            $(".close-btn-alert").hover(function (e) {
                $(this).css("background-color", e.type === "mouseenter" ? "#38F5A3" : "#2BD971")
            })
        } else {
            $('#alert_message').css({
                "background": "#FFE1E3",
                "border-left": "8px solid #FF4456"
            });
            $("#icon-alert-message").html('<i class="fas fa-exclamation-circle"></i>');
            $("#icon-alert-message").find('i').css({
                "color": "#FE4950"
            });
            $(".msg").css({
                "color": "#F694A9"
            });
            $(".close-btn-alert").css({
                "background": "#FF9CA4",
                "color": "#FD4653"
            });
            $(".close-btn-alert").find('.fas').css({
                "color": "#FD4653"
            });
            $(".close-btn-alert").hover(function (e) {
                $(this).css("background-color", e.type === "mouseenter" ? "#FFBDC2" : "#FF9CA4")
            })
        }

        $('.msg').text(message);
        $('.alert').addClass("show");
        $('.alert').removeClass("hide");
        $('.alert').addClass("showAlert");
        setTimeout(function () {
            $('.alert').removeClass("show");
            $('.alert').addClass("hide");
        }, 3000);
    }

    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });

    function showConfirm(message, btnConfirm, btnClose) {
        $('#modalCustomerConfirmContent').text(message);
        $('#btnClose').text(btnClose);
        $('#btnAgree').show();
        $('#btnAgree').text(btnConfirm);
        $('#btnClose').addClass("btn btn-secondary");
        $('#btnAgree').addClass("btn btn-primary");
        $('#modalCustomerConfirm').modal('show');
    }
});