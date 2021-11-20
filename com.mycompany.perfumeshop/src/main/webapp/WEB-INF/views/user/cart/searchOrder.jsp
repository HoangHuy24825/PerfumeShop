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
        		<h2 style="text-align: center;" class="m-b-5">Nhập thông tin khách hàng</h2>
				<form class="mt-5">
				  <div class="form-row">
				    <div class="form-group col-md-4">
				      <label for="inputPassword4">Họ tên khách hàng</label>
				      <input type="text" class="form-control" id="customerName" placeholder="Họ tên khách hàng">
				      <p class="text-danger" id="customerNameMessage"></p>
				    </div>
				    <div class="form-group col-md-4">
				      <label for="inputEmail4">Email</label>
				      <input type="email" class="form-control" id="customerEmail" placeholder="Email">
				      <p class="text-danger" id="customerEmailMessage"></p>
				    </div>
				    <div class="form-group col-md-4">
				      <label for="inputPassword4">Số điện thoại</label>
				      <input type="number" class="form-control" id="customerPhone" placeholder="Số điện thoại">
				      <p class="text-danger" id="customerPhoneMessage"></p>
				    </div>
				  </div>
				  <button type="button" style="float:right" class="btn btn-primary" onclick="loadSaleOrder()">Tìm kiếm</button>
				</form>
	        </div>
	    </div>
	    <div class="row">
        	<div class="col-md-12">
				<div id="my-order" class="container tab-pane">
                 <br>
                 <h3>Thông tin đơn hàng</h3>
                 <br>
                 <hr>
                 <div id="newBill">
                    
                 </div>
                 <div>
                     <table class="table table-striped">
                         <thead>
                             <tr>
                                 <th scope="col">Mã đơn hàng</th>
                                 <th scope="col">Ngày mua</th>
                                 <th scope="col">Sản phẩm</th>
                                 <th scope="col">Tổng tiền</th>
                                 <th scope="col">Trạng thái</th>
                             </tr>
                         </thead>
                         <tbody id="oldBill">
                          
                         </tbody>
                     </table>
                 </div>
             </div>
	        </div>
	    </div>
	 </div>
		
	 <!-- Pay part end-->
	 
	 
	<!--modal confirm delete product-->
	<!-- Modal -->
	<div class="modal fade" id="modalConfirmOder" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-body " id="modalConfirmOderContent" style="font-size:14px ">
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
	
	<!--::START MODAL CONFIRM::-->
   	 <div class="modal fade" id="modal-request-cancel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="modal-confirm-title">Gửi yêu cầu hủy đơn hàng</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <label for="code-confirm" class="col-form-label">Lý do hủy đơn hàng:</label>
	            <textarea class="form-control" id="input-request-cancel" name="input-request-cancel" rows="3"></textarea>         	
	            <p class="form-control text-danger" style="display: none" id="request-cancel-message"></p>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Thoát</button>
	        <button type="button" class="btn btn-primary" id="btn_request-cancel">Gửi yêu cầu</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!--::END MODAL CONFIRM::-->   

 	<!-- MODAL DETAIL ORDER FROM REQUEST CANCEL START -->
	<div class="modal fade" id="modal-bill-detail" tabindex="-1" role="dialog" aria-labelledby="mediumModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-lg" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="mediumModalLabel">
	                    Đơn hàng : <span id="id-orders">
	
	                    </span>  - <span id="status-orders" style="color:green;font-weight:bold">
	
	                    </span>
	                </h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                <div id="bill-product">
	                    <div id="infor-time" class="p-4"></div>
	                    <h4>Thông tin người nhận</h4>
	                    <br>
	                    <table class="table table-bordered">
	                        <tr>
	                            <td>Họ tên người nhận</td>
	                            <td id="FullRecieverName"></td>
	                        </tr>
	                        <tr>
	                            <td>Email</td>
	                            <td id="RecieverEmail"></td>
	                        </tr>
	                        <tr>
	                            <td>Số điện thoại</td>
	                            <td id="RecieverPhone"></td>
	                        </tr>
	                        <tr>
	                            <td>Địa chỉ</td>
	                            <td id="RecieverAddress"></td>
	                        </tr>
	                        <tr>
	                            <td>Tổng tiền thanh toán</td>
	                            <td id="SumPrice"></td>
	                        </tr>
	                    </table>
	                    <hr>
	                    <h4 id="detail">Chi tiết sản phẩm</h4>
	                    <div id="list-product-detail"></div>
	                </div>
	            </div>
	            <div class="modal-footer">
	              <!-- <button type="button" class="btn btn-warning" onclick="ReceiveBill()">Hủy đơn hàng</button> -->
	            </div>
	        </div>
	    </div>
	</div>
	<!-- MODAL DETAIL ORDER FROM REQUEST CANCEL START -->

 	<!--::START MODAL CONFIRM::-->
   	 <div class="modal fade" id="modal-confirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="modal-confirm-title">Xác nhận Email</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<p class="col-form-label">Chúng tôi đã gửi mã xác nhận gồm 6 chữ số đến email của bạn. Vui lòng nhập mã để xác nhận.</p>
	      	<input type="number" class="form-control" style="display: none" id="code-from-server" value="">
	      	<input type="number" class="form-control" style="display: none" id="idOrder-request-cancel-server" value="">
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
    var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    var regexPhone = /^[0]{1}[0-9]{9,13}$/;
    $(document).ready(function () {
    	$('#my-order').hide();
    	setMenuBanner();
    	
        $('.close-btn-alert').click(function () {
            $('.alert').removeClass("show");
            $('.alert').addClass("hide");
        });
        
        
        $('#customerNameMessage').hide();
        $('#customerEmailMessage').hide();
        $('#customerPhoneMessage').hide();
        
        $('#customerName').keydown(function () {
            $('#customerNameMessage').hide();
        });

        $('#customerEmail').keydown(function () {
            $('#customerEmailMessage').hide();
        });

        $('#customerPhone').keydown(function () {
            $('#customerPhoneMessage').hide();
        });
        
        
        $('#customerName').focusout(function () {
            if ($(this).val() == "" || $(this).val() == null) {
                $('#customerNameMessage').text("Tên người nhận không được trống!");
                $('#customerNameMessage').show();
            } else {
                $('#customerNameMessage').hide();
                
            }
        });

        $('#customerEmail').focusout(function () {
            if ($(this).val() == "" || $(this).val() == null) {
                $('#customerEmailMessage').text("Email người nhận không được trống!");
                $('#customerEmailMessage').show();
            } else {
                if (!regexEmail.test($(this).val())) {
                    $('#customerEmailMessage').text("Email người nhận không hợp lệ!");
                    $('#customerEmailMessage').show();
                } else {
                    $('#customerEmailMessage').hide();
                    
                }
            }

        });

        $('#customerPhone').focusout(function () {
            if ($(this).val() == "" || $(this).val() == null) {
                $('#customerPhoneMessage').text("Số điện thoại người nhận không được trống!");
                $('#customerPhoneMessage').show();
            } else {
                if (!regexPhone.test($(this).val())) {
                    $('#customerPhoneMessage').text("Số điện thoại người nhận không hợp lệ!");
                    $('#customerPhoneMessage').show();
                } else {
                    $('#customerPhoneMessage').hide();
                }
            }

        });
        
    });
    
    function validatorFormSearch() {
    	 var result = true;
         if ($('#customerName').val() == "" || $('#customerName').val() == null) {
             $('#customerNameMessage').text("Tên người nhận không được trống!");
             $('#customerNameMessage').show();
             result = false;
         } 
         if ($('#customerEmail').val() == "" || $('#customerEmail').val() == null) {
             $('#customerEmailMessage').text("Email người nhận không được trống!");
             $('#customerEmailMessage').show();
             result = false;
         } else {
             if (!regexEmail.test($('#customerEmail').val())) {
                 $('#customerEmailMessage').text("Email người nhận không hợp lệ!");
                 $('#customerEmailMessage').show();
                 result = false;
             }
         }
         if ($('#customerPhone').val() == "" || $('#customerPhone').val() == null) {
             $('#customerPhoneMessage').text("Số điện thoại người nhận không được trống!");
             $('#customerPhoneMessage').show();
             result = false;
         } else {
             if (!regexPhone.test($('#customerPhone').val())) {
                 $('#customerPhoneMessage').text("Số điện thoại người nhận không hợp lệ!");
                 $('#customerPhoneMessage').show();
                 result = false;
             }
         }
         return result;
	}

    function setMenuBanner() {
		$("#img-banner").html('<img src="${base}/user/img/my-image/banner/bill.png" alt="" width="200">');
    	var titlebanner='';
       	titlebanner+='<h2>Tra cứu thông tin đơn hàng</h2>';
       	titlebanner+='<p>Trang chủ <span>></span>Tra cứu thông tin đơn hàng</p>';
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
    
    
    
    function LoadBillModal(idOrder) {
		  $.ajax({
            url: '/load-sale-order-id-order',
            data: { idOrder: idOrder },
            type: "GET",
            success: function (jsonResult) {
          	  $('#id-orders').text(jsonResult.saleOrder.id);
                switch (jsonResult.saleOrder.processingStatus) {
					case 0:
						$('#status-orders').text("Chưa tiếp nhận");
						break;
					case 1:
						$('#status-orders').text("Đã tiếp nhận");
						break;
					case 2:
						$('#status-orders').text("Đang giao hàng");
						break;
					default:
						break;
					}
                $('#FullRecieverName').text(jsonResult.saleOrder.customerName);
                $('#RecieverEmail').text(jsonResult.saleOrder.customerEmail);
                $('#RecieverPhone').text(jsonResult.saleOrder.customerPhone);
                $('#RecieverAddress').text(jsonResult.saleOrder.customerAddress);
                $('#SumPrice').text(jsonResult.saleOrder.total.toLocaleString('it-IT', { style: 'currency', currency: 'VND' }));
                /* ID_Bill_Modal = ID_Bill; */
                loadSaleOrderProduct(idOrder, true);
            }
        });
    };
	  
	  function loadSaleOrderProduct(idOrder, status) {
        $.ajax({
            url: '/sale-order-product-id-order',
            data: { idOrder: idOrder },
            type: "GET",
            success: function (jsonResult) {
                if (status) {
                    $('.sp').remove();
                }
                var html1 = '';
                var html2 = '';
                $.each(jsonResult.saleOrderProducts, function (i, item) {
                    if (status) {
                        html1 += '<div class="sp">';
                        html1 += '<br>';
                        html1 += '<div class="d-flex flex-row">';
                        html1 += '<img class="border" src="${base}/upload/' + item.avatar + '" alt="" width="100" height="100">';
                        html1 += '<div class="ml-2">';
                        html1 += '<h5>' + item.productName + '</h5>';
                        html1 += '<p>Giá: ' + item.price.toLocaleString('it-IT', { style: 'currency', currency: 'VND' }) + '</p>';
                        html1 += '<p>Số lượng: ' + item.quality + '</p>';
                        html1 += '</div>';
                        html1 += '</div>';
                        html1 += '</div>';
                        $('#list-product-detail').html(html1);
                    }
                    else {
                        html2 += '<div class="sp_bill">';
                        html2 += '<br>';
                        html2 += '<div class="d-flex flex-row">';
                        html2 += '<img class="border" src="${base}/upload/' + item.avatar + '" alt="" width="100" height="100">';
                        html2 += '<div class="ml-2">';
                        html2 += '<h5>' + item.productName + '</h5>';
                        html2 += '<p>Giá: ' + item.price.toLocaleString('it-IT', { style: 'currency', currency: 'VND' }) + '</p>';
                        html2 += '<p>Số lượng: ' + item.quality + '</p>';
                        html2 += '</div>';
                        html2 += '</div>';
                        html2 += '</div>';
                        $('#' + idOrder).html(html2);
                    }
                });
            }
        });
    }
	  
    function loadSaleOrderProductTable(idOrder) {
        $.ajax({
            url: '/sale-order-product-id-order',
            data: { idOrder: idOrder },
            type: "GET",

            success: function (jsonResult) {

                var html = "";
                $.each(jsonResult.saleOrderProducts, function (i, item) {
                    html += '<span>' + item.productName + '</span>';
                    html += '<br/>';
                    html += '<br/>';
                    
                });
                $('#billBelow' + idOrder).html(html);
            }
        });
    }

	  function loadSaleOrder() {
		if (validatorFormSearch()) {
			
			var fullname=$("#customerName").val();		  
			var email=$("#customerEmail").val();
			var phone=$("#customerPhone").val();
			$('#my-order').show();
	        $.ajax({
	            url: '/load-sale-order-user-searching',
	            data: { fullname:fullname, email:email, phone:phone },
	            type: "GET",
	            success: function (jsonResult) {
	                var html = '';
	                var html2 = '';
	                var arrIdOrder=[];
	                $.each(jsonResult.saleOrders, function (index, item) {
	                    if (item.processingStatus == 1 || item.processingStatus == 2 || item.processingStatus==0) {
	                        var status;
	                        if (item.processingStatus == 1)
	                            status = "Đã tiếp nhận";
	                        else if (item.processingStatus == 2)
	                            status = "Giao cho đơn vị vận chuyển";
	                        else if (item.processingStatus == 0)
	                            status = "Đơn hàng mới";
							
	                        html += '<div class="row' + item.id + '">';
	                        html += '<div class="col-md-12">';
	                        html += '<div class="card">';
	                        html += '<div class="card-header">';
	                        html += '<ul class="blog-info-link">';
	                        html += '<li><a href="#"><i class="far fa-clock"></i>' + item.createdDate + '</a></li>';
	                        html += '<li>';
	                        html += '<a href="#" class="text-success">';
	                        html += '<i class="fas fa-shipping-fast"></i>';
	                        html += '<span>' + status + '</span?';
	                        html += '</a>';
	                        html += '</li>';
	                        html += '</ul>';
	                        html += '</div>';
	                        html += '<div class="card-body">';
	                        html += '<div class=" ">';
	                        html += '<div id="' + item.id + '"></div>';
	                        html += '<div class="p-4">';
	                        html += '<h4 class="text-danger float-right">Tổng tiền: '+item.total.toLocaleString('it-IT', { style: 'currency', currency: 'VND' })+'</h4>';
	                        html += '<br>';
	                        html += '<hr>';
	                        html += '<div class=" float-right">';
	                        html += '<div class="checkout_btn_inner float-right">';
	                        html += '<button style="border:unset" type="button" class="btn_1 btn_billAccount" onclick="LoadBillModal('+item.id+')" value="Chi tiết" data-toggle="modal" data-target="#modal-bill-detail">Chi tiết đơn hàng</button>';
	                        html += '<button style="border:unset" type="button" class="btn_1 checkout_btn_1 btn_billAccount" id="btn_pay" onclick="sentRequestGetCode(' + item.id +')">Hủy đơn hàng</button>';
	                        html += '</div>';
	                        html += '</div>';
	                        html += '</div>';
	                        html += '</div>';
	                        html += '</div>';
	                        html += '</div>';
	                        html += '</div >';
	                        html += '</div >';
	                        html += '</div ></br>';
	                        arrIdOrder.push(item.id);
	                    }
	                });
	                $('#newBill').html(html);
	                for (const element of arrIdOrder) {
	              	  loadSaleOrderProduct(element,false);
	                }
	                
	                var arrIdOrderBelow=[];
	                $.each(jsonResult.saleOrders, function (index, item) {
	                    if (item.processingStatus == 3 || item.processingStatus == 4) {
	                        var status = "";
	                        if (item.processingStatus == 3) {
	                            status = "Đã giao thành công";
	                        }
	                        else if (item.processingStatus == 4) {
	                            status = "Đã hủy";
	                        }

	                        html2 += '<tr>';
	                        html2 += '<th scope="row">' + item.code + '</th>';
	                        html2 += '<td>' + item.createdDate + '</td>';
	                        html2 += '<td id = "billBelow' + item.id + '">'; /*product*/
	                        html2 += '</td >';
	                        html2 += '<td>'+item.total.toLocaleString('it-IT', { style: 'currency', currency: 'VND' })+'</td>';

	                        if (item.processingStatus == 4)
	                            html2 += '<td id="statusBill" style="color:red">' + status + '</td>';
	                        else if (item.processingStatus == 3)
	                            html2 += '<td id="statusBill" style="color:green">' + status + '</td>';
	                        html2 += '</tr>';
	                        $('#oldBill').html(html2);
	                        if (item.Status == 4)
	                            $('#statusBill' + item.id).css("color", "red");
	                        if (item.Status == 3)
	                            $('#statusBill' + item.id).css("color", "green");
	                        arrIdOrderBelow.push(item.id);
	                    }
	                });
	                for (const element of arrIdOrderBelow) {
	              	  loadSaleOrderProductTable(element);
	                }
	            }
	        });
		}
    }
	  
	  function cancelOrder(idOrder) {
		  $('#btn_request-cancel').attr("onclick", "cancelOrderNotifyConfirmed(" + idOrder + ")");
		  $('#modal-request-cancel').modal('show');
	}
	  
	function cancelOrderNotifyConfirmed(idOrder) {
		var reason=$('#input-request-cancel').val().trim();
		console.log(reason);
		 if (reason!='' && reason!=null) {
			 $('#modal-request-cancel').modal('hide');
			 $.ajax({
	             url: '/request-cancel-order',
	             data: { idOrder: idOrder, reason:reason},
	             type: "GET",
	             success: function (jsonResult) {
	            	if (jsonResult.message==true) {
	            		 $('#btn_save').attr("onclick", "");
		    	         $('#modalConfirmOderContent').text("Chúng tôi đã nhận được yêu cầu hủy đơn hàng của bạn. Vui lòng kiểm tra email thường xuyên để nhận được thông "+
		    	        		 "báo về việc hủy đơn hàng!");
		    	         $('#btn_save').hide();
		    	         $('#btn_save').text("OK");
		    	         $('#btn_close').css({ "background-color": "#007bff", "border": "1px solid #007bff", "width": "200px" })
		    	          $('#btn_close').text("OK");
		    	         $('#btn_close').show();
		    	         $('#btn_save').css({ "background-color": "rgb(255, 66, 78)", "border": "1px solid rgb(255, 66, 78)", "width": "200px" });
		    	         $('#modalConfirmOder').modal('show');
		    	         $('#input-request-cancel').val("");
					}else{
						showAlertMessage("Gửi yêu cầu thất bại!",false);
					}
	             }
	         });
		}else{
			$('#request-cancel-message').text('Vui lòng nhập lý do hủy đơn!');
			$('#request-cancel-message').show();
		}
	}
	 function sentRequestGetCode(idOrder) {
		 if (validatorFormSearch()) {
			var fullname=$("#customerName").val();		  
			var email=$("#customerEmail").val();
		 	$("#modal-confirm").modal("show");
			$.ajax({
				type: "GET",
				enctype: 'multipart/form-data',
				url: "/get-code-cancel-bill",
				data: {email:email,fullname:fullname},
				contentType: JSON,
				timeout: 600000,
				success: function(jsonResult) {
					$("#code-from-server").val(jsonResult.codeConfirm);
					$("#idOrder-request-cancel-server").val(idOrder);
				},
				error: function(e) {
					console.log("ERROR : ", e);
				}
			});
		 }
	}
	 
	 function sendCodeConfirm() {
	    	var code_confirm=$("#code-from-server").val();
	    	var code_enter=$("#code-confirm").val();
	    	if ($("#code-from-server").val()==$("#code-confirm").val()) { 
	    		$("#modal-confirm").modal("hide");
	    		cancelOrder($("#idOrder-request-cancel-server").val());
	    		$("#code-confirm").val("");
			 }else{
				$("#code-confirm-message").text("Nhập sai mã! Vui lòng nhập lại!");
				$("#code-confirm-message").show();
			}
		}
    </script>
	<!--::footer_part end::-->
</body>

</html>