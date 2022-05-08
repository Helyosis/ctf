# T-Rex (3 étoiles - 361 points)

> Vous devez déchiffrer le flag :-)

Fichiers joints:
[TREX.py](/FCSC/2022/crypto/T-Rex/TRex.py)
[output.txt](/FCSC/2022/crypto/T-Rex/output.txt)

## Analyse du code

La classe importante est ici:
```python
class TRex:
	def __init__(self, key):
		N = len(key)
		M = 2 ** (8 * N)
		self.key = key
		self.iv = int.from_bytes(key, "big")
		R = lambda x: ((2 * x + 1) * x)
		for _ in range(31337):
			self.iv = R(self.iv) % M
		self.iv = int.to_bytes(self.iv, N, "big")

	def encrypt(self, data):
		E = AES.new(self.key, AES.MODE_CBC, iv = self.iv)
		return self.iv + E.encrypt(pad(data, 16))
```

Il s'agit d'un wrapper AES, rien de très compliqué, mais relativement sécurisé. Sauf que l'IV (qui est donné) dépend de la clé (secrète). On devine donc qu'il faut retrouver la clé à partir de l'IV pour déchiffrer le flag.

Il font donc réussir à inverser la fonction de transformation
## Analyse de la fonction de transformation `key` → `IV`
```python
self.iv = int.from_bytes(key, "big")
R = lambda x: ((2 * x + 1) * x)
for _ in range(31337):
    self.iv = R(self.iv) % M
```

`iv` est donc égal à `key` appliqué à la fonction `R` 31337 fois.
$$R: x \rightarrow (2x + 1) * x$$

On remarque qu'une propriété de $x$ reste constante avec $R(x)$. Si $x$ est pair, alors $R(x)$ est pair. Et inversement.

$$x = 2k \iff R(x) = (2 * 2k + 1) * (2k) = 2 * k(2 * 2k + 1)$$
$$x = 2k + 1 \iff R(x) = (2 * x + 1) * (2k + 1) = 2 * (...) + 2 * 2k + 1 = 2 * (...) + 1$$

On peut ainsi connaître le premier bit de `key` en regardant le premier bit de `iv`.
En utilisant cette info, on peut utiliser un raisonnement analogue pour trouver le deuxième bit, et ainsi de suite.

```python
def transform(key: int) -> int:
    M = 2 ** (8 * 16)
    R = lambda x: ((2 * x + 1) * x)
    for _ in range(31337):
        key = R(key) % M
    return key

known_bit = 0
for i in range(128):
    # On teste x avec du random en MSB, 0 en position i et known_bit en LSB
    x = randint(0, 2 ** 128)
    x = (x >> i) << (i + 1) 
    x += known_bit
    
    # On teste si le i_ème bit de iv est égal à transform(x)
    print(format(transform(x), "0128b"))    
    print(format(iv, "0128b"))
    print("=" * 128)
    if (transform(x) % (2 ** (i + 1))) == (iv % (2 ** (i + 1))):
        # Le i_ème bit est identique, on sait que c'est un 0 (vu qu'on a testé avec un 0)
        known_bit += 0 << i
    else:
        # Le i_ème bit est différent, c'est donc un 1
        known_bit += 1 << i

key = known_bit
```

On peut retrouver l'exploit complet ici: [exploit.py](/FCSC/2022/crypto/T-Rex/exploit.py)