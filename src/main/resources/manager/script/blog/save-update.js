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

    $('#detail').keydown(function () {
        $('#detailMsgErr').hide();
    });

    $('#detail').focusout(function () {
        if (editor.getData() == "" || editor.getData() == null) {
            $('#detailMsgErr').find('.message-content').text("Vui lòng nhập chi tiết blog!");
            $('#detailMsgErr').show();
        } else {
            $('#detailMsgErr').hide();
        }
    });

    $("#form--upload").validate({
        rules: {
            name: "required",
            avatar: {
                required: function () {
                    if ($('#id').val() != null && $('#id').val() != "")
                        return false;
                    return true;
                }
            },
            description: "required",
        },

        messages: {
            name: "Vui lòng nhập tiêu đề blog",
            avatar: "Vui lòng chọn ảnh cho blog",
            description: "Vui lòng nhập mô tả cho blog",
        },

        submitHandler: function (form1) {
            var form = $('#form--upload')[0];
            var data = new FormData(form);
            var detailCkEditor = editor.getData();
            data.append('detail', detailCkEditor);
            if (editor.getData() == "" || editor.getData() == null) {
                $('#detailMsgErr').find('.message-content').text("Vui lòng nhập chi tiết blog!");
                $('#detailMsgErr').show();
            } else {
                $('#detailMsgErr').hide();
                $.ajax({
                    type: "POST",
                    enctype: 'multipart/form-data',
                    url: "/perfume-shop/admin/add-update-blog",
                    data: data,
                    processData: false, //prevent jQuery from automatically transforming the data into a query string
                    contentType: false,
                    cache: false,
                    timeout: 600000,
                    success: function (data) {
                        showAlertMessage("Thành công", true);
                        $(location).attr('href', "/perfume-shop/admin/blog.html");
                    },
                    error: function (e) {
                        console.log("ERROR : ", e);
                    }
                });
            }
        }
    });

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

function loadDetailForEdit(idBlog) {
    $.ajax({
        url: "/perfume-shop/admin/detail-blog",
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
            editor.setData(result.detail);
        },
        error: function (jqXhr, textStatus, errorMessage) {
            //show error
        }
    });
}

function loadCategory() {
    $.ajax({
        url: "/perfume-shop/admin/all-category-blog-active",
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