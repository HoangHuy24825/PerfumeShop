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

	<!--::message to client part start::-->
	<jsp:include page="/WEB-INF/views/user/layout/message-to-user.jsp"></jsp:include>
	<!-- Message to client part end-->

	<!-- jquery plugins here-->
	<jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
	<script src="${base }/user/script/product/listProduct.js"></script>
	<!--::footer_part end::-->
	<script src="${base }/user/script/baseScript/rating-script.js"></script>
</body>

</html>