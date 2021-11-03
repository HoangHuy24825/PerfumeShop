/* STATUS TO CHECK MODAL SHOW ALL NOTIFY OPEN/CLOSE */
var status_all_notify_modal=false;

$(document).ready(function(){
	$('a[href="' + location.pathname + '"]').closest('li').addClass('active'); 
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

	$('#input-reason-reject').keydown(function () {
            $('#reason-message-error').hide();
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
            	
            	$("#reason-notify-detail").text(result.notify.reason);
            	
            	
				var html='';
                $.each(result.saleOrderProduct, function (i, item) {
                	html+='<div class="d-flex flex-row">';
               		html+='    <img class="" src="/upload/'+item.avatar+'" alt="'+item.productName+'"';
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
	  	if($("#input-reason-reject").val()!=null&&$("#input-reason-reject").val()!=""){
			$('#modal-reason-reject').modal('hide');
   			showAlertMessage("Email từ chối đề nghị hủy đơn đã được gửi!",true);
       		sentEmailConfirm(idOrder,0,$('#input-reason-reject').val());
			$("#input-reason-reject").val("");
		}else{
			$("#reason-message-error").text("Vui lòng nhập lý do để thông báo cho khách hàng!");
			$("#reason-message-error").show();
		}
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

