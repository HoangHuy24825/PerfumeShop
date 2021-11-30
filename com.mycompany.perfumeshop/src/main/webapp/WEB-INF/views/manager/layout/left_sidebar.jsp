<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- MENU SIDEBAR-->
<aside class="menu-sidebar d-none d-lg-block">
	<div class="logo">
		<a href="${base}/manager/dashboard"> <img src="${base}/manager/images/logo_admin.png" alt="Admin" />
		</a>
	</div>
	<div class="menu-sidebar__content js-scrollbar1">
		<nav class="navbar-sidebar">
			<ul class="list-unstyled navbar__list">
				<%-- <li id="menu--dashboard" class=""><a
					href="${base}/perfume-shop/admin/dashboard.html"> <i
						class="fas fa-tachometer-alt"></i>Dashboard
				</a></li> --%>
				<c:if test="${categoryRole.view==true}">
					<li id="menu--category" class="">
						<a href="${base}/perfume-shop/admin/category.html">
							<i class="fas fa-th-large"></i>Danh Mục
						</a>
					</li>
				</c:if>

				<c:if test="${productRole.view==true}">
					<li id="menu--product" class=""><a href="${base}/perfume-shop/admin/product.html">
							<i class="fas fa-sitemap"></i>Sản Phẩm
						</a></li>
				</c:if>

				<c:if test="${orderRole.view==true}">
					<li id="menu--order" class=""><a href="${base}/perfume-shop/admin/order.html">
							<i class="fas fa-money-check"></i>Đơn hàng
						</a></li>
				</c:if>

				<c:if test="${categoryBlogRole.view==true}">
					<li id="menu--category--blog" class=""><a href="${base}/perfume-shop/admin/category-blog.html">
							<i class="fas fa-th-list"></i>Danh mục blog
						</a></li>
				</c:if>

				<c:if test="${blogRole.view==true}">
					<li id="menu--blog" class=""><a href="${base}/perfume-shop/admin/blog.html">
							<i class="fab fa-blogger"></i>Blog
						</a></li>
				</c:if>

				<c:if test="${accountRole.view==true}">
					<li id="menu--account" class=""><a href="${base}/perfume-shop/admin/account.html">
							<i class="fas fa-user-circle"></i>Tài Khoản
						</a></li>
				</c:if>

				<c:if test="${introduceRole.view==true}">
					<li id="menu--introduce" class=""><a href="${base}/perfume-shop/admin/introduce.html">
							<i class="fas fa-info"></i>Giới thiệu
						</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
</aside>
<!-- END MENU SIDEBAR-->