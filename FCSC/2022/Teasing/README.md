# Teasing (1 point + 🔥)
> Pour vous faire patienter jusqu'au 29 avril 2022 à 18h pour le lancement du FCSC 2022, nous vous proposons cette année une épreuve de teasing ! Le point de départ est caché quelque part sur ce site et vous permettra d'aboutir à un flag au format FCSC{xxx}. La résolution de ce challenge apportera 1 point symbolique pour le FCSC 2022, et sera matérialisé sur le site par un 🔥 à côté des noms d'utilisateur. 

> [https://france-cybersecurity-challenge.fr/teasing](https://france-cybersecurity-challenge.fr/teasing)

## Étape 1: Stéganographie

La première étape est une épreuve de stéganographie sur le logo du FCSC. En effet, on découvre assez rapidement un fichier qui s'appelle "stégano.png" dans le code source de la page de teasing.
En l'ouvrant dans GIMP et en modifiant les teintes, on découvre un message caché "Bienvenue à l'épreuve zéro du FCSC 2022 ! :-)" et un texte avec des dinosaures.

![](/FCSC/2022/Teasing/modified.png)

En cherchant un peu sur internet, on trouve une police d'écriture dinosaure : [Din-o-saurs](https://www.fontspace.com/ding-o-saurs-font-f33573)

En s'armant de patience et d'un dictionnaire de dinosaures, on peut retranscrire le texte suivant:
```
WKSMGMGHIMOQOYJOPSIIOKVSPKODLOKOOUSPO
JOZOZCSVVOQXOMGHIUKGHMOKOYVSNLQSZOUUO
SJKOIIO
CUUPI://NKSQZO-ZTWOKIOZHKLUT-MCSVVOQBO.NK/WPWZDKPVNBYDYUBBBPWZ
```

## Étape 2: Crypto

Pas très compréhensible tout ça... 

C'est probablement un chiffrement par subsitution, chaque lettre de l'alphabet a été remplacée par une autre.

Mais on reconnait des schémas ! Par exemple `CUUPI://` est probablement `https://` et `CUUPI://NKSQZO-ZTWOKIOZHKLUT-MCSVVOQBO.NK` est `https://france-cybersecurity-challenge.fr`

On a donc quelques lettres trouvées, et en utilisant [dcode](https://www.dcode.fr/substitution-monoalphabetique) (puis en réglant quelques erreurs qui se sont glissées dans le retranscription), on trouve ce lien: https://france-cybersecurity-challenge.fr/BPBCMRPLFGZMZTGGGPBC

## Étape 3: Reverse

Fichier joint: [fcsc.8xp](/FCSC/2022/Teasing/fcsc.8xp)

On se retrouve avec un programme en 8xp
```sh
$ file fcsc.8xp
fcsc.8xp: TI-83+ Graphing Calculator (assembly program)
```

C'est un programme de TI-83+, plus précisement un programme assembleur. Différent des programmes normaux, les instructions sont des instructions processeur (z80 pour la TI-83+) au lieu de simple instructions de calculatrice.

Le programme est un simple programme, demandant un mot de passe et qui affiche si le mot de passe est bon ou non.

Je préfère l'analyse statique donc j'ai décidé de désassembler le programme à l'aide de [ti83-assembler](https://github.com/mkpellegrino/ti83-assembler)

Je me retrouve alors avec le fichier [fcsc.asm](/FCSC/2022/Teasing/fcsc.asm) et après un peu d'analyse on remarque une suite de labels de ce style.

```
label_13:			;9DEB
	inc ix
	xor @0x09
	cp (ix+@0x00)
	jr nz, %label_15; [relative 3]
	call &verify_step1_lose; [absolute]
```

En remontant les labels, on voit qu'il s'agit de la fonction pour verifier le mot de passe.

```
verify_user_input:			;9F65
	ld c, @0x00
	ld ix, 0xA0A1 ; user_input
	inc ix
	ld b, @0x50
	call &label_77; [absolute]
	ld b, @0x50
	call &label_78; [absolute]
	ret
```

En suivant les label au fur et à mesure, on remarque qu'il y a un `xor` avec `a` et un entier à chaque étape, qui est ensuite comparé avec notre entrée. Si il est identique, l'exécution continue, sinon on fail.
Pour trouver le bon flag, il suffit donc faire les `xor` au fur et à mesure, et de récupérer les entiers demandés. Attention, les entiers ne correspondents pas aux valeurs ASCII des lettres, mais aux [charcodes de la TI](https://en.wikipedia.org/wiki/TI_calculator_character_sets)

Flag: FCSC{4B8CB9E0ADB7F2B3BA4E6CB7156F1243}