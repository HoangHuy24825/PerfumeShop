<%@page language="java" contentType="text/html; charset=UTF-8"
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
	<title>Tài khoản | ${tileWebsite}</title>
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

	<!--================Login Area =================-->
	<section class="login_part mt-3">
		<div class="container mt-3 p-4 bg-white">
			<div class="row">
				<div class="col-md-12">
					<ul class="nav nav-tabs" role="tablist">
						<li class="nav-item">
							<a class="nav-link active" data-toggle="tab" href="#my-account">
								<i class="fas fa-user-alt">
									Tài
									khoản của tôi
								</i>
							</a>
						</li>
						<li class="nav-item" onclick="loadSaleOrder('${userLogined.id}')">
							<a class="nav-link" data-toggle="tab" href="#my-order">
								<i class="fas fa-clipboard-list">
									Đơn
									mua
								</i>
							</a>
						</li>
					</ul>

					<!-- Tab panes -->
					<div class="tab-content">
						<div id="my-account" class="container tab-pane active">
							<br>
							<h3 class="title-5 m-b-35">Tài khoản của tôi</h3>
							<div class="row p-2">
								<div class="col-md-4 bg-white p-4 border-right">
									<aside class="profile-nav alt ">
										<section class="">
											<div class=" user-header alt">
												<div class="" style="align-items:center;">
													<div style="text-align:center; ">
														<c:if test="${userLogined.avatar!=null}">
															<img class="align-self-center rounded-circle mr-3 border"
																style="width:150px; height:150px;" alt=""
																src="${base }/upload/${userLogined.avatar}">
														</c:if>
														<c:if test="${userLogined.avatar==null}">
															<img class="align-self-center rounded-circle mr-3 border"
																style="width:150px; height:150px;" alt=""
																src="${base }/manager/images/noAvatar.png">
														</c:if>
													</div>
													<div style="text-align:center; ">
														<h2 class="text-dark display-6">${userLogined.fullname}</h2>
													</div>
												</div>
											</div>
										</section>
									</aside>
								</div>
								<div class="col-md-8 bg-white  p-4">
									<div class=" p-2">
										<ul class="nav nav-pills">
											<li class="nav-item">
												<a class="nav-link active" href="#inforuser" data-toggle="tab">Thông tin
													tài khoản</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="#update-infor" data-toggle="tab">Thông tin cá
													nhân</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="#change-password" data-toggle="tab">Mật
													khẩu</a>
											</li>
										</ul>
									</div>
									<!-- /.card-header -->

									<div class="">
										<div class="tab-content">
											<!-- Thông tin tài khoản -->
											<div class="active tab-pane" id="inforuser">
												<table class="table text-info">
													<tr>
														<td>
															<i class="fas fa-info mr-2 "></i>
														</td>
														<td>
															Họ tên
														</td>
														<td>
															${userLogined.fullname}
														</td>
													</tr>
													<tr>
														<td>
															<i class="fas fa-mobile-alt mr-2"></i>
														</td>
														<td>
															Số điện thoại
														</td>
														<td>
															${userLogined.phone}
														</td>
													</tr>
													<tr>
														<td>
															<i class="fas fa-map-marker-alt mr-2"></i>
														</td>
														<td>
															Địa chỉ
														</td>
														<td>
															${userLogined.address}
														</td>
													</tr>
													<tr>
														<td>
															<i class="fas fa-envelope-open-text mr-2"></i>
														</td>
														<td>
															Email
														</td>
														<td>
															${userLogined.email}
														</td>
													</tr>
												</table>

											</div>
											<!-- /.tab-pane -->

											<div class="tab-pane" id="update-infor">
												<form class="form-horizontal" action="" method="post" id="form-infor">
													<div class="mt-2"></div>
													<input type="text" hidden="true" value="${userLogined.id}" name="id"
														id="Avatar" />
													<div class="form-group row">
														<div class="col-md-12">
															<div class="d-flex justify-content-center">
																<c:if test="${userLogined.avatar!=null }">
																	<img id="output"
																		src="${base }/upload/${userLogined.avatar}"
																		alt="Ảnh" class="rounded-circle border"
																		style="width:100px !important; height:100px !important">
																</c:if>
																<c:if test="${userLogined.avatar==null }">
																	<img id="output"
																		src="${base }/manager/images/noAvatar.png"
																		alt="Ảnh" class="rounded-circle border"
																		style="width:100px !important; height:100px !important">
																</c:if>
															</div>
															<div class="d-flex justify-content-center">
																<!--  <input hidden="true" type="file" name="ImageFile" id="ufile" onchange="loadFile(event)"> -->
																<input type="file"
																	accept="image/png, image/jpeg, image/jpg"
																	hidden="true" value="" name="avatar" id="ufile"
																	onchange="loadFile(event)" />
																<label for="ufile"
																	class="label bg-light border p-2 m-3">Chọn
																	ảnh</label>
															</div>

														</div>
													</div>
													<input class="au-input au-input--full" type="text" name="username"
														placeholder="Tên đăng nhập" value="${userLogined.username}"
														hidden="true">
													<div class="form-group">
														<label class="col-md-3">Họ & Tên</label>
														<input class="form-control col-md-12 text-box single-line valid"
															type="text" name="fullname" id="fullname"
															placeholder="Họ tên" value="${userLogined.fullname }">
													</div>
													<div class="form-group">
														<label class="col-md-3">Địa chỉ</label>
														<input class="form-control col-md-12 text-box single-line valid"
															type="text" name="address" id="address"
															placeholder="Địa chỉ" value="${userLogined.address}">
													</div>
													<div class="form-group">
														<label class="col-md-3">Email</label>
														<input class="form-control col-md-12 text-box single-line valid"
															type="text" name="email" id="email" placeholder="Email"
															disabled value="${userLogined.email}">
													</div>
													<div class="form-group">
														<label class="col-md-3">Số Điện Thoại</label>
														<input id="phone" name="phone" value="${userLogined.phone}"
															id="phone"
															class="form-control col-md-12 text-box single-line valid"
															placeholder="Số điện thoại" />
													</div>
													<input hidden="true" id="Pasword" name="password"
														value="${userLogined.password}" />
													<div class="form-group">
														<button type="submit" class="btn btn-outline-primary">
															<i class="ace-icon fa fa-check bigger-110"></i> Cập Nhật
														</button>
													</div>
												</form>
											</div>
											<!-- /.tab-pane -->
											<!-- Cập nhật mật khẩu -->
											<div class="tab-pane" id="change-password">
												<form class="form-horizontal" action="" method="post"
													id="changePasswordForm">
													<div class="space-10"></div>

													<div class="form-group">
														<label class="col-sm-3 control-label no-padding-right"
															for="oldPassword">Mật khẩu hiện tại</label>
														<div class="col-sm-9">
															<input class="form-control" type="password" id="oldPassword"
																name="oldPassword" />
															<span style="color:red" id="errMsg"></span>
														</div>
													</div>
													<div class="form-group">
														<label class="col-sm-3 control-label no-padding-right"
															for="password">Mật khẩu mới</label>

														<div class="col-sm-9">
															<input class="form-control" type="password" id="newPassword"
																name="newPassword" />
														</div>
													</div>
													<div class="form-group">
														<label class="col-sm-3 control-label no-padding-right"
															for="confirmPassword">Nhập lại mật khẩu</label>
														<div class="col-sm-9">
															<input class="form-control" type="password"
																id="confirmPassword" name="confirmPassword" />
														</div>
													</div>
													<div class="clearfix form-actions">
														<div class="col-md-offset-3 col-md-9">
															<button class="btn btn-outline-primary" type="submit">
																<i class="ace-icon fa fa-check bigger-110"></i> Cập nhật
															</button>
														</div>
													</div>
												</form>
											</div>
											<!-- /.tab-pane -->
										</div>
										<!-- /.tab-content -->
									</div>
								</div>
							</div>
						</div>
						<div id="change-pass" class="container tab-pane">

						</div>
						<div id="my-order" class="container tab-pane fade">
							<br>
							<h3>Đơn hàng của tôi</h3>
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
		</div>
	</section>
	<!--================End Account Area =================-->

	<!--::footer_part start::-->
	<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
	<!--::footer_part end::-->

	<!--::message to client part start::-->
	<jsp:include page="/WEB-INF/views/user/layout/modal-cancel-order.jsp"></jsp:include>
	<!-- Message to client part end-->

	<!--::message to client part start::-->
	<jsp:include page="/WEB-INF/views/user/layout/message-to-user.jsp"></jsp:include>
	<!-- Message to client part end-->

	<!-- jquery plugins here-->
	<jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
	<script src="${base }/user/script/accountUser/accountUser.js"></script>
	<script src="${base }/user/script/cart/view-detail-order.js"></script>
</body>

</html>