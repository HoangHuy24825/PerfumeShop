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
    <title>Sản phẩm | Admin Electronic Device</title>
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
                                <!-- CONTENT PAGE -->
                                <h3 class="title-5 m-b-35">Danh sách sản phẩm</h3>
                                <div class="table-data__tool">
	                                <div class="table-data__tool-left">
	                                <div class="rs-select2--light rs-select2--md first--select--filter">
	                                    <select class="js-select2" name="property" id="select-category">
	                                        <%-- select category to filter --%>
	                                    </select>
	                                    <div class="dropDownSelect2"></div>
	                                </div>
	                                <div class="rs-select2--light rs-select2--md">
	                                    <select class="js-select2" name="status" id="filter-status">
	                                        <option selected="selected" value="0">Trạng Thái</option>
	                                        <option value="1">Hiển Thị</option>
	                                        <option value="2">Ẩn</option>
	                                    </select>
	                                    <div class="dropDownSelect2"></div>
	                                </div>
	                                </div>
	                                <div class="table-data__tool-right">
	                                	<c:if test="${productRole.insert ==true}">	
		                                    <button class="au-btn au-btn-icon au-btn--green au-btn--small" onclick="location.href='${base}/admin/add-product'">
		                                        <i class="fas fa-plus"></i>Thêm mới
		                                    </button>
		                               </c:if>   
		                                <input id="update_role" value="${productRole.update}" type="text" style="display: none"/> 
                                    	<input id="delete_role" value="${productRole.delete}" type="text" style="display: none"/>
	                                </div>
                                </div>
                                <div class="table-responsive table-data">
                                    <table class="table table-data2">
                                        <thead>
                                            <tr>
                                                <th>Ảnh</th>
                                                <th>Tên</th>
                                                <th>Thương hiệu</th>
                                                <th>Mùi hương</th>
                                                <th>Trạng thái</th>
                                                <th>Thịnh hành</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody id="table_data">


                                        </tbody>
                                    </table>
                                </div>

                                <div class="my-3">
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination justify-content-center " id="paged--list">
                                            
                                        </ul>
                                    </nav>
                                </div>
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
    
    <!-- START MODAL CONFIRM -->
	<div class="modal fade" id="modalConfirmOder" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-body " id="modalConfirmOderContent" style="font-size:22px ">
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
	
	<!-- START MESSAGE -->
	<div class="alert hide" id="alert_message">
    <div id="icon-alert-message"><i class="fas fa-exclamation-circle"></i></div>
    <span class="msg">Warning: This is a warning alert!</span>
    <div class="close-btn-alert">
        <span class="fas fa-times"></span>
    </div>
	</div>
	<!-- END MESSAGE -->
	
	<!-- START NOTIFY MODAL -->
	 <jsp:include page="/WEB-INF/views/manager/layout/notify.jsp"></jsp:include>
	<!-- START NOTIFI MODAL -->
	
    <!-- JS-->
    <jsp:include page="/WEB-INF/views/manager/layout/script.jsp"></jsp:include>
    <%-- <script src="${base }/manager/js/productScript/product.js"></script> --%>
    <script type="text/javascript">
    $(document).ready(function () {
        loadProduct(null,1);//load page 1
        loadCategory();//load category to filter
        setActiveMenu();
    });
    
    
    $('#input-search-header').on('keydown', function (e) {
        if (e.keyCode == 13) {
        	$('#btn_search_header').click();
        }
    });
    
    function loadCategory() {
        $.ajax({
            url: "/admin/all-category-active",
            type: "get",
            contentType: "application/json",
            data: "",
            dataType: "json", // kieu du lieu tra ve tu controller la json
            success: function (result) {
                var html = '';
                html+='<option value="' + 0 + '">Danh mục sản phẩm</option>';
                $.each(result, function (index, value) {
                    html += '<option value="' + value.id + '">' + value.name + '</option>';
                });
                $('#select-category').html(html);
            },
            error: function (jqXhr, textStatus, errorMessage) { // error callback 

            }
        });
    }

    /* LOAD PRODUCT START */
    function loadProduct(keySearch, currentPage,idCategory,status) {
    	var update_role=$("#update_role").val();
		var delete_role=$("#delete_role").val();
        $.ajax({
            url: "/admin/all-product",
            type: "get",
            contentType: "application/json",
            data: { currentPage: currentPage, idCategory:idCategory, status:status,keySearch:keySearch },
            dataType: "json", // kieu du lieu tra ve tu controller la json
            success: function (result) {
                var html = '';
                $.each(result.products, function (index, value) {
                    html += '<tr class="tr-shadow">';
                    html += '<td class="block-image">';
                    html += '<img src="/upload/' + value.avatar + '" alt="Hình Ảnh Sản Phẩm" />';
                    html += '</td>';
                    html += '<td>';
                    html += '<span class="block-name-product">' + value.title + '</span>';
                    html += '</td>';
                    html += '<td>';
                    html += '<span class="text-primary font-weight-bold">'+value.trademark+'</span>';
                    html += '</td>';
                    html += '<td>';
                    html += '<span class="text-primary font-weight-bold">'+value.fragrant+'</span>';
                    html += '</td>';
                    html += '<td>';

                    if (value.status) {
                        html += '<span class="status--process">Hiển thị</span>';
                    } else {
                        html += '<span class="status--denied">Ẩn</span>';
                    }
                    html += '</td>';
                    html += '<td>';

                    if (value.isHot) {
                        html += '<span class="status--process">Hot</span>';
                    } else {
                        html += '<span>Bình thường</span>';
                    }
                    html += '</td>';
                    html += '<td>';
                    html += '<div class="table-data-feature">';
                    html += '<button class="item" title="Xem" onclick="detail('+value.id+')">';
                    html += '                <input type="hidden" id="view_'+value.id+'" name="custId" value="'+value.seo+'">';
                    html += '<i class="fas fa-eye"></i>';
                    html += '</button>';
                    if (update_role=='true') {
	                    html += '<button class="item" title="Sửa">';
	                    html += '<i class="fas fa-pencil-alt" onclick="edit('+value.id+')"></i>';
	                    html += '             <input type="hidden" id="edit_'+value.id+'" name="custId" value="'+value.seo+'">';
	                    html += ' </button>';
                    }
                	if (delete_role=='true') {
	                    html += '<button class="item" title="Xóa" onclick="deleteProduct('+value.id+')" >';
	                    html += '<i class="fas fa-trash-alt"></i>';
	                    html += '</button>';
                	}
                    html += '</div>';
                    html += '</td>';
                    html += '</tr>';
                    html += '<tr class="spacer"></tr>';
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
                        pagination_string += '<li class="page-item active"><a href="" class="page-link" data-page=' + i + '>' + currentPage + '</a></li>';
                    } else if (i >= currentPage - 3 && i <= currentPage + 4) {
                        pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + i + '>' + i + '</a></li>';
                    }
                }

                if (currentPage > 0 && currentPage < totalPage) {
                    var nextPage = currentPage + 1;
                    pagination_string += '<li class="page-item"><a href="" class="page-link"  data-page=' + nextPage + '><i class="fas fa-angle-double-right" style="font-size:18px"></i></a></li>';
                }
                $("#input-search-header").val(keySearch);
                $("#paged--list").html(pagination_string);
                $('#table_data').html(html);
            },
            error: function (jqXhr, textStatus, errorMessage) { // error callback 

            }
        });
    }
    
   	/* LOAD PRODUCT END */

   	/* SEARCH HEADER START */
    $("#btn_search_header").click(function() {
    	$("#filter-status").val("0");
    	$("#select-category").val("0");
    	var txtSearch = $("#input-search-header").val();
    	if (txtSearch != "") {
    		loadProduct(txtSearch, 1, null, null);
    	}
    	else {
    		loadProduct(null, 1, null, null);
    	}
    });
   
   	

   /*  $("#input-search-header").keyup(function(event) {
    	$("#filter-status").val("0");
    	$("#select-category").val("0");
    	$('#btn_search_header').click();
    }); */
    /* SEARCH HEADER END */
    
    /* SELECT CATEGORY START */
    $("#select-category").change(function() {
    	var filterType = $("#filter-status").val();
    	var id_category= $("#select-category").val();
    	if (filterType != 0) {
    		loadProduct(null,1,id_category, filterType);
    	} else {
    		loadProduct(null,1,id_category, null);
    	}
    });
    /* SELECT CATEGORY END */
    
    /* SELECT STATUS START */
    $("#filter-status").change(function() {
    	var txtSearch = $("#input-search-header").val();
    	var filterType = $("#filter-status").val();
    	var id_category= $("#select-category").val();
    	if (filterType != 0) {
    		loadProduct(txtSearch,1,id_category, filterType);
    	} else {
    		loadProduct(txtSearch,1,id_category, null);
    	}
    });
    /* SELECT STATUS END */
    
    /* PAGING CLICK START */
    $("body").on("click", ".pagination li a", function (event) {
        event.preventDefault();
        var currentPage = $(this).attr('data-page');
        var txtSearch = $("#input-search-header").val();
    	var filterType = $("#filter-status").val();
    	var id_category= $("#select-category").val();
    	console.log(txtSearch);
    	console.log(filterType);
    	console.log(id_category);
        //load event pagination
        loadProduct(txtSearch,currentPage,id_category,filterType);
    });
    /* PAGING CLICK END */

    function detail(id){
        window.location.href='/admin/product-detail/'+$('#view_'+id).val();
    }

    function edit(id){
        window.location.href='/admin/edit-product/'+ $('#edit_'+id).val();
    }
    
    function setActiveMenu() {
     	$( ".navbar__list li" ).each(function() {
     		$(this).removeClass("active");
     	});
     	$( ".list-unstyled li" ).each(function() {
     		$(this).removeClass("active");
     	});
     	$('.list-unstyled #menu--product').addClass("active");
     	$('.navbar__list #menu--product').addClass("active");
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
    
    function deleteProduct(idProduct) {
        $('#btn_save').attr("onclick", "deleteConfirmed(" + idProduct +")");
        $('#modalConfirmOderContent').text("Bạn chắc chắn muốn xóa sản phẩm này ?");
        $('#btn_save').show();
        $('#btn_save').text("Có");
        $('#btn_close').css({ "background-color": "#007bff", "border": "1px solid #007bff", "width": "200px" })
        $('#btn_save').css({ "background-color": "rgb(255, 66, 78)", "border": "1px solid rgb(255, 66, 78)", "width": "200px" });
        $('#modalConfirmOder').modal('show');
    };
    
    function deleteConfirmed(idProduct) {
    	$('#modalConfirmOder').modal('hide');
    	$.ajax({
            url: '/admin/delete-product?idProduct='+idProduct,
            type: "POST",
            data: {},
            dataType: "json",
            contentType: "application/json",
            success: function (result) {   
            	if (result.message==true) {
            		showAlertMessage("Xóa sản phẩm thành công!",true);
                	loadProduct(null,1,null,null);
				}else{
					showAlertMessage("Không thể xóa sản phẩm này!",false);
            	}
            },
            error: function (jqXhr, textStatus, errorMessage) { // error callback 
            	showAlertMessage("Không thể xóa sản phẩm này!",false);
            }
        });
	}
    </script>
</body>

</html>
<!-- end document-->