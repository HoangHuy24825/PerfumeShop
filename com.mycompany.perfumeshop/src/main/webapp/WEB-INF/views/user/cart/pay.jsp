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
    <title>Đặt hàng | Electronic Device</title>
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
    <div class="container mt-3 bg-white p-4">
        <div class="row">
            <div class="col-md-8">
                <h3 id="title-infor-customer" data-useraccount-login="${username }">Thông tin người nhận</h3>
                <br>
                <form enctype="multipart/form-data" method="post" id="form-upload">
                    <div class="form-group row">
                        <label for="fullname" class="col-md-3">Họ tên người nhận <span
                                class="text-danger">*</span></label>
                        <input id="customerName" name="customerName" class="form-control col-md-9"
                            placeholder="Họ tên người nhận" value="${account.fullname }" />
                        <label class="text-danger message_error" style="display:none;width:100%"
                            id="customerNameMessage">
                            <label for="message-content" class="col-md-3"></label>
                            <span class="col-md-9 message-content"></span>
                        </label>
                    </div>
                    <div class="form-group row">
                        <label for="email" class="col-md-3">Email người nhận <span class="text-danger">*</span></label>
                        <input id="customerEmail" name="customerEmail" class="form-control col-md-9"
                            placeholder="Email người nhận" value="${account.email }" />
                        <label class="text-danger message_error" style="display:none;width:100%"
                            id="customerEmailMessage">
                            <label for="message-content" class="col-md-3"></label>
                            <span class="col-md-9 message-content"></span>
                        </label>
                    </div>
                    <div class="form-group row">
                        <label for="phone" class="col-md-3">Số điện thoại <span class="text-danger">*</span></label>
                        <input id="customerPhone" name="customerPhone" class="form-control col-md-9"
                            placeholder="Số điện thoại người nhận" value="${account.phone }" />
                        <label class="text-danger message_error" style="display:none;width:100%"
                            id="customerPhoneMessage">
                            <label for="message-content" class="col-md-3"></label>
                            <span class="col-md-9 message-content"></span>
                        </label>
                    </div>
                    <div class="form-group row">
                        <label for="address" class="col-md-3">Địa chỉ <span class="text-danger">*</span></label>
                        <input id="customerAddress" name="customerAddress" class="form-control col-md-9"
                            placeholder="Địa chỉ người nhận" value="${account.address }" />
                        <label class="text-danger message_error" style="display:none;width:100%"
                            id="customerAddressMessage">
                            <label for="message-content" class="col-md-3"></label>
                            <span class="col-md-9 message-content"></span>
                        </label>
                    </div>
                    <hr>
                    <c:if test="${cartItems==null }">
                        <fmt:setLocale value="vi_VN" />
                        <h3 id="totalPay">Tổng tiền phải trả:
                            <span style="color: #ff3368">
                                <fmt:formatNumber value="${product.price*amount}" minFractionDigits="0" type="currency"
                                    currencySymbol="VND" />
                            </span>
                        </h3>
                    </c:if>
                    <c:if test="${cartItems!=null }">
                        <fmt:setLocale value="vi_VN" />
                        <h3 id="totalPay">Tổng tiền phải trả:
                            <span style="color: #ff3368">
                                <fmt:formatNumber value="${totalMoney}" minFractionDigits="0" type="currency"
                                    currencySymbol="VND" />
                            </span>
                        </h3>
                    </c:if>
                    <hr>
                    <div class="form-group">
                        <button type="button" id="btn_submit" Value="submit" class="genric-btn danger circle"
                            onclick="CallSubmit()">ĐẶT MUA</button>
                    </div>
                </form>
            </div>
            <div class="col-md-4">
                <h3>Chi tiết sản phẩm</h3>
                <br>
                <c:if test="${cartItems==null }">
                    <div class="d-flex flex-row item-product" data-id-product="${ product.id}"
                        data-amount-product="${amount }">
                        <img src="${base }/upload/${ product.avatar}" alt="" width="100" height="100">
                        <div class="ml-2">
                            <h5>${ product.title}</h5>
                            <p>Giá: <span style="color: #ff3368">
                                    <fmt:formatNumber value="${product.price}" minFractionDigits="0" type="currency"
                                        currencySymbol="VND" /> </span></p>
                            <p>Số lượng: <span style="color: #ff3368">${amount }</span></p>
                        </div>
                    </div>
                    <hr />
                </c:if>
                <c:if test="${cartItems!=null }">
                    <c:forEach var="cartItem" items="${cartItems}">
                        <div class="d-flex flex-row item-product" data-id-product="${ cartItem.attrProductId}"
                            data-amount-product="${cartItem.quantity }">
                            <img src="${base }/upload/${ cartItem.avatarProduct}" alt="" width="100" height="100">
                            <div class="ml-2">
                                <h5>${ cartItem.productName}</h5>
                                <p>Giá: <span style="color: #ff3368">
                                        <fmt:formatNumber value="${cartItem.priceUnit}" minFractionDigits="0"
                                            type="currency" currencySymbol="VND" /> </span></p>
                                <p>Số lượng: <span style="color: #ff3368">${cartItem.quantity }</span></p>
                            </div>
                        </div>
                        <hr />
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>
    <!-- Pay part end-->

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
    <script src="${base }/user/script/cart/pay.js"></script>
</body>

</html>