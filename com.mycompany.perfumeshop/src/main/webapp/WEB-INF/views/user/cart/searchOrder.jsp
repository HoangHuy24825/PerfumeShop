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
	<title>Hóa đơn | ${tileWebsite}</title>
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

	<!-- Pay part start-->
	<div class="container mt-3 p-4 bg-white">
		<div class="row">
			<div class="col-md-12">
				<h2 style="text-align: center;" class="m-b-5">Nhập thông tin khách hàng</h2>
				<form class="mt-5" id="formSearchOrder" method="post">
					<div class="form-row">
						<div class="form-group col-md-4">
							<label for="inputPassword4">Họ tên khách hàng</label>
							<input type="text" class="form-control" id="customerName" name="name"
								placeholder="Họ tên khách hàng">
						</div>
						<div class="form-group col-md-4">
							<label for="inputEmail4">Email</label>
							<input type="email" class="form-control" id="customerEmail" name="email"
								placeholder="Email">
						</div>
						<div class="form-group col-md-4">
							<label for="inputPassword4">Số điện thoại</label>
							<input type="number" class="form-control" name="phone" placeholder="Số điện thoại">
						</div>
					</div>
					<button type="post" style="float:right" id="btnSearchOrder" class="btn btn-primary">Tìm
						kiếm</button>
				</form>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div id="my-order" class="container tab-pane">
					<br>
					<h3>Thông tin đơn hàng</h3>
					<br>
					<hr>
					<div id="newBill">

					</div>
					<div>
						<table class="table table-striped">
							<thead>
								<tr>
									<th scope="col">Mã đơn hàng</th>
									<th scope="col">Ngày mua</th>
									<th scope="col">Sản phẩm</th>
									<th scope="col">Tổng tiền</th>
									<th scope="col">Trạng thái</th>
								</tr>
							</thead>
							<tbody id="oldBill">

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Pay part end-->

	<!--::message to client part start::-->
	<jsp:include page="/WEB-INF/views/user/layout/modal-cancel-order.jsp"></jsp:include>
	<!-- Message to client part end-->

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
	<script src="${base }/user/script/cart/search-order.js"></script>
</body>

</html>