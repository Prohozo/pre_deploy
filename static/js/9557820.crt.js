$("#ls").html("<script src='/static/js/CryptoJS v3.1.2/rollups/sha512.js'></script> \
               <script src='/static/js/CryptoJS v3.1.2/rollups/pbkdf2.js'></script>");

function haPa(p) {
    var salt = 'ioweqytoyewtyqncyshfwyrueyruwyenvche';
    var hasher = CryptoJS.algo.SHA512;
    var pwd_hash = CryptoJS.PBKDF2(p, salt, { keySize: 512 / 32,
                                              hasher: hasher,
                                              iterations: 1000});
    return pwd_hash.toString();                                            
}