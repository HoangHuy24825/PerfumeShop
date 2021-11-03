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
    <title>Sản phẩm | Electronic Device</title>
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

    <!--================Category Product Area =================-->
   <!--================Single Product Area =================-->
	<div class="product_image_area mt-3">
	    <div class="container bg-white p-4">
	        <div class="row s_product_inner justify-content-between">
	           <div class="col-lg-7 col-xl-7">
		          <div class="product_slider_img" id="img--product">
			          <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
						  <ol class="carousel-indicators" id="ol-img-slide">
							    <!-- <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
							    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
							    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
							    <li data-target="#carouselExampleIndicators" data-slide-to="3"></li> -->
						  </ol>
						  <div class="carousel-inner" id="img-slide">
							   <!--  <div class="carousel-item active">
							      	<img class="d-block w-100" src="..." alt="First slide">
							    </div>
							    <div class="carousel-item">
							      	<img class="d-block w-100" src="..." alt="Second slide">
							    </div>
							    <div class="carousel-item">
							      	<img class="d-block w-100"  src="..." alt="Third slide">
							    </div>
							    <div class="carousel-item">
							      	<img class="d-block w-100" src="..." alt="Four slide">
							    </div> -->
						  </div>
						  <a class="carousel-control-prev button--slider-image-detail" href="#carouselExampleIndicators" role="button" data-slide="prev">
						  		<i class="fa fa-chevron-left" aria-hidden="true"></i>
							    <!-- <i class="carousel-control-prev-icon" aria-hidden="true"></i> -->
							    <span class="sr-only">Previous</span>
						  </a>
						  <a class="carousel-control-next button--slider-image-detail" href="#carouselExampleIndicators" role="button" data-slide="next">
						  		<i class="fa fa-chevron-right" aria-hidden="true"></i>
							    <!-- <i class="carousel-control-next-icon" aria-hidden="true"></i> -->
							    <span class="sr-only">Next</span>
						  </a>
					</div>
		          </div>
		        </div>
	            <div class="col-md-5 col-xl-4">
	                <div class="s_product_text">
	                    <h3 id="name-product">
	                    
	                        <!-- product name -->
	                        
	                    </h3>
	                    <input type="hidden" id="id_detail_product" name="custId" value="${id_product}">
	                    <h2 id="price-product">
	                    
	                        <!-- product price -->
	                        
	                    </h2>
	                    <table id="table-product-detail">
	                        <tr>
	                            <td>Model:</td>
	                            <td id="model-product">
	                            
	                                <!-- product model -->
	                                
	                            </td>
	                        </tr>
	                        <tr>
	                            <td>Bảo hành:</td>
	                            <td id="guarantee-product">
	                               
	                                <!-- product guarantee -->
	                                
	                            </td>
	                        </tr>
	                        <tr>
	                            <td>Xuất xứ:</td>
	                            <td id="origin-product">
	                            
	                                <!-- product origin -->
	                                
	                            </td>
	                        </tr>
	                        <tr>
	                            <td>Trạng thái:</td>
	                            <td id="status-product">
	                            
	                                <!-- product status -->
	                                
	                            </td>
	                        </tr>
	                    </table>
	                    <p id="short-description-product">
	                        
	                        <!-- product short description -->
	                        
	                    </p>
	                    <div class="card_area d-flex justify-content-between align-items-center">
	                        <div class="product_count">
	                            <span class="detail-order" onclick="checkValidAmount('decrease')"><i class="ti-minus"></i></span>
	                            <input class="input-number" onkeyup="checkValidAmountInput()" onkeypress="return isNumberKey(event)"
	                            	onfocusout="checkValidOutFocus()"  id="numberProductOrder" data-id-product="" data-amount-product=""
	                                   type="text" value="1" min="1" max="">
	                            <span class="detail-order" onclick="checkValidAmount('increase')"> <i class="ti-plus"></i></span>
	                        </div>
	                        <div class="my-cart border rounded-circle detail-order" title="Thêm sản phẩm vào giỏ" id="add-product-to-cart">
	                            <i class="fas fa-shopping-cart"></i>
	                        </div>
	                        <div class="btn_3" id="buy-now">Mua ngay</div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	<!--================End Single Product Area =================-->
	<!--================Product Description Area =================-->
	<section class="mt-3">
	    <div class="container bg-white p-4">
	        <ul class="nav nav-tabs" id="myTab" role="tablist">
	            <li class="nav-item">
	                <a class="nav-link active" id="home-tab" data-toggle="tab" href="#deteal-product" role="tab"
	                   aria-controls="home" aria-selected="true">Thông tin sản phẩm</a>
	            </li>
	        </ul>
	        <div class="tab-content" id="myTabContent">
	            <div class="tab-pane fade show active" id="deteal-product" role="tabpanel" aria-labelledby="home-tab">
	                <br><br>
	                <p id="detail-product">
	                   
	                   <!-- product detail -->
	                   
	                </p>
	            </div>
	        </div>
	    </div>
	</section>
	
	<!--================End Product Description Area =================-->

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

   $(document).ready(function() {
	
	setMenuBanner();
   	
   	$('.close-btn-alert').click(function() {
   		$('.alert').removeClass("show");
   		$('.alert').addClass("hide");
   	});

   	var id_product = $('#id_detail_product').val();
   	var load = function(id_product) {
   		$.ajax({
   			url: "/detail-product-loading?",
   			type: "GET",
   			data: {id_product:id_product },
   			dataType: "json",
   			contentType: "application/json",
   			success: function(jsonResult)  {
   				/* $("#image-product").attr("src", "/upload/"+result.avatar);*/
   				$("#name-product").html(jsonResult.product[0].title);
   				$("#price-product").html(jsonResult.product[0].price.toLocaleString('it-IT', { style: 'currency', currency: 'VND' }));
   				$("#model-product").html(jsonResult.product[0].model);
   				$("#guarantee-product").html(jsonResult.product[0].guarantee + ' tháng');
   				$("#origin-product").html(jsonResult.product[0].origin);
   				var status = jsonResult.product[0].amount > 0 ? "Còn hàng" : "Hết hàng";
   				$("#status-product").html(status);
   				$("#short-description-product").html(jsonResult.product[0].description);
   				$("#detail-product").html(jsonResult.product[0].detail);

   				$('#numberProductOrder').attr("data-id-product", jsonResult.product[0].id);
   				$('#numberProductOrder').attr("data-max-order", jsonResult.product[0].amount);

   				document.title = jsonResult.product[0].title;
   				$('#add-product-to-cart').click(function() {
   					addProductToCart(jsonResult.product[0].id);
   				});
   				$('#buy-now').click(function() {
   					payNow(jsonResult.product[0].id);
   				});
   				
   				var ol_image_slide='<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>';
   				var image_slide='';
  				image_slide+='<div class="carousel-item active">';
  				image_slide+='	<img class="d-block mw-100" src="${base}/upload/'+jsonResult.product[0].avatar+'" alt="First slide">';
  				image_slide+='</div>';
  				
  				
  				if(jsonResult.images!=null){
  					var i=0;
  					$.each( jsonResult.images, function( key, value ){
  						image_slide+='<div class="carousel-item">';
  		  				image_slide+='	<img class="d-block mw-100 mx-auto" style="max-height:600px" src="${base}/upload/'+value.path+value.title+'" alt="First slide">';
  		  				image_slide+='</div>';
  		  				i++;
  		  			 	ol_image_slide+='<li data-target="#carouselExampleIndicators" data-slide-to="'+i+'" class=""></li>';
  					});
  				}
  				
  				
  				$('#ol-img-slide').html(ol_image_slide);
  				$('#img-slide').html(image_slide);
   			}
   		});
   	}
   	load(id_product);
   	loadNewProduct();
   });
   
   function setMenuBanner() {
	   
	$("#img-banner").html('<img src="${base}/user/img/my-image/banner/product1.png" alt="" width="560">');
	var titlebanner='';
   	titlebanner+='<h2>Sản phẩm</h2>';
   	titlebanner+='<p>Trang chủ <span>></span>Chi tiết sản phẩm</p>';
   	$("#title-banner").html(titlebanner);
   	
   	$( "#mainNav li" ).each(function( index ) {
   		  $(this).removeClass("my-menu-active");
   	});
   	
   	$("#menu-product").addClass("my-menu-active");
	}
   
   function addProductToCart(id_product) {
   	var amount = $("#numberProductOrder").val();
   	let data={
   		productId:id_product,
   		quanlity:amount
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
   }


   function loadNewProduct() {
   	$.ajax({
   		url: "/new-product",
   		type: "GET",
   		data: {},
   		dataType: "json",
   		contentType: "application/json",
   		success: function(jsonResult) {
   			var html='';
   			$.each(jsonResult,function(index,value){
   				 html+='<div class="single_product_item" >';
                    html+='     <img class="img-product" src="/upload/'+value.avatar+'" alt="'+value.title+'">';
                    html+='     <div class="single_product_text">';
                    html+='         <h4>'+value.title+'</h4>';
                    html+='         <h3>'+value.price.toLocaleString('it-IT', { style: 'currency', currency: 'VND' })+'</h3>';
                    html+='         <div class="my-cart border rounded-circle" title="Thêm sản phẩm vào giỏ">';
                    html+='             <i class="fas fa-shopping-cart"></i>';
                    html+='         </div>';
                    html+='     </div>';
                    html+=' </div>';
   			});
   			$('#list-new-product').html(html);
   		},
   		error : function(jqXhr, textStatus, errorMessage) {
   			console.log(errorMessage);
   		}
   	});
   }
   
   function payNow(idProduct) {
        var maxOrder = parseInt($("#numberProductOrder").attr("data-max-order"));
        var amount = parseInt($("#numberProductOrder").val());
        if (maxOrder == 0) {
            showAlertMessage("Sản phẩm tạm thời hết hàng!", true);
        } 
        else if (maxOrder<amount) {
            showAlertMessage("Số lượng mua vượt quá số lượng hiện có!", false);
        }
        else {
        	window.location.href = '/bill?idProduct='+idProduct+"&&amount="+amount;
        }
	}


	function isNumberKey(evt) {
	    var charCode = (evt.which) ? evt.which : event.keyCode
	    if (charCode > 31 && (charCode < 48 || charCode > 57))
	        return false;
	    return true;
	}

	function checkValidAmount(status) {
	    var numberOrder = parseInt($('#numberProductOrder').val());
	    if (status == 'decrease') {
	        if (numberOrder == 1) {
	            showAlertMessage("Số lượng không được nhỏ hơn 1!", false);
	            $('#numberProductOrder').val('1');
	        }
	    } else {
	    	var maxOrder = parseInt($('#numberProductOrder').attr('data-max-order'));
	        if (numberOrder >= maxOrder) {
	            showAlertMessage("Số lượng sản phẩm chỉ còn lại " + maxOrder, false);
	            $('#numberProductOrder').val((maxOrder-1).toString());
	        }
	    }
	}

	function checkValidAmountInput() {
	    var numberOrder = parseInt($('#numberProductOrder').val());
	    var maxOrder = parseInt($('#numberProductOrder').attr('data-max-order'));
	    if (numberOrder < 1) {
	        showAlertMessage("Số lượng không được nhỏ hơn 1!", false);
	        $('#numberProductOrder').val(1);
	    }
	    if (numberOrder > maxOrder) {
	        showAlertMessage("Số lượng sản phẩm chỉ còn lại " + maxOrder, false);
	        $('#numberProductOrder').val(maxOrder);
	    }
	}
	
	
	function  checkValidOutFocus(){
		if ($('#numberProductOrder').val() == "" || $('#numberProductOrder').val() == null) {
			  showAlertMessage("Số lượng không được trống!", false);
		       $('#numberProductOrder').val(1);
		}
	}

   </script>
</body>

</html>