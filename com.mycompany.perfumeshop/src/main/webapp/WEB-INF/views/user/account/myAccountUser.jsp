<%@page language="java" contentType="text/html; charset=UTF-8"
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
    <title>Tài khoản | Electronic Device</title>
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

    <!--================Login Area =================-->
   	<section class="login_part mt-3">
		<div class="container mt-3 p-4 bg-white">
		    <div class="row">
		        <div class="col-md-12">
		            <ul class="nav nav-tabs" role="tablist">
		                <li class="nav-item">
		                    <a class="nav-link active" data-toggle="tab" href="#my-account">
		                        <i class="fas fa-user-alt">
		                            Tài
		                            khoản của tôi
		                        </i>
		                    </a>
		                </li>
		                <li class="nav-item" onclick="loadSaleOrder(${userLogined.id})">
		                    <a class="nav-link" data-toggle="tab" href="#my-order">
		                        <i class="fas fa-clipboard-list">
		                            Đơn
		                            mua
		                        </i>
		                    </a>
		                </li>
		            </ul>
		
		            <!-- Tab panes -->
		            <div class="tab-content">
		                <div id="my-account" class="container tab-pane active">
		                    <br>
                            <h3 class="title-5 m-b-35">Tài khoản của tôi</h3>
							<div class="row p-2">
							    <div class="col-md-4 bg-white p-4 border-right">
							        <aside class="profile-nav alt ">
							            <section class="">
							                <div class=" user-header alt">
							                    <div class="" style="align-items:center;">
							                        <div style="text-align:center; ">
							                        	<c:if test="${userLogined.avatar!=null}">
							                            	<img class="align-self-center rounded-circle mr-3 border" style="width:150px; height:150px;" alt="" src="${base }/upload/${userLogined.avatar}">
							                            </c:if>
							                            <c:if test="${userLogined.avatar==null}">
							                            	<img class="align-self-center rounded-circle mr-3 border" style="width:150px; height:150px;" alt="" src="${base }/manager/images/noAvatar.png">
							                            </c:if>
							                        </div>
							                        <div style="text-align:center; ">
							                            <h2 class="text-dark display-6">${userLogined.fullname}</h2>
							                        </div>
							                    </div>
							                </div>
							            </section>
							        </aside>
							    </div>
							    <div class="col-md-8 bg-white  p-4">
							        <div class=" p-2">
							            <ul class="nav nav-pills">
							                <li class="nav-item">
							                    <a class="nav-link active"
							                       href="#inforuser" data-toggle="tab">Thông tin tài khoản</a>
							                </li>
							                <li class="nav-item">
							                    <a class="nav-link"
							                       href="#update-infor" data-toggle="tab">Thông tin cá nhân</a>
							                </li>
							                <li class="nav-item">
							                    <a class="nav-link"
							                       href="#change-password" data-toggle="tab">Mật khẩu</a>
							                </li>
							            </ul>
							        </div>
							        <!-- /.card-header -->
							
							        <div class="">
							            <div class="tab-content">
							                <!-- Thông tin tài khoản -->
							                <div class="active tab-pane" id="inforuser">
							                    <table class="table text-info">
							                        <tr>
							                            <td>
							                                <i class="fas fa-info mr-2 "></i>
							                            </td>
							                            <td>
							                                Họ tên
							                            </td>
							                            <td>
							                                ${userLogined.fullname}
							                            </td>
							                        </tr>
							                        <tr>
							                            <td>
							                                <i class="fas fa-mobile-alt mr-2"></i>
							                            </td>
							                            <td>
							                                Số điện thoại
							                            </td>
							                            <td>
							                               ${userLogined.phone}
							                            </td>
							                        </tr>
							                        <tr>
							                            <td>
							                                <i class="fas fa-map-marker-alt mr-2"></i>
							                            </td>
							                            <td>
							                                Địa chỉ
							                            </td>
							                            <td>
							                                ${userLogined.address}
							                            </td>
							                        </tr>
							                        <tr>
							                            <td>
							                                <i class="fas fa-envelope-open-text mr-2"></i>
							                            </td>
							                            <td>
							                                Email
							                            </td>
							                            <td>
							                                ${userLogined.email}
							                            </td>
							                        </tr>
							                    </table>
							
							                </div>
							                <!-- /.tab-pane -->
							
							                <div class="tab-pane" id="update-infor">
							                     <form class="form-horizontal" action="" method="post" id="form-infor">
							                        <div class="mt-2"></div>
							                         <input type="text" hidden="true" value="${userLogined.id}" name="id" id="Avatar" />
							                        <div class="form-group row">
							                            <div class="col-md-12">
							                                <div class="d-flex justify-content-center">
							                                    <c:if test="${userLogined.avatar!=null }">
							                                        <img id="output" src="${base }/upload/${userLogined.avatar}"
							                                             alt="Ảnh" class="rounded-circle border"
							                                             style="width:100px !important; height:100px !important">
							                                    </c:if>
							                                    <c:if test="${userLogined.avatar==null }">
							                                        <img id="output" src="${base }/manager/images/noAvatar.png" alt="Ảnh" class="rounded-circle border"
							                                             style="width:100px !important; height:100px !important">
							                                   	</c:if>
							                                </div>
							                                <div class="d-flex justify-content-center">
							                                   <!--  <input hidden="true" type="file" name="ImageFile" id="ufile" onchange="loadFile(event)"> -->
							                                    <input type="file" accept="image/png, image/jpeg, image/jpg" hidden="true" value="" name="avatar" id="ufile"  onchange="loadFile(event)"/>
                                  									<label for="ufile" class="label bg-light border p-2 m-3">Chọn ảnh</label>
							                                </div>
							                                 
							                            </div>
							                        </div>
							                        <input class="au-input au-input--full"
							                               type="text" name="username" placeholder="Tên đăng nhập" value="${userLogined.username}" hidden="true">
							                        <div class="form-group">
							                            <label class="col-md-3">Họ & Tên</label>
							                            <input class="form-control col-md-12 text-box single-line valid" type="text" name="fullname" id="fullname" placeholder="Họ tên" value="${userLogined.fullname }" >
							                            <span class="text-danger hide" id="error_full_name"></span>
							                        </div>
							                        <div class="form-group">
							                            <label class="col-md-3">Địa chỉ</label>
							                            <input class="form-control col-md-12 text-box single-line valid" type="text" name="address" id="address" placeholder="Địa chỉ" value="${userLogined.address}">
							                            <span class="text-danger hide" id="error_address"></span>
							                        </div>
							                        <div class="form-group">
							                            <label class="col-md-3">Email</label>
							                            <input class="form-control col-md-12 text-box single-line valid" type="text" name="email" id="email" placeholder="Email" value="${userLogined.email}">
							                            <span class="text-danger hide" id="error_email"></span>
							                        </div>
							                        <div class="form-group">
							                            <label class="col-md-3">Số Điện Thoại</label>
							                            <input id="phone" name="phone" value="${userLogined.phone}" id="phone" class="form-control col-md-12 text-box single-line valid" placeholder="Số điện thoại" />
							                            <span class="text-danger hide" id="error_phone"></span>
							                        </div>
							                        <input hidden="true" id="Pasword" name="password" value="${userLogined.password}" />
							                        <div class="form-group">
							                            <button type="button" class="btn btn-outline-primary" onclick="clickUpdateInfo()">
							                                <i class="ace-icon fa fa-check bigger-110"></i> Cập Nhật
							                            </button>
							                        </div>
							                     </form>
							                </div>
							                <!-- /.tab-pane -->
							                <!-- Cập nhật mật khẩu -->
							                <div class="tab-pane" id="change-password">
							                    <form class="form-horizontal" action="" method="post">
							                        <div class="space-10"></div>
							                        <div class="form-group">
							                            <label class="col-sm-3 control-label no-padding-right"
							                                   for="oldPassword">Mật khẩu hiện tại</label>
							
							                            <div class="col-sm-9">
							                                <div class="input-group">
							                                    <input class="form-control" type="password" id="OldPassword" name="OldPassword" />
							                                </div>
							                                <span id="error_old_password" class="text-danger hide"></span>
							                            </div>
							                        </div>
							                        <div class="form-group">
							                            <label class="col-sm-3 control-label no-padding-right"
							                                   for="password">Mật khẩu mới</label>
							
							                            <div class="col-sm-9">
							                                <div class="input-group">
							                                    <input class="form-control" type="password" id="NewPassword" name="NewPassword" />
							
							                                </div>
							                                <span id="error_new_password" class="text-danger hide"></span>
							                            </div>
							                        </div>
							                        <div class="form-group">
							                            <label class="col-sm-3 control-label no-padding-right" for="confirmPassword">Nhập lại mật khẩu</label>
							                            <div class="col-sm-9">
							                                <div class="input-group">
							                                    <input class="form-control" type="password" id="ConfirmPassword" name="ConfirmPassword" />
							                                </div>
							                                <span class="hide text-danger" id="error_confirm_password"></span>
							                            </div>
							                        </div>
							                        <div class="clearfix form-actions">
							                            <div class="col-md-offset-3 col-md-9">
							                                <button class="btn btn-outline-primary" type="button" onclick="changePassword()">
							                                    <i class="ace-icon fa fa-check bigger-110"></i> Cập nhật
							                                </button>
							                            </div>
							                        </div>
							                    </form>
							                </div>
							                <!-- /.tab-pane -->
							            </div>
							            <!-- /.tab-content -->
							        </div>
							    </div>
							</div>
		                </div>
		                <div id="change-pass" class="container tab-pane">
		                    
		                </div>
		                <div id="my-order" class="container tab-pane fade">
		                    <br>
		                    <h3>Đơn hàng của tôi</h3>
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
		</div>
	</section>
    <!--================End Account Area =================-->

    <!--::footer_part start::-->
   	 <jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
    <!--::footer_part end::-->
    
    <!-- modal orders -->
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
    
    
    <!--::message_part start::-->
	<div class="alert hide" id="alert_message">
	    <div id="icon-alert-message"><i class="fas fa-exclamation-circle"></i></div>
	    <span class="msg">Warning: This is a warning alert!</span>
	    <div class="close-btn-alert">
	        <span class="fas fa-times"></span>
	    </div>
	</div>
	<!--::message_part end::-->
	
	<!-- START MODAL CONFIRM -->
	<div class="modal fade" id="modalConfirmOder" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-body " id="modalConfirmOderContent" style="font-size:14px ">
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
	            <textarea class="form-control" id="input-request-cancel" name="input-request-cancel" rows="3">
	            	
	            </textarea>
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
	
    <!-- jquery plugins here-->
    <jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
    <script type="text/javascript">
    var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	var regexPhone = /^[0]{1}[0-9]{9,13}$/;
    $(document).ready(function() {
    	setMenuBanner();
    	
    	$('.close-btn-alert').click(function() {
    		$('.alert').removeClass("show");
    		$('.alert').addClass("hide");
    	});
    	
    	 $('#error_full_name').hide();
         $('#error_address').hide();
         $('#error_email').hide();
         $('#error_phone').hide();
         $('#error_old_password').hide();
         $('#error_new_password').hide();
         $('#error_confirm_password').hide();
         
         $('#input-request-cancel').keydown(function () {
             $('#request-cancel-message').hide();
         });
         
         $('#fullname').keydown(function () {
             $('#error_full_name').hide();
         });
         $('#address').keydown(function () {
             $('#error_address').hide();
         });
         $('#email').keydown(function () {
             $('#error_email').hide();
         });
         $('#phone').keydown(function () {
             $('#error_phone').hide();
         });
         
         $('#OldPassword').keydown(function () {
             $('#error_old_password').hide();
         });
         
         $('#NewPassword').keydown(function () {
             $('#error_new_password').hide();
         });
         
         $('#ConfirmPassword').keydown(function () {
             $('#error_confirm_password').hide();
         });
         
         $("#fullname").focusout(function() {
            	if ($(this).val()==null||$(this).val()=="") {
     			$("#error_full_name").text("Tên người dùng không được trống!");
     			$("#error_full_name").show();
     		}else{
     			$("#error_full_name").hide();
     		}
          })
          
           $("#address").focusout(function() {
            	if ($(this).val()==null||$(this).val()=="") {
     			$("#error_address").text("Địa chỉ người dùng không được trống!");
     			$("#error_address").show();
     		}else{
     			$("#error_address").hide();
     		}
          })
          
           $("#email").focusout(function() {
            	if ($(this).val()==null||$(this).val()=="") {
     			$("#error_email").text("Email người dùng không được trống!");
     			$("#error_email").show();
     		}else{
     			 if (!regexEmail.test($(this).val())) {
     				 $("#error_email").text("Email người dùng không hợp lệ!");
     				 $("#error_email").show();
                  } else {
                      $('#error_email').hide();
                  }
     		}
          })
          
           $("#phone").focusout(function() {
            	if ($(this).val()==null||$(this).val()=="") {
     			$("#error_phone").text("Số điện thoại người dùng không được trống!");
     			$("#error_phone").show();
     		}else{
     			if (!regexPhone.test($(this).val())) {
     				$("#error_phone").text("Số điện thoại không hợp lệ!");
     				$("#error_phone").show();
                 } else {
                     $('#error_phone').hide();
                 }
     		}
          })
          
           $("#OldPassword").focusout(function() {
            	if ($(this).val()==null||$(this).val()=="") {
     			$("#error_old_password").text("Mật khẩu hiện tại không được trống!");
     			$("#error_old_password").show();
     		}else{
     			$("#error_old_password").hide();
     		}
          })
          
           $("#NewPassword").focusout(function() {
            	if ($(this).val()==null||$(this).val()=="") {
     			$("#error_new_password").text("Mật khẩu mới không được trống!");
     			$("#error_new_password").show();
     		}else{
     			$("#error_new_password").hide();
     		}
          })
          
           $("#ConfirmPassword").focusout(function() {
            	if ($(this).val()==null||$(this).val()=="") {
     			$("#error_confirm_password").text("Vui lòng nhập lại mật khẩu mới!");
     			$("#error_confirm_password").show();
     		}else{
     			$("#error_confirm_password").hide();
     		}
          })
    });
    
   
    function setMenuBanner() {
    	var titlebanner='';
    	$("#img-banner").html('<img class="avatar rounded-circle" src="'+$('#output').attr('src')+'" alt="">');
    	titlebanner+='<h2>Thông tin tài khoản</h2>';
    	titlebanner+='<p> Trang chủ <span>></span> Thông tin tài khoản </p>';
    	$("#title-banner").html(titlebanner);
    	
    	$( "#mainNav li" ).each(function( index ) {
    		  $(this).removeClass("my-menu-active");
    	});
    	
	}
    
    function validateFormInfor() {
    	var result=true;
    	
   		if ($("#fullname").val()==null||$("#fullname").val()=="") {
   			$("#error_full_name").text("Tên người dùng không được trống!");
   			$("#error_full_name").show();
   			result=false;
   		}
   		
   		if ($("#address").val()==null||$("#address").val()=="") {
			$("#error_address").text("Địa chỉ người dùng không được trống!");
			$("#error_address").show();
			result=false;
		}
   		
   		if ($("#email").val()==null||$("#email").val()=="") {
			$("#error_email").text("Email người dùng không được trống!");
			$("#error_email").show();
			result=false;
		}else{
			 if (!regexEmail.test($("#email").val())) {
				 $("#error_email").text("Email người dùng không hợp lệ!");
				 $("#error_email").show();
				 result=false;
			}
		}
   		
   		if ($("#phone").val()==null||$("#phone").val()=="") {
			$("#error_phone").text("Số điện thoại người dùng không được trống!");
			$("#error_phone").show();
			result=false;
		}else{
			if (!regexPhone.test($("#phone").val())) {
				$("#error_phone").text("Số điện thoại không hợp lệ!");
				$("#error_phone").show();
				result=false;
			}
		}
   		return result;
	}
     
   	function clickUpdateInfo() {
   		if (validateFormInfor()) {
   			var form = $('#form-infor')[0];
   			var data = new FormData(form);
   			for (var value of data.values()) {
   				   console.log(value);
   			}
   			$.ajax({
   				type: "POST",
   				enctype: 'multipart/form-data',
   				url: "/add-update-account",
   				data: data,
   				processData: false, //prevent jQuery from automatically transforming the data into a query string
   				contentType: false,
   				cache: false,
   				timeout: 600000,
   				success: function(data) {
   					showAlertMessage("Đổi thông tin thành công!",true);
   					window.location.href = '/my-account';
   				},
   				error: function(e) {
   					console.log("ERROR : ", e);
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

    function validateFormChangePassword() {
    	var result=true;
    	
   		if ($("#OldPassword").val()==null||$("#OldPassword").val()=="") {
   			$("#error_old_password").text("Mật khẩu hiện tại không được trống!");
   			$("#error_old_password").show();
   			result=false;
   		}
   		
   		if ($("#NewPassword").val()==null||$("#NewPassword").val()=="") {
			$("#error_new_password").text("Mật khẩu mới không được trống!");
			$("#error_new_password").show();
			result=false;
		}
   		
   		if ($("#ConfirmPassword").val()==null||$("#ConfirmPassword").val()=="") {
			$("#error_confirm_password").text("Vui lòng nhập lại mật khẩu!");
			$("#error_confirm_password").show();
			result=false;
		}
   		return result;
	}
  
  function changePassword() {
		if (validateFormChangePassword()) {
			var oldPassword=$("#OldPassword").val();
			var newPassword=$("#NewPassword").val();
			var reNewPassword=$("#ConfirmPassword").val();
			
			if (newPassword!=reNewPassword) {
				$("#error_confirm_password").text("Nhập lại mật khẩu mới phải trùng mới mật khẩu mới!");
				$("#error_confirm_password").show();
			}else{
				$.ajax({
	   				type: "POST",
	   				enctype: 'multipart/form-data',
	   				url: "/update-password?oldPass="+oldPassword+"&&newPass="+newPassword,
	   				data: {},
	   				processData: false, //prevent jQuery from automatically transforming the data into a query string
	   				contentType: false,
	   				cache: false,
	   				timeout: 600000,
	   				success: function(jsonResult) {
	   					if (jsonResult.message==true) {
	   						showAlertMessage("Đổi mật khẩu thành công!",true);
	   	   					window.location.href = '/my-account';
						}else{
							$('#error_old_password').text("Sai mật khẩu!");
		   					$('#error_old_password').show();
		   					showAlertMessage("Đổi mật khẩu thất bại!",false);
						}
	   				},
	   				error: function(e) {
	   				}
	   			});
			}
		}
	} 
  
	  const loadFile = (event) => {
	      let image = document.getElementById('output');
	      image.src = URL.createObjectURL(event.target.files[0]);
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
  
	  function loadSaleOrder(idAccount) {
          $.ajax({
              url: '/load-sale-order-id-account',
              data: { idAccount: idAccount },
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
                          html += '<button style="border:unset" type="button" class="btn_1 checkout_btn_1 btn_billAccount" id="btn_pay" onclick="cancelOrder(' + item.id +')">Hủy đơn hàng</button>';
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
    </script>
	<!--::footer_part end::-->
</body>

</html>