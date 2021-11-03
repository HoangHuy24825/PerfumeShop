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
			             <label for="fullname" class="col-md-3">Họ tên người nhận <span class="text-danger">*</span></label>
			             <input id="customerName" name="customerName" class="form-control col-md-9" placeholder="Họ tên người nhận" value="${account.fullname }"/>
			             <label class="text-danger message_error" style="display:none;width:100%" id="customerNameMessage">
			                 <label for="message-content" class="col-md-3"></label>
			                 <span class="col-md-9 message-content"></span>
			             </label>
			         </div>
			         <div class="form-group row">
			             <label for="email" class="col-md-3">Email người nhận <span class="text-danger">*</span></label>
			             <input id="customerEmail" name="customerEmail" class="form-control col-md-9" placeholder="Email người nhận" value="${account.email }"/>
			             <label class="text-danger message_error" style="display:none;width:100%" id="customerEmailMessage">
			                 <label for="message-content" class="col-md-3"></label>
			                 <span class="col-md-9 message-content"></span>
			             </label>
			         </div>
			         <div class="form-group row">
			             <label for="phone" class="col-md-3">Số điện thoại <span class="text-danger">*</span></label>
			             <input id="customerPhone" name="customerPhone" class="form-control col-md-9" placeholder="Số điện thoại người nhận" value="${account.phone }"/>
			             <label class="text-danger message_error" style="display:none;width:100%" id="customerPhoneMessage">
			                 <label for="message-content" class="col-md-3"></label>
			                 <span class="col-md-9 message-content"></span>
			             </label>
			         </div>
			         <div class="form-group row">
			             <label for="address" class="col-md-3">Địa chỉ <span class="text-danger">*</span></label>
			             <input id="customerAddress" name="customerAddress" class="form-control col-md-9" placeholder="Địa chỉ người nhận" value="${account.address }"/>
			             <label class="text-danger message_error" style="display:none;width:100%" id="customerAddressMessage">
			                 <label for="message-content" class="col-md-3"></label>
			                 <span class="col-md-9 message-content"></span>
			             </label>
			         </div>
			         <hr>
			         <c:if test="${cartItems==null }">
			         	<fmt:setLocale value="vi_VN"/>
			         	<h3 id="totalPay">Tổng tiền phải trả:   
			         		<span style="color: #ff3368"> 
			         			<fmt:formatNumber value="${product.price*amount}" minFractionDigits="0" type="currency" currencySymbol="VND"/> 
			         		</span>
			         	</h3>
			         </c:if>
			         <c:if test="${cartItems!=null }">
			         	<fmt:setLocale value="vi_VN"/>
			         	<h3 id="totalPay">Tổng tiền phải trả:   
			         		<span style="color: #ff3368"> 
			         			<fmt:formatNumber value="${totalMoney}" minFractionDigits="0" type="currency" currencySymbol="VND"/> 
			         		</span>
			         	</h3>
			         </c:if>
			         <hr>
			         <div class="form-group">
			             <button type="button" id="btn_submit" Value="submit" class="genric-btn danger circle" onclick="CallSubmit()">ĐẶT MUA</button>
			         </div>
				</form>
			</div>
			 <div class="col-md-4">
	            <h3>Chi tiết sản phẩm</h3>
	            <br>
	             <c:if test="${cartItems==null }">
		             <div class="d-flex flex-row item-product" data-id-product="${ product.id}" data-amount-product="${amount }">
	                    <img src="${base }/upload/${ product.avatar}" alt="" width="100" height="100">
	                    <div class="ml-2">
	                        <h5>${ product.title}</h5>
	                        <p>Giá: <span style="color: #ff3368"><fmt:formatNumber value="${product.price}" minFractionDigits="0" type="currency" currencySymbol="VND"/> </span></p>
	                        <p>Số lượng: <span style="color: #ff3368">${amount }</span></p>
	                    </div>
	                </div>
	                <hr/>
                </c:if>
                 <c:if test="${cartItems!=null }">
                 	<c:forEach var="cartItem" items="${cartItems}">
                 		<div class="d-flex flex-row item-product" data-id-product="${ cartItem.productId}" data-amount-product="${cartItem.quanlity }">
		                    <img src="${base }/upload/${ cartItem.avatarProduct}" alt="" width="100" height="100">
		                    <div class="ml-2">
		                        <h5>${ cartItem.productName}</h5>
		                        <p>Giá: <span style="color: #ff3368"><fmt:formatNumber value="${cartItem.priceUnit}" minFractionDigits="0" type="currency" currencySymbol="VND"/> </span></p>
		                        <p>Số lượng: <span style="color: #ff3368">${cartItem.quanlity }</span></p>
		                    </div>
	               		 </div>
	               		 <hr/>
                 	</c:forEach>
                 </c:if>
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


        $('#customerNameMessage').hide();
        $('#customerEmailMessage').hide();
        $('#customerPhoneMessage').hide();
        $('#customerAddressMessage').hide();

        $('#customerName').keydown(function () {
            $('#customerNameMessage').hide();
        });

        $('#customerEmail').keydown(function () {
            $('#customerEmailMessage').hide();
        });

        $('#customerPhone').keydown(function () {
            $('#customerPhoneMessage').hide();
        });

        $('#customerAddress').keydown(function () {
            $('#customerAddressMessage').hide();
        });

        $('#customerName').focusout(function () {
            if ($(this).val() == "" || $(this).val() == null) {
                $('#customerNameMessage').find('.message-content').text("Tên người nhận không được trống!");
                $('#customerNameMessage').show();
                $('#btn_submit').attr("type", "button");
            } else {
                $('#customerNameMessage').hide();
                
            }
        });

        $('#customerEmail').focusout(function () {
            if ($(this).val() == "" || $(this).val() == null) {
                $('#customerEmailMessage').find('.message-content').text("Email người nhận không được trống!");
                $('#customerEmailMessage').show();
                $('#btn_submit').attr("type", "button");
            } else {
                var expr = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                if (!expr.test($(this).val())) {
                    $('#customerEmailMessage').find('.message-content').text("Email người nhận không hợp lệ!");
                    $('#customerEmailMessage').show();
                    $('#btn_submit').attr("type", "button");
                } else {
                    $('#customerEmailMessage').hide();
                    
                }
            }

        });

        $('#customerPhone').focusout(function () {
            if ($(this).val() == "" || $(this).val() == null) {
                $('#customerPhoneMessage').find('.message-content').text("Số điện thoại người nhận không được trống!");
                $('#customerPhoneMessage').show();
                $('#btn_submit').attr("type", "button");
            } else {
                var val = /^[0]{1}[0-9]{9,13}$/;
                if (!val.test($(this).val())) {
                    $('#customerPhoneMessage').find('.message-content').text("Số điện thoại người nhận không hợp lệ!");
                    $('#customerPhoneMessage').show();
                    $('#btn_submit').attr("type", "button");
                } else {
                    $('#customerPhoneMessage').hide();
                }
            }

        });

        $('#customerAddress').focusout(function () {
            if ($(this).val() == "" || $(this).val() == null) {
                $('#customerAddressMessage').find('.message-content').text("Địa chỉ người nhận không được trống!");
                $('#customerAddressMessage').show();
                $('#btn_submit').attr("type", "button");
            } else {
                $('#customerAddressMessage').hide();
                
            }
        });

        preLoad();
    });

    function setMenuBanner() {
		$("#img-banner").html('<img src="${base}/user/img/my-image/banner/buy.png" alt="" width="460">');
    	var titlebanner='';
       	titlebanner+='<h2>Đặt hàng</h2>';
       	titlebanner+='<p>Trang chủ <span>></span>Đặt hàng</p>';
       	$("#title-banner").html(titlebanner);
    	
    	
    	$( "#mainNav li" ).each(function( index ) {
    		  $(this).removeClass("my-menu-active");
    	});
	}
    
    function preLoad() {
    	var username=$('#title-infor-customer').attr("data-useraccount-login").toString();
      	if (username!=null&&username!="") {
      		 if ($('#customerName').val() == "" || $('#customerName').val() == null) {
                 $('#customerNameMessage').find('.message-content').text("Tên người nhận không được trống!");
                 $('#customerNameMessage').show();
                 $('#btn_submit').attr("type", "button");
             } else {
                 $('#customerNameMessage').hide();
                 
             }

             if ($('#customerEmail').val() == "" || $('#customerEmail').val() == null) {
                 $('#customerEmailMessage').find('.message-content').text("Email người nhận không được trống!");
                 $('#customerEmailMessage').show();
                 $('#btn_submit').attr("type", "button");
             } else {
                 var expr = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                 if (!expr.test($('#customerEmail').val())) {
                     $('#customerEmailMessage').find('.message-content').text("Email người nhận không hợp lệ!");
                     $('#customerEmailMessage').show();
                     $('#btn_submit').attr("type", "button");
                 } else {
                     $('#customerEmailMessage').hide();
                     
                 }
             }

             if ($('#customerPhone').val() == "" || $('#customerPhone').val() == null) {
                 $('#btn_submit').attr("type", "button");
             }

             if ($('#customerAddress').val() == "" || $('#customerAddress').val() == null) {
                 $('#btn_submit').attr("type", "button");
             } else {
                 $('#customerAddressMessage').hide();
             }
		}
    }

    function validationAfterClick() {

        var result = true;
        if ($('#customerName').val() == "" || $('#customerName').val() == null) {
            $('#customerNameMessage').find('.message-content').text("Tên người nhận không được trống!");
            $('#customerNameMessage').show();
            result = false;
        } 

        if ($('#customerEmail').val() == "" || $('#customerEmail').val() == null) {
            $('#customerEmailMessage').find('.message-content').text("Email người nhận không được trống!");
            $('#customerEmailMessage').show();
            result = false;
        } else {
            var expr = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!expr.test($('#customerEmail').val())) {
                $('#customerEmailMessage').find('.message-content').text("Email người nhận không hợp lệ!");
                $('#customerEmailMessage').show();
                result = false;
            }
        }

        if ($('#customerPhone').val() == "" || $('#customerPhone').val() == null) {
            $('#customerPhoneMessage').find('.message-content').text("Số điện thoại người nhận không được trống!");
            $('#customerPhoneMessage').show();
            result = false;
        } else {
            var val = /^[0]{1}[0-9]{9,13}$/;
            if (!val.test($('#customerPhone').val())) {
                $('#customerPhoneMessage').find('.message-content').text("Số điện thoại người nhận không hợp lệ!");
                $('#customerPhoneMessage').show();
                result = false;
            }
        }

        if ($('#customerAddress').val() == "" || $('#customerAddress').val() == null) {
            $('#customerAddressMessage').find('.message-content').text("Địa chỉ người nhận không được trống!");
            $('#customerAddressMessage').show();
            result = false;
        }
        return result;
    }


    function CallSubmit() {
        if (validationAfterClick()) {
        	var arrIdProductStr ='';
        	var amount=0;
            if ($('.item-product').size()==1) {
            	arrIdProductStr = ($('.item-product').attr("data-id-product")+";");
            	amount=parseInt($('.item-product').attr("data-amount-product"));
			}else{
	             $('.item-product').each(function () {
	            	 arrIdProductStr+=($(this).attr("data-id-product")+";");
	             })
			}
        	
        	var form = $('#form-upload')[0];
        	var data = new FormData(form);
        	$.ajax({
        		url: "/order?strIdProduct="+arrIdProductStr+"&&amount="+amount,
        		type: "POST",
        		enctype: 'multipart/form-data',
        		data: data,
        		processData: false, //prevent jQuery from automatically transforming the data into a query string
        		contentType: false,
        		cache: false,
        		timeout: 600000,
        		success: function(jsonResult) {
        			$(location).attr('href', "/recent-order?idSaleOrder="+jsonResult.idSaleOrder);
        		},
        		error: function(e) {
        			showAlertMessage("Đặt hàng không thành công!",false);
        		}
        	});
        }
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