import math
from random import randrange

def rsa_gen(p, q):
    n = p*q
    e = 3
    while math.gcd(e, p-1) != 1 or math.gcd(e, q-1) != 1:
        e += 1
    d = pow(e, -1, (p-1)*(q-1))
    return n, e, d

def encrypt_rsa(data, e, n):
    data = int(data.encode().hex(), 16)
    assert data < n
    enc = pow(data, e, n)
#     enc = hex(pow(data, e, n))[2:]
#     enc = '0'*(len(enc) % 2) + enc
    return enc
    
def decrypt_rsa(data, d, n):
#     enc_int = int(data.encode().hex(), 16)
    enc_int = data
    dec = hex(pow(enc_int, d, n))[2:]
    dec = '0'*(len(dec) % 2) + dec
    return bytes.fromhex(dec).decode('utf-8')

def rsa_fun(p, q, en_data):
    n, e, d = rsa_gen(p, q)
    de_data = decrypt_rsa(en_data, d, n)
    return n, e, d, en_data, de_data

import binascii
import math
from random import randrange



def is_prime(n):
    if n % 2 == 0 and n > 2: 
        return False
    return all(n % i for i in range(3, int(math.sqrt(n)) + 1, 2))

def dsa_generation(q):
    p = 3
    while not ( ((p - 1) % q == 0) and is_prime(p)):
        p += 1
    h = randrange(2, p - 1)
    g = 2
    while g < p and not (pow(g, q, p) == 1 and g == pow(h, (p-1)//q, p)):
        g += 1
    x = randrange(0, q)
    y = pow(g, x, p)
    return p, q, g, y, x

p = 101
q = 103
print('TASK 1')
n, e, d = rsa_gen(p, q)
print(f'   RSA: p:{p}, q:{q} --> n:{n}, e:{e}, d:{d}' )
print(f"")
print('TASK 2')
text = 'H'
enc_text = encrypt_rsa(text, e, n)
print(f'   ORIGINAL TEXT:{text}, ENCRYPTED TEXT: {enc_text}')
n, e, d, enc_text, dec_text = rsa_fun(p, q, enc_text)
print(f'   n:{n}, e:{e}, d:{d}, ENCRYPTED TEXT: {enc_text}, DECRYPTED TEXT: {dec_text}')
print('')

print("TASK 3")

p, q, g, y, x = dsa_generation(53)

print(f"   PUBLIC KEY: {p, q, g, y}")
print(f"   PRIVATE KEY: {p, q, g, x}")

