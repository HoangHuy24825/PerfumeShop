<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!-- HEADER MOBILE-->
        <header class="header-mobile d-block d-lg-none">
            <div class="header-mobile__bar">
                <div class="container-fluid">
                    <div class="header-mobile-inner">
                        <a class="logo" href="index.html">
                            <img src="${base }/manager/images/logo_admin.png" alt="CoolAdmin" />
                        </a>
                        <button class="hamburger hamburger--slider" type="button">
                            <span class="hamburger-box">
                                <span class="hamburger-inner"></span>
                            </span>
                        </button>
                    </div>
                </div>
            </div>
            <nav class="navbar-mobile">
                <div class="container-fluid">
                    <ul class="navbar-mobile__list list-unstyled">
                        <li id="menu--dashboard" class="">
                            <a href="${base}/perfume-shop/admin/dashboard.html">
                                <i class="fas fa-tachometer-alt"></i>Dashboard</a>
                        </li>
                       
                        <li id="menu--category" class="">
                            <a href="${base}/perfume-shop/admin/category.html">
                                <i class="fas fa-th-large"></i>Danh Mục</a>
                        </li>
                        <li id="menu--product" class="">
                            <a href="${base}/perfume-shop/admin/product.html">
                                <i class="fas fa-sitemap"></i>Sản Phẩm</a>
                        </li>
                         <li id="menu--order" class="">
                            <a href="${base}/perfume-shop/admin/order.html">
                               <i class="fas fa-money-check"></i>Đơn hàng</a>
                        </li>
                        <li id="menu--category--blog" class="">
                            <a href="${base}/perfume-shop/admin/category-blog.html">
                                <i class="fas fa-th-list"></i>Danh mục blog</a>
                        </li>
                        <li id="menu--blog" class="">
                            <a href="${base}/perfume-shop/admin/blog.html">
                                <i class="fab fa-blogger"></i>Blog</a>
                        </li>
                         <li id="menu--account" class="">
                            <a href="${base}/perfume-shop/admin/account.html">
                                <i class="fas fa-user-circle"></i>Tài Khoản</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <!-- END HEADER MOBILE-->