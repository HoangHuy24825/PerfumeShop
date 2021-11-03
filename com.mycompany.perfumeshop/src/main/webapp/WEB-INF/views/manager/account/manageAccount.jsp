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
                            <div class="col-md-12" id="content_page">            
		           	<h3 class="title-5 m-b-35">Danh sách người dùng</h3>
		           	  <div class="table-data__tool">
	                     <div class="table-data__tool-left">
	                     
	                     </div>
	                     <div class="table-data__tool-right">
	                     	<c:if test="${productRole.insert ==true}">	
		                         <button class="au-btn au-btn-icon au-btn--green au-btn--small" onclick="location.href='${base}/admin/add-account'">
		                             <i class="fas fa-plus"></i>Thêm mới nhân viên
		                         </button>
		                  	</c:if>
		                  	<input id="update_role" value="${productRole.update}" type="text" style="display: none"/> 
	                     </div>
                    </div>
					<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
					    <li class="nav-item" role="presentation">
					        <a class="nav-link active" id="new-orders-tab" data-toggle="pill" onclick="loadStaff(1)" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Danh sách nhân viên</a>
					    </li>
					    <li class="nav-item" role="presentation">
					        <a class="nav-link" id="pills-processing-tab" data-toggle="pill" onclick="loadCustomer(1)" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">Danh sách khách hàng</a>
					    </li>
					</ul>
					<div class="tab-content" id="pills-tabContent">
					 	<!--START TAB LIST NEW ORDER -->
					    <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="new-orders-tab">
					        <div class="table-responsive table-data">
					            <table class="table table-data2">
					                <thead>
					                    <tr>
					                        <th>Tên đăng nhập</th>
					                        <th>Ảnh đại diện</th>
					                        <th>Họ tên</th>
					                        <th>Email</th>
					                        <th>Số điện thoại</th>
					                        <th>Địa chỉ</th>
					                        <th>Trạng thái</th>
					                        <th>Hành động</th>
					                    </tr>
					                </thead>
					                <tbody id="staff-list">
					                   <!-- List new order -->
		 			                </tbody>
					            </table>
					
					        </div>
					        <div class="my-3">
		                        <nav aria-label="Page navigation example">
		                            <ul class="pagination justify-content-center " id="paged--list--staff">
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
					                        <th>Tên đăng nhập</th>
					                        <th>Ảnh đại diện</th>
					                        <th>Họ tên</th>
					                        <th>Email</th>
					                        <th>Số điện thoại</th>
					                        <th>Địa chỉ</th>
					                        <th>Trạng thái</th>
					                        <th>Hành động</th>
					                    </tr>
					                </thead>
					                <tbody id="customer-list">
					                    <!-- list order were be processing -->
					                </tbody>
					            </table>
					        </div>
					         <div class="my-3">
		                        <nav aria-label="Page navigation example">
		                            <ul class="pagination justify-content-center " id="paged--list--customer">
		                                <!-- paging -->
		                            </ul>
		                        </nav>
		                    </div>
					    </div>
					     <!--END TAB LIST ORDER BE PROCESSING-->
					</div>
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
    
    $(document).ready(function () {
        setActiveMenu();
        loadStaff(1);
    });
    
    function setActiveMenu() {
     	$( ".navbar__list li" ).each(function() {
     		$(this).removeClass("active");
     	});
     	$( ".list-unstyled li" ).each(function() {
     		$(this).removeClass("active");
     	});
     	$('.list-unstyled #menu--account').addClass("active");
     	$('.navbar__list #menu--account').addClass("active");
 	}
    
    function loadStaff(page) {
    	var update_role=$("#update_role").val();
    	var type=0;
        $.ajax({
            url: '/admin/list-account',
            type: "GET",
            data: {type: type, page: page},
            dataType: "json",
            contentType: "application/json",
            success: function (result) {
				var html='';
                $.each(result.users, function (i, item) {
                	html+='<tr class="tr-shadow">';
               		html+='    <td class="number_order">'+item.username+'</td>';
               		if (item.avatar!=null) {
               			html+='		<td class="block-image">';
                    	html+='			<img src="${base}/upload/' + item.avatar + '" alt="" />';
    	                html+='		</td>';
					}else{
						html+='		<td class="block-image">';
	                	html+='			<img src="${base}/manager/images/noAvatar.png" alt="" />';
		                html+='		</td>';
					}
           			html+='    <td>';
  					html+='         <span>'+item.fullname+'</span>';
          			html+='    </td>';
					html+='    <td>';
					html+='         <span>'+item.email+'</span>';
					html+='    </td>';
					html+='     <td>';
					html+='         <span>'+item.phone+'</span>';
					html+='     </td>';
					html+='     <td>';
					html+='          <span>'+item.address+'</span>';
					html+='     </td>';
					html+='		<td>';
                    if (item.status) {
                        html += '<span class="status--process">Hoạt động</span>';
                    } else {
                        html += '<span class="status--denied">Vô hiệu hóa</span>';
                    }
                    html+='		</td>';
					html+='		<td>';
                    html+='			<div class="table-data-feature">';
                    if (update_role=='true') {
	                    html+='				<button class="item" title="Phân quyền" onclick="decentralization('+item.id+')">';
	                    html+='					<i class="fas fa-user-tag"></i>';
	                    html+=' 			</button>';
	                    html+='				<button class="item" title="Vô hiệu hóa" onclick="changeStatusActive('+item.id+',0,0)" >';
	                    html+='					<i class="fas fa-ban"></i>';
	                    html+='				</button>';
	                    html+='				<button class="item" title="Kích hoạt" onclick="changeStatusActive('+item.id+',1,0)" >';
	                    html+='					<i class="fas fa-check-circle"></i>';
	                    html+='				</button>';
	                    html+='			</div>';
	                    html+='		</td>'
                    }
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
                        pagination_string += '<li class="page-item active"><a href="" class="page-link" data-page=' + i +' >' + currentPage + '</a></li>';
                    } else if (i >= currentPage - 3 && i <= currentPage + 4) {
                        pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + i + '>' + i + '</a></li>';
                    }
                }

                if (currentPage > 0 && currentPage < totalPage) {
                    var nextPage = currentPage + 1;
                    pagination_string += '<li class="page-item"><a href="" class="page-link"  data-page=' + nextPage + '><i class="fas fa-angle-double-right" style="font-size:18px"></i></a></li>';
                }
                
                $('#staff-list').html(html);
                $('#paged--list--staff').html(pagination_string);
            }
        });
    }
    
    function loadCustomer(page) {
    	var update_role=$("#update_role").val();
    	var type=1;
        $.ajax({
            url: '/admin/list-account',
            type: "GET",
            data: {type: type, page: page},
            dataType: "json",
            contentType: "application/json",
            success: function (result) {
				var html='';
                $.each(result.users, function (i, item) {
                	html+='<tr class="tr-shadow">';
               		html+='    <td class="number_order">'+item.username+'</td>';
               		if (item.avatar!=null) {
               			html+='		<td class="block-image">';
                    	html+='			<img src="${base}/upload/' + item.avatar + '" alt="" />';
    	                html+='		</td>';
					}else{
						html+='		<td class="block-image">';
	                	html+='			<img src="${base}/manager/images/noAvatar.png" alt="" />';
		                html+='		</td>';
					}
           			html+='    <td>';
  					html+='         <span>'+item.fullname+'</span>';
          			html+='    </td>';
					html+='    <td>';
					html+='         <span>'+item.email+'</span>';
					html+='    </td>';
					html+='     <td>';
					html+='         <span>'+item.phone+'</span>';
					html+='     </td>';
					html+='     <td>';
					html+='          <span>'+item.address+'</span>';
					html+='     </td>';
					html+='		<td>';
                    if (item.status) {
                        html += '<span class="status--process">Hoạt động</span>';
                    } else {
                        html += '<span class="status--denied">Vô hiệu hóa</span>';
                    }
                    html+='		</td>';
                    if (update_role=='true') {
						html+='		<td>';
	                    html+='			<div class="table-data-feature">';
	                    html+='				<button class="item" title="Vô hiệu hóa" onclick="changeStatusActive('+item.id+',0,1)" >';
	                    html+='					<i class="fas fa-ban"></i>';
	                    html+='				</button>';
	                    html+='				<button class="item" title="Kích hoạt" onclick="changeStatusActive('+item.id+',1,1)" >';
	                    html+='					<i class="fas fa-check-circle"></i>';
	                    html+='				</button>';
	                    html+='			</div>';
	                    html+='		</td>';
                    }
					html+='</tr>';
					html+='<tr class="spacer"></tr>';				
                });
                
                var totalPage = result.listPage[0].totalPage;
                var currentPage = result.listPage[0].currentPage;
                var pagination_string = '';
                if (currentPage > 1) {
                    var previousPage = currentPage - 1;
                    pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + previousPage +'><i class="fas fa-angle-double-left" style="font-size:18px"></i></a></li>';
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
                
                $('#customer-list').html(html);
                $('#paged--list--customer').html(pagination_string);
            }
        });
    }
  
    $("body").on("click", "#paged--list--staff li a", function (event) {
        event.preventDefault();
        var currentPage = parseInt($(this).attr('data-page'));
		loadStaff(currentPage);
    });
    
    $("body").on("click", "#paged--list--customer li a", function (event) {
        event.preventDefault();
        var currentPage = parseInt($(this).attr('data-page'));
        loadCustomer(currentPage);
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
    
    
	function decentralization(idAccount) {
		 window.location.href='/admin/decentralization-account/'+idAccount;
	}
	
	function changeStatusActiveConfirmed(idAccount,status,typeAccount) {
		console.log(status);
		 $('#modalConfirmOder').modal('hide');
		 $.ajax({
	            url: '/admin/change-status-account?idAccount='+idAccount+"&&status="+status,
	            type: "POST",
	            data: {},
	            dataType: "json",
	            contentType: "application/json",
	            success: function (result) {
	            	if (result.message==true) {
	            		showAlertMessage("Thay đổi trạng thái tài khoản thành công!",true);
		            	if (typeAccount==0) {
							loadStaff(1);
						}else{
							loadCustomer(1);
						}
					}else{
						showAlertMessage("Thay đổi trạng thái tài khoản thất bại!",false);
					}
	            },
	            error: function (jqXhr, textStatus, errorMessage) { // error callback 
	            	showAlertMessage("Thay đổi trạng thái tài khoản thất bại!",false);
	            }
	        });
	}
	
	 function changeStatusActive(idAccount,status,typeAccount) {
	        $('#btn_save').attr("onclick", "changeStatusActiveConfirmed(" + idAccount + ","+status+","+typeAccount+")");
	       	if (status==0) {
	       	 	$('#modalConfirmOderContent').text("Bạn chắc chắn muốn vô hiệu hóa tài khoản này?");
			}else{
				$('#modalConfirmOderContent').text("Bạn chắc chắn muốn kích hoạt lại tài khoản này?");
			}
	        $('#btn_save').show();
	        $('#btn_save').text("Có");
	        $('#btn_close').css({ "background-color": "#007bff", "border": "1px solid #007bff", "width": "200px" })
	        $('#btn_save').css({ "background-color": "rgb(255, 66, 78)", "border": "1px solid rgb(255, 66, 78)", "width": "200px" });
	        $('#modalConfirmOder').modal('show');
	   };
    </script>
</body>

</html>
<!-- end document-->