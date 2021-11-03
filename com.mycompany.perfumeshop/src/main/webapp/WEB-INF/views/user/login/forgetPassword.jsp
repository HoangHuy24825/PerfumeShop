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
    <title>Login | Electronic Device</title>
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
    <div class="container p-4 bg-white">
		        <div class="row align-items-center">
		            <div class="col-lg-6 col-md-6">
		                <div class="login_part_text text-center">
		                    <div class="login_part_text_iner">
		                        <h2>Bạn mới đến với cửa hàng của chúng tôi?</h2>
		                        <p>Tạo một tài khoản để tham gia mua sắm được dễ dàng và thuận tiện hơn!</p>
		                        <a href="${base }/register" class="btn_3">Tạo một tài khoản</a>
		                    </div>
		                </div>
		            </div>
		            <div class="col-lg-6 col-md-6">
		                <div class="login_part_form" style="width: 100%" id="form-send-requet-get-password">
		                    <div class="login_part_form_iner">
		                        <h3>Quên mật khẩu</h3>
		                       	<form>
		                            <div class="col-md-12 form-group p_star">
		                                <label>Nhập email đăng ký tài khoản</label>
	                                    <input class="form-control" type="email" name="email" placeholder="Email" id="email" />
	                                     <label class="text-danger message_error" style="display:none;width:100%" id="emailMessage">
							                 <span class="col-md-9 message-content"></span>
							             </label>
		                            </div>
		                            <div class="col-md-12 form-group">
		                                <button type="button" value="button" class="btn_3" onclick="requestCode()">
		                                    Lấy lại mật khẩu
		                                </button>
		                            </div>
		                        </form>
	                    	</div>
	                	</div>
	                	 <div class="login_part_form" id="form-change-password">
		                    <div class="login_part_form_iner">
		                        <h3>Đổi mật khẩu mới</h3>
		                       <form>
	                       			<input type="text" class="form-control" style="display: none" id="emailHidden" value="">
		                            <div class="col-md-12 form-group p_star">
		                                <label>Mật khẩu mới</label>
	                                    <input class="form-control" type="password" name="password" placeholder="Mật khẩu mới" id="password"/>
	                                     <label class="text-danger message_error" style="display:none;width:100%" id="passwordMessage">
							                 <span class="col-md-9 message-content"></span>
							             </label>
		                            </div>
		                            <div class="col-md-12 form-group p_star">
		                                <label>Nhập lại mật khẩu</label>
	                                    <input class="form-control" type="password" name="password" placeholder="Mật Khẩu" id="re-password">
	                                    <label class="text-danger message_error" style="display:none;width:100%" id="re-passwordMessage">
						                 	<span class="col-md-9 message-content"></span>
							             </label>
		                            </div>
		                            <div class="col-md-12 form-group">
		                                <button type="button" value="submit" class="btn_3" onclick="changePassword()">
		                                    Đổi mật khẩu
		                                </button>
		                            </div>
		                        </form>
	                    	</div>
                		</div>
            	</div>
        	</div>
    	</div>
	</section>
    <!--================End Login Area =================-->

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
	
    <!-- jquery plugins here-->
    <jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
    <script type="text/javascript">
    var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    $(document).ready(function() {
    	$("#form-change-password").hide();
    	$("#form-send-requet-get-password").show();
    	setMenuBanner();
    	$('.close-btn-alert').click(function() {
    		$('.alert').removeClass("show");
    		$('.alert').addClass("hide");
    	});
    	
    	$('#email').bind('keypress keydown keyup', function(e){
    	       if(e.keyCode == 13) { 
    	    	   e.preventDefault();
    	    	   requestCode();
    	       }
    	});
    	
    	let searchParams = new URLSearchParams(window.location.search);
    	if(searchParams.has('login_error')){
    		let param = searchParams.get('login_error');
    		if(param){
    			showAlertMessage("Sai tên đăng nhập hoặc mật khẩu!",false);
    		}
    	}
    	
    	$('#email').keydown(function () {
            $('#emailMessage').hide();
        });
    	
    	$('#password').keydown(function () {
            $('#passwordMessage').hide();
        });
    	
    	 $('#email').focusout(function () {
             if ($(this).val() == "" || $(this).val() == null) {
                 $('#emailMessage').find('.message-content').text("Vui lòng nhập email!");
                 $('#emailMessage').show();
             } else {
            	 if (!regexEmail.test($(this).val())) {
                     $('#emailMessage').find('.message-content').text("Email người nhận không hợp lệ!");
                     $('#emailMessage').show();
                 } else {
                     $('#emailMessage').hide();
                     
                 }
             }
         });
    	 
    	 $('#password').focusout(function () {
             if ($(this).val() == "" || $(this).val() == null) {
                 $('#passwordMessage').find('.message-content').text("Mật khẩu không được rỗng!");
                 $('#passwordMessage').show();
             } else {
                 $('#passwordMessage').hide();
             }
         });
    	
    	 $('#re-password').keydown(function () {
             $('#re-passwordMessage').hide();
         });
     	
    	 $('#re-password').focusout(function () {
             if ($(this).val() == "" || $(this).val() == null) {
                 $('#re-passwordMessage').find('.message-content').text("Vui lòng nhập lại mật khẩu!");
                 $('#re-passwordMessage').show();
             } else {
                 $('#re-passwordMessage').hide();
             }
         });
    	 
    	 $('#code-confirm').keydown(function () {
     		$("#code-confirm-message").hide();
         });
    });
    
    function requestCode() {
		if (validationFormRequest()) {
			
			var email=$("#email").val();
			email=email.replace("@","-");
			$("#emailHidden").val(email);
			
			$.ajax({
				type: "GET",
				enctype: 'multipart/form-data',
				url: "/code-request-forget-password",
				data: {email:email},
				contentType: JSON,
				timeout: 600000,
				success: function(jsonResult) {
					if (jsonResult.code==0) {
						 $('#emailMessage').find('.message-content').text("Email này chưa được đăng ký tài khoản!");
			             $('#emailMessage').show();
					}else{
						sendEmailCode();
					}
				},
				error: function(e) {
					console.log("ERROR : ", e);
				}
			});
		}
	}
    
    function sendEmailCode() {
    	$("#modal-confirm").modal("show");
    	var email=$("#emailHidden").val();
    	$.ajax({
			type: "GET",
			enctype: 'multipart/form-data',
			url: "/send-email-code-confirm",
			data: {email:email},
			contentType: JSON,
			timeout: 600000,
			success: function(jsonResult) {
				$("#code-from-server").val(jsonResult.codeConfirm);
			},
			error: function(e) {
				console.log("ERROR : ", e);
			}
		});
	}
    
   	function changePassword() {
		if (validationFormNewPass()) {
			var email=$("#emailHidden").val();
			var password=$("#password").val();
			console.log(email);
			if ($("#password").val()==$("#re-password").val()) {
				$.ajax({
					type: "GET",
					enctype: 'multipart/form-data',
					url: "/change-password-forget",
					data: {email:email,password:password},
					contentType: JSON,
					timeout: 600000,
					success: function(jsonResult) {
						showAlertMessage("Đổi mật khẩu thành công!",true);
						window.location.href = '/login';
					},
					error: function(e) {
						console.log("ERROR : ", e);
					}
				});
			}else{
				 $('#re-passwordMessage').find('.message-content').text("Vui lòng nhập lại mật khẩu trùng với mật khẩu mới!");
		            $('#re-passwordMessage').show();
			}
		}
	}
   	
   	function sendCodeConfirm() {
    	var code_confirm=$("#code-from-server").val();
    	$("#modal-confirm").modal("hide");
    	var code_enter=$("#code-confirm").val();
    	if ($("#code-from-server").val()==$("#code-confirm").val()) { 
    		$("#code-confirm").val("");
    		$("#form-change-password").show();
    		$("#form-send-requet-get-password").hide();
		 }else{
			$("#code-confirm-message").text("Nhập sai mã! Vui lòng nhập lại!");
			$("#code-confirm-message").show();
		}
	}
    
    function validationFormNewPass() {
		 var result=true;
		 
		  if ($('#password').val() == "" || $('#password').val() == null) {
             $('#passwordMessage').find('.message-content').text("Mật khẩu không được rỗng!");
             $('#passwordMessage').show();
             result=false;
         } else {
             $('#passwordMessage').hide();
         }
		  
		  if ($("#re-password").val() == "" || $("#re-password").val() == null) {
              $('#re-passwordMessage').find('.message-content').text("Vui lòng nhập lại mật khẩu!");
              $('#re-passwordMessage').show();
              result=false;
          } else {
              $('#re-passwordMessage').hide();
          }
		  
		  return result;
	}
    
    function validationFormRequest() {
		 var result=true;
		 
		 if ($("#email").val().trim() == "" || $("#email").val().trim() == null) {
             $('#emailMessage').find('.message-content').text("Vui lòng nhập email!");
             $('#emailMessage').show();
             result=false;
         } else {
        	 if (!regexEmail.test($("#email").val())) {
                 $('#emailMessage').find('.message-content').text("Email người nhận không hợp lệ!");
                 $('#emailMessage').show();
                 result=false;
             } else {
                 $('#emailMessage').hide();
                 
             }
         }
		  
		  return result;
	}
    
    function setMenuBanner() {
    	var titlebanner='';
    	$("#img-banner").html('<img src="${base}/user/img/my-image/banner/login.png" alt="" width="250">');
    	titlebanner+='<h2>Đăng nhập</h2>';
    	titlebanner+='<p> Trang chủ <span>></span> Đăng nhập </p>';
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

    
    </script>
	<!--::footer_part end::-->
</body>

</html>