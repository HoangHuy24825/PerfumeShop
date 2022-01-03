$(document).ready(function () {
	var id_category = $('#id').val();

	if (id_category != null && id_category != "") {
		loadDetailForEdit(id_category);
		$("#title-page-update-add").text("Cập nhật danh mục");
	}
	setActiveMenu();

	showNotifyHeader();

	$("#form--upload").validate({
		rules: {
			name: "required",
			avatar: "required",
			description: "required",
		},

		messages: {
			name: "Vui lòng nhập tên danh mục",
			avatar: "Vui lòng chọn ảnh danh mục",
			description: "Vui lòng nhập mô tả"
		},

		submitHandler: function (form) {
			var id_category = $('#id').val();
			var form = $('#form--upload')[0];
			var data = new FormData(form);
			$.ajax({
				type: "POST",
				enctype: 'multipart/form-data',
				url: "/perfume-shop/admin/add-update-category",
				data: data,
				processData: false, //prevent jQuery from automatically transforming the data into a query string
				contentType: false,
				cache: false,
				timeout: 600000,
				success: function (data) {
					if (id_category == null || id_category == "") {
						showAlertMessage("Thêm mới danh mục thành công", true);
					} else {
						showAlertMessage("Cập nhật danh mục thành công", true);
					}
					setTimeout(function () {
						$(location).attr('href', "/perfume-shop/admin/category.html");
					}, 1600);
				},
				error: function (e) {
					console.log("ERROR : ", e);
				}
			});
		}
	});

});

function setActiveMenu() {
	console.log("call");
	$(".navbar__list li").each(function () {
		$(this).removeClass("active");
	});
	$(".list-unstyled li").each(function () {
		$(this).removeClass("active");
	});
	$('.list-unstyled #menu--category').addClass("active");
	$('.navbar__list #menu--category').addClass("active");
}

function loadDetailForEdit(idCategory) {
	$.ajax({
		url: "/perfume-shop/admin/detail-category",
		type: "get",
		contentType: "application/json", //set data send to server is json
		data: {
			idCategory: idCategory
		},
		dataType: "json", //set data return is json
		success: function (category) {
			$('#id').val(category.id);
			$('#name').val(category.name);
			$('.img--avatar').css("background-image", "url(/upload/" + category.avatar + ")");
			$('#seo').val(category.seo);
			$('#description').val(category.description);
		},
		error: function (jqXhr, textStatus, errorMessage) {
			//show error
		}
	});
}