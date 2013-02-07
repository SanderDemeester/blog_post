---
title: "Chosen Ciphertext Attack against RSA"
created_at: 2012-07-27 20:49:00 +0000
auteur: "Sander Demeester"
kind: article
img: "/img/1.jpg"
---
We onderscheiden 2 soorten problemen als we het hebben over het "aanvallen" van cryptografische protocollen. 
Soort 1, aanvallen tegen de implementatie van het protocol. 
Soort 2, aanvallen tegen het protocol zelf. 
<! -- more -->
De volgende 3 senario's die ik beschrijf zijn bekende aanvallen tegen het RSA protocol.

Zeer korte beschrijving van het RSA protocol.
RSA krijgt zijn beveiliging door de moeilijkheid van het factoriseren van grote getallen. De public en private key zijn functies van een paar (200 of meer digits) priem getallen. Het bekomen van de plaintext van de public key en de ciphertext is equivalent met het factoriseren van het product bestaand uit 2 priem getallen.

Om de twee keys te maken kiezen we 2 random priem getallen van gelijk lengte, we noemen deze \\((p,q)\\). We bepalen het product.
<notextile>
$$n = pq$$
</notextile>
We kiezen random een encryptie key \\(e\\), zodanig dat \\(e\\) en \\((p-1)(q-1)\\) relatief priem zijn. 
Daarna gebruiken we het [extended euclidean algoritm](http://en.wikipedia.org/wiki/Extended_Euclidean_algorithm) om een decryptie key \\(d\\) te vinden zodanig dat

<notextile>
$$ed \equiv 1 \text{ mod } (p-1)(q-1)$$
Of
$$d = e^{-1} \text{ mod } ((p-1)(q-1))$$
</notextile>

We merken op dat \\(d\\) en \\(n\\) relatief priem zijn.  De getallen \\(e\\) en \\(n\\) zijn de public key, \\(d\\) is de private key. \\(p,q\\) zijn verder niet meer nodig, maar moeten wel geheim blijven.
Om een bericht \\(m\\) te encrypteren delen we het eerst op in blokken smaller dan \\(n\\), het resultaat, \\(e\\) zal zijn bestaan uit gelijkaardige blokken die we \\(c_{i}\\) zullen noemen.
De encryptie formule is de volgende:
<notextile>
$$c_{i} = m_{i}^{e} \text{ mod n }$$
</notextile>
Decrypteren is dan logischerwijze:
<notextile>
$$m_{i} = c_{i}^{d} \text{mod n}$$
</notextile>

Omdat

<notextile>
$$c_{i}^{d}=(m_{i}^{e})^{d} = m_{i}^{ed}=m_{i}^{k(p-1)(q-1)+1} = m_{i}m_{i}^{k(p-1)(q-1)} = m_{i}*1=m_{i} \text{ alles mod n.}$$
</notextile>
[maple voorbeeld](/mw/RSA-example.mw)

Samenvatting van het protocol:<br>
Public Key:<br>
  - n: product van 2 priem getallen, \\(p,q\\) (beide getallen moeten geheim blijven)<br>
  - e: relatief priem met \\((p-1)(q-1)\\) <br>
Private Key: <br>
  - d: \\(e^{-1} \\text{mod } ((p-1)(q-1))\\) <br>
Encrypteren: <br>
  - c: \\(c=m^{e} \\text{ mod n }\\) <br>
Decrypteren: <br>
  - m: \\(m = c^{d} \\text{ mod n }\\) <br>
Nu de werking van het protocol is begrepen ga ik 3 bekende scenario's tekenen waar deze manier van werken zijn doel mist. 

**Scenario 1**: 
Eve, luistert in op de communicatie van Alice en slaagt erin om een ciphertext bericht \\(c\\) te onderscheppen, \\(c\\) is geëncrypteerd met Alice haar public key. Eve wilt het bericht kunnen lezen. 
Wiskundig uitgedrukt wilt Eve het volgende doen,
<notextile>
$$m = c^{d}$$
</notextile>
Om \\(m\\) te herstellen kiest Eve eerst een random getal \\(r\\), zodanig dat \\(r\\) kleiner is dan \\(n\\) alsook Alice haar public key \\(e\\), die gepubliceerd is.
Alice voert de volgende berekeningen uit:
<notextile>
$$x = r^{e} \text{ mod n}$$
$$y = xc \text{ mod n}$$
$$t = r^{-1} \text{mod n}$$
</notextile>

Let op dat als \\(x = r^{e} \text{ mod n}\\), dan \\(r = x^{d} \text{ mod n}\\)
Nu moet Eve Alice overtuigen om y te signeren met haar private key, m.a.w \\(y\\) te decrypteren (Let op, Alice decrypteert het bericht, niet een hash van het bericht). Alice heeft \\(y\\) nog nooit gezien, dus ze signed \\(y\\)
<notextile>
$$u = y^{d} \text{mod n}$$
</notextile>

Alice stuurt het resultaat terug door naar Eve die 
<notextile>
$$tu \text{ mod n}  = r^{-1}y^{d} \text{ mod n} = r^{-1}x^{d}c^{d} \text{ mod n} = c^{d} \text{ mod n} = m$$
</notextile>
berekent, eve beschikt nu over m.

**Senario 2**:
Trent is een publieke computer notaris. Als Alice een document laat notaliseren, stuurt ze het document naar Trent. Trent signeert het document een RSA digital signature en stuurt het 
document terug naar Alice (opnieuw wordt hier geen one-way hash function gebruikt, Trent encrypteert het volledige document met zijn private key).

Mallory wilt dat Trent een bericht signeert dat hij normaal zou weigeren om te signeren. Wat de reden ook is, hij zou het nooit doen uit vrije wil. We noemen dit bericht \\(m'\\).
Eerst, Mallory kiest een arbitrere waarde \\(x\\) en berekent 

\\(y = x^{e} \text{ mod n}\\), waar \\(e\\) Trent zijn public key is, deze moet publiek zijn anders zouden andere entiteiten zijn signature niet kunnen controleren.

Daarna berekent Mallory,

$$m = ym' \text{ mod n}$$

Mallory stuurt dit resultaat naar Trent, die het resultaat \\(m'^{d} mod \text{ } n\\) terug geeft. Wat nu moet gebeuren is

\\((m^{d} \text{ mod n})x^{-1} \text{ mod n}\\), wat gelijk is aan \\(n'^{d}\\) en dus de signature is van \\(m'\\)

Er zijn verschillende werkwijze's mogelijk om het zelfde resultaat te bekomen en worden besproken in volgende papers: 
[G.I. Davida, "Chosen Signture Cryptanalysis of the RSA (MIT) Public Key Cryptosystem"](http://www.dtc.umn.edu/~odlyzko/doc/arch/rsa.attack.pdf)

[D.E. Denning, "Digital Signaatures with RSA and Other Pubilc-Key Cryptosystems"](faculty.nps.edu/dedennin/publications/digitalsigsrsa.pdf)

[Y. Desmedt and A.M. Odlykzo, "A Chosen Text Attack on the RSA Cryptosystem and Some Discrete Logarithm Problems"](http://wenku.baidu.com/view/78bfd93767ec102de2bd89e3.html)

De manier van werken die wordt gebruikt is het zelfde voor alle exploits, en is dat de machtsverheffing de multipliciteits structuur behoudt van zijn input:

<notextile>
$$(xm)^{d} \text{ mod n} = x^{d}m^{d} \text{ mod n}$$
</notextile>

**Senario 3**:
Eve wilt dat Alice \\(m\_{3}\\) signed. Ze genereert twee berichten, \\(m\_{1},m_{2}\\) zodanig dat

<notextile>
$$m_{3} \equiv m_{1}m_{2} (\text{ mod n})$$
</notextile>

Als Eve instaat is om Alice \\(m\_{1}\\) en \\(m\_{2}\\) te laten signeren kan ze volgende berekening toepassen om \\(m\_{3}\\) te bekomen.
<notextile>
$$m_{3}^{d} = (m_{1}^{d})(m_{2}^{d} \text{ mod n})$$
</notextile>
Conclusie: 
Gebruik RSA nooit om een random document te signen.
Maak altijd eerst een message digest van het document met een one-way hashing functie. <a href="http://www.iso.org/iso/iso\_catalogue/catalogue\_tc/catalogue\_detail.htm?csnumber=35455">ISO 9796</a> block formaat voorkomt dit soort aanvallen.