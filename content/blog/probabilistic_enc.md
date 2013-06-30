---
title: "Probabilistic Encryption"
created_at 2013-06-30 13:33:21 +0000
auteur: "Sander Demeester"
img: "/img/1.jpg"
---

Het idee van "probabilistic encryption" is uitgevonden door ["Shafi Goldwasser en Silvio Micali"](http://people.csail.mit.edu/joanne/shafi-pubs.html) en is in theorie het veiligste cryptosysteem uitvonden. De eerste implementaties waren helaas niet praktisch. Dit is "recent" geëvolueerd naar meer praktische implementaties.

Het idee achter probabilistic encryption is om eventuele lekken van informatie te elimineren die voorkomen bij public-key cryptografie. Het is altijd mogelijk om random geencrypteerd bericht te decrypteren met de public-key.

Stel dat Carol een bericht <notextile>$$C = E_{K}(M)$$</notextile> heeft en probeerd het plaintext bericht <notextile>$$M$$</notextile> te achterhalen. Ze kan een random bericht <notextile>$$M'$$</notextile> maken en het encrypteren <notextile>$$C' = E_{K}(M')$$</notextile>, als <notextile>$$C = C'$$</notextile> dan kent Carol origineel bericht <notextile>$$M$$</notextile> door te gokken. Als het fout is kan ze gewoon verder proberen.

Er bestaan verschillende soorten aanvallen op RSA, soms kan het mogelijk zijn door de XOR te te doen van bepaalde bits dat er een zeker patroon is te vinden. Met probabilistic encryption is dit niet het geval. Een iet-wat filosofisch idee is dat elke keer Carol een random bericht encrypteerd met een public-key zal er wat informatie worden gelekt, niemand weet hoeveel, maar informatie gaat verloren.

Probabilistic encryption probeerdt dit verlies van informatie te elimineren. Ons doel hier is om te voorkomen dat elke soort berekening op de ciphertext, of proberen te achterhalen van de plaintext door random berichten te encrypteren informatie heeft aan Carol over de originele plaintext. Bij  probabilistic encryption, het encryptie algoritme zal probabilistische zijn ipv deterministisch. Dus een grote verzameling van ciphertexts zal decrypteren tot een gegeven plaintext, en de originele ciphertext zal random worden gekozen.

<notextfile>$$
C_{1} = E_{K}(M), C_{2} = E_{K}(M),\cdots, C_{i} = E_{K}(M)
$$<notextile>
<notextile>$$
M = D_{K}(C_{1}) = D_{K}(C_{2}) = D_{K}(C_{3}) = \cdots = D_{K}(C_{i})
$$<notextile>





