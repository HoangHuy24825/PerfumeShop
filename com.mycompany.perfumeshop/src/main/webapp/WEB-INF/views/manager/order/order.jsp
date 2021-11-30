<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- SPRING FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<!DOCTYPE html>
<html lang="en">

<head>
	<!-- Required meta tags-->
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<!-- Title Page-->
	<title>Đơn hàng | ${tileWebsite}</title>
	<link rel="icon" href="${base}/manager/images/logo-asp.net.png">

	<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/manager/layout/style.jsp"></jsp:include>

</head>

<body class="">
	<div class="page-wrapper">
		<!-- HEADER MOBILE-->
		<jsp:include page="/WEB-INF/views/manager/layout/header_mobile.jsp"></jsp:include>
		<!-- END HEADER MOBILE-->

		<!-- MENU SIDEBAR-->
		<jsp:include page="/WEB-INF/views/manager/layout/left_sidebar.jsp"></jsp:include>
		<!-- END MENU SIDEBAR-->

		<!-- PAGE CONTAINER-->
		<div class="page-container">
			<!-- HEADER DESKTOP-->
			<jsp:include page="/WEB-INF/views/manager/layout/header.jsp"></jsp:include>
			<!-- HEADER DESKTOP-->

			<!-- MAIN CONTENT-->
			<div class="main-content">
				<div class="section__content section__content--p30">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12" id="content_page">
								<h3 class="title-5 m-b-35">Danh sách đơn hàng</h3>
								<input id="update_role" value="${orderRole.update}" type="text" style="display: none" />
								<input id="delete_role" value="${orderRole.delete}" type="text" style="display: none" />
								<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
									<li class="nav-item" role="presentation">
										<a class="nav-link active" id="new-orders-tab" data-toggle="pill"
											onclick="LoadNewOrder(1)" href="#pills-home" role="tab"
											aria-controls="pills-home" aria-selected="true">Đơn hàng mới</a>
									</li>
									<li class="nav-item" role="presentation">
										<a class="nav-link" id="pills-processing-tab" data-toggle="pill"
											onclick="LoadOrderProcess(1)" href="#pills-profile" role="tab"
											aria-controls="pills-profile" aria-selected="false">Đơn hàng đang xử lý</a>
									</li>
									<li class="nav-item" role="presentation">
										<a class="nav-link" id="pills-successful-tab" data-toggle="pill"
											onclick="LoadOrderSuccessOrDeleted(3,1)" href="#pills-contact" role="tab"
											aria-controls="pills-contact" aria-selected="false">Đơn hàng gửi thành
											công</a>
									</li>
									<li class="nav-item" role="presentation">
										<a class="nav-link" id="pills-delete-tab" data-toggle="pill"
											onclick="LoadOrderSuccessOrDeleted(4,1)" href="#pills-delete" role="tab"
											aria-controls="pills-contact" aria-selected="false">Đơn hàng đã hủy</a>
									</li>
								</ul>
								<div class="tab-content" id="pills-tabContent">
									<!--START TAB LIST NEW ORDER -->
									<div class="tab-pane fade show active" id="pills-home" role="tabpanel"
										aria-labelledby="new-orders-tab">
										<table class="table table-data2">
											<thead>
												<tr>
													<th>ID</th>
													<th>Mã đơn</th>
													<th>Người nhận</th>
													<th>Địa chỉ</th>
													<th>Tổng tiền</th>
													<th>Ngày đặt</th>
													<th>Hành động</th>
												</tr>
											</thead>
											<tbody id="newBill">
												<!-- List new order -->
											</tbody>
										</table>
										<div class="my-3">
											<nav aria-label="Page navigation example">
												<ul class="pagination justify-content-center "
													id="paged--list--new--order">
													<!-- paging -->
												</ul>
											</nav>
										</div>
									</div>
									<!--END TAB LIST NEW ORDER -->

									<!--START TAB LIST ORDER BE PROCESSING-->
									<div class="tab-pane fade" id="pills-profile" role="tabpanel"
										aria-labelledby="pills-processing-tab">
										<table class="table table-data2">
											<thead>
												<tr>
													<th>ID</th>
													<th>Mã đơn</th>
													<th>Người nhận</th>
													<th>Địa chỉ</th>
													<th>Tổng tiền</th>
													<th>Ngày đặt</th>
													<th>Ngày cập nhật</th>
													<c:if test="${orderRole.update ==true}">
														<th>Cập nhật trạng thái</th>
													</c:if>
													<th>Hành động</th>
												</tr>
											</thead>
											<tbody id="billProcess">
												<!-- list order were be processing -->
											</tbody>
										</table>
										<div class="my-3">
											<nav aria-label="Page navigation example">
												<ul class="pagination justify-content-center "
													id="paged--list--order--process">
													<!-- paging -->
												</ul>
											</nav>
										</div>
									</div>
									<!--END TAB LIST ORDER BE PROCESSING-->

									<!--START TAB LIST ORDER DELIVERY SUCCESSFUL-->
									<div class="tab-pane fade" id="pills-contact" role="tabpanel"
										aria-labelledby="pills-successful-tab">
										<table class="table table-data2">
											<thead>
												<tr>
													<th>ID</th>
													<th>Mã đơn</th>
													<th>Người nhận</th>
													<th>Địa chỉ</th>
													<th>Tổng tiền</th>
													<th>Ngày đặt</th>
													<th>Ngày cập nhật</th>
													<th>Hành động</th>
												</tr>
											</thead>
											<tbody id="billReceived">
												<!-- list order received -->
											</tbody>
										</table>
										<div class="my-3">
											<nav aria-label="Page navigation example">
												<ul class="pagination justify-content-center "
													id="paged--list--order--success">
													<!-- paging -->
												</ul>
											</nav>
										</div>
									</div>
									<!--END TAB LIST ORDER DELIVERY SUCCESSFUL-->

									<!--START TAB LIST ORDER CANCELLED-->
									<div class="tab-pane fade" id="pills-delete" role="tabpanel"
										aria-labelledby="pills-processing-tab">
										<table class="table table-data2">
											<thead>
												<tr>
													<th>ID</th>
													<th>Mã đơn</th>
													<th>Người nhận</th>
													<th>Địa chỉ</th>
													<th>Tổng tiền</th>
													<th>Ngày đặt</th>
													<th>Ngày cập nhật</th>
													<th>Hành động</th>
												</tr>
											</thead>
											<tbody id="billDeleted">
												<!-- list order deleted -->
											</tbody>
										</table>
										<div class="my-3">
											<nav aria-label="Page navigation example">
												<ul class="pagination justify-content-center "
													id="paged--list--order--deleted">
													<!-- paging -->
												</ul>
											</nav>
										</div>
									</div>
								</div>
								<!--END TAB LIST ORDER CANCELLED-->

								<!--END MAIN CONTENT-->
							</div>
						</div>
						<jsp:include page="/WEB-INF/views/manager/layout/footer.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END PAGE CONTAINER-->


	<!--START MODAL DETAIL -->
	<div class="modal fade" id="detail-modal" tabindex="-1" role="dialog" aria-labelledby="mediumModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="mediumModalLabel">
						Đơn hàng mã: <span id="code-order"></span> - <span id="status-orders"> Chưa xác nhận
						</span><br /> ID: <span id="id-order"></span>
					</h5>
					<br />
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div id="order--information">
						<div class="p-4">
							<h4 style="margin-left: -25px;">Trạng thái đơn hàng</h4>
							<br />
							<ul class="text-muted" id="status--order">
								<li style="list-style-type:none" id="status--4" class="d-none text-danger"><i
										class="fas fa-hand-point-right"></i> Đơn hàng đã bị hủy</li>
								<li style="list-style-type:none" id="status--3"><i class="fas fa-hand-point-right"></i>
									Giao hàng thành công</li>
								<li style="list-style-type:none" id="status--2"><i class="fas fa-hand-point-right"></i>
									Đang giao hàng</li>
								<li style="list-style-type:none" id="status--1"><i class="fas fa-hand-point-right"></i>
									Đã tiếp nhận đơn hàng</li>
								<li style="list-style-type:none" id="status--0"><i class="fas fa-hand-point-right"></i>
									Chưa tiếp nhận đơn hàng</li>
							</ul>
							<hr />
						</div>
						<h4>Thông tin người nhận</h4>
						<br>
						<table class="table table-bordered font-weight-bold">
							<tr>
								<td>Họ tên</td>
								<td id="fullname" class="text-primary"></td>
							</tr>
							<tr>
								<td>Email</td>
								<td id="email" class="text-primary"></td>
							</tr>
							<tr>
								<td>Số điện thoại</td>
								<td id="phone" class="text-primary"></td>
							</tr>
							<tr>
								<td>Địa chỉ</td>
								<td id="address" class="text-primary"></td>
							</tr>
							<tr>
								<td>Ngày mua</td>
								<td id="createdDate" class="text-primary"></td>
							</tr>
							<tr>
								<td>Tổng tiền thanh toán</td>
								<td id="total" class="text-primary"></td>
							</tr>
						</table>
						<hr />
						<h4 class="mb-3">Chi tiết sản phẩm</h4>
						<div id="list--product--order">

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button id="In" type="button" class="btn btn-warning">In thông tin đơn hàng</button>
				</div>
			</div>
		</div>
	</div>
	<!--END MODAL DETAIL -->

	<!-- START NOTIFY MODAL -->
	<jsp:include page="/WEB-INF/views/manager/layout/notify.jsp"></jsp:include>
	<!-- START NOTIFI MODAL -->

	<!-- START MESSAGE TO USER -->
	<jsp:include page="/WEB-INF/views/manager/layout/message-to-user.jsp"></jsp:include>
	<!-- START MESSAGE TO USER -->

	<!-- JS-->
	<jsp:include page="/WEB-INF/views/manager/layout/script.jsp"></jsp:include>
	<script type="text/javascript" src="${base }/manager/script/order/list-order.js"></script>

</body>

</html>
<!-- end document-->