function match_pwd_login_first() {
    var pwd = $("#password").val();
    var pw_again = $("#pw_again").val();
    
    $("#noti_match").attr("style", "display: none");

    $.ajax({
        type: "POST",
        url: "/confirm_pwd",
        contentType: "application/json",
        data: JSON.stringify({
            pwd_cf: haPa($("#pwd_cf").val())
        }),
        dataType: "text",
        success: function (result) {
            if (result=='CF') {
                $("#noti_pw").attr("style", "display: none");
                if (pwd == pw_again && pwd.length >= 8) {
                    $("#pwd").val(haPa(pwd));
                    $("#submit").attr("type", "submit");
                    $("#submit").click();
                }
            }
            else {
                $("#noti_pw").attr("style", "color: red; font-size: 12px");
            }
        },
        error: function (jqXHR) {
            console.log(jqXHR);
        }
    });
}