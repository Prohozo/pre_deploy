function pwd_error() {
    $("#pwd_cf").focus();
    document.getElementById("noti_pw").setAttribute("style", "color: red");
}

function depa(i, p){
    var k = CryptoJS.enc.Utf8.parse('Q05WTmhPSjlXM1Bm');
    
    var iv  = CryptoJS.enc.Base64.parse(i);
    var encrypto_pwd = p;
    
    var decrypted = CryptoJS.AES.decrypt(encrypto_pwd,
                                         k,
                                         {
                                             iv: iv,
                                             mode: CryptoJS.mode.CBC,
                                             padding: CryptoJS.pad.Pkcs7
                                         });
    return decrypted.toString(CryptoJS.enc.Utf8);
}

function reset_pwd(uid) {
    $.ajax({
        type: "POST",
        url: "/reset_pwd",
        contentType: "application/json",
        data: JSON.stringify({
            id: uid,
            pw_cf: haPa($("#pwd_cf").val())
        }),
        dataType: "json",
        success: function (response) {
            if (response != 'NCF'){
                var pwd = depa(response.i, response.r);
                var noti = 'Mật khẩu mới: ' + pwd;
                noti = '<h3 style="text-align: center; color: #3e8f3e;">' + noti + '</h3>'
                document.getElementById("modal_body").innerHTML = noti;
            }
            else {
                pwd_error();
            }
        },
        error: function (jqXHR) {
            console.log(jqXHR);
        }
    });
}

function remove_one_user(uid, confirm) {
    if (confirm == "CF") {
        var submit = document.getElementById("del_"+uid);
        submit.removeAttribute("type");
        submit.removeAttribute("onclick");
        submit.click();
    }
    else {
        pwd_error();
    }
}

function remove_users(confirm) {
    if (confirm == "CF") {
        var del_action = new AdminModelActions("", JSON.parse("{\"delete\": \"\"}"));
        del_action.execute('delete');
        return true
    }
    return false
}

function del_user(uid, type) {
    function check(result) {
        if (type=="1" || !remove_users(result)) {
            remove_one_user(uid, result);
        }
    }
    pst_conf_pwd(check);
}

function gen_modal_content(title, body) {
    var content =  '<div class="modal-header" style="padding: 8px;"> \
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button> \
                        <h3 class="modal-title" id="addUserModalLabel" style="font-size: 20px;">' + title + '</h3> \
                    </div> \
                    <div class="modal-body" id="modal_body"> \
                        <div class="admin-form form-horizontal">' + body +
                        '</div> \
                    </div>';
    document.getElementById("modal_content").innerHTML = content;
}

function gen_modal(uid, type="r"){
    document.getElementsByClassName("modal-dialog")[1].removeAttribute("style");
    
    var fn = type=="r" ? "reset_pwd('"+uid+"')" : "del_user('" + uid + "','" + type + "')";

    var body = '<div class="form-group"> \
                    <div class="col col-md-4"> \
                        <label for="password-user-confirm" class=" form-control-label">Xác nhận mật khẩu:</label> \
                    </div> \
                    <div class="col-12 col-md-8"> \
                        <input type="password" id="pwd_cf" class="form-control"> \
                        <small id="noti_pw" class="help-block form-text" style="display: none;">Xác nhận mật khẩu sai</small> \
                    </div> \
                </div> \
                <hr> \
                <div class="form-group" style="margin-bottom: 0;"> \
                    <div style="float: right;margin-right: 15px;"> \
                        <button type="button" class="btn btn-success" onclick="' + fn + '">Xác nhận</button> \
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Huỷ</button> \
                    </div> \
                </div>';
                
    var title = type=="r" ? "TẠO MẬT KHẨU MỚI" : "XOÁ NGƯỜI DÙNG";    
    gen_modal_content(title, body);
}

function del_excute() {
    var selected = $('input.action-checkbox:checked').length;

    if (selected === 0) {
        alert("Vui lòng chọn ít nhất một người dùng cần xoá!!!");
        return false;
    }

    gen_modal('','d_s');
    $('#modal_check').modal('show');
}