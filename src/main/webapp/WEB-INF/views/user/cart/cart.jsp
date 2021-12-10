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
    <title>Giỏ hàng | ${tileWebsite}</title>
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

    <!--================Cart Area =================-->
    <section class="cart_area mt-3">
        <div class="container bg-white p-4">
            <div class="cart_inner">
                <div class="table-responsive" id="content-cart-page">
                    <c:if test="${cart==null}">
                        <div style="text-align:center">
                            <img src="${base }/user/myImages/shopping_cart.png" alt="Chưa có sản phẩm nào trong giỏ!"
                                style="width:200px;height:auto" />
                            <p style="margin: 15px 0px 30px; ">Không có sản phẩm nào trong giỏ hàng của bạn.</p>
                            <a class="btn_1" href="${base }/perfume-shop/product.html">Tiếp tục mua hàng</a>
                        </div>
                    </c:if>
                    <c:if test="${cart!=null}">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col"><input type="checkbox" id="selectAll" onclick="selectAllRecord()">
                                    </th>
                                    <th scope="col">Sản phẩm</th>
                                    <th scope="col">Giá</th>
                                    <th scope="col">Số lượng</th>
                                    <th scope="col" width="150px">Thành tiền</th>
                                    <th scope="col" data-toggle="tooltip" title="Xóa các mục đã chọn!"
                                        id="btn-delete-selected" onclick="deleteRecordSelected()"><i
                                            class="fas fa-trash-alt"></i></th>
                                </tr>
                            </thead>
                            <tbody id="cart-container">
                                <c:forEach var="cartItem" items="${cart.cartItems}">
                                    <tr class="data-table" id="${cartItem.attrProductId }">
                                        <td scope="col"><input type="checkbox"
                                                onclick="changeStatus('${cartItem.attrProductId}')"></td>
                                        <td>
                                            <div class="media">
                                                <div class="d-flex">
                                                    <img src="/upload/${cartItem.avatarProduct}" alt="" width="150" />
                                                </div>
                                                <div class="media-body">
                                                    <p>${cartItem.productName} - ${cartItem.capacity} ML</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <h5 id="price">
                                                <fmt:setLocale value="vi_VN" />
                                                <fmt:formatNumber value="${cartItem.priceUnit}" minFractionDigits="0"
                                                    type="currency" currencySymbol="&#8363;" />
                                            </h5>
                                        </td>
                                        <td>
                                            <div class="d-flex flex-row">
                                                <div class="up-down decrease"
                                                    onclick="alterProductOrder('decrease','${cartItem.maxOrder}','${cartItem.attrProductId}')">
                                                    <i class="fas fa-minus"></i>
                                                </div>
                                                <div class="number_product_order">
                                                    <input class="text-center" id="number_order"
                                                        onkeypress="return isNumberKey(event)"
                                                        onfocusout="focusOut('${cartItem.attrProductId}')"
                                                        onfocus="getOldValue('${cartItem.attrProductId}')"
                                                        onkeyup="checkValid('${cartItem.maxOrder}','${cartItem.attrProductId}')"
                                                        onchange="totalMoney('${cartItem.attrProductId}')" type="text"
                                                        value="${cartItem.quantity}">
                                                </div>
                                                <div class="up-down increment"
                                                    onclick="alterProductOrder('increment', '${cartItem.maxOrder}','${cartItem.attrProductId}')">
                                                    <i class="fas fa-plus"></i>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <h5 id="totalProductItem">
                                                <!--total money to pay product item-->
                                            </h5>
                                        </td>
                                        <td onclick="deleteRecord('${cartItem.attrProductId}')"><i
                                                class="fas fa-trash-alt"></i></td>
                                    </tr>
                                </c:forEach>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>
                                        <h5>Tổng tiền</h5>
                                    </td>
                                    <td>
                                        <h5 id="totalPay">
                                            <!--total pay-->
                                        </h5>
                                    </td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="checkout_btn_inner float-right">
                            <a class="btn_1" href="${base }/perfume-shop/product.html">Tiếp tục mua hàng</a>
                            <div class="btn_1 checkout_btn_1" id="btn_pay" onclick="payNow()">Mua hàng</div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </section>


    <!--modal confirm delete product-->
    <!-- Modal -->
    <div class="modal fade" id="modalConfirmOder" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body " id="modalConfirmOderContent" style="font-size:22px ">
                    <!--content-->
                </div>
                <div class="modal-footer mx-auto" style="border:unset">
                    <button type="button" id="btn_close" class="btn btn-secondary" data-dismiss="modal">
                        <!--Button Close-->
                    </button>
                    <button type="button" id="btn_save" onclick="deleteRecordConfirmed()" class="btn btn-primary">
                        <!--Button Save-->
                    </button>
                </div>
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
    <script src="${base }/user/script/cart/cart.js"></script>

</body>

</html>