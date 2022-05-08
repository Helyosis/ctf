En recherchant un peu sur Internet, on remarque que gaston.py implémente une version de signature à base de lattices.
J'ai pas trouvé le nom mais son explication est disponible [ici](https://cryptojedi.org/papers/lattisigns-20130328.pdf)

Cependant, l'algorithme diffère un peu car la signature de gaston.py donne trop d'information, en particulier elle donne $y1$, $c$ et $z1 = s1 * c + y1$.
Avec un peu d'arithmétique on peut en déduire $s1 = (z1 - y1) / c$ qui est censé être privé.

En utilisant ensuite la clé publique $a$ et $t = a * s1 + s2$, on peut retrouver $s2 = t - a * s1$.
Ainsi on a la clé privée en entier, et on peut déchiffrer le flag.

PS: Comme tous les élements ci-dessus sont des polynômes dans un anneau particulier (un anneau quotient sur des polynômes d'après Wikipédia), il faut faire bien attention dans les opérations.
On était ici dans l'anneau $Z_Q[x]/(x^n + 1)$ qui s'écrit ainsi dans SageMath:
```python
E = PolynomialRing(GF(Q), names = 'x'); x = E.gen()
R = QuotientRing(E, x ** N + 1)
```