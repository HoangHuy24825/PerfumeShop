$(document).ready(function() {
	var id_category = $('#id').val();
	console.log("ID category" + id_category);
	if (id_category != null && id_category != "") {
		loadDetailForEdit(id_category);
	}
});

// function to add imput image product
$(".imgAdd").click(function() {
	$(this).closest(".row").find('.imgAdd').before('<div class="col-sm-2 imgUp"><div class="imagePreview image--product" data-id-image=""></div><label class="btn btn-primary btn--upload-image">Upload<input type="file" class="uploadFile img" name="images" accept="image/png, image/jpeg, image/jpg" style="width:0px;height:0px;overflow:hidden;"></label><i class="fa fa-times del"></i></div>');
});
$(document).on("click", "i.del", function() {
	$(this).parent().remove();
});
//function to add preview image
$(function() {
	$(document).on("change", ".uploadFile", function() {
		var uploadFile = $(this);
		var files = !!this.files ? this.files : [];
		if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support

		if (/^image/.test(files[0].type)) { // only image file
			var reader = new FileReader(); // instance of the FileReader
			reader.readAsDataURL(files[0]); // read the local file

			reader.onloadend = function() { // set image data as background of div
				//alert(uploadFile.closest(".upimage").find('.imagePreview').length);
				uploadFile.closest(".imgUp").find('.imagePreview').css("background-image", "url(" + this.result + ")");
			}
		}

	});
});

//function to add new product
function clickSaveCategory() {
	var form = $('#form--upload')[0];
	var data = new FormData(form);

	// var listIdImage;
	// $(".image--product").each(function () {
	//     if ($(this).attr("data-id-image") != "" && $(this).attr("data-id-image") != null) {
	//         listIdImage += $(this).attr("data-id-image") + ";";
	//     }
	// });

	$.ajax({
		type: "POST",
		enctype: 'multipart/form-data',
		url: "/admin/add-update-category",
		data: data,
		processData: false, //prevent jQuery from automatically transforming the data into a query string
		contentType: false,
		cache: false,
		timeout: 600000,
		success: function(data) {
			alert("Thành công!");
			$(location).attr('href', "/admin/category");
		},
		error: function(e) {
			console.log("ERROR : ", e);
		}
	});
}

function loadDetailForEdit(idCategory) {
	$.ajax({
		url: "/admin/detail-category",
		type: "get",
		contentType: "application/json", //set data send to server is json
		data: { idCategory: idCategory },
		dataType: "json", //set data return is json
		success: function(result) {
			$('#id').val(result.category[0].id);
			$('#name').val(result.category[0].name);
			$('.img--avatar').css("background-image", "url(/upload/" + result.category[0].avatar + ")");
			$('#seo').val(result.category[0].seo);
			$('#description').val(result.category[0].description);
			if (result.category[0].status == true) {
				$('#status1').attr("checked", true);
			} else {
				$('#status2').attr("checked", true);
			}
			if (result.category[0].isHot == true) {
				$('#isHot1').attr("checked", true);
			} else {
				$('#isHot2').attr("checked", true);
			}
		},
		error: function(jqXhr, textStatus, errorMessage) {
			//show error
		}
	});
}