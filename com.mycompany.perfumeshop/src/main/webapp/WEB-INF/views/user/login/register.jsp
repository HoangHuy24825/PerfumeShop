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
    <title>Đăng ký | Electronic Device</title>
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
		                <div class="login_part_text text-center" style="height: 700px">
		                    <div class="login_part_text_iner">
		                        <h2>Bạn đã có tài khoản?</h2>
		                        <p>Đăng nhập ngay để có thể mua sắp một cách thuận tiên hơn!</p>
		                        <a href="${base }/login" class="btn_3">Đăng nhập</a>
		                    </div>
		                </div>
		            </div>
		            <div class="col-lg-6 col-md-6">
	                <div class="login_part_form">
	                    <div class="login_part_form_iner">
	                        <h3 class="mb-4">Đăng ký tài khoản</h3>
	                       <form action="" method="post" id="form-register" enctype="multipart/form-data">
	                            <div class="col-md-12 form-group p_star">
	                                <label>Tài Khoản</label>
                                    <input class="form-control" type="text" name="username" placeholder="Tài Khoản" id="username"/>
                                     <label class="text-danger message_error" style="display:none;width:100%" id="usernameMessage">
						                 <span class="col-md-9 message-content"></span>
						             </label>
	                            </div>
	                            <div class="col-md-12 form-group p_star">
	                                <label>Mật Khẩu</label>
                                    <input class="form-control" type="password" name="password" placeholder="Mật Khẩu" id="password" >
                                    <label class="text-danger message_error" style="display:none;width:100%" id="passwordMessage">
					                 	<span class="col-md-9 message-content"></span>
						             </label>
	                            </div>
	                             <div class="col-md-12 form-group p_star">
	                                <label>Nhập lại mật khẩu</label>
                                    <input class="form-control" type="password" name="re_password" placeholder="Nhập lại mật Khẩu" id="re_password" >
                                    <label class="text-danger message_error" style="display:none;width:100%" id="re_passwordMessage">
					                 	<span class="col-md-9 message-content"></span>
						             </label>
	                            </div>
	                             <div class="col-md-12 form-group p_star">
	                                <label>Họ và tên</label>
                                    <input class="form-control" type="text" name="fullname" placeholder="Họ và tên" id="fullname">
                                    <label class="text-danger message_error" style="display:none;width:100%" id="fullnameMessage">
					                 	<span class="col-md-9 message-content"></span>
						             </label>
	                            </div>
	                             <div class="col-md-12 form-group p_star">
	                                <label>Email</label>
                                    <input class="form-control" type="email" name="email" placeholder="Email" id="email">
                                    <label class="text-danger message_error" style="display:none;width:100%" id="emailMessage">
					                 	<span class="col-md-9 message-content"></span>
						             </label>
	                            </div>
	                             <div class="col-md-12 form-group p_star">
	                                <label>Số điện thoại</label>
                                    <input class="form-control" type="number" name="phone" placeholder="Số điện thoại" id="phone">
                                    <label class="text-danger message_error" style="display:none;width:100%" id="phoneMessage">
					                 	<span class="col-md-9 message-content"></span>
						             </label>
	                            </div>
	                             <div class="col-md-12 form-group p_star">
	                                <label>Địa chỉ</label>
                                    <input class="form-control" type="text" name="address" placeholder="Địa chỉ" id="address">
                                    <label class="text-danger message_error" style="display:none;width:100%" id="addressMessage">
					                 	<span class="col-md-9 message-content"></span>
						             </label>
	                            </div>
	                            <div class="col-md-12 form-group">
	                                <button type="button" value="submit" class="btn_3" onclick="register()">
	                                    Đăng ký
	                                </button>
	                                  <a class="lost_pass" href="${base }/login">Tôi đã có tài khoản!</a>
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
    var regexPhone = /^[0]{1}[0-9]{9,13}$/;
	var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    $(document).ready(function() {
    	
    	setMenuBanner();
    	$('.close-btn-alert').click(function() {
    		$('.alert').removeClass("show");
    		$('.alert').addClass("hide");
    	});
    	
    	$('#username').keydown(function () {
            $('#usernameMessage').hide();
        });
    	$('#password').keydown(function () {
            $('#passwordMessage').hide();
        });
    	$('#re_password').keydown(function () {
            $('#re_passwordMessage').hide();
        });
    	$('#fullname').keydown(function () {
            $('#fullnameMessage').hide();
        });
    	$('#email').keydown(function () {
            $('#emailMessage').hide();
        });
    	$('#phone').keydown(function () {
            $('#phoneMessage').hide();
        });
    	$('#address').keydown(function () {
            $('#addressMessage').hide();
        });
    	
    	$('#code-confirm').keydown(function () {
    		$("#code-confirm-message").hide();
        });
    	
    	
    	 $('#username').focusout(function () {
             if ($(this).val() == "" || $(this).val() == null) {
                 $('#usernameMessage').find('.message-content').text("Tên đăng nhập không được trống!");
                 $('#usernameMessage').show();
             } else {
     			var username=$("#username").val();
     			console.log(username);	
     			$.ajax({
     				type: "GET",
     				url: "/check-username",
     				data: {username:username},
     				dataType: "json",
     	    		contentType: "application/json;charset=utf-8",
     				timeout: 600000,
     				success: function(jsonResult) {
     					if (jsonResult.result==false) {
     						 $('#usernameMessage').find('.message-content').text("Tên đăng nhập đã tồn tại. Vui lòng chọn tên khác!");
     						 $('#usernameMessage').show();
						}else{
							 $('#usernameMessage').hide();
						}
     				},
     				error: function(e) {
     					console.log("ERROR : ", e);
     				}
     			});
             }
         });
    	 $('#password').focusout(function () {
             if ($(this).val() == "" || $(this).val() == null) {
                 $('#passwordMessage').find('.message-content').text("Mật khẩu không được trống!");
                 $('#passwordMessage').show();
             } else {
                 $('#passwordMessage').hide();
             }
         });
		
    	 $('#re_password').focusout(function () {
             if ($(this).val() == "" || $(this).val() == null) {
                 $('#re_passwordMessage').find('.message-content').text("Vui lòng nhập lại mật khẩu!");
                 $('#re_passwordMessage').show();
             } else {
                 $('#re_passwordMessage').hide();
             }
         });
    	 $('#fullname').focusout(function () {
             if ($(this).val() == "" || $(this).val() == null) {
                 $('#fullnameMessage').find('.message-content').text("Vui lòng nhập họ và tên!");
                 $('#fullnameMessage').show();
             } else {
                 $('#fullnameMessage').hide();
             }
         });
    	 $('#email').focusout(function () {
             if ($(this).val() == "" || $(this).val() == null) {
                 $('#emailMessage').find('.message-content').text("Vui lòng nhập email!");
                 $('#emailMessage').show();
             } else {
                 if (!regexEmail.test($('#email').val())) {
                	 $('#emailMessage').find('.message-content').text("Email không hợp lệ!");
                     $('#emailMessage').show();
				}else{
					$('#emailMessage').hide();
				}
             }
         });
    	 $('#phone').focusout(function () {
             if ($(this).val() == "" || $(this).val() == null) {
                 $('#phoneMessage').find('.message-content').text("Vui lòng nhập số điện thoại!");
                 $('#phoneMessage').show();
             } else {
            	 if (!regexPhone.test($('#phone').val())) {
            		 $('#phoneMessage').find('.message-content').text("Số điện thoại không hợp lệ!");
                     $('#phoneMessage').show();
				}else{
            		 $('#phoneMessage').hide();
           		}
             }
         });
    	 $('#address').focusout(function () {
             if ($(this).val() == "" || $(this).val() == null) {
                 $('#addressMessage').find('.message-content').text("Vui lòng nhập địa chỉ!");
                 $('#addressMessage').show();
             } else {
                 $('#addressMessage').hide();
             }
         });
    	 
    });
    
    function validationForm() {
		 var result=true;
		 
		 if ($('#username').val() == "" || $('#username').val() == null) {
            $('#usernameMessage').find('.message-content').text("Tên đăng nhập không được rỗng!");
            $('#usernameMessage').show();
            result=false;
        } else {
        	 var username=$("#username").val();
       	    console.log(username);	
       	    $.ajax({
       	        type: "GET",
       	        url: "/check-username",
       	        data: {username:username},
       	        dataType: "json",
       	        contentType: "application/json;charset=utf-8",
       	        timeout: 600000,
       	        success: function(jsonResult) {
       	            if (jsonResult.result==false) {
       	                    $('#usernameMessage').find('.message-content').text("Tên đăng nhập đã tồn tại. Vui lòng chọn tên khác!");
       	                    $('#usernameMessage').show();
       	                 	result=false;
       	            }
       	        },
       	        error: function(e) {
       	            console.log("ERROR : ", e);
       	        }
       	    });
        }
		 
		if ($('#password').val() == "" || $('#password').val() == null) {
             $('#passwordMessage').find('.message-content').text("Mật khẩu không được rỗng!");
             $('#passwordMessage').show();
             result=false;
		}
		
		 if ($("#email").val() == "" || $("#email").val() == null) {
             $('#emailMessage').find('.message-content').text("Vui lòng nhập email!");
             $('#emailMessage').show();
             result=false;
         } else {
             if (!regexEmail.test($('#email').val())) {
            	 $('#emailMessage').find('.message-content').text("Email không hợp lệ!");
                 $('#emailMessage').show();
                 result=false;
       		  }
          }
		 
		 if ($("#phone").val() == "" || $("#phone").val() == null) {
             $('#phoneMessage').find('.message-content').text("Vui lòng nhập số điện thoại!");
             $('#phoneMessage').show();
             result=false;
         } else {
        	 if (!regexPhone.test($('#phone').val())) {
        		 $('#phoneMessage').find('.message-content').text("Số điện thoại không hợp lệ!");
                 $('#phoneMessage').show();
                 result=false;
			}
         }
		 
		 if ($("#fullname").val() == "" || $("#fullname").val() == null) {
             $('#fullnameMessage').find('.message-content').text("Vui lòng nhập họ và tên!");
             $('#fullnameMessage').show();
             result=false;
         } 
		 
		 if ($("#re_password").val() == "" || $("#re_password").val() == null) {
             $('#re_passwordMessage').find('.message-content').text("Vui lòng nhập lại mật khẩu!");
             $('#re_passwordMessage').show();
             result=false;
         } 
		 
		 if ($("#re_password").val()!=$('#password').val()) {
			 $('#re_passwordMessage').find('.message-content').text("Nhập lại mật khẩu không trùng với mật khẩu mới. Vui lòng nhập lại!");
             $('#re_passwordMessage').show();
             result=false;
		} 
		
		 if ($("#address").val() == "" || $("#address").val() == null) {
            $('#addressMessage').find('.message-content').text("Vui lòng nhập địa chỉ!");
            $('#addressMessage').show();
            result=false;
        } 
		  
		return result;
	}
    
    
    function call_Login() {
    	if(validationForm()){
			$('#form-login').submit();
		}
	}
    
    function setMenuBanner() {
    	var titlebanner='';
    	$("#img-banner").html('<img src="${base}/user/img/my-image/banner/sign-up.png" alt="" width="250">');
    	titlebanner+='<h2>Đăng nhập</h2>';
    	titlebanner+='<p> Trang chủ <span>></span> Đăng ký tài khoản </p>';
    	$("#title-banner").html(titlebanner);
    	
    	$( "#mainNav li" ).each(function( index ) {
    		  $(this).removeClass("my-menu-active");
    	});
    	
	}
    
    function register() {
		if (validationForm()) {
			$("#modal-confirm").modal("show");
			var email=$("#email").val();
			var fullname=$("#fullname").val();
			$.ajax({
				type: "GET",
				enctype: 'multipart/form-data',
				url: "/code-confirm",
				data: {email:email,fullname:fullname},
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
	}
    
    function sendCodeConfirm() {
    	var code_confirm=$("#code-from-server").val();
    	var code_enter=$("#code-confirm").val();
    	if ($("#code-from-server").val()==$("#code-confirm").val()) { 
    		$("#code-confirm").val("");
    		var form = $('#form-register')[0];
    		var data = new FormData(form);
    		$("#modal-confirm").modal("hide");
        	$.ajax({
        		type: "POST",
        		enctype: 'multipart/form-data',
        		url: "/register-account",
        		data: data,
        		processData: false, //prevent jQuery from automatically transforming the data into a query string
        		contentType: false,
        		cache: false,
        		timeout: 600000,
        		success: function(jsonResult) {
        			if (jsonResult.message==true) {
        				alert("Đăng ký tài khoản thành thông!");
            			$(location).attr('href', "/login");
					}else{
						alert("Đăng ký tài khoản thất bại!");
            			$(location).attr('href', "/register");
					}
        		},
        		error: function(e) {
        			console.log("ERROR : ", e);
        		}
        	});
		 }else{
			$("#code-confirm-message").text("Nhập sai mã! Vui lòng nhập lại!");
			$("#code-confirm-message").show();
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

    
    </script>
	<!--::footer_part end::-->
</body>

</html>