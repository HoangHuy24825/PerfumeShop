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
	<!--================Single Product Area =================-->
	<div class="product_image_area mt-3">
		<div class="container bg-white p-4">
			<div class="row s_product_inner justify-content-between">
				<div class="col-lg-7 col-xl-7">
					<div class="product_slider_img" id="img--product">
						<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
							<ol class="carousel-indicators" id="ol-img-slide">
								<!-- <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
							    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
							    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
							    <li data-target="#carouselExampleIndicators" data-slide-to="3"></li> -->
							</ol>
							<div class="carousel-inner" id="img-slide">
								<!--  <div class="carousel-item active">
							      	<img class="d-block w-100" src="..." alt="First slide">
							    </div>
							    <div class="carousel-item">
							      	<img class="d-block w-100" src="..." alt="Second slide">
							    </div>
							    <div class="carousel-item">
							      	<img class="d-block w-100"  src="..." alt="Third slide">
							    </div>
							    <div class="carousel-item">
							      	<img class="d-block w-100" src="..." alt="Four slide">
							    </div> -->
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
				<div class="col-md-5 col-xl-4">
					<div class="s_product_text">
						<h3 id="name-product">

							<!-- product name -->

						</h3>
						<input type="hidden" id="id_detail_product" name="custId" value="${id_product}">
						<h2 id="price-product">

							<!-- product price -->

						</h2>
						<table id="table-product-detail">
							<tr>
								<td>Model:</td>
								<td id="model-product">

									<!-- product model -->

								</td>
							</tr>
							<tr>
								<td>Bảo hành:</td>
								<td id="guarantee-product">

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
								<td>Trạng thái:</td>
								<td id="status-product">

									<!-- product status -->

								</td>
							</tr>
						</table>
						<p id="short-description-product">

							<!-- product short description -->

						</p>
						<div class="card_area d-flex justify-content-between align-items-center">
							<div class="product_count">
								<span class="detail-order" onclick="checkValidAmount('decrease')"><i
										class="ti-minus"></i></span>
								<input class="input-number" onkeyup="checkValidAmountInput()"
									onkeypress="return isNumberKey(event)" onfocusout="checkValidOutFocus()"
									id="numberProductOrder" data-id-product="" data-amount-product="" type="text"
									value="1" min="1" max="">
								<span class="detail-order" onclick="checkValidAmount('increase')"> <i
										class="ti-plus"></i></span>
							</div>
							<div class="my-cart border rounded-circle detail-order" title="Thêm sản phẩm vào giỏ"
								id="add-product-to-cart">
								<i class="fas fa-shopping-cart"></i>
							</div>
							<div class="btn_3" id="buy-now">Mua ngay</div>
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
				<div class="tab-pane fade show active" id="deteal-product" role="tabpanel" aria-labelledby="home-tab">
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
	<script src="${base }/user/script/product/detail.js"></script>
</body>

</html>