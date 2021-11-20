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
    <title>Tin tức | ${tileWebsite}</title>
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
    
	<!--::message to client part start::-->
	<jsp:include page="/WEB-INF/views/user/layout/message-to-user.jsp"></jsp:include>
	<!-- Message to client part end-->
	
    <!-- jquery plugins here-->
    <jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
	<script src="${base }/user/script/blog/list-blog.js"></script>

</body>

</html>