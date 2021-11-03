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
                                <!-- CONTENT PAGE -->
                                <!-- DATA TABLE -->
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
									                            <label>Họ & Tên</label>
									                            <input class="au-input au-input--full" type="text" name="fullname" id="fullname" placeholder="Họ tên" value="${userLogined.fullname }" >
									                            <span class="text-danger hide" id="error_full_name"></span>
									                        </div>
									                        <div class="form-group">
									                            <label>Địa chỉ</label>
									                            <input class="au-input au-input--full" type="text" name="address" id="address" placeholder="Địa chỉ" value="${userLogined.address}">
									                            <span class="text-danger hide" id="error_address"></span>
									                        </div>
									                        <div class="form-group">
									                            <label>Email</label>
									                            <input class="au-input au-input--full" type="text" name="email" id="email" placeholder="Email" value="${userLogined.email}">
									                            <span class="text-danger hide" id="error_email"></span>
									                        </div>
									                        <div class="form-group">
									                            <label>Số Điện Thoại</label>
									                            <input id="phone" name="phone" value="${userLogined.phone}" id="phone" class="au-input au-input--full" placeholder="Số điện thoại" />
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
                                <!-- END DATA TABLE -->
                                <div class="my-3">
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination justify-content-center" id="paged--list">
                                            <!-- paging category -->
                                        </ul>
                                    </nav>
                                </div>

                                 <!-- END CONTENT PAGE -->
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

	 <!-- START MODAL CONFIRM -->
	<div class="modal fade" id="modalConfirmOder" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-body " id="modalConfirmOderContent" style="font-size:22px ">
	                <!--content-->
	            </div>
	            <div class="modal-footer mx-auto" style="border:unset">
	                <button type="button" id="btn_close" onclick="hideModal()" class="btn btn-secondary" data-dismiss="modal" aria-label="Close">
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
     <%-- <script type="text/javascript" src="${base }/manager/js/categoryScript/category.js"></script> --%>
     <script type="text/javascript">
	 var regexEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	 var regexPhone = /^[0]{1}[0-9]{9,13}$/;
     $(document).ready(function() {
    	 $('#error_full_name').hide();
         $('#error_address').hide();
         $('#error_email').hide();
         $('#error_phone').hide();
         $('#error_old_password').hide();
         $('#error_new_password').hide();
         $('#error_confirm_password').hide();
         
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
   				url: "/admin/add-update-account",
   				data: data,
   				processData: false, //prevent jQuery from automatically transforming the data into a query string
   				contentType: false,
   				cache: false,
   				timeout: 600000,
   				success: function(data) {
   					showAlertMessage("Đổi thông tin thành công!",true);
   					window.location.href = '/admin/my-account';
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
      
      const loadFile = (event) => {
          let image = document.getElementById('output');
          image.src = URL.createObjectURL(event.target.files[0]);
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
	   				url: "/admin/update-password?oldPass="+oldPassword+"&&newPass="+newPassword,
	   				data: {},
	   				processData: false, //prevent jQuery from automatically transforming the data into a query string
	   				contentType: false,
	   				cache: false,
	   				timeout: 600000,
	   				success: function(jsonResult) {
	   					if (jsonResult.message==true) {
	   						showAlertMessage("Đổi mật khẩu thành công!",true);
	   	   					window.location.href = '/admin/my-account';
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
     </script>
</body>

</html>
<!-- end document-->