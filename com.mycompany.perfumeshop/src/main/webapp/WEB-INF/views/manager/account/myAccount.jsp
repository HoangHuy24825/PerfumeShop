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
							<div class="col-md-12">
								<!-- CONTENT PAGE -->
								<!-- DATA TABLE -->
								<h3 class="title-5">Tài khoản của tôi</h3>
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
													<a class="nav-link active" href="#inforuser" data-toggle="tab">Thông
														tin tài khoản</a>
												</li>
												<li class="nav-item">
													<a class="nav-link" href="#update-infor" data-toggle="tab">Thông tin
														cá nhân</a>
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
													<form class="form-horizontal" action="" method="post"
														id="form-infor">
														<div class="mt-2"></div>
														<input type="text" hidden="true" value="${userLogined.id}"
															name="id" id="Avatar" />
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
														<input class="au-input au-input--full" type="text"
															name="username" placeholder="Tên đăng nhập"
															value="${userLogined.username}" hidden="true">
														<div class="form-group">
															<label>Họ & Tên</label>
															<input class="au-input au-input--full" type="text"
																name="fullname" id="fullname" placeholder="Họ tên"
																value="${userLogined.fullname }">
															<span class="text-danger hide" id="error_full_name"></span>
														</div>
														<div class="form-group">
															<label>Địa chỉ</label>
															<input class="au-input au-input--full" type="text"
																name="address" id="address" placeholder="Địa chỉ"
																value="${userLogined.address}">
															<span class="text-danger hide" id="error_address"></span>
														</div>
														<div class="form-group">
															<label>Email</label>
															<input class="au-input au-input--full" type="text"
																name="email" id="email" placeholder="Email"
																value="${userLogined.email}">
															<span class="text-danger hide" id="error_email"></span>
														</div>
														<div class="form-group">
															<label>Số Điện Thoại</label>
															<input id="phone" name="phone" value="${userLogined.phone}"
																id="phone" class="au-input au-input--full"
																placeholder="Số điện thoại" />
															<span class="text-danger hide" id="error_phone"></span>
														</div>
														<input hidden="true" id="Pasword" name="password"
															value="${userLogined.password}" />
														<div class="form-group">
															<button type="button" class="btn btn-outline-primary"
																onclick="clickUpdateInfo()">
																<i class="ace-icon fa fa-check bigger-110"></i> Cập Nhật
															</button>
														</div>
													</form>
												</div>
												<!-- /.tab-pane -->
												<!-- Cập nhật mật khẩu -->
												<div class="tab-pane" id="change-password">
													<form class="form-horizontal" action="" method="post">
														<div class="space-10"></div>
														<div class="form-group">
															<label class="col-sm-3 control-label no-padding-right"
																for="oldPassword">Mật khẩu hiện tại</label>

															<div class="col-sm-9">
																<div class="input-group">
																	<input class="form-control" type="password"
																		id="OldPassword" name="OldPassword" />
																</div>
																<span id="error_old_password"
																	class="text-danger hide"></span>
															</div>
														</div>
														<div class="form-group">
															<label class="col-sm-3 control-label no-padding-right"
																for="password">Mật khẩu mới</label>

															<div class="col-sm-9">
																<div class="input-group">
																	<input class="form-control" type="password"
																		id="NewPassword" name="NewPassword" />

																</div>
																<span id="error_new_password"
																	class="text-danger hide"></span>
															</div>
														</div>
														<div class="form-group">
															<label class="col-sm-3 control-label no-padding-right"
																for="confirmPassword">Nhập lại mật khẩu</label>
															<div class="col-sm-9">
																<div class="input-group">
																	<input class="form-control" type="password"
																		id="ConfirmPassword" name="ConfirmPassword" />
																</div>
																<span class="hide text-danger"
																	id="error_confirm_password"></span>
															</div>
														</div>
														<div class="clearfix form-actions">
															<div class="col-md-offset-3 col-md-9">
																<button class="btn btn-outline-primary" type="button"
																	onclick="changePassword()">
																	<i class="ace-icon fa fa-check bigger-110"></i> Cập
																	nhật
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
								<!-- END DATA TABLE -->
								<div class="my-3">
									<nav aria-label="Page navigation example">
										<ul class="pagination justify-content-center" id="paged--list">
											<!-- paging category -->
										</ul>
									</nav>
								</div>

								<!-- END CONTENT PAGE -->
							</div>
						</div>
						<jsp:include page="/WEB-INF/views/manager/layout/footer.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
		<!-- END PAGE CONTAINER-->

	</div>

	<!-- START NOTIFY MODAL -->
	<jsp:include page="/WEB-INF/views/manager/layout/notify.jsp"></jsp:include>
	<!-- START NOTIFI MODAL -->

	<!-- START MESSAGE TO USER -->
	<jsp:include page="/WEB-INF/views/manager/layout/message-to-user.jsp"></jsp:include>
	<!-- START MESSAGE TO USER -->

	<!-- JS-->
	<jsp:include page="/WEB-INF/views/manager/layout/script.jsp"></jsp:include>
	<%-- <script type="text/javascript" src="${base }/manager/js/categoryScript/category.js"></script> --%>
	<script type="text/javascript">
		
	</script>
</body>

</html>
<!-- end document-->