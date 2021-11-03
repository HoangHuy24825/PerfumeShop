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
    <title>Giới thiệu | Admin Electronic Device</title>
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
                                <div class="d-flex ">
                                    <a href="${base}/admin/introduce" class="btn_back_list"><i class="fa fa-arrow-left"></i></a> &nbsp
                                    <h3 class="title-5 m-b-35" id="title-page-update-add">Cập nhật giới thiệu công ty </h3>
                                </div>
                                <div class="">
                                    <div class="bg-light p-4">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <form enctype="multipart/form-data" id="form--upload">
                                                    
                                                    <input id="id" name="id" value="${id_introduce}" hidden="true"/>

                                                    <div class="form-group">
                                                        <label for="detail">Nội dung <span class="required_field">*</span></label>
                                                        <textarea row=5 autocomplete="off" class="form-control summernote" id="detail" name="detail" required="required">
                                                        </textarea>
                                                    </div>
                                                    <div class="form-group">
                                                        <a class="btn btn-secondary" href="${base}/admin/introduce">Hủy</a>
                                                        <button type="button" class="btn btn-primary" onclick="clickSaveBlog()">Lưu</button>
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
    
    <!-- START MODAL NOTIFY SUCESS -->
	<div class="modal fade" id="modalNotidfySuccess" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-body " id="modalNotidfySuccessContent" style="font-size:14px ">
	                <!--content-->
	            </div>
	            <div class="modal-footer mx-auto" style="border:unset">
	                <button type="button" id="btn_close" class="btn btn-secondary" data-dismiss="modal">
	                   Ok
	                </button>
	            </div>
	        </div>
	    </div>
	</div>
    <!-- END MODAL NOTIFY SUCESS -->
    
    <!-- START NOTIFY MODAL -->
	 <jsp:include page="/WEB-INF/views/manager/layout/notify.jsp"></jsp:include>
	<!-- START NOTIFI MODAL -->

    <!-- JS-->
    <jsp:include page="/WEB-INF/views/manager/layout/script.jsp"></jsp:include>
    <script type="text/javascript">
    var editor = '';
    $(document).ready(function() {
    	editor = CKEDITOR.replace('detail',{width: ['100%'], height: ['800px']});
    	var id_introduce = $('#id').val();
    
    	loadDetailForEdit(id_introduce);
    	setActiveMenu();
    });
    
    function setActiveMenu() {
    	console.log("call");
    	$( ".navbar__list li" ).each(function() {
    		$(this).removeClass("active");
    	});
    	$( ".list-unstyled li" ).each(function() {
    		$(this).removeClass("active");
    	});
    	$('.list-unstyled #menu--introduce').addClass("active");
    	$('.navbar__list #menu--introduce').addClass("active");
	}

    //function to add new product
    function clickSaveBlog() {
    	var form = $('#form--upload')[0];
    	var data = new FormData(form);
    	var detailCkEditor=editor.getData();
		data.append('detail', detailCkEditor);
    	$.ajax({
    		type: "POST",
    		enctype: 'multipart/form-data',
    		url: "/admin/update-introduce",
    		data: data,
    		processData: false, //prevent jQuery from automatically transforming the data into a query string
    		contentType: false,
    		cache: false,
    		timeout: 600000,
    		success: function(data) {
    			alert("Cập nhật thành công!");
    			$(location).attr('href', "/admin/introduce");
    		},
    		error: function(e) {
    			console.log("ERROR : ", e);
    		}
    	});
    }

    function loadDetailForEdit(idBlog) {
    	$.ajax({
    		url: "/admin/introduce-detail",
    		type: "get",
    		contentType: "application/json", //set data send to server is json
    		data: { idBlog: idBlog },
    		dataType: "json", //set data return is json
    		success: function(result) {
    			editor.setData(result.introduce.detail);
    		},
    		error: function(jqXhr, textStatus, errorMessage) {
    			//show error
    		}
    	});
    }
    
    </script>
</body>

</html>
<!-- end document-->