// Fill password auto for edit form
function fp() {
    $("label")[2].innerHTML = "Mật khẩu";
    var pwd = $("#password");
    pwd.val('********');
    pwd.removeAttr("required");

    $("label")[3].innerHTML = "Nhắc lại mật khẩu";
    var pwd_again = $("#pw_again");
    pwd_again.val('********');
    pwd_again.removeAttr("required");
}

function create_modal_content(content) {
    noti = '<h4 style="text-align: center;"> \
                <i class="fa fa-bullhorn" aria-hidden="true"></i>' + content +
            '</h4> \
            <hr> \
            <div class="form-group" style="margin-bottom: 0;"> \
                <div style="float: right;margin-right: 15px;"> \
                    <button id="noti-close" type="button" class="btn btn-primary">Đóng</button> \
                </div> \
            </div>';
    gen_modal_content("Thông báo", noti);
    $('#modal_check').modal('show');
    document.getElementsByClassName("modal-dialog")[1].setAttribute("style", "top: 30%;margin-top: 0px !important");
    document.getElementsByClassName("modal-backdrop fade in")[1].setAttribute("style", "z-index: 1050");
}

function noti_validate_pwd(id, type) {
    if (type == "error") {
        $("#div_"+id).attr("class", "col-md-8 has-error");
        $("#"+id).attr("style", "border: 1px solid red");
        $("#noti_"+id).text("** Mật khẩu không đủ 8 ký tự.");
        $("#noti_"+id).attr("style", "color: red");
        $("#password").focus();
    }
    else {
        $("#div_"+id).attr("class", "col-md-8");
        $("#"+id).removeAttr("style");
        $("#noti_"+id).attr("style", "display: none");
    }
}

function check_valid_pwd() {
    var pwd = $("#password").val();
    var pw_again = $("#pw_again").val();

    if (pwd != pw_again) {
        return false;
    }

    return true;
}

function confirm_pwd(result) {
    if (result == "CF") {
        var pwd = $("#password").val();
        var pw_again = $("#pw_again").val();
        if (pwd != '********') {
            $("#password").val(haPa(pwd));
            $("#pw_again").val(haPa(pw_again));
        };

        var submit = $(".btn-primary");
        submit.attr("type", "submit");
        submit.removeAttr("onclick");
        submit.click();
    }
    else {
        create_modal_content('Mật khẩu xác nhận không đúng!!!');

        $("#noti-close").click(function() {
            $('#modal_check').modal('toggle');
            $("#pwd_cf").focus();
        });
    }
}

function chk_pwd() {
    if (check_valid_pwd()) {
        pst_conf_pwd(confirm_pwd);
    }
}

$("#email").on('keyup', empty_email);
$("#name").on('keyup', empty_name);
$("#pwd_cf").on('keyup', empty_pwd_cf);

function chk_info(type, id='') {
    if (empty_inp()==1) {
        return false;
    }
    var data_info = JSON.stringify({
        type: type,
        id: id,
        usn: $("#email").val()
    });
    $.ajax({
        type: "POST",
        url: "/checking_info",
        contentType: "application/json",
        data: data_info,
        dataType: "text",
        success: function (result) {
            if (result == 'EXISTS') {
                $("#noti_email").text('** Tên tài khoản đã tồn tại.');
                $("#noti_email").attr('style', 'color: red');
            }
            else {
                $("#noti_email").attr('style', 'display: none;');
                chk_pwd();
            }
        },
        error: function (jqXHR) {
            console.log(jqXHR);
        }
    });
}