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
	 <section class="blog_area pt-5 bg-white">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mb-5 mb-lg-0">
                    <div class="blog_left_sidebar" id="blog-container">
                       
						<!-- Blog list -->
                       
                    </div>
                     <div class="col-lg-12">
                         <div class="pageination">
                             <nav aria-label="Page navigation example">
                                 <ul class="pagination justify-content-center" id="load-pagination">
                                    
                                    <!-- pagination -->
                                    
                                 </ul>
                             </nav>
                         </div>
                     </div>
                </div>
                <div class="col-lg-4">
                    <div class="blog_right_sidebar">
                        <aside class="single_sidebar_widget search_widget">
                            <form action="#">
                                <div class="form-group">
                                    <div class="input-group mb-3">
                                        <input type="text" id="searchStr" class="form-control" placeholder='Từ khóa tìm kiếm'
                                            onfocus="this.placeholder = ''"
                                            onblur="this.placeholder = 'Từ khóa tìm kiếm'">
                                        <div class="input-group-append">
                                            <button class="btn" type="button"><i class="ti-search"></i></button>
                                        </div>
                                    </div>
                                </div>
                                <button class="button rounded-0 primary-bg text-white w-100 btn_1"
                                    type="button" id="search">Tìm kiếm</button>
                            </form>
                        </aside>

                        <aside class="single_sidebar_widget post_category_widget">
                            <h4 class="widget_title">Danh mục</h4>
                            <ul class="list cat-list" id="list-category-blog">
                           		<li class="" id="">
                                    <div class="d-flex">
                                        <p style="margin-right: 5px"> Tất cả blog </p>
                                        <p>(${ amountBlog})</p>
                                    </div>
                                </li>
                            	<c:forEach var="category" items="${categoryBlogs}">
	                                <li class="" id="${category.id}">
	                                    <div class="d-flex">
	                                        <p style="margin-right: 5px"> ${category.name} </p>
	                                        <p>(${category.blogs.size()})</p>
	                                    </div>
	                                </li>
                                </c:forEach>
                            </ul>
                        </aside>

                        <aside class="single_sidebar_widget popular_post_widget">
                            <h3 class="widget_title">Bài viết gần đây</h3>
                            <c:forEach var="blog" items="${recentPosts}">
	                            <div class="media post_item" onclick="detail('${blog.id}')">
	                                <img width="80" height="80" src="${base}/upload/${blog.avatar}" alt="post">
	                                <div class="media-body">
	                                    <div>
	                                        <h3>${blog.name}</h3>
	                                    </div>
	                                    <c:if test="${blog.updatedDate==null}">
	                                    	<p><fmt:formatDate value="${blog.createdDate}" pattern="dd-MM-yyyy" /></p>
	                                    </c:if>
	                                    <c:if test="${blog.updatedDate!=null}">
	                                    	<p><fmt:formatDate value="${blog.createdDate}" pattern="dd-MM-yyyy" /></p>
	                                    </c:if>
	                                </div>
	                            </div>
	                       </c:forEach>
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
    	$('.close-btn-alert').click(function() {
    		$('.alert').removeClass("show");
    		$('.alert').addClass("hide");
    	});
    	$("#searchStr").val("");
    	//load init
    	loadData(null, 1, null);
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
    
    function loadData(searchStr, page, id_category) {
    	$.ajax({
    		url: "/all-blog",
    		type: "GET",
    		data: { searchStr: searchStr, page: page, id_category: id_category},
    		dataType: "json",
    		contentType: "application/json;charset=utf-8",
    		success: function(result) {
    			var html = '';
    			if ((result.blogs.length == 0 || result.blogs == null) && searchStr != null && searchStr != "") {
    				html += '<div style="margin:auto;text-align:center">';
    				html += ' <img src="${base}/user/img/NotFoundBlog.png" width="300" style="margin:auto"/>';
    				html += '<br/>'
    				html += ' <p style="text-align:center; margin: 25px 0px 30px;">Không tìm thấy blog phù hợp!</p>';
    				html += '</div>';
    				$("#load-pagination").html("");
    			} else if ((result.blogs.length == 0 || result.blogs == null) && id_category != null && id_category != "") {
    				html += '<div style="margin:auto;text-align:center">';
    				html += ' <img src="${base}/user/img/NotFoundBlog.png" width="300" style="margin:auto"/>';
    				html += '<br/>'
    				html += ' <p style="text-align:center; margin: 25px 0px 30px;">Không có blog nào trong danh mục!</p>';
    				html += '</div>';
    				$("#load-pagination").html("");
    			}
    			else {
    				$.each(result.blogs, function(index, item) {
    					html+='<article class="blog_item" onclick="detail('+item.id+')">';
   						html+='		<div class="blog_item_img">';
						html+='         <img class="card-img rounded-0" width="750" height="375" src="${base}/upload/'+item.avatar+'	" alt="">';
						if (item.updatedDate!=null) {
							html+='         <div class="blog_item_date">';
							html+='       		<h3>'+item.updatedDate.slice(0,2)+'</h3>';
							html+='     		<p>Tháng '+item.updatedDate.slice(3,5)+'</p>';
							html+=' 		</div>';
						}else{
							html+='         <div class="blog_item_date">';
							html+='       		<h3>'+item.createdDate.slice(0,2)+'</h3>';
							html+='     		<p>Tháng '+item.createdDate.slice(3,5)+'</p>';
							html+=' 		</div>';
						}
					
						html+='		</div>';
						html+='    <div class="blog_details">';
						html+='        <div class="d-inline-block">';
						html+='            <h2>'+item.name+'</h2>';
						html+='        </div>';
						html+='         <p>'+item.description+'</p>';
						html+='        <ul class="blog-info-link">';
						html+='            <li><div><i class="far fa-user"></i>'+item.categoryname+'</div></li>';
						html+='        </ul>';
						html+='    </div>';
						html+='</article>';			
    				});
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
    			}
    			$("#blog-container").html(html);
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

    function detail(id_blog) {
    	$.ajax({
    		url: "/detail-blog",
    		type: "GET",
    		data: { idBlog: id_blog},
    		dataType: "json",
    		contentType: "application/json;charset=utf-8",
    		success: function(result) {
    			$("#load-pagination").html("");
    			var html = '';
    			html+=result.detail;
    			$("#blog-container").html(html);
    		}

    	});
    };

    $('.row-left-sidebar').click(function() {
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
    		loadData(txtSearch, page, id_category);
    	}
    	else {
    		loadData(null, page, id_category);
    	}

    });

    $("#search").click(function() {
    	$('#list-category-blog').find('.selected-category').removeClass('selected-category');
    	var txtSearch = $("#searchStr").val();
    	console.log(txtSearch);
    	if (txtSearch != "") {
    		loadData(txtSearch, 1, null);
    	}
    	else {
    		loadData(null, 1, null);
    	}
    });

    $("#searchStr").keyup(function(event) {
    	$('#search').click();
    });
    
    $('#list-category-blog li').click(function() {
    	$('#searchStr').val("");
    	
    	$('#list-category-blog').find('.selected-category').removeClass('selected-category');
    	$('#list-category-blog').find('.chosed').removeClass('chosed');
    	
    	var id_category = $(this).attr('id');
    	loadData(null, 1, id_category);
    	$(this).addClass('chosed');
    	$(this).addClass('selected-category');
    	
    	var title = $(this).find('p:first-child').text();
    	$('#title-banner').find('h2').html("Blogs");
    	$('#title-banner').find('p').html("Trang chủ > " + title);
    });

   
    </script>
	<!--::footer_part end::-->
</body>

</html>