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
	<title>Tài khoản | ${tileWebsite}</title>
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
								<h3 class="title-5">Danh sách người dùng</h3>
								<div class="table-data__tool">
									<div class="table-data__tool-left">

									</div>
									<div class="table-data__tool-right">
										<c:if test="${productRole.insert ==true}">
											<button class="au-btn au-btn-icon au-btn--green au-btn--small"
												onclick="location.href='${base}/perfume-shop/admin/add-account'">
												<i class="fas fa-plus"></i>Thêm mới nhân viên
											</button>
										</c:if>
										<input id="update_role" value="${accountRole.update}" type="text"
											style="display: none" />
									</div>
								</div>
								<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
									<li class="nav-item" role="presentation">
										<a class="nav-link active" id="new-orders-tab" data-toggle="pill"
											onclick="loadStaff(1)" href="#pills-home" role="tab"
											aria-controls="pills-home" aria-selected="true">Danh sách nhân viên</a>
									</li>
									<li class="nav-item" role="presentation">
										<a class="nav-link" id="pills-processing-tab" data-toggle="pill"
											onclick="loadCustomer(1)" href="#pills-profile" role="tab"
											aria-controls="pills-profile" aria-selected="false">Danh sách khách hàng</a>
									</li>
								</ul>
								<div class="tab-content" id="pills-tabContent">
									<!--START TAB LIST NEW ORDER -->
									<div class="tab-pane fade show active" id="pills-home" role="tabpanel"
										aria-labelledby="new-orders-tab">
										<table class="table table-data2">
											<thead>
												<tr>
													<th>Tên đăng nhập</th>
													<th>Ảnh đại diện</th>
													<th>Họ tên</th>
													<th>Email</th>
													<th>Số điện thoại</th>
													<th>Địa chỉ</th>
													<th>Trạng thái</th>
												</tr>
											</thead>
											<tbody id="staff-list">
												<!-- List new order -->
											</tbody>
										</table>
										<div class="my-3">
											<nav aria-label="Page navigation example">
												<ul class="pagination justify-content-center " id="paged--list--staff">
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
													<th>Tên đăng nhập</th>
													<th>Ảnh đại diện</th>
													<th>Họ tên</th>
													<th>Email</th>
													<th>Số điện thoại</th>
													<th>Địa chỉ</th>
													<th>Trạng thái</th>
												</tr>
											</thead>
											<tbody id="customer-list">
												<!-- list order were be processing -->
											</tbody>
										</table>
										<div class="my-3">
											<nav aria-label="Page navigation example">
												<ul class="pagination justify-content-center "
													id="paged--list--customer">
													<!-- paging -->
												</ul>
											</nav>
										</div>
									</div>
									<!--END TAB LIST ORDER BE PROCESSING-->
								</div>
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

	<!-- START NOTIFY MODAL -->
	<jsp:include page="/WEB-INF/views/manager/layout/notify.jsp"></jsp:include>
	<!-- START NOTIFI MODAL -->

	<!-- START MESSAGE TO USER -->
	<jsp:include page="/WEB-INF/views/manager/layout/message-to-user.jsp"></jsp:include>
	<!-- START MESSAGE TO USER -->

	<!-- JS-->
	<jsp:include page="/WEB-INF/views/manager/layout/script.jsp"></jsp:include>

	<script src="${base }/manager/script/account/listAccount.js"></script>
</body>

</html>
<!-- end document-->