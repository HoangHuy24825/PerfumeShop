<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- SPRING FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<span%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<div%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		<!doctype html>
		<html lang="zxx">

		<head>
			<!-- Required meta tags -->
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
			<title>Sản phẩm | ${tileWebsite}</title>
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

										<div class="front-stars">
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
									<div class="my-cart border rounded-circle detail-order"
										title="Thêm sản phẩm vào giỏ" id="addProductToCart">
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
						<li class="nav-item">
							<a class="nav-link" id="review-tab" data-toggle="tab" href="#review" role="tab"
								aria-controls="review" aria-selected="false">Đánh giá sản phẩm</a>
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
						<div class="tab-pane fade " id="review" role="tabpanel" aria-labelledby="review-tab">
							<br><br>
							<div class="row">
								<div class="col-lg-6">
									<div class="row total_rate">
										<div class="col-12">
											<div class="box_total">
												<div class="d-flex flex-row justify-content-center">
													<div class="border-right border-danger pr-5">
														<h5 class="text-center">Đánh giá chung</h5>
														<br>
														<div class="star-rating" title="">
															<div class="back-stars" style="font-size: 42px">
																<i class="fa fa-star" aria-hidden="true"></i>
																<i class="fa fa-star" aria-hidden="true"></i>
																<i class="fa fa-star" aria-hidden="true"></i>
																<i class="fa fa-star" aria-hidden="true"></i>
																<i class="fa fa-star" aria-hidden="true"></i>

																<div class="front-stars">
																	<i class="fa fa-star" aria-hidden="true"></i>
																	<i class="fa fa-star" aria-hidden="true"></i>
																	<i class="fa fa-star" aria-hidden="true"></i>
																	<i class="fa fa-star" aria-hidden="true"></i>
																	<i class="fa fa-star" aria-hidden="true"></i>
																</div>
															</div>
														</div>
														<br>
														<h3 class="text-danger text-center rating-title">5 trên 5</h3>
													</div>
													<div class="pl-5">
														<div class="rating_list">
															<h5>Tổng quan</h5>
															<br />
															<ul class="list">
																<li>
																	<a href="#">5 / 5
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-warning"></i> <span
																			id="numstar5"> ( 01 ) </span></a>
																</li>
																<li>
																	<a href="#">4 / 5
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-secondary"></i> <span
																			id="numstar4"> ( 02 ) </span></a>
																</li>
																<li>
																	<a href="#">3 / 5
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-secondary"></i>
																		<i class="fa fa-star text-secondary"></i> <span
																			id="numstar3"> ( 03 ) </span></a>
																</li>
																<li>
																	<a href="#">2 / 5
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-secondary"></i>
																		<i class="fa fa-star text-secondary"></i>
																		<i class="fa fa-star text-secondary"></i> <span
																			id="numstar2"> ( 01 ) </span></a>
																</li>
																<li>
																	<a href="#">1 / 5
																		<i class="fa fa-star text-warning"></i>
																		<i class="fa fa-star text-secondary"></i>
																		<i class="fa fa-star text-secondary"></i>
																		<i class="fa fa-star text-secondary"></i>
																		<i class="fa fa-star text-secondary"></i> <span
																			id="numstar1"> ( 01 ) </span></a>
																</li>
															</ul>
														</div>
													</div>
												</div>

											</div>

										</div>

									</div>
									<br>

								</div>
								<div class="col-lg-6">
									<div class="review_box">
										<h4>Đánh giá sản phẩm</h4>
										<p>Mức độ hài lòng:</p>
										<div class="list p-0">
											<div class="container p-0">
												<div
													class="starrating risingstar d-flex justify-content-center flex-row-reverse">
													<input type="radio" id="star5" name="rating" class="rating-star"
														value="5" /><label for="star5" title="5 star"></label>
													<input type="radio" id="star4" name="rating" class="rating-star"
														value="4" /><label for="star4" title="4 star"></label>
													<input type="radio" id="star3" name="rating" class="rating-star"
														value="3" /><label for="star3" title="3 star"></label>
													<input type="radio" id="star2" name="rating" class="rating-star"
														value="2" /><label for="star2" title="2 star"></label>
													<input type="radio" id="star1" name="rating" class="rating-star"
														value="1" /><label for="star1" title="1 star"></label>
												</div>
											</div>
										</div>
										<br>

										<div class="row">
											<div class="col">
												<div style="color:red" id="errMsgReview" class="my-2 px-2"></div>
												<form method="post" id="formReview" enctype="multipart/form-data">
													<div class="col-md-12">
														<div class="form-group">
															<input type="${isLogined?'hidden':'text'}"
																class="form-control" name="customerName"
																placeholder="Họ và tên"></input>
														</div>
														<div class="form-group">
															<input type="${isLogined?'hidden':'email'}"
																class="form-control" name="customerEmail"
																placeholder="Email"></input>
														</div>
														<div class="form-group">
															<input type="${isLogined?'hidden':'number'}"
																class="form-control" name="customerPhone"
																placeholder="Số điện thoại"></input>
														</div>
														<div class="form-group">
															<textarea class="form-control" name="content" rows="6"
																placeholder="Đánh giả về sản phẩm ..."></textarea>
														</div>
													</div>
													<div class="col-md-12 text-right">
														<button type="submit" id="btnReviewProduct" class="btn_3">
															Gửi đánh giá
														</button>
													</div>
											</div>
											</form>
										</div>
									</div>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col">
									<div class="review_list">

										<!-- show list review -->

									</div>
								</div>
							</div>
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