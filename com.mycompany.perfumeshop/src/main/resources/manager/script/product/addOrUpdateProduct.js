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
                        <input name="idAttribute" class="idAttribute" type="number" hidden="true" value="" />

                        <div class="form-group col-3">
                            <label for="capacity" class="font-weight-bold">Dung tích <span
                                    class="required">*</span></label>
                            <input type="number" autocomplete="off" class="form-control capacity" name="capacity"
                                placeholder="Dung tích"></input>
                        </div>

                        <div class="form-group col-3">
                            <label for="price" class="font-weight-bold">Giá <span class="required">*</span></label>
                            <input type="number" autocomplete="off" class="form-control price" name="price"
                                placeholder="Giá sản phẩm" required="required"></input>
                        </div>

                        <div class="form-group col-3">
                            <label for="priceSale" class="font-weight-bold">Giảm giá <span
                                    class="required">*</span></label>
                            <input type="number" autocomplete="off" class="form-control priceSale" name="priceSale"
                                placeholder="Giảm giá"></input>
                        </div>

                        <div class="form-group col-3">
                            <label for="amount" class="font-weight-bold">Số lượng <span
                                    class="required">*</span></label>
                            <input type="number" autocomplete="off" class="form-control amount" name="amount"
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
			if ($("#id").val() != null && $("#id").val() != "") {
				showAlertMessage("Cập nhật sản phẩm thành công!", true);
			} else {
				showAlertMessage("Thêm mới sản phẩm thành công!", true);
			}
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

			$('#id').val(result.product.id);
			$('#title').val(result.product.title);
			$('#select-category').val(result.product.id_category);
			$('.img--avatar').css("background-image", "url(/upload/" + result.product.avatar + ")");
			$('#description').val(result.product.description);
			$("#trademark").val(result.product.trademark);
			$('#manufactureYear').val(result.product.manufactureYear);
			$('#origin').val(result.product.origin);
			$('#fragrant').val(result.product.fragrant);
			editor.setData(result.product.detail);

			if (result.product.isHot == true) {
				$('#isHot1').attr("checked", true);
			} else {
				$('#isHot2').attr("checked", true);
			}

			if (result.product.status == true) {
				$("#status").attr("checked", true);
			} else {
				$("#status").attr("checked", false);
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

			var html = '';
			$.each(result.productAttrs, function (index, value) {
				html += `<div class="item-attribute row col-12">
                        <input name="idAttribute" class="idAttribute" type="number" hidden="true" value="${value.id}" />

                        <div class="form-group col-3">
                            <label for="capacity" class="font-weight-bold">Dung tích <span
                                    class="required">*</span></label>
                            <input type="number" autocomplete="off" class="form-control capacity" name="capacity"
                                placeholder="Dung tích" value="${value.capacity}"></input>
                        </div>

                        <div class="form-group col-3">
                            <label for="price" class="font-weight-bold">Giá <span class="required">*</span></label>
                            <input type="number" autocomplete="off" class="form-control price" name="price"
                                placeholder="Giá sản phẩm" required="required" value="${value.price}"></input>
                        </div>

                        <div class="form-group col-3">
                            <label for="priceSale" class="font-weight-bold">Giảm giá <span
                                    class="required">*</span></label>
                            <input type="number" autocomplete="off" class="form-control priceSale" name="priceSale"
                                placeholder="Giảm giá" value="${value.priceSale}"></input>
                        </div>

                        <div class="form-group col-3">
                            <label for="amount" class="font-weight-bold">Số lượng <span
                                    class="required">*</span></label>
                            <input type="number" autocomplete="off" class="form-control amount" name="amount"
                                placeholder="Số lượng" value="${value.amount}"></input>
                        </div>

                        <div class="btn-delete-attribute"><i class="fas fa-times"></i></div>
                     </div>`;
			});
			$(".detail-attribute-card").html(html);
		},
		error: function (jqXhr, textStatus, errorMessage) {
			//show error
		}
	});


}