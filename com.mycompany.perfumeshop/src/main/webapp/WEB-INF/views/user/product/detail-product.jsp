<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- SPRING FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
		<!--================Single Product Area =================-->
		<div class="product_image_area mt-3">
			<div class="container bg-white p-4">
				<div class="row s_product_inner justify-content-between">
					<div class="col-7 col-xl-7">
						<div class="product_slider_img" id="img--product">
							<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel"
								data-interval="2000">
								<ol class="carousel-indicators" id="ol-img-slide">

								</ol>
								<div class="carousel-inner" id="img-slide">

								</div>
								<a class="carousel-control-prev button--slider-image-detail"
									href="#carouselExampleIndicators" role="button" data-slide="prev">
									<i class="fa fa-chevron-left" aria-hidden="true"></i>
									<!-- <i class="carousel-control-prev-icon" aria-hidden="true"></i> -->
									<span class="sr-only">Previous</span>
								</a>
								<a class="carousel-control-next button--slider-image-detail"
									href="#carouselExampleIndicators" role="button" data-slide="next">
									<i class="fa fa-chevron-right" aria-hidden="true"></i>
									<!-- <i class="carousel-control-next-icon" aria-hidden="true"></i> -->
									<span class="sr-only">Next</span>
								</a>
							</div>
						</div>
					</div>
					<div class="col-5 col-xl-5">
						<div class="s_product_text">
							<h3 id="name-product">

								<!-- product name -->

							</h3>
							<input type="hidden" id="id_detail_product" value="${id_product}">


							<div class="star-rating" title="">
								<div class="back-stars">
									<i class="fa fa-star" aria-hidden="true"></i>
									<i class="fa fa-star" aria-hidden="true"></i>
									<i class="fa fa-star" aria-hidden="true"></i>
									<i class="fa fa-star" aria-hidden="true"></i>
									<i class="fa fa-star" aria-hidden="true"></i>

									<div class="front-stars" >
										<i class="fa fa-star" aria-hidden="true"></i>
										<i class="fa fa-star" aria-hidden="true"></i>
										<i class="fa fa-star" aria-hidden="true"></i>
										<i class="fa fa-star" aria-hidden="true"></i>
										<i class="fa fa-star" aria-hidden="true"></i>
									</div>
								</div>
								<div class="rating-title ml-3" style="font-size: 11px"></div>
							</div>




							<table id="table-product-detail">
								<tr>
									<td>Thương hiệu:</td>
									<td id="trademark-product">

										<!-- product model -->

									</td>
								</tr>
								<tr>
									<td>Năm phát hành:</td>
									<td id="manufactureYear-product">

										<!-- product guarantee -->

									</td>
								</tr>
								<tr>
									<td>Xuất xứ:</td>
									<td id="origin-product">

										<!-- product origin -->

									</td>
								</tr>
								<tr>
									<td>Mùi hương:</td>
									<td id="fragrant-product">

										<!-- product status -->

									</td>
								</tr>
							</table>

							<div class="row chose-capacity-container">

							</div>

							<p id="short-description-product">

								<!-- product short description -->

							</p>
							<hr />
							<div id="priceProductCurrent">
								<table id="table-product-detail">
									<!-- product short description -->
								</table>
							</div>
							<hr />
							<div class="card_area d-flex justify-content-between align-items-center">
								<div class="product_count">
									<span class="detail-order" onclick="checkValidAmount('decrease')"><i
											class="ti-minus"></i></span>
									<input class="input-number" onkeyup="checkValidAmountInput()"
										onkeypress="return isNumberKey(event)" onfocusout="checkValidOutFocus()"
										id="numberProductOrder" data-id-product="" data-max-order="" type="text"
										value="1" min="1" max="">
									<span class="detail-order" onclick="checkValidAmount('increase')"> <i
											class="ti-plus"></i></span>
								</div>
								<div class="my-cart border rounded-circle detail-order" title="Thêm sản phẩm vào giỏ"
									id="addProductToCart">
									<i class="fas fa-shopping-cart"></i>
								</div>
								<div class="btn_3" id="buyNow">Mua ngay</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--================End Single Product Area =================-->
		<!--================Product Description Area =================-->
		<section class="mt-3">
			<div class="container bg-white p-4">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item">
						<a class="nav-link active" id="home-tab" data-toggle="tab" href="#deteal-product" role="tab"
							aria-controls="home" aria-selected="true">Thông tin sản phẩm</a>
					</li>
				</ul>
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="deteal-product" role="tabpanel"
						aria-labelledby="home-tab">
						<br><br>
						<p id="detail-product">

							<!-- product detail -->

						</p>
					</div>
				</div>
			</div>
		</section>

		<!--================End Product Description Area =================-->

		<!-- product_list part start-->
		<jsp:include page="/WEB-INF/views/user/layout/new-product.jsp"></jsp:include>
		<!-- product_list part end-->

		<!--::footer_part start::-->
		<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
		<!--::footer_part end::-->

		<!--::message to client part start::-->
		<jsp:include page="/WEB-INF/views/user/layout/message-to-user.jsp"></jsp:include>
		<!-- Message to client part end-->

		<!-- jquery plugins here-->
		<jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
		<script src="${base }/user/script/product/detail.js"></script>
		<script src="${base }/user/script/baseScript/rating-script.js"></script>
	</body>

	</html>