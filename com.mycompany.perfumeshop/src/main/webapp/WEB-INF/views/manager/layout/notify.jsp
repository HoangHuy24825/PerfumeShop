<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!--START MODAL DETAIL -->
<div class="modal fade" id="notify-modal" tabindex="-1" role="dialog" aria-labelledby="mediumModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="mediumModalLabel">
					Thông báo <span id="code-order"></span>
				</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div id="order--information">
					<div class="p-2">
						<h4>Tất cả thông báo của bạn</h4>
						<ul class="text-muted">
							<li style="list-style-type:none" id="notify_detail_title"></li>
						</ul>
					</div>
					<br>
					<div class="au-message-list" id="list-detail-notify">
						<!-- Content notify list -->
					</div>
				</div>
			</div>
			<div class="modal-footer">

			</div>
		</div>
	</div>
</div>
<!--END MODAL DETAIL -->

<!--START MODAL DETAIL -->
<div class="modal fade" id="notify-detail-modal" tabindex="-1" role="dialog" aria-labelledby="mediumModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="mediumModalLabel">
					Đơn hàng mã: <span id="code-order-notify"></span> - <span id="status-orders-notify"> Chưa xác nhận
					</span><br /> ID: <span id="id-order-notify"></span>
				</h5>
				<br />
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div id="order--information">
					<div class="p-4">
						<h4 style="margin-left: -25px;">Trạng thái đơn hàng</h4>
						<br />
						<ul class="text-muted" id="status--order">
							<li style="list-style-type:none" id="status--4--notify" class="d-none text-danger"><i
									class="fas fa-hand-point-right"></i> Đơn hàng đã bị hủy</li>
							<li style="list-style-type:none" id="status--3--notify"><i
									class="fas fa-hand-point-right"></i> Giao hàng thành công</li>
							<li style="list-style-type:none" id="status--2--notify"><i
									class="fas fa-hand-point-right"></i> Đang giao hàng</li>
							<li style="list-style-type:none" id="status--1--notify"><i
									class="fas fa-hand-point-right"></i> Đã tiếp nhận đơn hàng</li>
							<li style="list-style-type:none" id="status--0--notify"><i
									class="fas fa-hand-point-right"></i> Chưa tiếp nhận đơn hàng</li>
						</ul>
						<hr />
					</div>
					<h4>Thông tin người nhận</h4>
					<br>
					<table class="table table-bordered font-weight-bold">
						<tr>
							<td>Họ tên</td>
							<td id="fullname-notify" class="text-primary"></td>
						</tr>
						<tr>
							<td>Email</td>
							<td id="email-notify" class="text-primary"></td>
						</tr>
						<tr>
							<td>Số điện thoại</td>
							<td id="phone-notify" class="text-primary"></td>
						</tr>
						<tr>
							<td>Địa chỉ</td>
							<td id="address-notify" class="text-primary"></td>
						</tr>
						<tr>
							<td>Ngày mua</td>
							<td id="createdDate-notify" class="text-primary"></td>
						</tr>
						<tr>
							<td>Tổng tiền thanh toán</td>
							<td id="total-notify" class="text-primary"></td>
						</tr>
						<tr>
							<td>Lý do hủy đơn hàng</td>
							<td id="reason-notify-detail" class="text-primary"></td>
						</tr>
					</table>
					<hr />
					<h4 class="mb-3">Chi tiết sản phẩm</h4>
					<div id="list--product--order-notify">

					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="btn_not_cancel_order" class="btn btn-primary">Không hủy đơn</button>
				<button type="button" id="btn_cancel_order" class="btn btn-danger">Hủy đơn</button>
			</div>
		</div>
	</div>
</div>
<!--END MODAL DETAIL -->

<!--::START MODAL CONFIRM::-->
<div class="modal fade" id="modal-reason-reject" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
	aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modal-confirm-title">Từ chối hủy đơn hàng</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<div class="form-group">
						<label for="code-confirm" class="col-form-label">Lý do:</label>
						<textarea class="form-control" id="input-reason-reject" name="input-reason-reject"
							rows="3"></textarea>
						<!-- <input type="text" class="form-control" id="code-confirm"> -->
						<p class="form-control text-danger" style="display: none" id="reason-message-error"></p>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Thoát</button>
				<button type="button" class="btn btn-primary" id="btn_confirm_reject">Gửi mail xác nhận</button>
			</div>
		</div>
	</div>
</div>
<!--::END MODAL CONFIRM::-->