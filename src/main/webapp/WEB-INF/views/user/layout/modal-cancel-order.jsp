<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!--::START MODAL CONFIRM::-->
<div class="modal fade" id="modal-request-cancel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-confirm-title">Gửi yêu cầu hủy đơn hàng</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="code-confirm" class="col-form-label">Lý do hủy đơn hàng:</label>
                        <textarea class="form-control" id="input-request-cancel" name="input-request-cancel"
                            rows="3"></textarea>
                        <p class="form-control text-danger" style="display: none" id="request-cancel-message"></p>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Thoát</button>
                <button type="button" class="btn btn-primary" id="btn_request-cancel">Gửi yêu cầu</button>
            </div>
        </div>
    </div>
</div>
<!--::END MODAL CONFIRM::-->

<!-- MODAL DETAIL ORDER FROM REQUEST CANCEL START -->
<div class="modal fade" id="modal-bill-detail" tabindex="-1" role="dialog" aria-labelledby="mediumModalLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="mediumModalLabel">
                    Đơn hàng : <span id="id-orders"> </span> - <span id="status-orders"
                        style="color: green; font-weight: bold">

                    </span>
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="bill-product">
                    <div id="infor-time" class="p-4"></div>
                    <h4>Thông tin người nhận</h4>
                    <br>
                    <table class="table table-bordered">
                        <tr>
                            <td>Tên người nhận</td>
                            <td id="FullRecieverName"></td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td id="RecieverEmail"></td>
                        </tr>
                        <tr>
                            <td>Số điện thoại</td>
                            <td id="RecieverPhone"></td>
                        </tr>
                        <tr>
                            <td>Địa chỉ</td>
                            <td id="RecieverAddress"></td>
                        </tr>
                        <tr>
                            <td>Tổng tiền thanh toán</td>
                            <td id="SumPrice"></td>
                        </tr>
                    </table>
                    <hr>
                    <h4 id="detail">Chi tiết sản phẩm</h4>
                    <div id="list-product-detail"></div>
                </div>
            </div>
            <div class="modal-footer">
                <!-- <button type="button" class="btn btn-warning" onclick="ReceiveBill()">Há»§y ÄÆ¡n hÃ ng</button> -->
            </div>
        </div>
    </div>
</div>
<!-- MODAL DETAIL ORDER FROM REQUEST CANCEL START -->

<!--::START MODAL CONFIRM::-->
<div class="modal fade" id="modal-confirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-confirm-title">Xác nhận Email</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p class="col-form-label">Chúng tôi đã gửi mã xác nhận vào email của bạn. Vui lòng kiểm tra email và
                    nhập mã xác nhận hủy đơn hàng.</p>
                <form>
                    <div class="form-group">
                        <label for="code-confirm" class="col-form-label">Mã xác nhận</label> <input type="number"
                            class="form-control" id="code-confirm">
                        <p class="form-control text-danger" style="display: none" id="code-confirm-message"></p>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Thoát</button>
                <button type="button" class="btn btn-primary btnSendCode" data-id-order="" data-code-confirm="">Gửi mã
                    xác nhận</button>
            </div>
        </div>
    </div>
</div>
<!--::END MODAL CONFIRM::-->

<!--START MODAL DETAIL -->
<div class="modal fade" id="detail-modal-client" tabindex="-1" role="dialog" aria-labelledby="mediumModalLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="mediumModalLabel">
                    Đơn hàng mã: <span id="code-order"></span> - <span id="statusOrderDetail" class="text-primary font-weight-bold"> Chưa xác nhận
                    </span><br /> ID: <span id="id-order"></span>
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
                            <li style="list-style-type:none" id="status--4" class="d-none text-danger"><i
                                    class="fas fa-hand-point-right"></i> Đơn hàng đã bị hủy</li>
                            <li style="list-style-type:none" id="status--3"><i class="fas fa-hand-point-right"></i>
                                Giao hàng thành công</li>
                            <li style="list-style-type:none" id="status--2"><i class="fas fa-hand-point-right"></i>
                                Đang giao hàng</li>
                            <li style="list-style-type:none" id="status--1"><i class="fas fa-hand-point-right"></i>
                                Đã tiếp nhận đơn hàng</li>
                            <li style="list-style-type:none" id="status--0"><i class="fas fa-hand-point-right"></i>
                                Chưa tiếp nhận đơn hàng</li>
                        </ul>
                        <hr />
                    </div>
                    <h4>Thông tin người nhận</h4>
                    <br>
                    <table class="table table-bordered font-weight-bold">
                        <tr>
                            <td>Họ tên</td>
                            <td id="fullnameDetailOrder" class="text-primary"></td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td id="emailDetailOrder" class="text-primary"></td>
                        </tr>
                        <tr>
                            <td>Số điện thoại</td>
                            <td id="phoneDetailOrder" class="text-primary"></td>
                        </tr>
                        <tr>
                            <td>Địa chỉ</td>
                            <td id="addressDetailOrder" class="text-primary"></td>
                        </tr>
                        <tr>
                            <td>Ngày mua</td>
                            <td id="createdDateDetailOrder" class="text-primary"></td>
                        </tr>
                        <tr>
                            <td>Tổng tiền thanh toán</td>
                            <td id="totalDetailOrder" class="text-primary"></td>
                        </tr>
                    </table>
                    <hr />
                    <h4 class="mb-3">Chi tiết sản phẩm</h4>
                    <div id="list--product--order">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--END MODAL DETAIL -->