$('#sign_in').submit(function() {
    var p = haPa($("#pwd").val());
    $("#password").val(p);
});