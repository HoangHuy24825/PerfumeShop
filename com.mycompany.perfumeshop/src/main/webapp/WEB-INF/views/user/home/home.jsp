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
    <title>Trang chủ | Electronic Device</title>
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
     <section class="banner_part">
        <div class="container">
            <div class="row align-items-center" style="margin-top: 150px; margin-bottom: 40px;">
            
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                      <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                      <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                      <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                      <div class="carousel-item active">
                        <img class="d-block w-100" src="${base }/user/img/1-slide-frct-228-iCW048-vq.png" alt="First slide">
                      </div>
                      <div class="carousel-item">
                        <img class="d-block w-100" src="${base }/user/img/dh-lg1-5sAxKq-vq.png" alt="Second slide">
                      </div>
                      <div class="carousel-item">
                        <img class="d-block w-100" src="${base }/user/img/dh-midea-box-1-ceE6bI-vq.png" alt="Third slide">
                      </div>
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                      <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                      <span class="carousel-control-next-icon" aria-hidden="true"></span>
                      <span class="sr-only">Next</span>
                    </a>
                  </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb start-->

    <!--================Category Product Area =================-->
    <section class="product_list best_seller mt-3">
        <div class="container bg-white p-4">
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="section_tittle text-center">
                        <h2>Danh mục sản phẩm</h2>
                    </div>
                </div>
            </div>
            <div class="row align-items-center justify-content-between">
                <div class="col-lg-12">
                    <div class="best_product_slider owl-carousel">
                    	<c:forEach var="category" items="${categories}">
	                        <div class="single_product_item" onclick="getProductByCategory(${category.id})">
	                        	<input type="hidden" id="view_category_${category.id}" name="custId" value="${category.seo}">
	                            <div class="d-flex flex-column justify-content-between">
	                                <div class="text-center">
	                                    <img class="img-category-product"
	                                        src="${base }/upload/${category.avatar}" alt="">
	                                </div>
	                                <h5 class="text-center">${category.name }</h5>
	                            </div>
	                        </div>
	                   	</c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--================End Category Product Area =================-->
    
    <!--================Start New Product Area =================-->
	 <section class="product_list mt-3">
        <div class="container bg-white p-4">
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class=" text-center">
                        <h2>Sản phẩm mới</h2>
                        <br>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                		<div class="row align-items-center justify-content-between">
                			<c:forEach var="product" items="${newProducts}">
	                           	<div class="col-lg-3 col-sm-6 box-single-product" onclick = "detail(${product.id})">
	                           		<input type="hidden" id="view_${product.id}" name="custId" value="${product.seo}">
			    					<div class="single_product_item">
			    						<img class="img-product" src="${base }/upload/${product.avatar}"  alt="">
			    					<div class="single_product_text">
			    					<h4>${product.title}</h4>
			    					<h3>
			    						 <fmt:setLocale value = "vi_VN"/>
                                         <fmt:formatNumber value = "${product.price}" type = "currency" currencySymbol = "VNĐ" minFractionDigits = "0"/>
			    					</h3>
			    					<div class="my-cart border rounded-circle" title="Thêm sản phẩm vào giỏ" onclick="event.stopPropagation();addProductToCart(${product.id})">
			    						<i class="fas fa-shopping-cart"></i>
			    					</div>
			    					</div>
			    					</div>
		   						</div>
		   					</c:forEach>	
                    	</div>
                  </div>
              </div>
          </div>
    </section>

	<!--================End New Product Area =================-->

	<!--================Start Awesome Shop Area =================-->	
	<section class="our_offer mt-3">
        <div class="container pt-4 pb-4">
            <div class="row align-items-center justify-content-between">
                <div class="col-lg-6 col-md-6">
                    <div class="offer_img">
                        <img src="https://vietship.net/wp-content/uploads/2017/12/van-chuyen-hang-hoa-theo-duong-bien12-2.jpg"
                            alt="">
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="offer_text">
                        <h3>Giảm giá hàng tuần, giảm giá 60% cho tất cả các sản phẩm</h3>
                        <div class="date_countdown">
                            <div id="timer">
                                <div id="days" class="date"></div>
                                <div id="hours" class="date"></div>
                                <div id="minutes" class="date"></div>
                                <div id="seconds" class="date"></div>
                            </div>
                        </div>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="enter email address"
                                aria-label="Recipient's username" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <a href="#" class="input-group-text btn_2" id="basic-addon2">book now</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
	<!--================End Awesome Shop Area =================-->	
	
	<!--================End Awesome Shop Area =================-->	
	
    <section class="product_list best_seller mt-3">
        <div class="container bg-white p-4">
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="section_tittle text-center">
                        <h2>Sản phẩm hot</h2>
                    </div>
                </div>
            </div>
            <div class="row align-items-center justify-content-between">
                <div class="col-lg-12">
                    <div class="best_product_slider owl-carousel">
                    	<c:forEach var="product" items="${hotProducts}">
	                        <div class="single_product_item" onclick="detail(${product.id})">
	                        	<input type="hidden" id="view_${product.id}" name="custId" value="${product.seo}">
	                            <img class="img-product" src="${base }/upload/${product.avatar}" alt="">
	                            <div class="single_product_text">
	                                <h4>${product.title }</h4>
	                                <h3>
										<fmt:setLocale value = "vi_VN"/>
                                         <fmt:formatNumber value = "${product.price}" type = "currency" currencySymbol = "VNĐ" minFractionDigits = "0"/>
	                                </h3>
	                              <div class="my-cart border rounded-circle" title="Thêm sản phẩm vào giỏ" onclick="event.stopPropagation();addProductToCart(${product.id})">
			    						<i class="fas fa-shopping-cart"></i>
			    					</div>
	                            </div>
	                        </div>
	                 	</c:forEach>       
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!--================End Awesome Shop Area =================-->	

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
    $(document).ready(function() {
    	$('.close-btn-alert').click(function() {
    		$('.alert').removeClass("show");
    		$('.alert').addClass("hide");
    	});
    });

    function showAlertMessage(message, messageState) {
    	if (messageState) {
    		$('#alert_message').css({ "background": "#C5F3D7", "border-left": "8px solid #2BD971" });
    		$("#icon-alert-message").html('<i class="fas fa-check-circle"></i>');
    		$("#icon-alert-message").find('i').css({ "color": "#2BD971" });
    		$(".msg").css({ "color": "#24AD5F" });
    		$(".close-btn-alert").css({ "background": "#2BD971", "color": "#24AD5F" });
    		$(".close-btn-alert").find('.fas').css({ "color": "#24AD5F" });
    		$(".close-btn-alert").hover(function(e) {
    			$(this).css("background-color", e.type === "mouseenter" ? "#38F5A3" : "#2BD971")
    		})
    	} else {
    		$('#alert_message').css({ "background": "#FFE1E3", "border-left": "8px solid #FF4456" });
    		$("#icon-alert-message").html('<i class="fas fa-exclamation-circle"></i>');
    		$("#icon-alert-message").find('i').css({ "color": "#FE4950" });
    		$(".msg").css({ "color": "#F694A9" });
    		$(".close-btn-alert").css({ "background": "#FF9CA4", "color": "#FD4653" });
    		$(".close-btn-alert").find('.fas').css({ "color": "#FD4653" });
    		$(".close-btn-alert").hover(function(e) {
    			$(this).css("background-color", e.type === "mouseenter" ? "#FFBDC2" : "#FF9CA4")
    		})
    	}

    	$('.msg').text(message);
    	$('.alert').addClass("show");
    	$('.alert').removeClass("hide");
    	$('.alert').addClass("showAlert");
    	setTimeout(function() {
    		$('.alert').removeClass("show");
    		$('.alert').addClass("hide");
    	}, 3000);
    };

    function detail(id) {
    	window.location.href = '/detail-product/' + $("#view_"+id).val();
    };

    function addProductToCart(id_product) {
       	let data={
       		productId:id_product,
       		quanlity:1
       	}
       	$.ajax({
       		url: "/cart/add",
       		type: "post",
       		data: JSON.stringify(data),
       		dataType: "json",
       		contentType: "application/json",
       		success : function(jsonResult) {
       			showAlertMessage("Thêm vào giỏ hàng thành công!",true);
       			$('#icon-cart-header').find($('#amount_cart')).text(jsonResult.totalItems);
       		},
       		error : function(jqXhr, textStatus, errorMessage) {
       			showAlertMessage("Không thêm được sản phẩm vào giỏ hàng!",false);
       		}
           });
       }

    function getProductByCategory(idCategory) {
    	window.location.href = '/product-category/' + $("#view_category_"+idCategory).val();
	}
    </script>
	<!--::footer_part end::-->
</body>

</html>