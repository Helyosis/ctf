# Hash-ish (2 étoiles - 350 points)

>Savez-vous comment fonctionne la fonction hash de Python ?
>
>nc challenges.france-cybersecurity-challenge.fr 2103

Fichier joint: [hashish.py](/hashish.py)

## Objectif du challenge

```python
challenge = hash(flag)
print(f"{challenge = }")

a = int(input(">>> "))
b = int(input(">>> "))

if hash((a, b)) == challenge:
    print(flag)
else:
    print("Try harder :-)")
```

Le but du challenge est de trouver deux entiers `a` et `b` tel que `hash((a, b)) == challenge`

En théorie une fonction de hash est censée être à sens unique, on n'est pas censé pouvoir trouver un élément `c` tel que `hash(c) == h`, pour un `h` donné.

C'est ce qu'on appelle dans notre cas la résistance à la pré-image.

Cependant la fonction hash() en python n'est pas cryptographiquement sûre, on peut donc essayer de l'attaquer.

## Analyse de la fonction hash() de python
```py
def py_hash(t: tuple) -> int:
    acc = 2870177450012600261
    for i in range(len(t)):
        lane = hash(t[i])
        if lane == -1: return -1
        if lane < 0: lane = twos_comp(lane, 64)
        print(f"acc at {i = } at start: {hex(acc)}")

        acc += lane * 14029467366897019727
        acc %= 2 ** 64

        acc = (acc << 31) | (acc >> (64 - 31))
        acc %= 2 ** 64

        acc *= 11400714785074694791
        acc %= 2 ** 64

    acc += len(t) ^ 2870177450012600261 ^ 3527539
    acc %= 2 ** 64

    if acc == -1: return 1546275796
    if acc >> 63 == 1: # If msb is set -> acc is negative
        return twos_comp(acc, 64)
    return acc
```
Voici un équivalent de la fonction hash() en python, uniquement valable pour les tuples. Le code n'est sûrement pas opti mais les résultats sont identiques.

On remarque que la fonction ne dépends d'aucune variable à la fin (sauf len(t), qui est fixé à 2 dans notre cas)

Ainsi, il est possible de remonter la fonction à partir du hash jusqu'à la ligne 

```python
acc += lane * 14029467366897019727
```

`lane` correspond au hash du i<sub>ème</sub> élément, qui est égal à l'élément même pour les entiers inférieur à 2<sup>32</sup> (ceux au-dessus sont gérés d'une manière différente)

Autrement dit, on peut tenter de trouver un entier `lane` acceptable si on a l'état de `acc` au début de la boucle et le hash de fin demandé.

Il est cependant possible qu'il n'y ai pas de valeurs de `lane` acceptable si la valeur de `acc` ne l'est pas non plus. Pour cela, il suffit de continuer le calcul du hash et de regarder si il correspond à ce qu'on veut. 

## Attaque 

Pour trouver une seconde pré-image au hash `challenge`, il suffit alors de bruteforce un peu le premier élément `a` du tuple, de calculer l'état de `acc` après la première boucle (qui sera le même peu importe la valeur du deuxième élément) et de calculer `b = lane`, si un hash existe, alors `hash((a, b)) == challenge`, si il n'existe pas, le hash n'est pas valide, on peut passer au prochain `a`.

Code source:
```python
def rev_hash(h: int):
    hash_to_fake = h

    h -= 2 ^ 2870177450012600261 ^ 3527539
    if h < 0:
        h = twos_comp(h, 64)
    # We multiply by the opposite mod 2^64 to cancel the original multiplication
    h *= pow(11400714785074694791, -1, 2 ** 64)
    h %= 2 ** 64

    h = (h >> 31) | (h << (64 - 31))
    h %= 2 ** 64

    for i1 in range(2 ** 30):
        lane_mul = h - partial_hash((i1, None), 1)
        if lane_mul < 0:
            lane_mul = twos_comp(lane_mul, 64)

        i2 = lane_mul * pow(14029467366897019727, -1, 2 ** 64)
        i2 %= 2 ** 64
        if i2 >> 63 == 1:
            i2 = twos_comp(i2, 64)

        h_ = hash((i1, i2))
        if h_ == hash_to_fake:
            print(f"wanted_hash = {hex(hash_to_fake)}")
            print(f"found hash with i = {i2}: {hex(h_)}")
            return (i1, i2)
```

```python
def partial_hash(t: tuple, nb_iter: int):
    acc = 2870177450012600261
    for i in range(min(nb_iter, len(t))):
        lane = hash(t[i])
        if lane == -1: return -1
        if lane < 0: lane = twos_comp(lane, 64)

        acc += lane * 14029467366897019727
        acc %= 2 ** 64

        acc = (acc << 31) | (acc >> (64 - 31))
        acc %= 2 ** 64

        acc *= 11400714785074694791
        acc %= 2 ** 64

    return acc

def twos_comp(val, bits):
    """compute the 2's complement of int value val"""
    sign = -1
    if val < 0:
        sign = 1
        val = -val
    val = val ^ ((2 ** bits) - 1)
    val += 1
    return sign * (val % (2 ** bits))
```

![](/Hashish/meme.jpg)