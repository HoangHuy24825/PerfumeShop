<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- HEADER DESKTOP-->
<header class="header-desktop">
    <div class="section__content section__content--p30">
        <div class="container-fluid">
            <div class="header-wrap">
                <div class="form-header">
                    <input class="au-input au-input--xl" type="text" name="" value="" id="input-search-header"
                        placeholder="Tìm kiếm...." />
                    <button class="au-btn--submit" type="button" id="btn_search_header">
                        <i class="zmdi zmdi-search"></i>
                    </button>
                </div>
                <div class="header-button">
                    <div class="noti-wrap">
                        <c:if test="${notifyRole.view == true}">
                            <div class="noti__item js-item-menu">
                                <i class="zmdi zmdi-notifications"></i>
                                <span class="quantity" id="quanlity_notify">3</span>

                                <div class="notifi-dropdown js-dropdown rounded mt-2 " id="notify_content">
                                    <!-- load notify -->
                                </div>
                            </div>
                        </c:if>
                    </div>
                    <div class="account-wrap">
                        <div class="account-item clearfix js-item-menu">
                            <div class="image rounded-circle">
                                <c:if test="${userLogined.avatar!=null }">
                                    <img src="${base}/upload/${userLogined.avatar}" alt="${userLogined.fullname }" />
                                </c:if>
                                <c:if test="${userLogined.avatar==null }">
                                    <img src="${base }/manager/images/noAvatar.png" alt="${userLogined.fullname }" />
                                </c:if>
                            </div>
                            <div class="content">
                                <a class="js-acc-btn" href="#">${userLogined.fullname }</a>
                            </div>
                            <div class="account-dropdown js-dropdown rounded mt-2">
                                <div class="info clearfix">
                                    <div class="image rounded-circle">
                                        <a href="${base }/perfume-shop/admin/my-account.html">
                                            <c:if test="${userLogined.avatar!=null }">
                                                <img src="${base}/upload/${userLogined.avatar}"
                                                    alt="${userLogined.fullname }" />
                                            </c:if>
                                            <c:if test="${userLogined.avatar==null }">
                                                <img src="${base }/manager/images/noAvatar.png"
                                                    alt="${userLogined.fullname }" />
                                            </c:if>
                                        </a>

                                    </div>
                                    <div class="content">
                                        <h5 class="name">
                                            <a href="user-account.html">${userLogined.fullname }</a>
                                        </h5>
                                        <span class="email">${userLogined.email }</span>
                                    </div>
                                </div>
                                <div class="account-dropdown__body">
                                    <div class="account-dropdown__item">
                                        <a href="${base}/perfume-shop/admin/my-account.html">
                                            <i class="fas fa-id-card"></i>Tài Khoản</a>
                                    </div>
                                </div>
                                <div class="account-dropdown__body">
                                    <div class="account-dropdown__item">
                                        <a href="${base}/perfume-shop/home.html">
                                            <i class="fas fa-pager"></i>Website</a>
                                    </div>
                                </div>
                                <div class="account-dropdown__footer">
                                    <a href="${base}/perfume-shop/logout.html">
                                        <i class="zmdi zmdi-power"></i>Đăng Xuất</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- HEADER DESKTOP-->