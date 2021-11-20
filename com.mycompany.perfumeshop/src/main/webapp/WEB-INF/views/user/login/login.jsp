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
	<title>Login | ${tileWebsite}</title>
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
					<div class="login_part_form">
						<div class="login_part_form_iner">
							<h3>Đăng nhập</h3>
							<form action="/perform_login" method="post" id="form-login">
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}">
								<div class="col-md-12 form-group p_star">
									<label>Tài Khoản</label>
									<input class="form-control" type="text" name="username" placeholder="Tài Khoản"
										id="username" />
									<label class="text-danger message_error" style="display:none;width:100%"
										id="usernameMessage">
										<span class="col-md-9 message-content"></span>
									</label>
								</div>
								<div class="col-md-12 form-group p_star">
									<label>Mật Khẩu</label>
									<input class="form-control" type="password" name="password" placeholder="Mật Khẩu"
										id="password" onkeypress="return runScript(event)">
									<label class="text-danger message_error" style="display:none;width:100%"
										id="passwordMessage">
										<span class="col-md-9 message-content"></span>
									</label>
								</div>
								<div class="col-md-12 form-group">
									<div class="creat_account d-flex align-items-center">
										<input type="checkbox" id="f-option" name="selector">
										<label for="f-option">Nhớ mật khẩu</label>
									</div>
									<button type="button" value="submit" class="btn_3" onclick="call_Login()">
										Đăng nhập
									</button>
									<a class="lost_pass" href="${base}/forget-password">Quên mật khẩu?</a>
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
	
	<!-- jquery plugins here-->
	<jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
	<script src="${base }/user/script/login/login.js"></script>
</body>

</html>