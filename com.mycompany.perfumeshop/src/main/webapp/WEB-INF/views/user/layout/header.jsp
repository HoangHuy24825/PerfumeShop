<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>        

<header class="main_menu home_menu" id="my_header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-12">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <a class="navbar-brand" href="${base }">
                        <img class="logo" src="${base }/user/img/my-logo/logo-asp.net.png" alt="logo"
                             width="84px" height="84px">
                    </a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse"
                            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                        <span class="menu_icon"><i class="fas fa-bars"></i></span>
                    </button>

                    <div class="collapse navbar-collapse main-menu-item" id="navbarSupportedContent">
                        <ul class="navbar-nav stroke" id="mainNav">
                            <li class="nav-item my-menu-active" id="menu-home">
                                <a class="nav-link" href="${base}/home">Trang chủ</a>
                            </li>
                             <li class="nav-item" id="menu-product">
                                <a class="nav-link" href="${base}/product">Sản phẩm</a>
                            </li>
                            <li class="nav-item " id="menu-blog">
                                <a class="nav-link" href="${base }/blog">Tin tức</a>
                            </li>
                            <li class="nav-item" id="menu-promotion">
                                <a class="nav-link" href="#">Khuyến mãi</a>
                            </li>
                            <li class="nav-item" id="menu-contact">
                                <a class="nav-link" href="${base }/contact">Liên hệ</a>
                            </li>
                            <li class="nav-item" id="menu-introduce">
                                <a class="nav-link" href="${base }/introduce">Giới thiệu</a>
                            </li>

                        </ul>



                    </div>
                    <div class="hearer_icon d-flex">
    		            <div class="align-self-center cart" id="icon-cart-header" >
                             <a class="text-center" href="${base }/cart">
                                 <i class="fas fa-cart-plus">
                                 </i>
                             </a>
                             <div id="amount_cart">
                             	<c:if test="${totalItems!=null}">
                             		${totalItems}
                             	</c:if>
                             	<c:if test="${totalItems==null}">
                             		0
                             	</c:if>
                             </div>
                         </div>
                        
                        <c:if test="${isLogined==true }">
                            <div class="dropdown ml-4">
                                <div class="dropdown-toggle" id="navbarDropdown3" role="button"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <c:if test="${userLogined.avatar!=null }">
                                        <img width="35" height="35" class="rounded-circle"
                                             src="${base }/upload/${userLogined.avatar}" alt="">
                                    
                                    </c:if>
                                  	<c:if test="${userLogined.avatar==null }">
                                        <img width="35" height="35" class="rounded-circle"
                                             src="http://m.myclip.vn/images/avatar.gif" alt="">
                                    </c:if>
                                    &nbsp;
                                   <span>${userLogined.fullname}</span>
                                 <!--    <i class="fas fa-user-circle"></i> -->
                                </div>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown"
                                     style="background-color: #D1FDFF !important; ">
                                    <div class="p-2 rounded-5" id="menu-header-account">
                                        <div class="p-1 dropdown-menu-item menu-header-account-item">
                                            <a href="${base }/my-account"><i class="fas fa-user-alt ml-0">  Quản lý tài khoản</i></a>
                                        </div>
										<c:if test="${userLogined.userRoles.get(0).roleName=='ADMIN_S' }">
											<div class="p-1 dropdown-menu-item menu-header-account-item">
                                            <a href="${base }/admin/category">
                                              <i class="fas fa-store ml-0">  Quản lý website</i>
                                            </a>
                                        </div>
										</c:if>
                                        <div class="p-1 dropdown-menu-item menu-header-account-item">
                                            <a href="${base }/logout">
                                                <i class="fas fa-sign-out-alt ml-0">  Đăng xuất</i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                       </c:if>
                     <c:if test="${isLogined==false }">
                           <%--  <div id="login-item" style="margin-left: 30px; background: #ff443a; border-radius: 30px; padding: 10px; min-width: 100px; text-align: center;">
                                <a style=" color: #fff;" href="${base }/login">
                                    Đăng nhập
                                </a>
                            </div>
                             <div id="login-item" style="margin-left: 10px; background: #ff443a; border-radius: 30px; padding: 10px; min-width: 100px; text-align: center;">
                                <a style=" color: #fff;" href="${base }/register">
                                    Đăng ký
                                </a>
                            </div> --%>
                            <div class="dropdown ml-4">
                                <div class="dropdown-toggle" id="navbarDropdown3" role="button"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                  	<c:if test="${userLogined.avatar==null }">
                                        <img width="35" height="35" class="rounded-circle"
                                             src="http://m.myclip.vn/images/avatar.gif" alt="">
                                    </c:if>
                                    &nbsp;
                                   <span>Đăng nhập/ Đăng ký</span>
                                 <!--    <i class="fas fa-user-circle"></i> -->
                                </div>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown"
                                     style="background-color: #D1FDFF !important; ">
                                    <div class="p-2 rounded-5" id="menu-header-account">
                                        <div class="p-1 dropdown-menu-item menu-header-account-item">
                                            <a href="${base }/login"><i class="fas fa-user-alt ml-0">  Đăng nhập</i></a>
                                        </div>
											<div class="p-1 dropdown-menu-item menu-header-account-item">
                                            <a href="${base }/register">
                                              <i class="fas fa-user-plus ml-0">  Đăng ký</i>
                                            </a>
                                        </div>
                                        <div class="p-1 dropdown-menu-item menu-header-account-item">
                                            <a href="${base }/search-order">
                                                <i class="fas fa-search ml-0">  Tra cứu đơn hàng</i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                      </c:if>
                    </div>
                </nav>
            </div>
        </div>
    </div>
</header>
