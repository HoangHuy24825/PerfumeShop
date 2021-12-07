/**
 * 
 */

$(document).ready(function () {
    setActiveMenu("#menu--account");

    $("#onloadImage").hide();

    $(".row_role").each(function () {
        var id = $(this).attr("id");
        if ($("#" + id + "_Insert").prop("checked") || $("#" + id + "_Update").prop("checked") || $(
                "#" + id + "_Delete").prop("checked")) {
            $("#" + id + "_View").attr("disabled", true);
            $("#" + id + "_View").prop('checked', true);
        }
    });
});

function setStatus(idUserRole, type, status) {
    if ($("#" + idUserRole + "_Insert").prop("checked") || $("#" + idUserRole + "_Update").prop("checked") || $("#" +
            idUserRole + "_Delete").prop("checked")) {
        $("#" + idUserRole + "_View").attr("disabled", true);
        $("#" + idUserRole + "_View").prop('checked', true);
    } else {
        $("#" + idUserRole + "_View").attr("disabled", false);
        if ($("#" + idUserRole + "_View").prop("checked")) {
            $("#" + idUserRole + "_View").prop('checked', true);
        } else {
            $("#" + idUserRole + "_View").prop('checked', false);
        }
    }
    $("#onloadImage").show();
    /*$(".permission").click(false); */
    $.ajax({
        url: '/perfume-shop/admin/change-status-role?idUserRole=' + idUserRole + "&&status=" + status + "&&type=" + type,
        type: "POST",
        data: {},
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            $("#onloadImage").hide();
            if (status == true && type != 1) {
                $("#" + idUserRole + "_View").prop('checked', true);
            }
        },
        error: function (jqXhr, textStatus, errorMessage) {}
    });
}

$(".permission").click(function () {
    var idPermission = $(this).attr("id");
    var strIdPermission = idPermission.split('_');
    var type;
    switch (strIdPermission[1]) {
        case 'View':
            type = 1;
            break;
        case 'Insert':
            type = 2;
            break;
        case 'Update':
            type = 3;
            break;
        case 'Delete':
            type = 4;
            break;
        default:
            break;
    }
    var status = $("#" + idPermission).prop("checked");
    console.log(status);
    setStatus(strIdPermission[0], type, status);
});