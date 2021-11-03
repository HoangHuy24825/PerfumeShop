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
    <meta name="description" content="au theme template">
    <meta name="author" content="Hau Nguyen">
    <meta name="keywords" content="au theme template">

    <!-- Title Page-->
    <title>Tài khoản | Admin Electronic Device</title>
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
                            <div class="col-md-12">
                                <!-- DATA TABLE -->
                                <div class="d-flex">
                                    <a href="${base}/admin/account" class="btn_back_list"><i class="fa fa-arrow-left"></i></a> &nbsp
                                    <h3 class="title-5 m-b-35">Thêm tài khoản nhân viên</h3>
                                </div>
                                <div class="">
                                    <div class="bg-light p-4">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <form id="form--upload" enctype="multipart/form-data" >
                                                    
                                                    <input name="id" id="id" type="number" hidden="true" value="${id_product}"/>

                                                   <div class="form-group">
                                                        <label for="username">Tên đăng nhập <span class="required_field">*</span></label>
                                                        <input autocomplete="off" type="text" class="form-control" id="username" name="username" placeholder="Tên đăng nhập" required="required" ></input>
                                                        <p	class="text-danger" id="username_error"></p>
                                                    </div>
                                                    
                                                     <div class="form-group">
                                                        <label for="fullname">Họ tên nhân viên <span class="required_field">*</span></label>
                                                        <input autocomplete="off" type="text" class="form-control" id="fullname" name="fullname" placeholder="Họ tên nhân viên" required="required" ></input>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="password">Mật khẩu <span class="required_field">*</span></label>
                                                        <input type="password" autocomplete="off" class="form-control" id="pasword" name="password" placeholder="Mật khẩu" required="required"></input>
                                                    </div>
                                                    
                                                    <div class="form-group">
                                                        <label for="email">Email <span class="required_field">*</span></label>
                                                        <input type="email" autocomplete="off" class="form-control" id="email" name="email" placeholder="email" required="required"></input>
                                                    </div>

                                                     <div class="form-group">
                                                        <label for="phone">Số điện thoại <span class="required_field">*</span> </label>
                                                        <input type="number" autocomplete="off" class="form-control" id="phone" name="phone" placeholder="Số điện thoại" required="required"></input>
                                                    </div>
                                                    <div class="form-group">
                                                        <a class="btn btn-secondary" href="${base}/admin/account">Hủy</a>
                                                        <button type="button" class="btn btn-primary" onclick="saveOrUpdate()">Lưu</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <jsp:include page="/WEB-INF/views/manager/layout/footer.jsp"></jsp:include>
                    </div>
                </div>
            </div>
        </div>
        <!-- END PAGE CONTAINER-->
    </div>

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
    <%-- <script type="text/javascript" src="${base }/manager/js/productScript/addOrUpdateProduct.js"></script> --%>
	<script type="text/javascript">
	$(document).ready(function() {
		setActiveMenu();
		$("#username_error").hide();
		$("#username").keydown(function () {
			$("#username_error").hide();
		});
	});
	
	
	 function setActiveMenu() {
	     	console.log("call");
	     	$( ".navbar__list li" ).each(function() {
	     		$(this).removeClass("active");
	     	});
	     	$( ".list-unstyled li" ).each(function() {
	     		$(this).removeClass("active");
	     	});
	     	$('.list-unstyled #menu--account').addClass("active");
	     	$('.navbar__list #menu--account').addClass("active");
	 }


	//function to add new product
	function saveOrUpdate() {
		var form = $('#form--upload')[0];
		var data = new FormData(form);
		var typeAccount=1;
		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: "/admin/add-update-account?typeAccount="+typeAccount,
			data: data,
			processData: false, //prevent jQuery from automatically transforming the data into a query string
			contentType: false,
			cache: false,
			timeout: 600000,
			success: function(jsonResult) {
				if (jsonResult.result==true) {
					showAlertMessage("Thêm thành công!",true);
					$(location).attr('href', "/admin/account");
				}else{
					showAlertMessage("Thêm thất bại!",false);
					$("#username_error").text(jsonResult.message+'');
					$("#username_error").show();
				}
			},
			error: function(e) {
				console.log("ERROR : ", e);
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
</body>

</html>
<!-- end document-->