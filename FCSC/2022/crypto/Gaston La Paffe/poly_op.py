from sage.all import *
from Crypto.Random.random import randint
import numpy as np

Q = 8383489
B = 16384
N = 512

E = PolynomialRing(GF(Q), names = 'x'); x = E.gen()
R = QuotientRing(E, x ** N + 1)

def poly_add(p1, p2):
    return [ (p1[i] + p2[i]) % Q for i in range(N) ]

def poly_sub(p1, p2):
        return [ (p1[i] - p2[i]) % Q for i in range(N) ]

def poly_mul_add(p1, p2, p3):
    return poly_add(poly_mul(p1, p2), p3)

def poly_mul(p1,p2):
    res = np.convolve(p1, p2)
    res = [0] * (2 * N - 1 - len(res)) + list(res)
    a = list(map(int, res[:N]))
    b = list(map(int, res[N:] + [0]))
    res = poly_sub(a, b)

    return res


if __name__ == '__main__':
    
    s1 = [randint(-1, 1) % Q for _ in range(N)]
    s2 = [randint(-1, 1) % Q for _ in range(N)]

    s1s2 = poly_mul(s1, s2)
    assert len(s1s2) == N

    s1_p = R(s1)
    s2_p = R(s2)

    s1s2_p = (s1_p * s2_p)

    for i in range(N):
        assert s1s2[i] == s1s2_p[i], str(i)

    print("Multiplication works")

    retrieved_s1 = s1s2_p / (s2_p)

    for i in range(N):
        assert retrieved_s1[i] == s1[i], str(i)

    print("Division works")