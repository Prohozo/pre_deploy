from Crypto.Protocol.KDF import PBKDF2
from Crypto.Hash import SHA512
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
from base64 import b64encode
import json


# Hash password with PBKDF2_SHA512
def hapa(p):
    password = bytes(p,'utf-8')
    salt = b'ioweqytoyewtyqncyshfwyrueyruwyenvche'
    keys = PBKDF2(password, salt, 64, count=1000, hmac_hash_module=SHA512)
    return keys.hex()

# Encode password with AES
def enpa(p):
    data = bytes(p, 'utf-8')
    key = bytes('Q05WTmhPSjlXM1Bm', 'utf-8')
    print(len(key))
    cipher = AES.new(key, AES.MODE_CBC)
    ct_bytes = cipher.encrypt(pad(data, AES.block_size))
    iv = b64encode(cipher.iv).decode('utf-8')
    ct = b64encode(ct_bytes).decode('utf-8')
    result = json.dumps({'i':iv, 'r':ct})
    return result