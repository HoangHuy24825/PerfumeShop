/**
 * 
 */
$(document).ready(function () {

    $("body").on('click', ".close-btn-alert", function () {
        $('.alert-success').removeClass("show");
        $('.alert-success').addClass("hide");
        $('.alert-fail').removeClass("show");
        $('.alert-fail').addClass("hide");
    });
});

function showAlertMessage(message, messageState) {
    $('.msg').text(message);
    if (messageState) {
        $('.alert-success').addClass("show");
        $('.alert-success').removeClass("hide");
        $('.alert-success').addClass("showAlert");
    } else {
        $('.alert-fail').addClass("show");
        $('.alert-fail').removeClass("hide");
        $('.alert-fail').addClass("showAlert");
    }
    setTimeout(function () {
        $('.alert-success').removeClass("show");
        $('.alert-success').addClass("hide");
        $('.alert-fail').removeClass("show");
        $('.alert-fail').addClass("hide");
    }, 1500);
};

function showConfirm(message, btnConfirm, btnClose, danger) {
    $('#modalCustomerConfirmContent').text(message);
    $('#btnCloseConfirm').text(btnClose);
    $('#btnAgree').show();
    $('#btnAgree').text(btnConfirm);
    if (danger) {
        $('#btnAgree').addClass("btn btn-danger");
        $('#btnCloseConfirm').addClass("btn btn-primary");
    } else {
        $('#btnAgree').addClass("btn btn-primary");
        $('#btnCloseConfirm').addClass("btn btn-secondary");
    }
    $('#modalCustomerConfirm').modal('show');
}