$(document).ready(function () {
	var id_category = $('#id').val();

	if (id_category != null && id_category != "") {
		loadDetailForEdit(id_category);
		$("#title-page-update-add").text("Cập nhật danh mục");
	}
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
		url: "/admin/add-update-category",
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
		url: "/admin/detail-category",
		type: "get",
		contentType: "application/json", //set data send to server is json
		data: {
			idCategory: idCategory
		},
		dataType: "json", //set data return is json
		success: function (result) {
			$('#id').val(result.category.id);
			$('#name').val(result.category.name);
			$('.img--avatar').css("background-image", "url(/upload/" + result.category.avatar + ")");
			$('#seo').val(result.category.seo);
			$('#description').val(result.category.description);
			if (result.category.status == true) {
				$('#status').attr("checked", true);
			}
			if (result.category.isHot == true) {
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