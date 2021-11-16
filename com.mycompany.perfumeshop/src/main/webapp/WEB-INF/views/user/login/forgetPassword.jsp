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
	<title>Login | Electronic Device</title>
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
		<div class="container p-4 bg-white">
			<div class="row align-items-center">
				<div class="col-lg-6 col-md-6">
					<div class="login_part_text text-center">
						<div class="login_part_text_iner">
							<h2>Bạn mới đến với cửa hàng của chúng tôi?</h2>
							<p>Tạo một tài khoản để tham gia mua sắm được dễ dàng và thuận tiện hơn!</p>
							<a href="${base }/register" class="btn_3">Tạo một tài khoản</a>
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-md-6">
					<div class="login_part_form" style="width: 100%" id="form-send-requet-get-password">
						<div class="login_part_form_iner">
							<h3>Quên mật khẩu</h3>
							<form>
								<div class="col-md-12 form-group p_star">
									<label>Nhập email đăng ký tài khoản</label>
									<input class="form-control" type="email" name="email" placeholder="Email"
										id="email" />
									<label class="text-danger message_error" style="display:none;width:100%"
										id="emailMessage">
										<span class="col-md-9 message-content"></span>
									</label>
								</div>
								<div class="col-md-12 form-group">
									<button type="button" value="button" class="btn_3" onclick="requestCode()">
										Lấy lại mật khẩu
									</button>
								</div>
							</form>
						</div>
					</div>
					<div class="login_part_form" id="form-change-password">
						<div class="login_part_form_iner">
							<h3>Đổi mật khẩu mới</h3>
							<form>
								<input type="text" class="form-control" style="display: none" id="emailHidden" value="">
								<div class="col-md-12 form-group p_star">
									<label>Mật khẩu mới</label>
									<input class="form-control" type="password" name="password"
										placeholder="Mật khẩu mới" id="password" />
									<label class="text-danger message_error" style="display:none;width:100%"
										id="passwordMessage">
										<span class="col-md-9 message-content"></span>
									</label>
								</div>
								<div class="col-md-12 form-group p_star">
									<label>Nhập lại mật khẩu</label>
									<input class="form-control" type="password" name="password" placeholder="Mật Khẩu"
										id="re-password">
									<label class="text-danger message_error" style="display:none;width:100%"
										id="re-passwordMessage">
										<span class="col-md-9 message-content"></span>
									</label>
								</div>
								<div class="col-md-12 form-group">
									<button type="button" value="submit" class="btn_3" onclick="changePassword()">
										Đổi mật khẩu
									</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================End Login Area =================-->

	<!--::footer_part start::-->
	<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
	<!--::footer_part end::-->

	<!--::message to client part start::-->
	<jsp:include page="/WEB-INF/views/user/layout/message-to-user.jsp"></jsp:include>
	<!-- Message to client part end-->


	<!--::START MODAL CONFIRM::-->
	<div class="modal fade" id="modal-confirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal-confirm-title">Xác nhận Email</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p class="col-form-label">Chúng tôi đã gửi mã xác nhận gồm 6 chữ số đến email của bạn. Vui lòng nhập
						mã để xác nhận.</p>
					<input type="number" class="form-control" style="display: none" id="code-from-server" value="">
					<form>
						<div class="form-group">
							<label for="code-confirm" class="col-form-label">Mã xác nhận:</label>
							<input type="number" class="form-control" id="code-confirm">
							<p class="form-control text-danger" style="display: none" id="code-confirm-message"></p>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Thoát</button>
					<button type="button" class="btn btn-primary" onclick="sendCodeConfirm()">Gửi mã xác nhận</button>
				</div>
			</div>
		</div>
	</div>
	<!--::END MODAL CONFIRM::-->

	<!-- jquery plugins here-->
	<jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
	<script src="${base }/user/script/login/forgetPassword.js"></script>
</body>

</html>