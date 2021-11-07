var editor = '';
$(document).ready(function () {
	editor = CKEDITOR.replace('detail', {
		width: ['100%'],
		height: ['400px']
	});

	loadProduct(); //load data to select category for product

	var id_product = $('#id').val();
	if (id_product != null && id_product != "") {
		loadDetailForEdit(id_product);
		$("#title-page-add-update").text("Cập nhật sản phẩm");
	}
	setActiveMenu();

	$("body").on("click", ".btn-add-attribute", function (e) {
		e.preventDefault();
		var html = `<div class="item-attribute row col-12">
                        <input name="idAttribute" id="idAttribute" type="number" hidden="true" value="" />

                        <div class="form-group col-3">
                            <label for="capacity" class="font-weight-bold">Dung tích <span
                                    class="required">*</span></label>
                            <input type="number" autocomplete="off" class="form-control" id="capacity" name="capacity"
                                placeholder="Dung tích"></input>
                        </div>

                        <div class="form-group col-3">
                            <label for="price" class="font-weight-bold">Giá <span class="required">*</span></label>
                            <input type="number" autocomplete="off" class="form-control" id="price" name="price"
                                placeholder="Giá sản phẩm" required="required"></input>
                        </div>

                        <div class="form-group col-3">
                            <label for="priceSale" class="font-weight-bold">Giảm giá <span
                                    class="required">*</span></label>
                            <input type="number" autocomplete="off" class="form-control" id="priceSale" name="priceSale"
                                placeholder="Giảm giá"></input>
                        </div>

                        <div class="form-group col-3">
                            <label for="amount" class="font-weight-bold">Số lượng <span
                                    class="required">*</span></label>
                            <input type="number" autocomplete="off" class="form-control" id="amount" name="amount"
                                placeholder="Số lượng"></input>
                        </div>

                        <div class="btn-delete-attribute"><i class="fas fa-times"></i></div>
                     </div>`;
		$(".detail-attribute-card").append(html);
	});

	$("body").on("click", ".btn-delete-attribute", function (e) {
		if ($(".item-attribute").length > 1) {
			$(this).closest(".item-attribute").remove();
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
	$('.list-unstyled #menu--product').addClass("active");
	$('.navbar__list #menu--product').addClass("active");
}

// function to add imput image product
$(".imgAdd").click(function () {
	$(this).closest(".row").find('.imgAdd').before(
		'<div class="col-sm-2 imgUp"><div class="imagePreview image--product" data-id-image=""></div><label class="btn btn-primary btn--upload-image">Upload<input type="file" class="uploadFile img" name="images" accept="image/png, image/jpeg, image/jpg" style="width:0px;height:0px;overflow:hidden;"></label><i class="fa fa-times del"></i></div>'
	);
});

$(document).on("click", "i.del", function () {
	$(this).parent().remove();
});

//function to add preview image
$(function () {
	$(document).on("change", ".uploadFile", function () {
		var uploadFile = $(this);
		var files = !!this.files ? this.files : [];
		if (!files.length || !window.FileReader)
			return; // no file selected, or no FileReader support

		if (/^image/.test(files[0].type)) { // only image file
			var reader = new FileReader(); // instance of the FileReader
			reader.readAsDataURL(files[0]); // read the local file

			reader.onloadend = function () { // set image data as background of div
				//alert(uploadFile.closest(".upimage").find('.imagePreview').length);
				uploadFile.closest(".imgUp").find('.imagePreview').css("background-image",
					"url(" + this.result + ")");
			}
		}

	});
});

//function to add new product
function saveOrUpdate() {
	var form = $('#formDetailProduct')[0];
	var data = new FormData(form);
	var detailCkEditor = editor.getData();
	data.append('detail', detailCkEditor);

	$.ajax({
		type: "POST",
		enctype: 'multipart/form-data',
		url: "/admin/add-update-product",
		data: data,
		processData: false, //prevent jQuery from automatically transforming the data into a query string
		contentType: false,
		cache: false,
		timeout: 600000,
		success: function (data) {
			alert("Thành công!");
			$(location).attr('href', "/admin/product");
		},
		error: function (e) {
			console.log("ERROR : ", e);
		}
	});
}

//function to add category for selecting
function loadProduct() {
	$.ajax({
		url: "/admin/all-category-active",
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

function loadDetailForEdit(id_product) {
	$.ajax({
		url: "/admin/detail-product",
		type: "get",
		contentType: "application/json", //set data send to server is json
		data: {
			idProduct: id_product
		},
		dataType: "json", //set data return is json
		success: function (result) {

			$('#id').val(result.product[0].id);
			$('#title').val(result.product[0].title);
			$('#select-category').val(result.product[0].id_category);
			$('.img--avatar').css("background-image", "url(/upload/" + result.product[0].avatar +
				")");
			$('#price').val(result.product[0].price);
			$('#priceSale').val(result.product[0].priceSale);
			$('#seo').val(result.product[0].seo);
			$('#description').val(result.product[0].description);

			$('#model').val(result.product[0].model);
			$('#origin').val(result.product[0].origin);
			$('#guarantee').val(result.product[0].guarantee);
			$('#amount').val(result.product[0].amount);

			editor.setData(result.product[0].detail);

			if (result.product[0].status == true) {
				$('#status1').attr("checked", true);
			} else {
				$('#status2').attr("checked", true);
			}

			if (result.product[0].isHot == true) {
				$('#isHot1').attr("checked", true);
			} else {
				$('#isHot2').attr("checked", true);
			}

			$('i.del').parent().remove();

			$.each(result.productImages, function (index, value) {
				$(".imgAdd").closest(".row").find('.imgAdd').before(
					'<div class="col-sm-2 imgUp"><div class="imagePreview image--product" data-id-image="" ></div><label class="btn btn-primary btn--upload-image">Upload<input type="file" class="uploadFile img" name="images" accept="image/png, image/jpeg, image/jpg" style="width:0px;height:0px;overflow:hidden;"></label><i class="fa fa-times del"></i></div>'
				);
				$(".image--product").last().css("background-image", "url(/upload/" + value
					.path + value.title + ")");
				$(".image--product").last().attr("data-id-image", value.id);
			});
		},
		error: function (jqXhr, textStatus, errorMessage) {
			//show error
		}
	});


}