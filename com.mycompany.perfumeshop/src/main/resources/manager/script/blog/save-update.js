var editor = '';
$(document).ready(function () {
    editor = CKEDITOR.replace('detail', {
        width: ['100%'],
        height: ['400px']
    });
    var id_blog = $('#id').val();

    if (id_blog != null && id_blog != "") {
        loadDetailForEdit(id_blog);
        $("#title-page-update-add").text("Cập nhật blog");
    }
    setActiveMenu();

    loadCategory();

});

function setActiveMenu() {
    $(".navbar__list li").each(function () {
        $(this).removeClass("active");
    });
    $(".list-unstyled li").each(function () {
        $(this).removeClass("active");
    });
    $('.list-unstyled #menu--blog').addClass("active");
    $('.navbar__list #menu--blog').addClass("active");
}


//function to add new product
function clickSaveBlog() {
    var form = $('#form--upload')[0];
    var data = new FormData(form);
    var detailCkEditor = editor.getData();
    data.append('detail', detailCkEditor);
    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: "/admin/add-update-blog",
        data: data,
        processData: false, //prevent jQuery from automatically transforming the data into a query string
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (data) {
            showAlertMessage("Thành công", true);
            $(location).attr('href', "/admin/blog");
        },
        error: function (e) {
            console.log("ERROR : ", e);
        }
    });
}

function loadDetailForEdit(idBlog) {
    $.ajax({
        url: "/admin/detail-blog",
        type: "get",
        contentType: "application/json", //set data send to server is json
        data: {
            idBlog: idBlog
        },
        dataType: "json", //set data return is json
        success: function (result) {
            $('#id').val(result.id);
            $('#name').val(result.name);
            $('#select-category').val(result.id_category);
            $('.img--avatar').css("background-image", "url(/upload/" + result.avatar + ")");
            $('#seo').val(result.seo);
            $('#description').val(result.description);
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
            editor.setData(result.detail);
        },
        error: function (jqXhr, textStatus, errorMessage) {
            //show error
        }
    });
}

function loadCategory() {
    $.ajax({
        url: "/admin/all-category-blog-active",
        type: "get",
        contentType: "application/json", //set data send to server is json
        data: "",
        dataType: "json", //set data return is json
        success: function (result) {
            var html = '';
            $.each(result, function (index, value) {
                html += '<option value="' + value.id + '">' + value.name + '</option>';
            });
            $('#select-category').html(html);
        },
        error: function (jqXhr, textStatus, errorMessage) {
            //show error
        }
    });
}