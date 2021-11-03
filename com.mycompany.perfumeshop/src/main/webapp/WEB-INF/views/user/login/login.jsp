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
	                <div class="login_part_form">
	                    <div class="login_part_form_iner">
	                        <h3>Đăng nhập</h3>
	                       <form action="/perform_login" method="post" id="form-login">
	                       		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}">
	                            <div class="col-md-12 form-group p_star">
	                                <label>Tài Khoản</label>
                                    <input class="form-control" type="text" name="username" placeholder="Tài Khoản" id="username"/>
                                     <label class="text-danger message_error" style="display:none;width:100%" id="usernameMessage">
						                 <span class="col-md-9 message-content"></span>
						             </label>
	                            </div>
	                            <div class="col-md-12 form-group p_star">
	                                <label>Mật Khẩu</label>
                                    <input class="form-control" type="password" name="password" placeholder="Mật Khẩu" id="password" onkeypress="return runScript(event)" >
                                    <label class="text-danger message_error" style="display:none;width:100%" id="passwordMessage">
					                 	<span class="col-md-9 message-content"></span>
						             </label>
	                            </div>
	                            <div class="col-md-12 form-group">
	                                <div class="creat_account d-flex align-items-center">
	                                    <input type="checkbox" id="f-option" name="selector">
	                                    <label for="f-option">Nhớ mật khẩu</label>
	                                </div>
	                                <button type="button" value="submit" class="btn_3" onclick="call_Login()">
	                                    Đăng nhập
	                                </button>
	                                <a class="lost_pass" href="${base}/forget-password">Quên mật khẩu?</a>
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
	
    <!-- jquery plugins here-->
    <jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
    <script type="text/javascript">
    $(document).ready(function() {
    	setMenuBanner();
    	$('.close-btn-alert').click(function() {
    		$('.alert').removeClass("show");
    		$('.alert').addClass("hide");
    	});
    	
    	let searchParams = new URLSearchParams(window.location.search);
    	if(searchParams.has('login_error')){
    		let param = searchParams.get('login_error');
    		if(param){
    			showAlertMessage("Sai tên đăng nhập hoặc mật khẩu!",false);
    		}
    	}
    	
    	$('#username').keydown(function () {
            $('#usernameMessage').hide();
        });
    	
    	$('#password').keydown(function () {
            $('#passwordMessage').hide();
        });
    	
    	 $('#username').focusout(function () {
             if ($(this).val() == "" || $(this).val() == null) {
                 $('#usernameMessage').find('.message-content').text("Tên đăng nhập không được rỗng!");
                 $('#usernameMessage').show();
             } else {
                 $('#usernameMessage').hide();
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
    	
    	 
    });
    
    function validationForm() {
		 var result=true;
		 
		 if ($('#username').val() == "" || $('#username').val() == null) {
            $('#usernameMessage').find('.message-content').text("Tên đăng nhập không được rỗng!");
            $('#usernameMessage').show();
            result=false;
        } else {
            $('#usernameMessage').hide();
        }
		 
		  if ($('#password').val() == "" || $('#password').val() == null) {
             $('#passwordMessage').find('.message-content').text("Mật khẩu không được rỗng!");
             $('#passwordMessage').show();
             result=false;
         } else {
             $('#passwordMessage').hide();
         }
		  
		  return result;
	}
    
    function runScript(e) {
	    if (e.keyCode == 13) {
	    	call_Login();
	    }
	} 
    
    function call_Login() {
    	if(validationForm()){
			$('#form-login').submit();
		}
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