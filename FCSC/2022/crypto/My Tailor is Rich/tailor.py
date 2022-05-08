import string
import random

N = 8

def F(tmp):
    if tmp % 2: # tmp odd
        return (tmp % 26) + ord('A')
    else: # tmp even
        r = tmp % 16
        if r < 10:
            return ord('0') + r
        else:
            return r - 10 + ord('A')

def encode(pwd):
    

    a, res = 0, []

    for i in range(len(pwd)):
        c = pwd[i]
        T = sum(pwd)
        a = F((a + c) * i + T)
        res.append(a)

    return bytes(res)

def get_random_string(length):
    return ''.join(random.choice(string.ascii_letters) for _ in range(length)).encode()

if __name__ == '__main__':
    pwd = get_random_string(8)
    enc = encode(pwd)

    print(f'Can you find {N} different passwords that encode to "{enc.decode()}"?')

    P = []
    S = [enc]
    try:
        for _ in range(N):
            p = input(">>> ").encode()
            if not p.isascii():
                print("Please enter only ASCII strings.")
                exit(1)
            P.append(p)
            S.append(encode(p))

        if len(set(P)) == N and len(set(S)) == 1:
            print("Congrats!! Here is your flag:")
            print(open("flag.txt").read())
        else:
            print("Nope!")
    except:
        pass
