---
title: "Probabilistic Encryption"
created_at: 2013-06-30 13:33:21 +0000
auteur: "Sander Demeester"
kind: article
img: "/img/3.jpg"
---

Het idee van "probabilistic encryption" is uitgevonden door ["Shafi Goldwasser en Silvio Micali"](http://people.csail.mit.edu/joanne/shafi-pubs.html) en is in theorie het veiligste cryptosysteem uitgevonden. De eerste implementaties waren helaas niet praktisch. Dit is recent geëvolueerd naar meer praktische implementaties.

Het idee achter probabilistic encryption is om eventuele informatie lekken te elimineren die voorkomen bij public-key cryptografie. Het is altijd mogelijk om een random bericht te encrypteren met de public-key.

Stel dat Carol een bericht <notextile>$$C = E_{K}(M)$$</notextile> heeft en probeerd het plaintext bericht \\(M\\) te achterhalen. Ze kan een random bericht \\(M\'\\) maken en het encrypteren <notextile>$$C' = E_{K}(M')$$</notextile> als \\(C = C\'\\) dan kent Carol origineel bericht \\(M\\) door te gokken. Als het fout is kan ze gewoon verder proberen.

Er bestaan verschillende soorten aanvallen op RSA, soms kan het mogelijk zijn door een XOR te doen van bepaalde bits in het bericht om een zeker patroon te vinden. Met probabilistic encryption is dit niet het geval. Een iet-wat filosofisch idee is dat elke keer Carol een random bericht encrypteerd met een public-key is er wat informatie dat word gelekt, niemand weet hoeveel, maar informatie gaat verloren. 

Probabilistic encryption probeerdt dit verlies van informatie te elimineren. Ons doel hier is om te voorkomen dat elke soort berekening op de ciphertext niet resulteert in verlies van informatie. Het mag niet meer mogelijk zijn om random berichten te maken en deze te encrypteren met de public-key om te proberen de originele plaintext te achterhalen.

Bij probabilistic encryption zal het encryptie algoritme probabilistische zijn ipv deterministisch. Dus een grote verzameling van ciphertexts zal decrypteren tot een gegeven plaintext en de originele ciphertext zal random worden gekozen.

<notextile>$$
C_{1} = E_{K}(M), C_{2} = E_{K}(M),\cdots, C_{i} = E_{K}(M)
$$</notextile>
<notextile>$$
M = D_{K}(C_{1}) = D_{K}(C_{2}) = D_{K}(C_{3}) = \cdots = D_{K}(C_{i})
$$</notextile>

Deze eigenschap maakt het onmogelijk om random berichten \\(M\'\\) te maken en te encrypteren om te zien of er een gelijkenis is.
Stel dat Carol beschikt over ciphertext \\(C\_{i} = E\_{K}(M) \\). Als Carol \\(M\\) correct heeft geraden en de ciphertext \\(E\_{K}(M)\\) heeft berekend dan nog zal  het resultaattoch volledig verschillend zijn. Ze zal niet instaat zijn om \\(C\_{i},C\_{j}\\) te vergelijken en een gelijkenis te observeren.

Als Carol beschikt over de correcte plaintext, de ciphertext en de public key kan ze nog niet bewijzen ciphertext het resultaat is van het encryptie proces met de publieke sleutel van de correcte plaintext, zelfs niet met een "exhaustive search". Ze kan enkel beweren dat elke mogelijke plaintext de ciphertext kan zijn.

Het is duidelijk dat als we bovenstaande werkwijze toepassen de ciphertext altijd groter zal zijn dan de corresponderende plaintext. De eerste implementatie had het probleem dat de ciphertext zo groot was dat ze onbruikbaar was. Er bestaat nu een efficiente implementatie van probabilistic encryption gebruik makend van de [Blub Blub Shub (BBS) random-bit generator](https://dl.acm.org/citation.cfm?id=19501). De BBS generator maakt gebruik van kwadratische residuen.

Er zijn 2 priemgetallen \\(p,q\\) die conguruent 3 modulo 4 zijn. Dit is de private-key. De public-key is hun produdct \\(n = pq\\) (Het is belangrijk om \\(p,q\\) goed te kiezen. De sterkte van dit algoritme berust op de moelijkheid om \\(n\\) te factoriseren).

Om een bericht \\(M\\) te encrypteren kiezen we eerst een random \\(x\\) zodat \\(x \perp n\\).
dan
<notextile>
$$
x_{0} = x^{2} \text{ mod n }
$$
</notextile>

Gebruik \\(x\_{0}\\) als de seed voor de BBS pseudo-random bit generator en gebruik de output van de generator als "stream cipher".
XOR \\(M\\) , bit per bit met de output van de generator. De generator heeft als output \\(b\_{i}\\) bits (de minst significante bit van \\(x\_{i}\\), waar \\(x\_{i} = x\_{i-1}^2 \text{ mod n}\\)), dus:
<notextile>
$$
M = M_{1}, M_{2}, M_{3},\cdots,M_{t}
$$
$$
C = M_{1} \oplus b_{1}, M_{2} \oplus b_{2}, M_{3} \oplus b_{3},\cdots,M_{t} \oplus b_{t}
$$
</notextile>
waar \\(t\\) de lengte is van het plaintext bericht \\(M\\).
Voeg de laatst berekende waarde van \\(x\_{t}\\) toe aan het einde van het bericht.
De mogelijkheid om dit bericht terug de decrypteren is om \\(x\_{0}\\) terug te vinden en de zelfde BBS generator sequentie te gebruiken om te XOR-en met de ciphertext. Omdat de BBS generator veilig is naar richting links, de waarde \\(x\_{t}\\) is van geen nut voor Carol. Enkel de persoon met kennis van \\(p,q\\) kan het bericht decrypteren.

<pre>
<code>
	int xt_to_x0(int p, int q, int n, int t, int xt){
	    int a,b,u,w,z;
	    // gcd(p,q) = 1
	    ext_euclid(p,q,&a,&b);
	    u = modexp((p+1)/4, t, p-1);
	    v = modexp((q+1)/4, t, q-1);
	    w = modexp(xt % p, u, p);
	    z = modexp(xt % q, v, q);
	    return (b*q*w + a*p*z) % n;
	    }	   
</code>
</pre>

Zodra je kennis hebt van \\(x\_{0}\\) is het decryptie proces vrij eenvoudig. Configureer de BBS generator met de juiste seed en XOR de output met de ciphertext.

Je kan dit algoritme sneller maken door alle gekende veilige bits van BBS te gebruiken. Met deze verbetering is de Blum-Goldwasser probabilistic encryption sneller dan RSA terwijl er geen informatie verlies is. De moelijkheid om dit schema te breken is equivalent met het factoriseren van \\(n\\)).

Aan de andere kant is het belangrijk om te zien dat dit schema volledig breekt bij een chosen-ciphertext aanval. Van de minst significante bits van het rechterer kwadratische residu is het mogelijk om de vierkantswortel te berekenen van elke kwadratische residu. Als je dit kan doen kan je de rest ook factoriseren.