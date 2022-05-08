import json

def F(tmp):
    if tmp % 2: # tmp odd
        return (tmp % 26) + ord('A')
    else: # tmp even
        r = tmp % 16
        if r < 10:
            return ord('0') + r
        else:
            return r - 10 + ord('A')

reverse = {}
for c in range(0x7f * 8): # Maximum value possible in sum(s)
    if F(c) not in reverse:
        reverse[F(c)] = []
    
    reverse[F(c)].append(c)

with open("reverse_table.json", "w") as f:
    f.write(json.dumps(reverse))