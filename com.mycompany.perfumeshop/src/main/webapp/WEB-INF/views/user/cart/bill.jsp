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
	                    	<fmt:setLocale value="vi_VN"/>
	                    	<fmt:formatNumber value="${saleOrder.total }" minFractionDigits="0" type="currency" currencySymbol="VND"/>
	                    </td>
	                </tr>
	            </table>
	            <hr>
	            <h4>Chi tiết sản phẩm</h4>
	            <br>
	
	           <c:forEach items="${saleOrder.orderDetails}" var="detailOrder">
	                <div class="d-flex flex-row">
	                    <img src="/upload/${detailOrder.attributeProduct.product.avatar }" alt="" width="100" height="100">
	                    <div class="ml-2">
	                        <h4>${detailOrder.attributeProduct.product.title }</h4>
	                        <p>Giá:
	                        	<span style="color: #ff3368">
	                        		 <fmt:setLocale value="vi_VN"/>
	                    			 <fmt:formatNumber value="${detailOrder.price }" minFractionDigits="0" type="currency" currencySymbol="VND"/>
								</span>
							</p>
	                        <p>Số lượng: <span style="color: #ff3368"> ${detailOrder.quantity}</span>  </span></p>
	                    </div>
	                </div>
	                <br>
	            </c:forEach>
	            <hr>
	            <c:if test="${isLogined==true }">
	            	<input type="button" value="Đơn hàng của tôi" class="genric-btn danger circle" onclick="getMyOrder()">
	            </c:if>
	             <c:if test="${isLogined==false }">
	            	<input type="button" value="Tra cứu thông tin đơn hàng" class="genric-btn danger circle" onclick="searchOrder()">
	            </c:if>
	            <!-- <a href="@Url.Action("Index", "Account")" class="genric-btn danger circle"><i>Đơn hàng của tôi</i></a> -->

	        </div>
	    </div>
	 </div>
		
	 <!-- Pay part end-->
	 
	 
	<!--modal confirm delete product-->
	<!-- Modal -->
	<div class="modal fade" id="modalConfirmOder" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
    
    <!--::message_part start::-->
	<div class="alert hide" id="alert_message">
	    <div id="icon-alert-message"><i class="fas fa-exclamation-circle"></i></div>
	    <span class="msg">Warning: This is a warning alert!</span>
	    <div class="close-btn-alert">
	        <span class="fas fa-times"></span>
	    </div>
	</div>
	<!--::message_part end::-->
	
    <!-- jquery plugins here-->
    <jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
    <script type="text/javascript">
    $(document).ready(function () {

    	setMenuBanner();
    	
        $('.close-btn-alert').click(function () {
            $('.alert').removeClass("show");
            $('.alert').addClass("hide");
        });
        
        showAlertMessage("Đặt hàng thành công!",true);

    });
    
    function getMyOrder() {
    	window.location.href = '/my-account';
	}
    
    function searchOrder() {
    	window.location.href = '/search-order';
	}

    function setMenuBanner() {
		$("#img-banner").html('<img src="${base}/user/img/my-image/banner/bill.png" alt="" width="250">');
    	var titlebanner='';
       	titlebanner+='<h2>Hóa đơn đặt hàng</h2>';
       	titlebanner+='<p>Trang chủ <span>></span>Hóa đơn đặt hàng</p>';
       	$("#title-banner").html(titlebanner);
    	
    	$( "#mainNav li" ).each(function( index ) {
    		  $(this).removeClass("my-menu-active");
    	});
    	
    	
	}
    
    function showAlertMessage(message, messageState) {
        if (messageState) {
            $('#alert_message').css({ "background": "#C5F3D7", "border-left": "8px solid #2BD971" });
            $("#icon-alert-message").html('<i class="fas fa-check-circle"></i>');
            $("#icon-alert-message").find('i').css({ "color": "#2BD971" });
            $(".msg").css({ "color": "#24AD5F" });
            $(".close-btn-alert").css({ "background": "#2BD971", "color": "#24AD5F" });
            $(".close-btn-alert").find('.fas').css({ "color": "#24AD5F" });
            $(".close-btn-alert").hover(function (e) {
                $(this).css("background-color", e.type === "mouseenter" ? "#38F5A3" : "#2BD971")
            })
        } else {
            $('#alert_message').css({ "background": "#FFE1E3", "border-left": "8px solid #FF4456" });
            $("#icon-alert-message").html('<i class="fas fa-exclamation-circle"></i>');
            $("#icon-alert-message").find('i').css({ "color": "#FE4950" });
            $(".msg").css({ "color": "#F694A9" });
            $(".close-btn-alert").css({ "background": "#FF9CA4", "color": "#FD4653" });
            $(".close-btn-alert").find('.fas').css({ "color": "#FD4653" });
            $(".close-btn-alert").hover(function (e) {
                $(this).css("background-color", e.type === "mouseenter" ? "#FFBDC2" : "#FF9CA4")
            })
        }

        $('.msg').text(message);
        $('.alert').addClass("show");
        $('.alert').removeClass("hide");
        $('.alert').addClass("showAlert");
        setTimeout(function () {
            $('.alert').removeClass("show");
            $('.alert').addClass("hide");
        }, 3000);
    };
    </script>
	<!--::footer_part end::-->
</body>

</html>