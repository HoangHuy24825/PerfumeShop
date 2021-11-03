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
            <div class="row" >
            	<div id="content-page-introduce">
             	
             	</div>
            </div>
        </div>
    </section>
	
    <!--::footer_part start::-->
   	 <jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
    <!--::footer_part end::-->
    
	
    <!-- jquery plugins here-->
    <jsp:include page="/WEB-INF/views/user/layout/script.jsp"></jsp:include>
    <script type="text/javascript">
    $(document).ready(function() {
    	setMenuBanner();
    	$('.close-btn-alert').click(function() {
    		$('.alert').removeClass("show");
    		$('.alert').addClass("hide");
    	});
    	loadPage();
    });
    
    function setMenuBanner() {
    	var titlebanner='';
    	$("#img-banner").html('<img src="${base}/user/img/my-image/banner/about-us.png" alt="" width="300">');
    	titlebanner+='<h2>Giới thiệu</h2>';
    	titlebanner+='<p> Trang chủ <span>></span> Giới thiệu </p>';
    	$("#title-banner").html(titlebanner);
    	
    	$( "#mainNav li" ).each(function( index ) {
    		  $(this).removeClass("my-menu-active");
    	});
    	
    	$("#menu-introduce").addClass("my-menu-active");
	}
    
    function loadPage() {
    	$.ajax({
            url: '/load-introduce',
            type: "GET",
            data: {},
            dataType: "json",
            contentType: "application/json",
            success: function (jsonResult) { 
            	$("#content-page-introduce").html(jsonResult.content.detail);
            },
            error: function (jqXhr, textStatus, errorMessage) { // error callback 
            	
            }
        });
	}
    
    </script>
	<!--::footer_part end::-->
</body>

</html>