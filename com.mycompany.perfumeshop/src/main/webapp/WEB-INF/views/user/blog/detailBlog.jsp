<%@ page language="java" contentType="text/html; charset=UTF-8"
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
    <title>Tin tức | Electronic Device</title>
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

    <!--================ Start Blog Area =================-->
    
    <!--================End Blog Area =================-->
	 <section class="blog_area padding_top">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mb-5 mb-lg-0">
                    <div class="blog_left_sidebar">
                        <article class="blog_item">
                            <div class="blog_item_img">
                                <img class="card-img rounded-0" src="${base}/user/img/blog/single_blog_1.png" alt="">
                                <a href="#" class="blog_item_date">
                                    <h3>15</h3>
                                    <p>Jan</p>
                                </a>
                            </div>

                            <div class="blog_details">
                                <a class="d-inline-block" href="single-blog.html">
                                    <h2>Google inks pact for new 35-storey office</h2>
                                </a>
                                <p>That dominion stars lights dominion divide years for fourth have don't stars is that
                                    he earth it first without heaven in place seed it second morning saying.</p>
                                <ul class="blog-info-link">
                                    <li><a href="#"><i class="far fa-user"></i> Travel, Lifestyle</a></li>
                                </ul>
                            </div>
                        </article>

                        <article class="blog_item">
                            <div class="blog_item_img">
                                <img class="card-img rounded-0" src="${base}/user/img/blog/single_blog_2.png" alt="">
                                <a href="#" class="blog_item_date">
                                    <h3>15</h3>
                                    <p>Jan</p>
                                </a>
                            </div>

                            <div class="blog_details">
                                <a class="d-inline-block" href="single-blog.html">
                                    <h2>Google inks pact for new 35-storey office</h2>
                                </a>
                                <p>That dominion stars lights dominion divide years for fourth have don't stars is that
                                    he earth it first without heaven in place seed it second morning saying.</p>
                                <ul class="blog-info-link">
                                    <li><a href="#"><i class="far fa-user"></i> Travel, Lifestyle</a></li>
                                </ul>
                            </div>
                        </article>

                        <article class="blog_item">
                            <div class="blog_item_img">
                                <img class="card-img rounded-0" src="${base}/user/img/blog/single_blog_3.png" alt="">
                                <a href="#" class="blog_item_date">
                                    <h3>15</h3>
                                    <p>Jan</p>
                                </a>
                            </div>

                            <div class="blog_details">
                                <a class="d-inline-block" href="single-blog.html">
                                    <h2>Google inks pact for new 35-storey office</h2>
                                </a>
                                <p>That dominion stars lights dominion divide years for fourth have don't stars is that
                                    he earth it first without heaven in place seed it second morning saying.</p>
                                <ul class="blog-info-link">
                                    <li><a href="#"><i class="far fa-user"></i> Travel, Lifestyle</a></li>
                                </ul>
                            </div>
                        </article>

                        <article class="blog_item">
                            <div class="blog_item_img">
                                <img class="card-img rounded-0" src="${base}/user/img/blog/single_blog_4.png" alt="">
                                <a href="#" class="blog_item_date">
                                    <h3>15</h3>
                                    <p>Jan</p>
                                </a>
                            </div>

                            <div class="blog_details">
                                <a class="d-inline-block" href="single-blog.html">
                                    <h2>Google inks pact for new 35-storey office</h2>
                                </a>
                                <p>That dominion stars lights dominion divide years for fourth have don't stars is that
                                    he earth it first without heaven in place seed it second morning saying.</p>
                                <ul class="blog-info-link">
                                    <li><a href="#"><i class="far fa-user"></i> Travel, Lifestyle</a></li>
                                </ul>
                            </div>
                        </article>

                        <article class="blog_item">
                            <div class="blog_item_img">
                                <img class="card-img rounded-0" src="${base}/user/img/blog/single_blog_5.png" alt="">
                                <a href="#" class="blog_item_date">
                                    <h3>15</h3>
                                    <p>Jan</p>
                                </a>
                            </div>

                            <div class="blog_details">
                                <a class="d-inline-block" href="single-blog.html">
                                    <h2>Google inks pact for new 35-storey office</h2>
                                </a>
                                <p>That dominion stars lights dominion divide years for fourth have don't stars is that
                                    he earth it first without heaven in place seed it second morning saying.</p>
                                <ul class="blog-info-link">
                                    <li><a href="#"><i class="far fa-user"></i> Travel, Lifestyle</a></li>
                                </ul>
                            </div>
                        </article>

                        <nav class="blog-pagination justify-content-center d-flex">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a href="#" class="page-link" aria-label="Previous">
                                        <i class="ti-angle-left"></i>
                                    </a>
                                </li>
                                <li class="page-item">
                                    <a href="#" class="page-link">1</a>
                                </li>
                                <li class="page-item active">
                                    <a href="#" class="page-link">2</a>
                                </li>
                                <li class="page-item">
                                    <a href="#" class="page-link" aria-label="Next">
                                        <i class="ti-angle-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="blog_right_sidebar">
                        <aside class="single_sidebar_widget search_widget">
                            <form action="#">
                                <div class="form-group">
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control" placeholder='Từ khóa tìm kiếm'
                                            onfocus="this.placeholder = ''"
                                            onblur="this.placeholder = 'Từ khóa tìm kiếm'">
                                        <div class="input-group-append">
                                            <button class="btn" type="button"><i class="ti-search"></i></button>
                                        </div>
                                    </div>
                                </div>
                                <button class="button rounded-0 primary-bg text-white w-100 btn_1"
                                    type="submit">Tìm kiếm</button>
                            </form>
                        </aside>

                        <aside class="single_sidebar_widget post_category_widget">
                            <h4 class="widget_title">Category</h4>
                            <ul class="list cat-list">
                                <li>
                                    <a href="#" class="d-flex">
                                        <p>Resaurant food</p>
                                        <p>(37)</p>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" class="d-flex">
                                        <p>Travel news</p>
                                        <p>(10)</p>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" class="d-flex">
                                        <p>Modern technology</p>
                                        <p>(03)</p>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" class="d-flex">
                                        <p>Product</p>
                                        <p>(11)</p>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" class="d-flex">
                                        <p>Inspiration</p>
                                        <p>21</p>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" class="d-flex">
                                        <p>Health Care (21)</p>
                                        <p>09</p>
                                    </a>
                                </li>
                            </ul>
                        </aside>

                        <aside class="single_sidebar_widget popular_post_widget">
                            <h3 class="widget_title">Recent Post</h3>
                            <div class="media post_item">
                                <img src="img/post/post_1.png" alt="post">
                                <div class="media-body">
                                    <a href="single-blog.html">
                                        <h3>From life was you fish...</h3>
                                    </a>
                                    <p>January 12, 2019</p>
                                </div>
                            </div>
                            <div class="media post_item">
                                <img src="img/post/post_2.png" alt="post">
                                <div class="media-body">
                                    <a href="single-blog.html">
                                        <h3>The Amazing Hubble</h3>
                                    </a>
                                    <p>02 Hours ago</p>
                                </div>
                            </div>
                            <div class="media post_item">
                                <img src="img/post/post_3.png" alt="post">
                                <div class="media-body">
                                    <a href="single-blog.html">
                                        <h3>Astronomy Or Astrology</h3>
                                    </a>
                                    <p>03 Hours ago</p>
                                </div>
                            </div>
                            <div class="media post_item">
                                <img src="img/post/post_4.png" alt="post">
                                <div class="media-body">
                                    <a href="single-blog.html">
                                        <h3>Asteroids telescope</h3>
                                    </a>
                                    <p>01 Hours ago</p>
                                </div>
                            </div>
                        </aside>
                    </div>
                </div>
            </div>
        </div>
    </section>
	
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
    	$("#orderBy").val("0");
    	$("#filterBy").val("0");
    	$('.close-btn-alert').click(function() {
    		$('.alert').removeClass("show");
    		$('.alert').addClass("hide");
    	});
    	$("#orderBy").css({ "display": "block" });
    	$("#searchStr").val("");
    	$("#filterBy").css({ "display": "block"});
    	//load init
    	loadData(null, 1, null, null, null);
    	loadNewProduct();
    });
    
    function setMenuBanner() {
    	var titlebanner='';
    	$("#img-banner").html('<img src="${base}/user/img/my-image/banner/news.png" alt="" width="200">');
    	titlebanner+='<h2>Blog</h2>';
    	titlebanner+='<p> Trang chủ <span>></span> Blog </p>';
    	$("#title-banner").html(titlebanner);
    	
    	$( "#mainNav li" ).each(function( index ) {
    		  $(this).removeClass("my-menu-active");
    	});
    	
    	$("#menu-blog").addClass("my-menu-active");
	}
    
    function loadData(searchStr, page, id_category, typeOrder, filterType) {
    	$.ajax({
    		url: "/all-product",
    		type: "GET",
    		data: { searchStr: searchStr, page: page, id_category: id_category, typeOrder: typeOrder, filterType: filterType },
    		dataType: "json",
    		contentType: "application/json;charset=utf-8",
    		success: function(result) {
    			var html = '';
    			if ((result.products.length == 0 || result.products == null) && searchStr != null && searchStr != "") {
    				html += '<div style="margin:auto">';
    				html += ' <img src="/wwwroot/imageUpload/notFoundProduct.png" width="300" style="margin:auto"/>';
    				html += '<br/>'
    				html += ' <p style="text-align:center; margin: 25px 0px 30px;">Không tìm thấy sản phẩm phù hợp!</p>';
    				html += '</div>';
    				$("#load-pagination").html("");
    			} else if ((result.products.length == 0 || result.products == null) && id_category != null && id_category != "") {
    				html += '<div style="margin:auto">';
    				html += ' <img src="/wwwroot/imageUpload/notFoundProduct.png" width="300" style="margin:auto"/>';
    				html += '<br/>'
    				html += ' <p style="text-align:center; margin: 25px 0px 30px;">Không có sản phẩm nào trong danh mục!</p>';
    				html += '</div>';
    				$("#load-pagination").html("");
    			}
    			else {
    				$.each(result.products, function(index, item) {
    					html += '<div class="col-lg-4 col-sm-6 box-single-product" onclick = "detail(' + item.id + ')">';
    					html += '<div class="single_product_item">';
    					html += '<img class="img-product" src="/upload/' + item.avatar + '"  alt="">';
    					html += '<div class="single_product_text">';
    					html += '<h4>' + item.title + '</h4>';
    					html += '<h3>' + item.price.toLocaleString('it-IT', { style: 'currency', currency: 'VND' }) + '</h3>';
    					html += '<div class="my-cart border rounded-circle" title="Thêm sản phẩm vào giỏ" onclick="event.stopPropagation();addProductToCart(' + item.id +')">';
    					html += '<i class="fas fa-shopping-cart"></i>';
    					html += '</div>';
    					html += '</div>';
    					html += '</div>';
    					html += ' </div>';

    					//create pagination
    					var pagination_string = "";
    					var currentPage = result.listPage[0].currentPage;
    					var totalPage = result.listPage[0].totalPage;


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
    					$("#load-pagination").html(pagination_string);
    				});
    			}
    			$("#product-container").html(html);
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

    function detail(id_product) {
    	window.location.href = '/detail-product?id-product=' + id_product;
    };

    function addProductToCart(id_product) {
       	let data={
       		productId:id_product,
       		quanlity:1
       	}
       	$.ajax({
       		url: "/cart/add",
       		type: "post",
       		data: JSON.stringify(data),
       		dataType: "json",
       		contentType: "application/json",
       		success : function(jsonResult) {
       			showAlertMessage("Thêm vào giỏ hàng thành công!",true);
       			$('#icon-cart-header').find($('#amount_cart')).text(jsonResult.totalItems);
       		},
       		error : function(jqXhr, textStatus, errorMessage) {
       			showAlertMessage("Không thêm được sản phẩm vào giỏ hàng!",false);
       		}
           });
       }

    $("#orderBy").change(function() {
    	var txtSearch = $("#searchStr").val();
    	var orderType = $("#orderBy").val();
    	var filterType = $("#filterBy").val();
    	var id_category = $('.table-categoty').find('.chosed').attr('id');
    	if (orderType != 0) {
    		loadData(txtSearch, 1, id_category, orderType, filterType);
    	} else {
    		loadData(txtSearch, 1, id_category, null, filterType);
    	}
    });
    
     $("#filterBy").change(function() {
    	var txtSearch = $("#searchStr").val();
    	var orderType = $("#orderBy").val();
    	var filterType = $("#filterBy").val();
    	var id_category = $('.table-categoty').find('.chosed').attr('id');
    	if (filterType != 0) {
    		loadData(txtSearch, 1, id_category, orderType,filterType);
    	} else {
    		loadData(txtSearch, 1, id_category, orderType,null);
    	}
    }); 

    $('.row-left-sidebar').click(function() {
    	$("#orderBy").val("0");
    	$("#filterBy").val("0");
    	$('#searchStr').val("");
    	
    	$('.table-categoty').find('.selected-category').removeClass('selected-category');
    	$('.table-categoty').find('.chosed').removeClass('chosed');
    	
    	var id_category = $(this).attr('id');
    	loadData(null, 1, id_category, null, null);
    	$(this).addClass('chosed');
    	$(this).addClass('selected-category');
    	var title = $(this).children('td:nth-child(2)').text();
    	$('#title-banner').find('h2').html("Danh mục sản phẩm");
    	$('#title-banner').find('p').html("Trang chủ > " + title);
    });

    $("body").on("click", ".pagination li a", function(event) {
    	event.preventDefault();
    	var page = $(this).attr('data-page');
    	var id_category = $('.table-categoty').find('.chosed').attr('id');
    	//load event pagination
    	var txtSearch = $("#searchStr").val();
    	if (txtSearch != "") {
    		loadData(txtSearch, page, id_category, $("#orderBy").val(),$("#filterBy").val());
    	}
    	else {
    		loadData(null, page, id_category, $("#orderBy").val(),$("#filterBy").val());
    	}

    });

    $("#search").click(function() {
    	$("#orderBy").val("0");
    	$("#filterBy").val("0");
    	$('.table-categoty').find('.selected-category').removeClass('selected-category');
    	var txtSearch = $("#searchStr").val();
    	if (txtSearch != "") {
    		loadData(txtSearch, 1, null, null,null);
    	}
    	else {
    		loadData(null, 1, null, null,null);
    	}
    });

    $("#searchStr").keyup(function(event) {
    	$("#orderBy").val("0");
    	$("#filterBy").val("0");
    	$('#search').click();
    });



    function loadNewProduct() {
    	console.log("load new product");
    	$.ajax({
    		url: "/new-product",
    		type: "GET",
    		data: {},
    		dataType: "json",
    		contentType: "application/json",
    		success: function(jsonResult) {
    			var html='';
    			$.each(jsonResult,function(index,value){
    				 html+='<div class="single_product_item" >';
                     html+='     <img class="img-product" src="/upload/'+value.avatar+'" alt="'+value.title+'">';
                     html+='     <div class="single_product_text">';
                     html+='         <h4>'+value.title+'</h4>';
                     html+='         <h3>'+value.price.toLocaleString('it-IT', { style: 'currency', currency: 'VND' })+'</h3>';
                     html+='         <div class="my-cart border rounded-circle" title="Thêm sản phẩm vào giỏ">';
                     html+='             <i class="fas fa-shopping-cart"></i>';
                     html+='         </div>';
                     html+='     </div>';
                     html+=' </div>';
    			});
    			$('#list-new-product').html(html);
    		},
    		error : function(jqXhr, textStatus, errorMessage) {
    			console.log(errorMessage);
    		}
    	});
    }

    
    </script>
	<!--::footer_part end::-->
</body>

</html>