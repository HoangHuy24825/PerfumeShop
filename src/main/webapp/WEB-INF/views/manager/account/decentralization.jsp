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

			<!-- START MAIN CONTENT-->
			<div class="main-content">
				<div class="section__content section__content--p30">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12">
								<!-- CONTENT PAGE -->
								<div class="d-flex">
									<a href="${base }/perfume-shop/admin/account.html" class="btn_back_list"><i
											class="fa fa-arrow-left"></i></a> &nbsp
									<h3 class="title-5">Phân quyền nhân viên</h3>
								</div>
								<div class="">
									<div class="bg-light p-4">
										<div class="row">
											<div class="col-md-12">
												<div class="row">
													<div class="col-md-9">
														<table class="table table-bordered font-weight-bold">
															<tr>
																<td>Tên đăng nhập</td>
																<td id="fullname" class="text-primary">${user.username }
																</td>
															</tr>
															<tr>
																<td>Họ tên</td>
																<td id="fullname" class="text-primary">${user.fullname }
																</td>
															</tr>
															<tr>
																<td>Email</td>
																<td id="email" class="text-primary">${user.email }</td>
															</tr>
															<tr>
																<td>Số điện thoại</td>
																<td id="phone" class="text-primary">${user.phone }</td>
															</tr>
															<tr>
																<td>Địa chỉ</td>
																<td id="address" class="text-primary">${user.address }
																</td>
															</tr>
														</table>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<div class="col-md-12">
																<div class="d-flex justify-content-center">
																	<c:if test="${user.avatar!=null}">
																		<img id="output"
																			src="${base }/upload/${user.avatar}"
																			alt="Ảnh" class="rounded-circle border"
																			style="width:150px !important; height:150px !important">
																	</c:if>
																	<c:if test="${user.avatar==null }">
																		<img id="output"
																			src="${base }/manager/images/noAvatar.png"
																			alt="Ảnh" class="rounded-circle border"
																			style="width:150px !important; height:150px !important">
																	</c:if>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<br />
								<hr />
								<div style="display: flex; justify-content: space-between;">
									<h3 class="title-5 m-b-35">Quản lý quyền truy cập</h3>
									<img src="${base }/manager/images/load.gif" width="50" height="50"
										id="onloadImage" />
								</div>

								<div class="">
									<div class="bg-light p-4">
										<div class="row">
											<div class="col-md-12">

												<table class="table table-bordered">
													<thead>
														<tr>
															<th rowspan="2" style="text-align:center;">Tên quyền</th>
															<th colspan="4" style="text-align:center;">Hành động</th>
														</tr>
														<tr>
															<th>Xem</th>
															<th>Thêm</th>
															<th>Sửa</th>
															<th>Xóa</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="detailRole" items="${user.userRoles}">
															<tr id="${detailRole.id}" class="row_role">
																<td>${detailRole.role.name}</td>
																<td class="item-check-center">
																	<c:if test="${detailRole.view==true }">
																		<input class="permission" type="checkbox"
																			id="${detailRole.id}_View"
																			name="${detailRole.role.code }"
																			style="transform: scale(2);" checked />
																	</c:if>
																	<c:if test="${detailRole.view==false }">
																		<input class="permission" type="checkbox"
																			id="${detailRole.id}_View"
																			name="${detailRole.role.code}"
																			style="transform: scale(2);" />
																	</c:if>
																</td>
																<td class="item-check-center">
																	<c:if test="${detailRole.insert==true }">
																		<input class="permission" type="checkbox"
																			id="${detailRole.id}_Insert"
																			name="${detailRole.role.code}"
																			style="transform: scale(2);" checked />
																	</c:if>
																	<c:if test="${detailRole.insert==false}">
																		<input class="permission" type="checkbox"
																			id="${detailRole.id}_Insert"
																			name="${detailRole.role.code}"
																			style="transform: scale(2);" />
																	</c:if>
																</td>
																<td class="item-check-center">
																	<c:if test="${detailRole.update==true }">
																		<input class="permission" type="checkbox"
																			id="${detailRole.id}_Update"
																			name="${detailRole.role.code}"
																			style="transform: scale(2);" checked />
																	</c:if>
																	<c:if test="${detailRole.update==false }">
																		<input class="permission" type="checkbox"
																			id="${detailRole.id}_Update"
																			name="${detailRole.role.code}"
																			style="transform: scale(2);" />
																	</c:if>
																</td>
																<td class="item-check-center">
																	<c:if test="${detailRole.delete==true }">
																		<input class="permission" type="checkbox"
																			id="${detailRole.id}_Delete"
																			name="${detailRole.role.code}"
																			style="transform: scale(2);" checked />
																	</c:if>
																	<c:if test="${detailRole.delete==false }">
																		<input class="permission" type="checkbox"
																			id="${detailRole.id}_Delete"
																			name="${detailRole.role.code}"
																			style="transform: scale(2);" />
																	</c:if>
																</td>

															</tr>
														</c:forEach>
													</tbody>
												</table>

											</div>
										</div>
									</div>
								</div>
								<!-- END CONTENT PAGE -->
							</div>
						</div>
						<jsp:include page="/WEB-INF/views/manager/layout/footer.jsp"></jsp:include>
					</div>
				</div>
			</div>
			<!--END MAIN CONTENT-->
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

	<script src="${base }/manager/script/account/decentralization.js"></script>
</body>

</html>
<!-- end document-->