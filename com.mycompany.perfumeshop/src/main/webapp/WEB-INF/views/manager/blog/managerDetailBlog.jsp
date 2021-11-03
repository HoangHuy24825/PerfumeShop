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
    <title>Blog | Admin Electronic Device</title>
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
                                    <a href="${base}/admin/blog" class="btn_back_list"><i class="fa fa-arrow-left"></i></a> &nbsp
                                    <h3 class="title-5 m-b-35">Chi tiết blog</h3>
                                </div>
                               <div class="">
                                <div class="bg-light p-4">
                                    <table class="table table-bordered">
                                        <tr>
                                            <td>Tên blog</td>
                                            <td>${blog.name}</td>
                                        </tr>
                                        <tr>
                                            <td>Ảnh đại diện blog</td>
                                            <td> <img src="/upload/${blog.avatar}" width="300" /></td>
                                        </tr>
                                        <tr>
                                            <td>Mô tả</td>
                                            <td>
                                                ${blog.description}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Ngày tạo</td>
                                            <td><fmt:formatDate pattern="dd/MM/yyyy" value="${blog.createdDate}"/></td>
                                        </tr>
                                        <tr>
                                            <td>Người tạo</td>
                                            <td>${createdBy.fullname} (${createdBy.username})</td>
                                        </tr>
                                        <tr>
                                            <td>Ngày sửa</td>
                                            <td><fmt:formatDate pattern="dd/MM/yyyy" value="${blog.updatedDate}" /></td>
                                        </tr>
                                        <c:if test="${updatedBy!=null }">
	                                        <tr>
	                                            <td>Người sửa</td>
	                                            <td>${updatedBy.fullname} (${updatedBy.username })</td>
	                                        </tr>
                                        </c:if>
                                         <c:if test="${updatedBy==null }">
	                                        <tr>
	                                            <td>Người sửa</td>
	                                            <td>Danh mục chưa thực hiện cập nhật.</td>
	                                        </tr>
                                        </c:if>
                                         <tr>
                                            <td>Seo</td>
                                            <td> ${blog.seo}</td>
                                        </tr>
                                         <tr>
                                            <td>Hot</td>
                                            <td>
                                               ${blog.isHot==true?"Hot":"Bình thường"}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Trạng thái</td>
                                            <td>
                                               ${blog.status==true?"Hiển thị":"Ẩn"}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Chi tiết danh mục</td>
                                            <td>${blog.detail}</td>
                                        </tr>
                                    </table>
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
    	$('.list-unstyled #menu--blog').addClass("active");
    	$('.navbar__list #menu--blog').addClass("active");
	}
    
    </script>
</body>

</html>
<!-- end document-->