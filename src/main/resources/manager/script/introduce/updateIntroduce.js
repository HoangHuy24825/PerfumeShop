var editor = '';
$(document).ready(function () {
    editor = CKEDITOR.replace('detail', {
        width: ['100%'],
        height: ['800px']
    });
    var id_introduce = $('#id').val();

    loadDetailForEdit(id_introduce);
    setActiveMenu();
});

function setActiveMenu() {
    console.log("call");
    $(".navbar__list li").each(function () {
        $(this).removeClass("active");
    });
    $(".list-unstyled li").each(function () {
        $(this).removeClass("active");
    });
    $('.list-unstyled #menu--introduce').addClass("active");
    $('.navbar__list #menu--introduce').addClass("active");
}

//function to add new product
function clickSave() {
    var form = $('#form--upload')[0];
    var data = new FormData(form);
    var detailCkEditor = editor.getData();
    data.append('detail', detailCkEditor);
    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: "/perfume-shop/admin/update-introduce",
        data: data,
        processData: false, //prevent jQuery from automatically transforming the data into a query string
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (data) {
            showAlertMessage("Cập nhật thành công!");
            $(location).attr('href', "/perfume-shop/admin/introduce.html");
        },
        error: function (e) {
            console.log("ERROR : ", e);
        }
    });
}

function loadDetailForEdit(idBlog) {
    $.ajax({
        url: "/perfume-shop/admin/introduce-detail",
        type: "get",
        contentType: "application/json", //set data send to server is json
        data: {
            idBlog: idBlog
        },
        dataType: "json", //set data return is json
        success: function (result) {
            editor.setData(result.introduce.detail);
        },
        error: function (jqXhr, textStatus, errorMessage) {
            //show error
        }
    });
}