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

// function to add imput image product
$(".imgAdd").click(function () {
    $(this).closest(".row").find('.imgAdd').before('<div class="col-sm-2 imgUp"><div class="imagePreview image--product" data-id-image=""></div><label class="btn btn-primary btn--upload-image">Upload<input type="file" class="uploadFile img" name="images" accept="image/png, image/jpeg, image/jpg" style="width:0px;height:0px;overflow:hidden;"></label><i class="fa fa-times del"></i></div>');
});
$(document).on("click", "i.del", function () {
    $(this).parent().remove();
});
//function to add preview image
$(function () {
    $(document).on("change", ".uploadFile", function () {
        var uploadFile = $(this);
        var files = !!this.files ? this.files : [];
        if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support

        if (/^image/.test(files[0].type)) { // only image file
            var reader = new FileReader(); // instance of the FileReader
            reader.readAsDataURL(files[0]); // read the local file

            reader.onloadend = function () { // set image data as background of div
                //alert(uploadFile.closest(".upimage").find('.imagePreview').length);
                uploadFile.closest(".imgUp").find('.imagePreview').css("background-image", "url(" + this.result + ")");
            }
        }

    });
});

function setActiveMenu(currentTag) {
    $(".navbar__list li").removeClass("active");
    $(".list-unstyled li").removeClass("active");
    $('.list-unstyled ' + currentTag).addClass("active");
    $('.navbar__list ' + currentTag).addClass("active");
}

function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [day, month, year].join('-');
}

function formatDateType2(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}

function addCommas(nStr) {
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}