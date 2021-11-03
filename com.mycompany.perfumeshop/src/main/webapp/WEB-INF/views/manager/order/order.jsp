<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- SPRING FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags-->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Title Page-->
    <title>Đơn hàng | Admin Electronic Device</title>
    <link rel="icon" href="${base}/manager/images/logo-asp.net.png">
    
    <jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/manager/layout/style.jsp"></jsp:include>
	
</head>

<body class="">
    <div class="page-wrapper">
        <!-- HEADER MOBILE-->
        <jsp:include page="/WEB-INF/views/manager/layout/header_mobile.jsp"></jsp:include>
        <!-- END HEADER MOBILE-->

        <!-- MENU SIDEBAR-->
        <jsp:include page="/WEB-INF/views/manager/layout/left_sidebar.jsp"></jsp:include>
        <!-- END MENU SIDEBAR-->

        <!-- PAGE CONTAINER-->
        <div class="page-container">
            <!-- HEADER DESKTOP-->
              <jsp:include page="/WEB-INF/views/manager/layout/header.jsp"></jsp:include>
            <!-- HEADER DESKTOP-->
			
            <!-- MAIN CONTENT-->
 			<div class="main-content">
                <div class="section__content section__content--p30">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12" id="content_page">            
		           	<h3 class="title-5 m-b-35">Danh sách đơn hàng</h3>
		           	<input id="update_role" value="${orderRole.update}" type="text" style="display: none"/> 
                    <input id="delete_role" value="${orderRole.delete}" type="text" style="display: none"/>
					<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
					    <li class="nav-item" role="presentation">
					        <a class="nav-link active" id="new-orders-tab" data-toggle="pill" onclick="LoadNewOrder(1)" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Đơn hàng mới</a>
					    </li>
					    <li class="nav-item" role="presentation">
					        <a class="nav-link" id="pills-processing-tab" data-toggle="pill" onclick="LoadOrderProcess(1)" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">Đơn hàng đang xử lý</a>
					    </li>
					    <li class="nav-item" role="presentation">
					        <a class="nav-link" id="pills-successful-tab" data-toggle="pill" onclick="LoadOrderSuccessOrDeleted(3,1)" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">Đơn hàng gửi thành công</a>
					    </li>
					    <li class="nav-item" role="presentation">
					        <a class="nav-link" id="pills-delete-tab" data-toggle="pill" onclick="LoadOrderSuccessOrDeleted(4,1)" href="#pills-delete" role="tab" aria-controls="pills-contact" aria-selected="false">Đơn hàng đã hủy</a>
					    </li>
					</ul>
					<div class="tab-content" id="pills-tabContent">
					 	<!--START TAB LIST NEW ORDER -->
					    <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="new-orders-tab">
					        <div class="table-responsive table-data">
					            <table class="table table-data2">
					                <thead>
					                    <tr>
					                        <th>ID</th>
					                        <th>Mã đơn</th>
					                        <th>Người nhận</th>
					                        <th>Địa chỉ</th>
					                        <th>Tổng tiền</th>
					                        <th>Ngày đặt</th>
					                        <th>Hành động</th>
					                    </tr>
					                </thead>
					                <tbody id="newBill">
					                   <!-- List new order -->
		 			                </tbody>
					            </table>
					
					        </div>
					        <div class="my-3">
		                        <nav aria-label="Page navigation example">
		                            <ul class="pagination justify-content-center " id="paged--list--new--order">
		                                <!-- paging -->
		                            </ul>
		                        </nav>
		                    </div>
					    </div>
					    <!--END TAB LIST NEW ORDER -->
					    
					    <!--START TAB LIST ORDER BE PROCESSING-->
					    <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-processing-tab">
					        <div class="table-responsive table-data">
					            <table class="table table-data2">
					                <thead>
					                    <tr>
					                        <th>ID</th>
					                        <th>Mã đơn</th>
					                        <th>Người nhận</th>
					                        <th>Địa chỉ</th>
					                        <th>Tổng tiền</th>
					                        <th>Ngày đặt</th>
					                        <th>Ngày cập nhật</th>
					                        <c:if test="${orderRole.update ==true}">	
					                        	<th>Cập nhật trạng thái</th>
					                        </c:if>
					                        <th>Hành động</th>
					                    </tr>
					                </thead>
					                <tbody id="billProcess">
					                    <!-- list order were be processing -->
					                </tbody>
					            </table>
					        </div>
					         <div class="my-3">
		                        <nav aria-label="Page navigation example">
		                            <ul class="pagination justify-content-center " id="paged--list--order--process">
		                                <!-- paging -->
		                            </ul>
		                        </nav>
		                    </div>
					    </div>
					     <!--END TAB LIST ORDER BE PROCESSING-->
					     
					    <!--START TAB LIST ORDER DELIVERY SUCCESSFUL-->
					    <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-successful-tab">
					        <div class="table-responsive table-data">
					            <table class="table table-data2">
					                <thead>
					                    <tr>
					                      	<th>ID</th>
					                        <th>Mã đơn</th>
					                        <th>Người nhận</th>
					                        <th>Địa chỉ</th>
					                        <th>Tổng tiền</th>
					                        <th>Ngày đặt</th>
					                        <th>Ngày cập nhật</th>
					                        <th>Hành động</th>
					                    </tr>
					                </thead>
					                <tbody id="billReceived">
					                	<!-- list order received -->
					                </tbody>
					            </table>
					        </div>
					        <div class="my-3">
		                        <nav aria-label="Page navigation example">
		                            <ul class="pagination justify-content-center " id="paged--list--order--success">
		                                <!-- paging -->
		                            </ul>
		                        </nav>
		                    </div>
					    </div>
					     <!--END TAB LIST ORDER DELIVERY SUCCESSFUL-->
					     
					    <!--START TAB LIST ORDER CANCELLED-->
					    <div class="tab-pane fade" id="pills-delete" role="tabpanel" aria-labelledby="pills-processing-tab">
					        <div class="table-responsive table-data">
					            <table class="table table-data2">
					                <thead>
					                    <tr>
					                      	<th>ID</th>
					                        <th>Mã đơn</th>
					                        <th>Người nhận</th>
					                        <th>Địa chỉ</th>
					                        <th>Tổng tiền</th>
					                        <th>Ngày đặt</th>
					                        <th>Ngày cập nhật</th>
					                        <th>Hành động</th>
					                    </tr>
					                </thead>
					                <tbody id="billDeleted">
					                    <!-- list order deleted -->
					                </tbody>
					            </table>
					        </div>
					        <div class="my-3">
		                        <nav aria-label="Page navigation example">
		                            <ul class="pagination justify-content-center " id="paged--list--order--deleted">
		                                <!-- paging -->
		                            </ul>
		                        </nav>
		                    </div>
					    </div>
					</div>
					 <!--END TAB LIST ORDER CANCELLED-->
			 
          		<!--END MAIN CONTENT-->
	            </div>
	       	</div>
	        <jsp:include page="/WEB-INF/views/manager/layout/footer.jsp"></jsp:include>
	      </div>
	    </div>
	  </div>
	 </div>
    </div>
        <!-- END PAGE CONTAINER-->
        
        
    <!--START MODAL DETAIL -->
	<div class="modal fade" id="detail-modal" tabindex="-1" role="dialog" aria-labelledby="mediumModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-lg" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="mediumModalLabel">
	                    Đơn hàng mã: <span id="code-order"></span> - <span id="status-orders"> Chưa xác nhận </span><br/> ID: <span id="id-order"></span>
	                </h5>
	                <br/>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                <div id="order--information">
	                    <div class="p-4">
	                    	<h4 style="margin-left: -25px;">Trạng thái đơn hàng</h4>
	                    	<br/>
			                <ul class="text-muted"  id="status--order">
			                 	<li style="list-style-type:none" id="status--4" class="d-none text-danger"><i class="fas fa-hand-point-right"></i> Đơn hàng đã bị hủy</li>
				                <li style="list-style-type:none" id="status--3"><i class="fas fa-hand-point-right"></i> Giao hàng thành công</li>
				                <li style="list-style-type:none" id="status--2"><i class="fas fa-hand-point-right"></i> Đang giao hàng</li>
				                <li style="list-style-type:none" id="status--1"><i class="fas fa-hand-point-right"></i> Đã tiếp nhận đơn hàng</li>
				                <li style="list-style-type:none" id="status--0"><i class="fas fa-hand-point-right"></i> Chưa tiếp nhận đơn hàng</li>
			                </ul>
			                <hr/>
	                    </div>
	                    <h4>Thông tin người nhận</h4>
	                    <br>
	                    <table class="table table-bordered font-weight-bold" >
	                        <tr>
	                            <td>Họ tên</td>
	                            <td id="fullname" class="text-primary"></td>
	                        </tr>
	                        <tr>
	                            <td>Email</td>
	                            <td id="email" class="text-primary"></td>
	                        </tr>
	                        <tr>
	                            <td>Số điện thoại</td>
	                            <td id="phone" class="text-primary"></td>
	                        </tr>
	                        <tr>
	                            <td>Địa chỉ</td>
	                            <td id="address" class="text-primary"></td>
	                        </tr>
	                        <tr>
	                            <td>Ngày mua</td>
	                            <td id="createdDate" class="text-primary"></td>
	                        </tr>
	                        <tr>
	                            <td>Tổng tiền thanh toán</td>
	                            <td id="total" class="text-primary"></td>
	                        </tr>
	                    </table>
	                    <hr/>
	                    <h4 class="mb-3">Chi tiết sản phẩm</h4>
						<div id="list--product--order">
						
						</div>
	                </div>
	            </div>
	            <div class="modal-footer">
	                <button id="In" type="button" class="btn btn-warning">In thông tin đơn hàng</button>
	            </div>
	        </div>
	    </div>
	</div>
	<!--END MODAL DETAIL -->
	
	<!-- START MODAL CONFIRM -->
	<div class="modal fade" id="modalConfirmOder" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-body " id="modalConfirmOderContent" style="font-size:22px ">
	                <!--content-->
	            </div>
	            <div class="modal-footer mx-auto" style="border:unset">
	                <button type="button" id="btn_close" onclick="" class="btn btn-secondary" data-dismiss="modal" aria-label="Close">
	                    Không
	                </button>
	                <button type="button" id="btn_save" onclick="" class="btn btn-primary">
	                    <!--Button Save-->
	                </button>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- END MODAL CONFIRM -->
	
	<!-- START NOTIFY MODAL -->
	 <jsp:include page="/WEB-INF/views/manager/layout/notify.jsp"></jsp:include>
	<!-- START NOTIFI MODAL -->
	
	<!-- START MESSAGE -->
	<div class="alert hide" id="alert_message">
    <div id="icon-alert-message"><i class="fas fa-exclamation-circle"></i></div>
    <span class="msg">Warning: This is a warning alert!</span>
    <div class="close-btn-alert">
        <span class="fas fa-times"></span>
    </div>
	</div>
	<!-- END MESSAGE -->
	
    <!-- JS-->
    <jsp:include page="/WEB-INF/views/manager/layout/script.jsp"></jsp:include>
    
    <script type="text/javascript">
    
    /* STATUS TO CHECK MODAL SHOW ALL NOTIFY OPEN/CLOSE */
  	var status_all_notify_modal=false;
    
    $(document).ready(function () {
        setActiveMenu();
        LoadNewOrder(1);
        showNotifyHeader();
    	
       /*  FUNCTION WHEN MODAL NOTIFY CLOSING */
        $("#notify-detail-modal").on('hide.bs.modal', function(){
        	showNotifyHeader();
        	if (status_all_notify_modal) {
        		showAllNotify();
			}else{
				showAllNotify;
				$('#notify-modal').modal('hide');
			}
         });
    });
    
    /* NOTIFY CONTENT START */
      function showNotifyHeader() {
     	 $.ajax({
              url: "/admin/load-top-three-notify",
              type: "get",
              contentType: "application/json",
              data: "",
              dataType: "json", // kieu du lieu tra ve tu controller la json
              success: function (jsonResult) {
                  var html = '';
                  $("#quanlity_notify").text(jsonResult.amountUnread);
                  html+='<div class="notifi__title">';
                	 html+='	<p>Bạn có '+jsonResult.amountUnread+' thông báo mới</p>';
              	 html+='</div>';
                  $.each(jsonResult.notifies, function (index, value) {
                 	if (value.status==0) {
                 		html+='<div class="notifi__item unread" onclick="viewOrderNotify('+value.id+','+value.id_order+',1)">';
 					}else{
 						html+='<div class="notifi__item" onclick="viewOrderNotify('+value.id+','+value.id_order+',1)">';
 					}
                		html+='<div class="bg-c1 img-cir img-40">';
               		html+='    <i class="zmdi zmdi-email-open"></i>';
              	    html+='</div>';
           	    	html+='<div class="content">';
          	    	html+='    <p>'+value.message+'</p>';
          	    	html+='    <span class="date">'+value.createdDate+'</span>';
          	    	html+=' </div>';
          	    	html+='</div>';
                  });
                  html+='<div class="notifi__footer">';
                	 html+='	<button id="btn_show_nofity" style="width: 100%; padding: 15px 15px; color: blue" onclick="showAllNotify()">Tất cả thông báo</button>';
                  html+='</div>';
                  $('#notify_content').html(html);
              },
              error: function (jqXhr, textStatus, errorMessage) { // error callback 

              }
          });
 	}
    
    function showAllNotify() {
    	 $('.modal-backdrop').show();
    	 $.ajax({
             url: "/admin/load-all-notify",
             type: "get",
             contentType: "application/json",
             data: "",
             dataType: "json", // kieu du lieu tra ve tu controller la json
             success: function (jsonResult) {
                var html = '';
                $.each(jsonResult.notifies, function (index, value) {
                	if (value.status==0) {
                		html+='<div class="au-message__item unread" onclick="viewOrderNotify('+value.id+','+value.id_order+',2)">';
					}else{
						html+='<div class="au-message__item" onclick="viewOrderNotify('+value.id+','+value.id_order+',2)">';
					}
                	
                	html+='    <div class="au-message__item-inner">';
                	html+='        <div class="au-message__item-text">';
                	html+='            <div class="avatar-wrap">';
                	html+='                <div class="bg-c1 img-cir img-40">';
                	html+='                     <i class="zmdi zmdi-email-open"></i>';
                	html+='                </div>';
                	html+='            </div>';
                	html+='            <div class="text">';
                	html+='                <h5 class="name">'+value.email+'</h5>';
                	html+='                <p>'+value.firstName+' '+value.lastName+' yêu cầu '+value.requestType+' có mã <b>'+value.codeOrder+'</b>.</p>';
                	html+='                <span class="date">'+value.createdDate+'</span>';
                	html+='            </div>';
                	html+='        </div>';
                	html+='        <button class="item" title="Xóa" onclick="event.stopPropagation(); delete_notify('+value.id+')">';
                	html+='        	<i class="fas fa-trash-alt"></i>';
                	html+='        </button>';
                	html+='    </div>';
                	html+='</div>';
               	});
                
                $("#notify_detail_title").text("Bạn có "+jsonResult.amountUnread+" thông báo mới.");
                $("#list-detail-notify").html(html);
                $("#notify-modal").modal('show');
             },
             error: function (jqXhr, textStatus, errorMessage) { // error callback 

             }
         });
	}
    
   

    function delete_notify(idNotify) {
    	 $("#notify-modal").modal('hide');
    	 $('#btn_save').attr("onclick", "deleteNotifyConfirmed(" + idNotify +")");
         $('#modalConfirmOderContent').text("Bạn chắc chắn muốn xóa thông báo này ?");
         $('#btn_save').show();
         $('#btn_save').text("Có");
         $('#btn_close').css({ "background-color": "#007bff", "border": "1px solid #007bff", "width": "200px" })
         $('#btn_close').attr("onclick", "closeDeleteConfirm()");
         $('#btn_save').css({ "background-color": "rgb(255, 66, 78)", "border": "1px solid rgb(255, 66, 78)", "width": "200px" });
         $('#modalConfirmOder').modal('show');
	}
    
    function closeDeleteConfirm() {
    	console.log("call");
    	$('#modalConfirmOder').modal('hide');
    	showAllNotify();
	}
    
    function deleteNotifyConfirmed(idNotify) {
    	$.ajax({
            url: "/admin/delete-notify?id-notify="+idNotify,
            type: "POST",
            data: {},
            dataType: "json",
            contentType: "application/json",
            success: function (result) {   
            	if (result.message==true) {
            		showAlertMessage("Xóa thành công!",true);
            		showAllNotify();
            		showNotifyHeader();
				}else{
					showAlertMessage("Xóa thất bại!",false);
            	}
            },
            error: function (jqXhr, textStatus, errorMessage) { // error callback 
            	showAlertMessage("Xóa thất bại!",false);
            }
        });
	}
    
    function changeStyleStatusNotify(status){
    	for (var i = 0; i <= 4; i++) {
			$('#status--'+i+'--notify').removeClass("text-success");
			$('#status-orders').removeClass("text-dark");
			$('#status-orders').removeClass("text-success");
			$('#status-orders').removeClass("text-danger");
		}
    	if (status!=4) {
    		$('#status--4').addClass("d-none");
    		for (var i = 0; i <= status; i++) {
    			$('#status--'+i+'--notify').removeClass("d-none");
    			$('#status--'+i+'--notify').addClass("text-success");
    		}
    		if (status==3) {
    			$('#status-orders').addClass("text-success");
			}else{
				$('#status-orders').addClass("text-dark");
			}
		}else{
			for (var i = 0; i < status; i++) {
				$('#status--'+i+'--notify').addClass("d-none");
    		}
			$('#status--4--notify').removeClass("d-none");
			$('#status-orders').addClass("text-danger");
		}
    }
    
    function viewOrderNotify(idNotify,idOrder,status_all_notify_modal_1) {
    	$.ajax({
            url: '/admin/detail-order-notify',
            type: "GET",
            data: {idOrder : idOrder,idNotify : idNotify},
            dataType: "json",
            contentType: "application/json",
            success: function (result) {
            	$('#fullname-notify').text(result.saleOrder.customerName);
            	$('#email-notify').text(result.saleOrder.customerEmail);
            	$('#phone-notify').text(result.saleOrder.customerPhone);
            	$('#address-notify').text(result.saleOrder.customerAddress);
            	$('#createdDate-notify').text(result.saleOrder.createdDate);
            	$('#total-notify').text(result.saleOrder.total.toLocaleString('it-IT', { style: 'currency', currency: 'VND' }));
            	$('#code-order-notify').text(result.saleOrder.code);
            	$('#id-order-notify').text(result.saleOrder.id);
            	switch (result.saleOrder.processingStatus) {
				case 0:
					$('#status-orders-notify').addClass("text-dark");
					changeStyleStatusNotify(0);
					break;
				case 1:
					$('#status-orders-notify').text('Đã tiếp nhận');	
					changeStyleStatusNotify(1);
					break;
				case 2:
					$('#status-orders-notify').text('Đang giao');
					changeStyleStatusNotify(2);
					break;
				case 3:
					$('#status-orders-notify').text('Giao thành công');
					changeStyleStatusNotify(3);
					break;
				case 4:
					$('#status-orders-notify').text('Đã hủy');
					changeStyleStatusNotify(4);
					break;
				default:
					break;
				}
            	
            	$("reason-notify").text(result.notify.reason);
            	
            	
				var html='';
                $.each(result.saleOrderProduct, function (i, item) {
                	html+='<div class="d-flex flex-row">';
               		html+='    <img class="" src="${base}/upload/'+item.avatar+'" alt="'+item.productName+'"';
           			html+='        width="100" height="100">';
           			html+='    <div class="ml-4">';
           			html+='        <h5>'+item.productName+'</h5>';
           			html+='        <p>Giá: '+item.price.toLocaleString('it-IT', { style: 'currency', currency: 'VND' })+'</p>';
           			html+='        <p>Số lượng: '+item.quality+'</p>';
           			html+='    </div>';
           			html+='</div>';
           			html+='<br>';			
                });
                $('#list--product--order-notify').html(html);
                $('#notify-detail-modal').modal('show');
                $('#btn_cancel_order').attr("onclick", "cancelOrderFromRequest(" + idOrder + ")");
                $('#btn_not_cancel_order').attr("onclick", "rejectCancelOrderRequest(" + idOrder + ")");
            }
        });
    	
    	if (status_all_notify_modal_1==1) {
    		status_all_notify_modal=false;
		}else{
			status_all_notify_modal=true;
		}
	}
    
   function rejectCancelOrderRequest(idOrder) {
	   $('#notify-detail-modal').modal('hide');
	   $('#btn_confirm_reject').attr("onclick", "rejectCancelOrderRequestConfirmed(" + idOrder + ")");
	   $('#modal-reason-reject').modal('show');
	}
    
   function rejectCancelOrderRequestConfirmed(idOrder) {
	   $('#modal-reason-reject').modal('hide');
       showAlertMessage("Email từ chối đề nghị hủy đơn đã được gửi!",true);
       sentEmailConfirm(idOrder,0,$('#input-reason-reject').val());
	}
   
    function cancelOrderFromRequest(idOrder) {
       $('#notify-detail-modal').modal('hide');
       $('#notify-modal').modal('hide');
   	   $('#btn_save').attr("onclick", "cacelOrderRequestConfirmed(" + idOrder + ")");
       $('#modalConfirmOderContent').text("Bạn chắc chắn muốn hủy đơn hàng này ?");
       $('#btn_save').show();
       $('#btn_save').text("Có");
       $('#btn_close').css({ "background-color": "#007bff", "border": "1px solid #007bff", "width": "200px" })
       $('#btn_save').css({ "background-color": "rgb(255, 66, 78)", "border": "1px solid rgb(255, 66, 78)", "width": "200px" });
       $('#modalConfirmOder').modal('show');
	}
    
	function cacelOrderRequestConfirmed(idOrder) {
		var idOrder1=parseInt(idOrder);
    	$.ajax({
            url: '/admin/cancel-order-request?idOrder='+idOrder,
            type: "POST",
            data: {},
            dataType: "json",
            contentType: "application/json",
            success: function (result) {     
            	showAlertMessage("Hủy đơn hàng thành công!",true);
            	$('#modalConfirmOder').modal('hide');
            	sentEmailConfirm(idOrder,1,null);
            },
            error: function (jqXhr, textStatus, errorMessage) { // error callback 
            	showAlertMessage("Hủy đơn hàng thất bại!",false);
            }
        });
	}
	
	function sentEmailConfirm(idOrder,status,content) {
		$.ajax({
            url: '/admin/sent-email-confirm?idOrder='+idOrder+'&&status='+status+'&&content='+content,
            type: "POST",
            data: {},
            dataType: "json",
            contentType: "application/json",
            success: function (result) {     
            	
            },
            error: function (jqXhr, textStatus, errorMessage) { // error callback 
            	
            }
        });
	}
    
    
    /* NOTIFY CONTENT END */

    function setActiveMenu() {
     	$( ".navbar__list li" ).each(function() {
     		$(this).removeClass("active");
     	});
     	$( ".list-unstyled li" ).each(function() {
     		$(this).removeClass("active");
     	});
     	$('.list-unstyled #menu--order').addClass("active");
     	$('.navbar__list #menu--order').addClass("active");
 	}
    
    function LoadNewOrder(page) {
    	var update_role=$("#update_role").val();
		var delete_role=$("#delete_role").val();
        var status=0;
        $.ajax({
            url: '/admin/list-order',
            type: "GET",
            data: {status: status, page: page},
            dataType: "json",
            contentType: "application/json",
            success: function (result) {
				var html='';
                $.each(result.listOrder, function (i, item) {
                	html+='<tr class="tr-shadow">';
               		html+='    <td class="number_order">'+item.id+'</td>';
            		html+='    <td>';
            		html+='        <span>'+item.code+'</span>';
            		html+='    </td>';
           			html+='    <td>';
  					html+='         <span>'+item.customerName+'</span>';
          			html+='    </td>';
					html+='    <td>';
					html+='         <span>'+item.customerAddress+'</span>';
					html+='    </td>';
					html+='     <td>';
					html+='          <span class="text-primary font-weight-bold">'+item.total.toLocaleString('it-IT', { style: 'currency', currency: 'VND' })+'</span>';
					html+='     </td>';
					html+='     <td>';
					html+='          <span class="block-name-product">'+item.createdDate+'</span>';
					html+='     </td>';
					html+='     <td>';
					html+='          <input type="button" class="btn btn-outline-info" value="Xem" onclick="viewOrder('+item.id+')">';
					if (update_role=='true') {
						html+='          <input type="button" class="btn btn-outline-success" value="Nhận đơn" onclick="changeStatusOrder('+item.id+',1,0)">';
						html+='          <input type="button" class="btn btn-outline-danger" value="Hủy đơn" onclick="cancelBill('+item.id+')">';
					}
					html+='     </td>';
					html+='</tr>';
					html+='<tr class="spacer"></tr>';				
                });
                
                var totalPage = result.listPage[0].totalPage;
                var currentPage = result.listPage[0].currentPage;
                var pagination_string = '';
                if (currentPage > 1) {
                    var previousPage = currentPage - 1;
                    pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + previousPage + ' data-type-list='+result.listOrder[0].processingStatus+'><i class="fas fa-angle-double-left" style="font-size:18px"></i></a></li>';
                }

                for (i = 1; i <= totalPage; i++) {
                    if (i == currentPage) {
                        pagination_string += '<li class="page-item active"><a href="" class="page-link" data-page=' + i +' data-type-list='+result.listOrder[0].processingStatus+'>' + currentPage + '</a></li>';
                    } else if (i >= currentPage - 3 && i <= currentPage + 4) {
                        pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + i + ' data-type-list='+result.listOrder[0].processingStatus+'>' + i + '</a></li>';
                    }
                }

                if (currentPage > 0 && currentPage < totalPage) {
                    var nextPage = currentPage + 1;
                    pagination_string += '<li class="page-item"><a href="" class="page-link"  data-page=' + nextPage + ' data-type-list='+result.listOrder[0].processingStatus+'><i class="fas fa-angle-double-right" style="font-size:18px"></i></a></li>';
                }
                
                $('#newBill').html(html);
                $('#paged--list--new--order').html(pagination_string);
            }
        });
    }
    
    
    function LoadOrderProcess(page) {
        var status=1;
        var update_role=$("#update_role").val();
		var delete_role=$("#delete_role").val();
        $.ajax({
            url: '/admin/list-order',
            type: "GET",
            data: {status: status, page: page},
            dataType: "json",
            contentType: "application/json",
            success: function (result) {
				var html='';
                $.each(result.listOrder, function (i, item) {
                	html+='<tr class="tr-shadow">';
               		html+='    <td class="number_order">'+item.id+'</td>';
            		html+='    <td>';
            		html+='        <span>'+item.code+'</span>';
            		html+='    </td>';
           			html+='    <td>';
  					html+='         '+item.customerName;
          			html+='    </td>';
					html+='    <td>';
					html+='         '+item.customerAddress;
					html+='    </td>';
					html+='     <td>';
					html+='          <span class="text-primary font-weight-bold">'+item.total.toLocaleString('it-IT', { style: 'currency', currency: 'VND' })+'</span>';
					html+='     </td>';
					html+='     <td>';
					html+='          <span class="block-name-product">'+item.createdDate+'</span>';
					html+='     </td>';
					html+='     <td>';
					html+='          <span class="block-name-product">'+item.updatedDate+'</span>';
					html+='     </td>';
					if (update_role=='true') {
						html+='		<td>';
						html+='			<div class="rs-select2--light rs-select2--md">';
						html+='				<select id="'+item.id+'"  onchange="changeSelect('+item.id+');" style="font-size: 14px;color: #808080;width: 177px" class="form-control " name="status">';
						
						switch (item.processingStatus) {
						case 1:
							html+='					<option value="1" selected="true">Đã nhận đơn</option>';
							html+='					<option value="2">Giao cho ĐVVC</option>';
							break;
						case 2:
							html+='					<option value="1">Đã nhận đơn</option>';
							html+='					<option value="2" selected="true">Giao cho ĐVVC</option>';
							html+='					<option value="3">Giao thành công</option>';
							break;
						case 3:
							html+='					<option value="1">Đã nhận đơn</option>';
							html+='					<option value="2">Giao cho ĐVVC</option>';
							html+='					<option value="3" selected="true">Giao thành công</option>';
							break;
						default:
							break;
						}
						html+='				</select>';
						html+='				<div class="dropDownSelect2"></div>';
						html+='			</div>';
						html+='		</td>';
					}
					html+='     <td>';
                    html+='         <div class="table-data-feature">';
                    html+='            <button class="item" title="Xem" onclick="viewOrder('+item.id+')">';
                    html+='               <i class="fas fa-eye"></i>';
                    html+='            </button>';
                    html+='     </td>';
					html+='</tr>';
					html+='<tr class="spacer"></tr>';		
                });
                
                var totalPage = result.listPage[0].totalPage;
                var currentPage = result.listPage[0].currentPage;
                var pagination_string = '';
                if (currentPage > 1) {
                    var previousPage = currentPage - 1;
                    pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + previousPage + '><i class="fas fa-angle-double-left" style="font-size:18px"></i></a></li>';
                }

                for (i = 1; i <= totalPage; i++) {
                    if (i == currentPage) {
                        pagination_string += '<li class="page-item active"><a href="" class="page-link" data-page=' + i +'>' + currentPage + '</a></li>';
                    } else if (i >= currentPage - 3 && i <= currentPage + 4) {
                        pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + i + '>' + i + '</a></li>';
                    }
                }

                if (currentPage > 0 && currentPage < totalPage) {
                    var nextPage = currentPage + 1;
                    pagination_string += '<li class="page-item"><a href="" class="page-link"  data-page=' + nextPage + '><i class="fas fa-angle-double-right" style="font-size:18px"></i></a></li>';
                }
                
                $('#billProcess').html(html);
                $('#paged--list--order--process').html(pagination_string);
            }
        });
    }
    
    
    function LoadOrderSuccessOrDeleted(status,page) {
    	var update_role=$("#update_role").val();
		var delete_role=$("#delete_role").val();
    	 $.ajax({
             url: '/admin/list-order',
             type: "GET",
             data: {status: status, page: page},
             dataType: "json",
             contentType: "application/json",
             success: function (result) {
 				var html='';
                 $.each(result.listOrder, function (i, item) {
                 	html+='<tr class="tr-shadow">';
                	html+='    <td class="number_order">'+item.id+'</td>';
             		html+='    <td>';
             		html+='        <span>'+item.code+'</span>';
             		html+='    </td>';
            		html+='    <td>';
   					html+='         <span>'+item.customerName+'</span>';
           			html+='    </td>';
 					html+='    <td>';
 					html+='         <span>'+item.customerAddress+'</span>';
 					html+='    </td>';
 					html+='     <td>';
 					html+='          <span class="text-primary font-weight-bold">'+item.total.toLocaleString('it-IT', { style: 'currency', currency: 'VND' })+'</span>';
 					html+='     </td>';
 					html+='     <td>';
 					html+='          <span class="block-name-product">'+item.createdDate+'</span>';
 					html+='     </td>';
 					html+='     <td>';
 					html+='          <span class="block-name-product">'+item.updatedDate+'</span>';
 					html+='     </td>';
 					html+='     <td>';
                    html+='         <div class="table-data-feature">';
                    html+='            <button class="item" title="Xem" onclick="viewOrder('+item.id+')">';
                    html+='               <i class="fas fa-eye"></i>';
                    html+='            </button>';
                    if (status==4 && update_role=='true') {
                    	  html+='            <button class="item" title="Xem" onclick="rollBackOrder('+item.id+',0,4)">';
                          html+='               <i class="fas fa-undo"></i>';
                          html+='            </button>';
					}
                    html+='     </td>';
 					html+='</tr>';
 					html+='<tr class="spacer"></tr>';		
                 });
                 
                 var totalPage = result.listPage[0].totalPage;
                 var currentPage = result.listPage[0].currentPage;
                 var pagination_string = '';
                 if (currentPage > 1) {
                     var previousPage = currentPage - 1;
                     pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + previousPage + '><i class="fas fa-angle-double-left" style="font-size:18px"></i></a></li>';
                 }

                 for (i = 1; i <= totalPage; i++) {
                     if (i == currentPage) {
                         pagination_string += '<li class="page-item active"><a href="" class="page-link" data-page=' + i +'>' + currentPage + '</a></li>';
                     } else if (i >= currentPage - 3 && i <= currentPage + 4) {
                         pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + i + '>' + i + '</a></li>';
                     }
                 }

                 if (currentPage > 0 && currentPage < totalPage) {
                     var nextPage = currentPage + 1;
                     pagination_string += '<li class="page-item"><a href="" class="page-link"  data-page=' + nextPage + '><i class="fas fa-angle-double-right" style="font-size:18px"></i></a></li>';
                 }
                 
                if (status==3) {
                	 $('#billReceived').html(html);
                     $('#paged--list--order--success').html(pagination_string);
				}else{
					 $('#billDeleted').html(html);
                     $('#paged--list--order--deleted').html(pagination_string);
				}
             }
         });
	}
    
    $("body").on("click", "#paged--list--new--order li a", function (event) {
        event.preventDefault();
        var currentPage = parseInt($(this).attr('data-page'));
		LoadNewOrder(currentPage);
    });
    
    $("body").on("click", "#paged--list--order--process li a", function (event) {
        event.preventDefault();
        var currentPage = parseInt($(this).attr('data-page'));
        LoadOrderProcess(currentPage);
    });
    
    $("body").on("click", "#paged--list--order--success li a", function (event) {
        event.preventDefault();
        var currentPage = parseInt($(this).attr('data-page'));
        LoadOrderSuccessOrDeleted(3,currentPage);
    });
    
    $("body").on("click", "#paged--list--order--deleted li a", function (event) {
        event.preventDefault();
        var currentPage = parseInt($(this).attr('data-page'));
        LoadOrderSuccessOrDeleted(4,currentPage);
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
    
    function viewOrder(idOrder) {
    	$.ajax({
            url: '/admin/detail-order',
            type: "GET",
            data: {idOrder : idOrder},
            dataType: "json",
            contentType: "application/json",
            success: function (result) {
            	$('#fullname').text(result.saleOrder[0].customerName);
            	$('#email').text(result.saleOrder[0].customerEmail);
            	$('#phone').text(result.saleOrder[0].customerPhone);
            	$('#address').text(result.saleOrder[0].customerAddress);
            	$('#createdDate').text(result.saleOrder[0].createdDate);
            	$('#total').text(result.saleOrder[0].total.toLocaleString('it-IT', { style: 'currency', currency: 'VND' }));
            	$('#code-order').text(result.saleOrder[0].code);
            	$('#id-order').text(result.saleOrder[0].id);
            	switch (result.saleOrder[0].processingStatus) {
				case 0:
					$('#status-orders').addClass("text-dark");
					changeStyleStatus(0);
					break;
				case 1:
					$('#status-orders').text('Đã tiếp nhận');	
					changeStyleStatus(1);
					break;
				case 2:
					$('#status-orders').text('Đang giao');
					changeStyleStatus(2);
					break;
				case 3:
					$('#status-orders').text('Giao thành công');
					changeStyleStatus(3);
					break;
				case 4:
					$('#status-orders').text('Đã hủy');
					changeStyleStatus(4);
					break;
				default:
					break;
				}
            	
            	
				var html='';
                $.each(result.saleOrderProduct, function (i, item) {
                	html+='<div class="d-flex flex-row">';
               		html+='    <img class="" src="${base}/upload/'+item.avatar+'" alt="'+item.productName+'"';
           			html+='        width="100" height="100">';
           			html+='    <div class="ml-4">';
           			html+='        <h5>'+item.productName+'</h5>';
           			html+='        <p>Giá: '+item.price.toLocaleString('it-IT', { style: 'currency', currency: 'VND' })+'</p>';
           			html+='        <p>Số lượng: '+item.quality+'</p>';
           			html+='    </div>';
           			html+='</div>';
           			html+='<br>';			
                }); 
                $('#list--product--order').html(html);
                $('#detail-modal').modal('show');
            }
        });
    	
	}
    
    function changeStatusOrder(idOrder,status,previousStatus) {
    	var status1=parseInt(status);
    	var idOrder1=parseInt(idOrder);
    	$.ajax({
            url: '/admin/status-order?status='+status+'&&idOrder='+idOrder,
            type: "POST",
            data: {},
            dataType: "json",
            contentType: "application/json",
            success: function (result) {     
            	switch (previousStatus) {
				case 0:
					LoadNewOrder(1);
					 $('#modalConfirmOder').modal('hide');
					break;
				case 1:
				case 2:
					LoadOrderProcess(1);
					break;
				case 3:
					LoadOrderSuccessOrDeleted(3,1);
					break;
				case 4:
					LoadOrderSuccessOrDeleted(4,1);
					 $('#modalConfirmOder').modal('hide');
					break;
				default:
					break;
				}
            	showAlertMessage("Thay đổi trạng thái đơn hàng thành công!",true);
            },
            error: function (jqXhr, textStatus, errorMessage) { // error callback 
            	showAlertMessage("Thay đổi trạng thái đơn hàng thất bại!",false);
            }
        });
	}
    
    function changeStyleStatus(status){
    	for (var i = 0; i <= 4; i++) {
			$('#status--'+i).removeClass("text-success");
			$('#status-orders').removeClass("text-dark");
			$('#status-orders').removeClass("text-success");
			$('#status-orders').removeClass("text-danger");
		}
    	if (status!=4) {
    		$('#status--4').addClass("d-none");
    		for (var i = 0; i <= status; i++) {
    			$('#status--'+i).removeClass("d-none");
    			$('#status--'+i).addClass("text-success");
    		}
    		if (status==3) {
    			$('#status-orders').addClass("text-success");
			}else{
				$('#status-orders').addClass("text-dark");
			}
		}else{
			for (var i = 0; i < status; i++) {
				$('#status--'+i).addClass("d-none");
    		}
			$('#status--4').removeClass("d-none");
			$('#status-orders').addClass("text-danger");
		}
    }
    
    function cancelBill(id_bill) {
        $('#btn_save').attr("onclick", "changeStatusOrder(" + id_bill + ",4,0)");
        $('#modalConfirmOderContent').text("Bạn chắc chắn muốn hủy đơn hàng này ?");
        $('#btn_save').show();
        $('#btn_save').text("Có");
        $('#btn_close').css({ "background-color": "#007bff", "border": "1px solid #007bff", "width": "200px" })
        $('#btn_save').css({ "background-color": "rgb(255, 66, 78)", "border": "1px solid rgb(255, 66, 78)", "width": "200px" });
        $('#modalConfirmOder').modal('show');
    };
    
    function rollBackOrder(idOrder,status,previousStatus) {
    	$('#btn_save').attr("onclick", "changeStatusOrder(" + idOrder+","+status+","+previousStatus+")");
        $('#modalConfirmOderContent').text("Bạn chắc chắn muốn lấy lại đơn hàng này ?");
        $('#btn_save').show();
        $('#btn_save').text("Có");
        $('#btn_close').css({ "background-color": "#007bff", "border": "1px solid #007bff", "width": "200px" })
        $('#btn_save').css({ "background-color": "rgb(255, 66, 78)", "border": "1px solid rgb(255, 66, 78)", "width": "200px" });
        $('#modalConfirmOder').modal('show');
	};
    
    function changeSelect(idOrder) {
    	changeStatusOrder(idOrder,$("tr #"+idOrder).val(),1);
	};
    </script>
</body>

</html>
<!-- end document-->