function noti_empty(id) {
    $("#noti_"+id).text('** Không được để trống.');
    $("#noti_"+id).attr('style', 'color: red');
}

function non_empty(id) {
    $("#noti_"+id).attr('style', 'display: none;');
}

function empty_email() {
    var email = $("#email").val();
    if (email.trim() == "") {
        noti_empty('email');
        return true;
    }
    else {
        non_empty('email');
        return false;
    }
}

function empty_name() {
    var name = $("#name").val();
    if (name.trim() == "") {
        noti_empty('name');
        return true;
    }
    else {
        non_empty('name');
        return false;
    }
}

function empty_pwd_cf() {
    var pwd_cf = $("#pwd_cf").val();
    if (pwd_cf.trim() == "") {
        noti_empty('pwd_cf');
        return true;
    }
    else {
        non_empty('pwd_cf');
        return false;
    }
}

function empty_inp() {
    var checking = 0;

    if (empty_email()) {
        checking = 1;
    }

    var pwd = $("#password").val();
    if (pwd.trim() == "") {
        noti_empty('password');
        checking = 1;
    }

    var pw_again = $("#pw_again").val();
    if (pw_again.trim() == "") {
        noti_empty('pw_again');
        checking = 1;
    }

    if (empty_name()) {
        checking = 1;
    }

    if (empty_pwd_cf()) {
        checking = 1;
    }

    return checking;
}

function check_valid_pwd(id) {
    function not_match(id, message) {
        $('#div_'+id).attr('class', 'col-md-8 has-error');
        $('#'+id).attr('style', 'border: 1px solid red');
        $('#noti_'+id).text(message);
        $('#noti_'+id).attr('style', 'color: red');
    };

    function match(id) {
        $('#div_'+id).attr('class', 'col-md-8');
        $('#'+id).removeAttr('style');
        $('#noti_'+id).attr('style', 'display: none');
    };

    $('#'+id).on('keyup', function() {
        var message = '** Mật khẩu không khớp.';

        if (id=='password' && $(this).val().length < 8) {
            not_match(id, '** Mật khẩu không đủ 8 ký tự.');
        }
        else if (id=='pw_again' && $(this).val() != $('#password').val()) {
            not_match(id, message);
        }
        else {
            match(id);
        };

        if (id=='password' && $('#pw_again').val() != '' && $(this).val() != $('#pw_again').val()) {
            not_match('pw_again', message);
        }
        else if (id=='password' && $(this).val() == $('#pw_again').val()) {
            match('pw_again');
        };
    });
};

check_valid_pwd('password');
check_valid_pwd('pw_again');