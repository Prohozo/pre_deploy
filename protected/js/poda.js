$("#ls").html("<script src='/static/js/CryptoJS v3.1.2/rollups/sha512.js'></script> \
               <script src='/static/js/CryptoJS v3.1.2/rollups/pbkdf2.js'></script> \
               <script src='/static/js/CryptoJS v3.1.2/rollups/aes.js'></script>");

function haPa(p) {
    var salt = 'ioweqytoyewtyqncyshfwyrueyruwyenvche';
    var hasher = CryptoJS.algo.SHA512;
    var pwd_hash = CryptoJS.PBKDF2(p, salt, { keySize: 512 / 32,
                                              hasher: hasher,
                                              iterations: 1000});
    return pwd_hash.toString();                                            
}

function pst_conf_pwd(func) {
    $.ajax({
        type: "POST",
        url: "/confirm_pwd",
        contentType: "application/json",
        data: JSON.stringify({
            pwd_cf: haPa($("#pwd_cf").val())
        }),
        dataType: "text",
        success: function (result) {
            func(result);
        },
        error: function (jqXHR) {
            console.log(jqXHR);
        }
    });
}