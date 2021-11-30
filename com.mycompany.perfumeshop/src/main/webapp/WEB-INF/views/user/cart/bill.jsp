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
				<h3 class="text-center">Thông tin đơn đặt hàng</h3>
				<hr>
				<h4>Thông tin người nhận</h4>
				<br>
				<table class="table table-bordered">
					<tr>
						<td style="font-weight:bold">Mã đơn</td>
						<td style="color: #007bff">${saleOrder.code }</td>
					</tr>
					<tr>
						<td style="font-weight:bold">Họ tên người nhận</td>
						<td style="color: #007bff">${saleOrder.customerName }</td>
					</tr>
					<tr>
						<td style="font-weight:bold">Email</td>
						<td style="color: #007bff">${saleOrder.customerEmail }</td>
					</tr>
					<tr>
						<td style="font-weight:bold">Số điện thoại</td>
						<td style="color: #007bff">${saleOrder.customerPhone }</td>
					</tr>
					<tr>
						<td style="font-weight:bold">Địa chỉ</td>
						<td style="color: #007bff">${saleOrder.customerAddress }</td>
					</tr>
					<tr>
						<td style="font-weight:bold">Tổng tiền thanh toán</td>
						<td style="color: #ff3368; font-weight:bold">
							<fmt:setLocale value="vi_VN" />
							<fmt:formatNumber value="${saleOrder.total }" minFractionDigits="0" type="currency"
								currencySymbol="VND" />
						</td>
					</tr>
				</table>
				<hr>
				<h4>Chi tiết sản phẩm</h4>
				<br>

				<c:forEach items="${saleOrder.orderDetails}" var="detailOrder">
					<div class="d-flex flex-row">
						<img src="/upload/${detailOrder.attributeProduct.product.avatar }" alt="" width="100"
							height="100">
						<div class="ml-2">
							<h4>${detailOrder.attributeProduct.product.title }</h4>
							<p>Giá:
								<span style="color: #ff3368">
									<fmt:setLocale value="vi_VN" />
									<fmt:formatNumber value="${detailOrder.price }" minFractionDigits="0"
										type="currency" currencySymbol="VND" />
								</span>
							</p>
							<p>Số lượng: <span style="color: #ff3368"> ${detailOrder.quantity}</span> </span></p>
						</div>
					</div>
					<br>
				</c:forEach>
				<hr>
				<c:if test="${isLogined==true }">
					<input type="button" value="Đơn hàng của tôi" class="genric-btn danger circle"
						onclick="getMyOrder()">
				</c:if>
				<c:if test="${isLogined==false }">
					<input type="button" value="Tra cứu thông tin đơn hàng" class="genric-btn danger circle"
						onclick="searchOrder()">
				</c:if>
				<!-- <a href="@Url.Action("Index", "Account")" class="genric-btn danger circle"><i>Đơn hàng của tôi</i></a> -->

			</div>
		</div>
	</div>


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
	<script src="${base }/user/script/cart/bill.js"></script>
</body>

</html>