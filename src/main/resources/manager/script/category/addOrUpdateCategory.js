$(document).ready(function () {
	var id_category = $('#id').val();

	if (id_category != null && id_category != "") {
		loadDetailForEdit(id_category);
		$("#title-page-update-add").text("Cập nhật danh mục");
	}
	setActiveMenu();

	showNotifyHeader();
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

//function to add new category
function clickSaveCategory() {
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
			if ($("id") == null) {
				showAlertMessage("Thêm mới danh mục thành công", true);
			} else {
				showAlertMessage("Cập nhật danh mục thành công", true);
			}
			setTimeout(function () {
				$(location).attr('href', "/admin/category");
			}, 1600);
		},
		error: function (e) {
			console.log("ERROR : ", e);
		}
	});
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