$(document).ready(function () {
    var id_category = $('#id').val();

    if (id_category != null && id_category != "") {
        loadDetailForEdit(id_category);
        $("#title-page-update-add").text("Cập nhật danh mục blog");
    }
    setActiveMenu('#menu--category--blog');
});

//function to add new product
function clickSaveCategory() {
    var form = $('#form--upload')[0];
    var data = new FormData(form);

    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: "/perfume-shop/admin/add-update-category-blog",
        data: data,
        processData: false, //prevent jQuery from automatically transforming the data into a query string
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (data) {
            showAlertMessage("Thành công!", true);
            $(location).attr('href', "/perfume-shop/admin/category-blog.html");
        },
        error: function (e) {
            console.log("ERROR : ", e);
        }
    });
}

function loadDetailForEdit(idCategory) {
    $.ajax({
        url: "/perfume-shop/admin/detail-category-blog",
        type: "get",
        contentType: "application/json", //set data send to server is json
        data: {
            idCategory: idCategory
        },
        dataType: "json", //set data return is json
        success: function (result) {
            $('#id').val(result.id);
            $('#name').val(result.name);
            $('.img--avatar').css("background-image", "url(/upload/" + result.avatar + ")");
            if (result.status == true) {
                $('#status1').attr("checked", true);
            } else {
                $('#status2').attr("checked", true);
            }
            if (result.isHot == true) {
                $('#isHot1').attr("checked", true);
            } else {
                $('#isHot2').attr("checked", true);
            }
        },
        error: function (jqXhr, textStatus, errorMessage) {
            //show error
        }
    });
}