import random

flag = list(open("flag.txt", "rb").read().strip())
random.seed(i := 125)
random.shuffle(flag)
print(bytes(flag).decode())
print(i)