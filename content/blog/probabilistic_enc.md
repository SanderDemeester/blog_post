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

Deze eigenschap maakt het onmogelijk om random berichten <notextile>$M'$</notextile> te maken en te encrypteren om te zien of er een gelijkenis is.
Stel dat Carol beschikt over ciphertext <notextile>$C_{i} = E_{K}(M)$</notextile>. Als Carol <notextile>$M$</notextile> correct kan raden en de ciphertext <notextile>$E_{K}(M)$</notextile> zal het resultaat toch volledig verschillend zijn. Ze zal niet instaat zijn om <notextile>$C_{i},C_{j}$</notextile> te vergelijken en een gelijkenis te observeren.

Als Carol beschikt over de correcte plaintext, de ciphertext en de public key kan ze nog niet bewijzen ciphertext het resultaat is van het encryptie proces met de publieke sleutel van de correcte plaintext, zelfs niet met een "exhaustive search". Ze kan enkel beweren dat elke mogelijke plaintext de ciphertext kan zijn.

Het is duidelijk dat als we bovenstaande werkwijze toepassen de ciphertext altijd groter zal zijn dan de corresponderende plaintext. De eerste implementatie had het probleem dat de ciphertext zo groot was dat ze onbruikbaar was. Er bestaat nu een efficiente implementatie van probabilistic encryption gebruik makend van de [Blub Blub Shub (BBS) random-bit generator](https://dl.acm.org/citation.cfm?id=19501). De BBS generator maakt gebruik van kwadratische residuen.

Er zijn 2 priemgetallen <notextile>$p,q$</notextile> die conguruent 3 modulo 4 zijn. Dit is de private-key. De public-key is hun produdct <notextile>$n = pq$</notextile> (Het is belangrijk om <notextile>$p,q$</notextile> goed te kiezen. De sterkte van dit algoritme berust op de moelijkheid om <notextile>$n$</notextile> te factoriseren).

Om een bericht <notextile>$M$</notextile> te encrypteren kiezen we eerst een random <notextile>$x$</notextile> zodat <notextile>$x \perp n$</notextile>.
dan
<notextile>
$$
x_{0} = x^{2} \text{ mod n }
$$
</notextile>

Gebruik <notextile>$x_{0}$</notextile> als de seed voor de BBS pseudo-random bit generator en gebruik de output van de generator als "stream cipher".
XOR <notextile>$M$</notextile>, bit per bit met de output van de generator. De generator heeft als output <notextile>$b_{i}$</notextile> bits. De minst significante bit van <notextile>$x_{i}$</notextile>, waar <notextile>$x_{i} = x_{i-1}^{2} \text{ mod n }, dus:
<notextile>
$$
M = M_{1}, M_{2}, M_{3},\cdots,M_{t}
$$
$$
C = M_{1} \oplus b_{1}, M_{2} \oplus b_{2}, M_{3} \oplus b_{3},\cdots,M_{t} \oplus b_{t}
$$
</notextile>
waar <notextile>$t$</notextile> de lengte is van het plaintext bericht <notextile>$M$</notextile>





