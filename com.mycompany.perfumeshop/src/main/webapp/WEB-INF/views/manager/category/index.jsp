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
    <title>Danh mục | Admin Electronic Device</title>
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
                                <h3 class="title-5 m-b-35">danh mục sản phẩm</h3>
                                <div class="table-data__tool">
                                    <div class="table-data__tool-left">
                                    </div>
                                    <div class="table-data__tool-right">
                                    	<c:if test="${categoryRole.insert ==true}">	
	                                        <button class="au-btn au-btn-icon au-btn--green au-btn--small" onclick="location.href='${base}/admin/add-category'">
	                                            <i class="fas fa-plus" ></i>Thêm mới
	                                        </button>
                                       	</c:if>
                                       	<input id="update_role" value="${categoryRole.update}" type="text" style="display: none"/> 
                                    	<input id="delete_role" value="${categoryRole.delete}" type="text" style="display: none"/>
                                    </div>
                                </div>
                                <div class="table-responsive table-data">
                                    <table class="table table-data2">
                                        <thead>
                                            <tr>
                                                <th>Ảnh</th>
                                                <th>Tên</th>
                                                <th>Mô tả</th>
                                                <th>Seo</th>
                                                <th>Trạng thái</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody id="table_data">
                                            <!--List of category-->
                                        </tbody>
                                    </table>

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
    <script type="text/javascript" src="${base }/manager/script/category/listCategory.js"></script>
</body>

</html>
<!-- end document-->