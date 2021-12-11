<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- SPRING FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<button%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<!doctype html>
	<html lang="zxx">

	<head>
		<!-- Required meta tags -->
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<title>Liên hệ | ${tileWebsite}</title>
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

		<!--================Contact Area =================-->
		<section class="contact-section mt-3">
			<div class="container bg-white p-4">
				<div class="d-none d-sm-block mb-5 pb-4">
					<iframe
						src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.4737883168486!2d105.7329181147637!3d21.05373098598487!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345457e292d5bf%3A0x20ac91c94d74439a!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBDw7RuZyBuZ2hp4buHcCBIw6AgTuG7mWk!5e0!3m2!1svi!2s!4v1639151755835!5m2!1svi!2s"
						width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
				</div>


				<div class="row">
					<div class="col-12">
						<h2 class="contact-title">Liên hệ</h2>
					</div>
					<div class="col-lg-8">
						<span id="infoMsg" class="text-success font-weight-bold my-3"></span>
						<span id="errMsg" class="font-weight-bold my-3" style="color:red"></span>
						<form class="form-contact contact_form" method="post" id="contactForm">
							<div class="row">
								<div class="col-6">
									<div class="form-group">
										<input class="form-control w-100 border" name="subject" id="subject"
											placeholder="Nhập chủ đề"></input>
									</div>
								</div>
								<div class="col-sm-6">
									<div class="form-group">
										<input class="form-control border" name="customerName" id="customerName"
											type="text" placeholder='Nhập tên của bạn'>
									</div>
								</div>
								<div class="col-sm-6">
									<div class="form-group">
										<input class="form-control border" name="customerEmail" id="customerEmail"
											type="email" placeholder="Nhập địa chỉ email của bạn">
									</div>
								</div>
								<div class="col-sm-6">
									<div class="form-group">
										<input class="form-control border" name="customerPhone" id="customerPhone"
											type="number" placeholder="Nhập số điện thoại của bạn">
									</div>
								</div>
								<div class="col-12">
									<div class="form-group">
										<textarea class="form-control w-100 border" name="content" id="content"
											cols="30" rows="9" placeholder='Nội dung ...'></textarea>
									</div>
								</div>

							</div>
							<div class="form-group mt-3 text-right">
								<button type="submit" class="btn_3 button-contactForm">Gửi liên hệ</button>
							</div>
						</form>
					</div>
					<div class="col-lg-4">
						<div class="media contact-info">
							<span class="contact-info__icon"><i class="ti-home"></i></span>
							<div class="media-body">
								<h3>Số 256 Phú Diễn, Bắc Từ Liêm, Hà Nội</h3>
							</div>
						</div>
						<div class="media contact-info">
							<span class="contact-info__icon"><i class="ti-tablet"></i></span>
							<div class="media-body">
								<h3>0123456789 - 0241234567</h3>
							</div>
						</div>
						<div class="media contact-info">
							<span class="contact-info__icon"><i class="ti-email"></i></span>
							<div class="media-body">
								<h3>perfumeShop@gmail.com</h3>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!--================End Contact Area =================-->

		<!--::footer_part start::-->
		<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
		<!--::footer_part end::-->

		<!--::message to client part start::-->
		<jsp:include page="/WEB-INF/views/user/layout/message-to-user.jsp"></jsp:include>
		<!-- Message to client part end-->

		<!-- jquery plugins here-->
		<jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
		<script src="${base }/user/script/contact/contact.js"></script>
	</body>

	</html>