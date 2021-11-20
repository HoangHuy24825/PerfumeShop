<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--::message_part start::-->
<div class="alert alert-success hide" id="alert_message">
    <div id="icon-alert-message"><i class="fas fa-exclamation-circle"></i></div>
    <span class="msg">Warning: This is a warning alert!</span>
    <div class="close-btn-alert">
        <span class="fas fa-times"></span>
    </div>
</div>
<!--::message_part end::-->

<!--::message_part start::-->
<div class="alert alert-fail hide" id="alert_message">
    <div id="icon-alert-message"><i class="fas fa-exclamation-circle"></i></div>
    <span class="msg">Warning: This is a warning alert!</span>
    <div class="close-btn-alert">
        <span class="fas fa-times"></span>
    </div>
</div>
<!--::message_part end::-->

<!-- START MODAL CONFIRM -->
<div class="modal fade" id="modalCustomerConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body " id="modalCustomerConfirmContent" style="font-size:22px ">
                <!--content-->
            </div>
            <div class="modal-footer mx-auto" style="border:unset">
                <button type="button" id="btnCloseConfirm" onclick="" class="btn btn-secondary" data-dismiss="modal"
                    aria-label="Close">
                    Không
                </button>
                <button type="button" id="btnAgree" onclick="" class="btn btn-primary">
                    <!--Button Save-->
                </button>
            </div>
        </div>
    </div>
</div>
<!-- END MODAL CONFIRM -->

<!-- START MODAL CONFIRM -->
<div class="modal fade" id="modalCustomerOrder" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body " id="modalCustomerOrderContent" style="font-size:22px ">
                <div class="row px-3">Vui lòng chọn dung tích bạn muốn mua:</div>
                <hr />
                <div class="row px-3" id="currentCapacityModal">
                    Sản phẩm bạn đang chọn:
                </div>
                <hr />
                <div class="row px-3" id="modal-capacity-list">
                    <button class="col-4 text-center p-2 m-1 border rounded bg-white btnChoseCapacity"
                        data-price="${item.price}" data-price-sale="${item.priceSale}" data-id="${item.id}"
                        data-min-price="${jsonResult.product.minPrice}" data-amount="${item.amount}"
                        data-name="${jsonResult.product.title}">
                        <div class="capacityProduct">${item.capacity} ML</div>
                        <div class="priceProduct font-weight-bold">${price} &#8363;</div>
                    </button>
                </div>
                <hr />
                <div class="row px-3">
                    <input type="number" style="width:150px" class="col align-self-center" id="numberOrderInModal"
                        min="1" max="">
                </div>
            </div>
            <div class="modal-footer mx-auto" style="border:unset">
                <button type="button" id="btnCloseConfirm" onclick="" class="btn btn-secondary" data-dismiss="modal"
                    aria-label="Close">
                    Hủy
                </button>
                <button type="button" id="btnAgreeOrder" style="width:150px" onclick="" class="btn btn-primary">
                    <!--Button Save-->
                    Thêm vào giỏ
                </button>
            </div>
        </div>
    </div>
</div>
<!-- END MODAL CONFIRM -->