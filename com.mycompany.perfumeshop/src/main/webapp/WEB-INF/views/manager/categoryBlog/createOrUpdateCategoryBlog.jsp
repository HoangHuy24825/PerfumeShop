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
    <title>Danh mục blog | Admin Electronic Device</title>
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
                                    <a href="${base}/admin/category-blog" class="btn_back_list"><i class="fa fa-arrow-left"></i></a> &nbsp
                                    <h3 class="title-5 m-b-35" id="title-page-update-add">Thêm danh mục blog</h3>
                                </div>
                                <div class="">
                                    <div class="bg-light p-4">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <form enctype="multipart/form-data" id="form--upload">
                                                    
                                                    <input id="id" name="id" value="${id_category}" hidden="true"/>

                                                   <div class="form-group">
                                                        <label for="name">Tên danh mục <span class="required_field">*</span></label>
                                                        <input name="name" autocomplete="off" type="text" class="form-control" id="name" placeholder="Tên danh mục" required="required"/>
                                                    </div>
                                                    
                                                    <div class="form-group">
                                                        <label for="fileProductAvatar">Avatar <span class="required_field">*</span></label>
                                                        <div class="row d-flex justify-content-center mt-4">
                                                            <div class="col-sm-4 imgUp">
                                                                <div class="imagePreview img--avatar"></div>
                                                                <label class="btn btn-primary btn--upload-image">Upload
                                                                    <input type="file" class="uploadFile img uploadAvatar" name="avatar" accept="image/png, image/jpeg, image/jpg" style="width: 0px;height: 0px;overflow: hidden;">
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                                            
                                                    <!--  <div class="form-group">
                                                        <label for="seo">Seo </label>
                                                        <input autocomplete="off" name="seo" placeholder="Seo" class="form-control summernote" id="seo"/>
                                                    </div> -->
                                                    <div class="form-group">
                                                        <label>Danh mục hot</label>&nbsp;&nbsp;&nbsp;
                                                        <input type="radio" name="isHot" id="hot1" value="true" class="radio-button-form"/>
                                                        <label for="hot1" class="label-radio-button">Hot</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <input type="radio" name="isHot" id="hot2" value="false" class="radio-button-form"/>
                                                        <label for="hot2" class="label-radio-button">Bình thường</label>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Trạng thái <span class="required_field">*</span></label>&nbsp;&nbsp;&nbsp;
                                                        <input type="radio" name="status" id="status1" value="true" class="radio-button-form"/>
                                                        <label for="status1" class="label-radio-button">Hiển thị</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <input type="radio" name="status" id="status2" value="false" class="radio-button-form"/>
                                                        <label for="status2" class="label-radio-button">Ẩn</label>
                                                    </div>
                                                    
                                                    <div class="form-group">
                                                        <a class="btn btn-secondary" href="${base}/admin/category/index">Hủy</a>
                                                        <button type="button" class="btn btn-primary" onclick="clickSaveCategory()">Lưu</button>
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

    <!-- JS-->
    <jsp:include page="/WEB-INF/views/manager/layout/script.jsp"></jsp:include>
    <script type="text/javascript">
    $(document).ready(function() {
    	var id_category = $('#id').val();
    
    	if (id_category != null && id_category != "") {
    		loadDetailForEdit(id_category);
    		$("#title-page-update-add").text("Cập nhật danh mục blog");
    	}
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
    	$('.list-unstyled #menu--category--blog').addClass("active");
    	$('.navbar__list #menu--category--blog').addClass("active");
	}

    // function to add imput image product
    $(".imgAdd").click(function() {
    	$(this).closest(".row").find('.imgAdd').before('<div class="col-sm-2 imgUp"><div class="imagePreview image--product" data-id-image=""></div><label class="btn btn-primary btn--upload-image">Upload<input type="file" class="uploadFile img" name="images" accept="image/png, image/jpeg, image/jpg" style="width:0px;height:0px;overflow:hidden;"></label><i class="fa fa-times del"></i></div>');
    });
    $(document).on("click", "i.del", function() {
    	$(this).parent().remove();
    });
    //function to add preview image
    $(function() {
    	$(document).on("change", ".uploadFile", function() {
    		var uploadFile = $(this);
    		var files = !!this.files ? this.files : [];
    		if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support

    		if (/^image/.test(files[0].type)) { // only image file
    			var reader = new FileReader(); // instance of the FileReader
    			reader.readAsDataURL(files[0]); // read the local file

    			reader.onloadend = function() { // set image data as background of div
    				//alert(uploadFile.closest(".upimage").find('.imagePreview').length);
    				uploadFile.closest(".imgUp").find('.imagePreview').css("background-image", "url(" + this.result + ")");
    			}
    		}

    	});
    });

    //function to add new product
    function clickSaveCategory() {
    	var form = $('#form--upload')[0];
    	var data = new FormData(form);

    	$.ajax({
    		type: "POST",
    		enctype: 'multipart/form-data',
    		url: "/admin/add-update-category-blog",
    		data: data,
    		processData: false, //prevent jQuery from automatically transforming the data into a query string
    		contentType: false,
    		cache: false,
    		timeout: 600000,
    		success: function(data) {
    			alert("Thành công!");
    			$(location).attr('href', "/admin/category-blog");
    		},
    		error: function(e) {
    			console.log("ERROR : ", e);
    		}
    	});
    }

    function loadDetailForEdit(idCategory) {
    	$.ajax({
    		url: "/admin/detail-category-blog",
    		type: "get",
    		contentType: "application/json", //set data send to server is json
    		data: { idCategory: idCategory },
    		dataType: "json", //set data return is json
    		success: function(result) {
    			$('#id').val(result.category[0].id);
    			$('#name').val(result.category[0].name);
    			$('.img--avatar').css("background-image", "url(/upload/" + result.category[0].avatar + ")");
    			$('#seo').val(result.category[0].seo);
    			if (result.category[0].status == true) {
    				$('#status1').attr("checked", true);
    			} else {
    				$('#status2').attr("checked", true);
    			}
    			if (result.category[0].isHot == true) {
    				$('#isHot1').attr("checked", true);
    			} else {
    				$('#isHot2').attr("checked", true);
    			}
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