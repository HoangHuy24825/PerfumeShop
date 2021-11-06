<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!-- SPRING FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="zxx">

<head>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Sản phẩm | Electronic Device</title>
	<link rel="icon" href="${base }/user/img/my-logo/logo-asp.net.png">
	<!--::style part start::-->
	<jsp:include page="/WEB-INF/views/user/layout/style.jsp"></jsp:include>
	<!--::style part end::-->
</head>

<body>
	<!--::header part start::-->
	<jsp:include page="/WEB-INF/views/user/layout/header.jsp"></jsp:include>
	<!-- Header part end-->

	<!--================Home Banner Area =================-->
	<!-- breadcrumb start-->
	<jsp:include page="/WEB-INF/views/user/layout/banner.jsp"></jsp:include>
	<!-- breadcrumb start-->

	<!--================Category Product Area =================-->
	<section class="cat_product_area mt-3">
		<div class="container bg-white p-4">
			<div class="row">
				<div class="col-lg-3">
					<div class="left_sidebar_area">
						<aside class="left_widgets p_filter_widgets">
							<input hidden="true" value="${idCategory}" id="idCategoryLoad">
							<div class="l_w_title bg-warning">
								<h3>Danh mục sản phẩm</h3>
							</div>
							<div class="widgets_inner" style="padding-right:5px;padding-left:5px">
								<table class="table-categoty" id="table-category">
									<tr style="height:50px;" class="rounded-5 row-left-sidebar" id="">
										<td width="50px">
											<img src="${base }/user/img/logo_all.png"
												style="width: 20px; height: 20px; padding: 2px;" />
										</td>
										<td>Tất cả các sản phẩm</td>
									</tr>
									<c:forEach var="category" items="${categories }">
										<tr style="height:50px;" class="rounded-5 row-left-sidebar"
											id="${category.id }">
											<td width="50px">
												<img src="${base }/upload/${category.avatar}" alt="${category.name}"
													style="width: 20px;height: 20px;" />
											</td>
											<td>${category.name}</td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</aside>

					</div>
				</div>
				<div class="col-lg-9">
					<div class="row">
						<div class="col-lg-12">
							<div class="product_top_bar d-flex justify-content-between align-items-center">
								<div class="single_product_menu d-flex">
									<div class="input-group">
										<h5 class="my-auto" style="color: #495057; text-transform:none">Sắp xếp theo:
										</h5>
										<select class="m-1" id="orderBy" style="">
											<option value="0">Lựa chọn tiêu chí lọc</option>
											<option value="1">Giá tăng dần</option>
											<option value="2">Giá giảm dần</option>
										</select>
									</div>
								</div>
								<div class="single_product_menu d-flex">
									<div class="input-group">
										<h5 class="my-auto" style="color: #495057; text-transform:none">Giá: </h5>
										<select class="m-1" id="filterBy" style="">
											<option value="0">Giá</option>
											<option value="1">Từ 1-3 triệu</option>
											<option value="2">Từ 3-5 triệu</option>
											<option value="3">Từ 5-7 triệu</option>
											<option value="4">Từ 7-12 triệu</option>
											<option value="5">Trên 12 triệu</option>
										</select>
									</div>
								</div>
								<div class="single_product_menu d-flex">
									<div class="input-group" id="input-group-search">
										<input type="text" class="form-control" placeholder="Tìm kiếm"
											aria-describedby="inputGroupPrepend" id="searchStr" value="${searchKey}">
										<div class="input-group-prepend" id="search">
											<span class="input-group-text" id="inputGroupPrepend">
												<i class="ti-search"></i>
											</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="row align-items-center latest_product_inner" id="product-container">

						<!-- product list -->

					</div>
					<div class="col-lg-12">
						<div class="pageination">
							<nav aria-label="Page navigation example">
								<ul class="pagination justify-content-center" id="load-pagination">

									<!-- pagination -->

								</ul>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================End Category Product Area =================-->

	<!--::footer_part start::-->
	<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
	<!--::footer_part end::-->

	<!--::message_part start::-->
	<div class="alert hide" id="alert_message">
		<div id="icon-alert-message"><i class="fas fa-exclamation-circle"></i></div>
		<span class="msg">Warning: This is a warning alert!</span>
		<div class="close-btn-alert">
			<span class="fas fa-times"></span>
		</div>
	</div>
	<!--::message_part end::-->

	<!-- jquery plugins here-->
	<jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
	<script type="text/javascript">
		$(document).ready(function () {
			setMenuBanner();
			$("#orderBy").val("0");
			$("#filterBy").val("0");
			$('.close-btn-alert').click(function () {
				$('.alert').removeClass("show");
				$('.alert').addClass("hide");
			});
			$("#orderBy").css({
				"display": "block"
			});
			$("#searchStr").val("");
			$("#filterBy").css({
				"display": "block"
			});
			//load init

			var idCategoryLoad = $("#idCategoryLoad").val();
			if (idCategoryLoad != 0) {
				loadData(null, 1, idCategoryLoad, null, null);
				$("#table-category #" + idCategoryLoad).addClass('chosed');
				$("#table-category #" + idCategoryLoad).addClass('selected-category');
				var title = $("#table-category #" + idCategoryLoad).children('td:nth-child(2)').text();
				$('#title-banner').find('h2').html("Danh mục sản phẩm");
				$('#title-banner').find('p').html("Trang chủ > " + title);
			} else {
				loadData(null, 1, null, null, null);
			}
		});

		function setMenuBanner() {
			var titlebanner = '';
			$("#img-banner").html('<img src="${base}/user/img/my-image/banner/product1.png" alt="" width="560">');
			titlebanner += '<h2>Sản phẩm</h2>';
			titlebanner += '<p> Trang chủ <span>></span> Sản phẩm </p>';
			$("#title-banner").html(titlebanner);

			$("#mainNav li").each(function (index) {
				$(this).removeClass("my-menu-active");
			});

			$("#menu-product").addClass("my-menu-active");
		}

		function loadData(searchStr, page, id_category, typeOrder, filterType) {
			$.ajax({
				url: "/all-product",
				type: "GET",
				data: {
					searchStr: searchStr,
					page: page,
					id_category: id_category,
					typeOrder: typeOrder,
					filterType: filterType
				},
				dataType: "json",
				contentType: "application/json;charset=utf-8",
				success: function (result) {
					var html = '';
					if (result == null) {
						$("#product-container").html(`<h4 class="text-primary">Lỗi kết nối cơ sở dữ liệu</h4>`);
						return;
					}
					if ((result.products.length == 0 || result.products == null) && searchStr != null &&
						searchStr != "") {
						html += `<div style="margin:auto">
									<img src="${base}/user/img/notFoundProduct.png" width="300" style="margin:auto"/>
									<br/>
									<p style="text-align:center; margin: 25px 0px 30px;">Không tìm thấy sản phẩm phù hợp!</p>
								</div>`;
						$("#load-pagination").html("");
					} else if ((result.products.length == 0 || result.products == null) && id_category != null &&
						id_category != "") {
						html += `<div style="margin:auto">
									<img src="${base}/user/img/notFoundProduct.png" width="300" style="margin:auto"/>
									<br/>
									<p style="text-align:center; margin: 25px 0px 30px;">Không có sản phẩm nào trong danh mục!</p>
								</div>`;
						$("#load-pagination").html("");
					} else {
						$.each(result.products, function (index, item) {
							html += `<div class="col-lg-4 col-sm-6 box-single-product" onclick = "detail(${item.id})">
										<input type="hidden" id="view_${item.id}" name="custId" value="${item.seo}">
										<div class="single_product_item">
											<img class="img-product" src="/upload/${item.avatar}"  alt="">
											<div class="single_product_text">
												<h4>${item.title}</h4>
												<h3>${item.price.toLocaleString('it-IT', {style: 'currency',currency: 'VND'})} </h3>
												<div class="my-cart border rounded-circle" title="Thêm sản phẩm vào giỏ" 
													onclick="event.stopPropagation();addProductToCart(${item.id})">
												<i class="fas fa-shopping-cart"></i>
											</div>
										</div>
									</div>
								</div>`;
						});
						//create pagination
						var pagination_string = "";
						var currentPage = result.currentPage;
						var totalPage = result.totalPage;


						if (currentPage > 1) {
							var previousPage = currentPage - 1;
							pagination_string += `<li class="page-item">
													<a href="" class="page-link" data-page="${previousPage}">
														<i class="fas fa-angle-double-left" style="font-size:18px"></i>
													</a>
												</li>`;
						}

						for (i = 1; i <= totalPage; i++) {
							if (i == currentPage) {
								pagination_string +=`<li class="page-item active">
														<a href="" class="page-link" data-page=${i}>${currentPage}</a>
													</li>`;
							} else if (i >= currentPage - 3 && i <= currentPage + 4) {
								pagination_string +=`<li class="page-item">
														<a href="" class="page-link" data-page=${i}>${i}</a>
													</li>`;
							}
						}

						if (currentPage > 0 && currentPage < totalPage) {
							var nextPage = currentPage + 1;
							pagination_string +=`<li class="page-item">
													<a href="" class="page-link"  data-page=${nextPage}>
														<i class="fas fa-angle-double-right" style="font-size:18px"></i>
													</a>
												</li>`;
						}
						$("#load-pagination").html(pagination_string);
					}
					$("#product-container").html(html);
				}

			});
		}

		function showAlertMessage(message, messageState) {
			if (messageState) {
				$('#alert_message').css({
					"background": "#C5F3D7",
					"border-left": "8px solid #2BD971"
				});
				$("#icon-alert-message").html('<i class="fas fa-check-circle"></i>');
				$("#icon-alert-message").find('i').css({
					"color": "#2BD971"
				});
				$(".msg").css({
					"color": "#24AD5F"
				});
				$(".close-btn-alert").css({
					"background": "#2BD971",
					"color": "#24AD5F"
				});
				$(".close-btn-alert").find('.fas').css({
					"color": "#24AD5F"
				});
				$(".close-btn-alert").hover(function (e) {
					$(this).css("background-color", e.type === "mouseenter" ? "#38F5A3" : "#2BD971")
				})
			} else {
				$('#alert_message').css({
					"background": "#FFE1E3",
					"border-left": "8px solid #FF4456"
				});
				$("#icon-alert-message").html('<i class="fas fa-exclamation-circle"></i>');
				$("#icon-alert-message").find('i').css({
					"color": "#FE4950"
				});
				$(".msg").css({
					"color": "#F694A9"
				});
				$(".close-btn-alert").css({
					"background": "#FF9CA4",
					"color": "#FD4653"
				});
				$(".close-btn-alert").find('.fas').css({
					"color": "#FD4653"
				});
				$(".close-btn-alert").hover(function (e) {
					$(this).css("background-color", e.type === "mouseenter" ? "#FFBDC2" : "#FF9CA4")
				})
			}

			$('.msg').text(message);
			$('.alert').addClass("show");
			$('.alert').removeClass("hide");
			$('.alert').addClass("showAlert");
			setTimeout(function () {
				$('.alert').removeClass("show");
				$('.alert').addClass("hide");
			}, 3000);
		};

		function detail(id_product) {
			window.location.href = '/detail-product/' + $('#view_' + id_product).val();
		};

		function addProductToCart(id_product) {
			let data = {
				productId: id_product,
				quanlity: 1
			}
			$.ajax({
				url: "/cart/add",
				type: "post",
				data: JSON.stringify(data),
				dataType: "json",
				contentType: "application/json",
				success: function (jsonResult) {
					showAlertMessage("Thêm vào giỏ hàng thành công!", true);
					$('#icon-cart-header').find($('#amount_cart')).text(jsonResult.totalItems);
				},
				error: function (jqXhr, textStatus, errorMessage) {
					showAlertMessage("Không thêm được sản phẩm vào giỏ hàng!", false);
				}
			});
		}

		$("#orderBy").change(function () {
			var txtSearch = $("#searchStr").val();
			var orderType = $("#orderBy").val();
			var filterType = $("#filterBy").val();
			var id_category = $('.table-categoty').find('.chosed').attr('id');
			if (orderType != 0) {
				loadData(txtSearch, 1, id_category, orderType, filterType);
			} else {
				loadData(txtSearch, 1, id_category, null, filterType);
			}
		});

		$("#filterBy").change(function () {
			var txtSearch = $("#searchStr").val();
			var orderType = $("#orderBy").val();
			var filterType = $("#filterBy").val();
			var id_category = $('.table-categoty').find('.chosed').attr('id');
			if (filterType != 0) {
				loadData(txtSearch, 1, id_category, orderType, filterType);
			} else {
				loadData(txtSearch, 1, id_category, orderType, null);
			}
		});

		$('.row-left-sidebar').click(function () {
			$("#orderBy").val("0");
			$("#filterBy").val("0");
			$('#searchStr').val("");

			$('.table-categoty').find('.selected-category').removeClass('selected-category');
			$('.table-categoty').find('.chosed').removeClass('chosed');

			var id_category = $(this).attr('id');
			loadData(null, 1, id_category, null, null);
			$(this).addClass('chosed');
			$(this).addClass('selected-category');
			var title = $(this).children('td:nth-child(2)').text();
			$('#title-banner').find('h2').html("Danh mục sản phẩm");
			$('#title-banner').find('p').html("Trang chủ > " + title);
		});

		$("body").on("click", ".pagination li a", function (event) {
			event.preventDefault();
			var page = $(this).attr('data-page');
			var id_category = $('.table-categoty').find('.chosed').attr('id');

			var txtSearch = $("#searchStr").val();
			if (txtSearch != "") {
				loadData(txtSearch, page, id_category, $("#orderBy").val(), $("#filterBy").val());
			} else {
				loadData(null, page, id_category, $("#orderBy").val(), $("#filterBy").val());
			}

		});

		$("#search").click(function () {
			$("#orderBy").val("0");
			$("#filterBy").val("0");
			$('.table-categoty').find('.selected-category').removeClass('selected-category');
			var txtSearch = $("#searchStr").val();
			if (txtSearch != "") {
				loadData(txtSearch, 1, null, null, null);
			} else {
				loadData(null, 1, null, null, null);
			}
		});

		$("#searchStr").keyup(function (event) {
			$("#orderBy").val("0");
			$("#filterBy").val("0");
			$('#search').click();
		});



		function loadNewProduct() {
			console.log("load new product");
			$.ajax({
				url: "/new-product",
				type: "GET",
				data: {},
				dataType: "json",
				contentType: "application/json",
				success: function (jsonResult) {
					var html = '';
					$.each(jsonResult, function (index, value) {
						html += '<div class="single_product_item" >';
						html += '     <img class="img-product" src="/upload/' + value.avatar + '" alt="' +
							value.title + '">';
						html += '     <div class="single_product_text">';
						html += '         <h4>' + value.title + '</h4>';
						html += '         <h3>' + value.price.toLocaleString('it-IT', {
							style: 'currency',
							currency: 'VND'
						}) + '</h3>';
						html +=
							'         <div class="my-cart border rounded-circle" title="Thêm sản phẩm vào giỏ">';
						html += '             <i class="fas fa-shopping-cart"></i>';
						html += '         </div>';
						html += '     </div>';
						html += ' </div>';
					});
					$('#list-new-product').html(html);
				},
				error: function (jqXhr, textStatus, errorMessage) {
					console.log(errorMessage);
				}
			});
		}
	</script>
	<!--::footer_part end::-->
</body>

</html>