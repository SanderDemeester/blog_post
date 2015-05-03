---
title: "Groups and Subgroups while using DH"
created_at: 2013-09-01 09:35:01 +0000
auteur: "Sander Demeester"
kind: article
img: "/img/4.jpg"
---
### Groepen en Subgroepen###

Voor de rest van deze tekst, beschouw \\(p\\) als een groot priem-getal (orde 2000-4000 bits). De meeste van onze berekeningnen zullen module \\(p\\) zijn. 
Het DH (Diffie Hellman) protocol gebruikt \\(Z^{*}_{p} \\), multiplicative group modulo p.

Kies een \\(g\\) in die groep en beschouw de getallen:
<notextile>
$$
	1,g,g^{2},g^{3},\cdots,
$$
</notextile>

Allemaal module \\(p\\). Dit is een oneindige reeks in \\(Z^{\*}\_{p} \\) (Herinner dat \\(Z^{\*}_{p} \\) de getallen \\(1,2,\cdots,p-1\\) bevat met de multiplicatie operatie modulo 
\\(p\\) ).

Er komt een moment waar getallen zich moeten beginnen herhalen.<br>
We maken de veronderstelling dat dit gebeurd bij \\(g^{i} = g^{j}\\) waar \\(i < j\\). 

We kunnen een deling module \\(p\\) uitvoeren op beide getallen, we delen elke kant door \\(g^{i}\\) en krijgen \\(1 = g^{j-i}\\). 
Anders gezegd bestaat er een getal \\(q = j-i\\) zodat \\(g^q = 1 \text{ mod } p\\) We noemen de kleinste waarde voor \\(q\\) de orde van \\(g\\).

Als we \\(g\\) nu blijven vermenigvuldigingen bekomen we de reeks
<notextile>
$$
1,g,g^{2},\cdots,g^{q-1}
$$
</notextile>
Daarna komen we terug uit bij \\(g^{q} = 1\\) en herhaalt de reeks zich terug. We zeggen dat \\(g\\) een generator is voor de verzameling \\(1,g,g^{2},\cdots,g^{q-1}\\). Het aantal elementen dat we kunnen schrijven als een macht van \\(g\\) is \\(q\\), de orde van \\(g\\).

Een eigenschap van multiplicatieve modulo \\(p\\) is dat er minstens één waarde voor \\(g\\) bestaat die de volledige groep genereert, we bedoelen dus dat er een waarde voor \\(g\\) bestaat zodat \\(q = p -1 \\). Dus inplaats van de getallen in \\( Z^{\*}\_{p} \\) te zien als \\(1,\cdots,p-1\\) kunnen we ze ook bekijken als 
<notextile>
$$
	1,g,g^{2},\cdots,g^{p-2}
$$
</notextile>

Een \\(g\\) die de volledige groep genereert noemen we een premetief element van de groep. Andere waardes voor \\(g\\) kunnen kleinere verzamelingen voortbrengen.<br>
We observeren dat als we twee getallen nemen uit de verzameling die is voortgebracht uit \\(g\\) we terug een macht van \\(g\\) tegenkomen, dus ook een element uit die verzameling. Alle elementen uit deze verzameling vormen terug een groep. Deze kleinere groepen noemen we subgroepen.

Voor elk element \\(g\\) geld dat de orde van \\(g\\) een deler is van \\(p-1\\), dit is eenvoudig aan te tonen. Kies \\(g\\) een primitief element. Laat \\(h\\) elk ander element zijn. Omdat \\(g\\) de volledige groep genereert zal er een \\(x\\) zijn zodat \\(h = g^{x}\\). Beschouw nu de elementen voortgebracht door \\(h\\). Dit zijn:
<notextile>
$$
1,h,h^{2},h^{3},\cdots
$$
</notextile>
Dit is het zelfde als:
<notextile>
$$
1,g^{x},g^{2x},g^{3x},\cdots, 
$$
</notextile>
(al deze berekeningen zijn steeds module \\(p\\). )
De order van \\(h\\) is de kleinste \\(q\\) zodat \\(h^{q} = 1\\).<br>
Dit is het zelfde als zeggen dat het een \\(q\\) is zodat \\(g^{xq} = 1\\) voor elke \\(t\\), \\(g^{t} = 1\\). <br>
Dit is hetzelfde als zeggen dat \\(t = 0 (\text{mod }p-1)\\). Dus \\(q\\) is de kleinste \\(q\\) zodat \\(xq = 0 (\text{ mod }p-1)\\). <br>
Dit gebeurd wanneer
<notextile>
$$
q = \frac{p-1}{gcd(x,p-1)}
$$
</notextile>
Dus \\(q\\) is duidelijk een factor van \\(p-1\\).

Een simpel voorbeeld:
We kiezen \\(p = 7\\), en kiezen \\(g = 3\\). Dus \\(g\\) is een primitief element omdat:
<notextile>
$$
1,g,g^{2},g^{3},\cdots,g^{5} = 1,3,2,6,4,5
$$
</notextile>
(Alle bewerkingen zijn module 7).
We kiezen \\(h = 2\\), \\(h\\) brengt de volgende subgroep voor:
<notextile>
$$
1,h,h^{2} = 1,2,4.
$$
</notextile>
Omdat \\(h^{3} = 2^{3} (\text{mod } 7) = 1\\). Het element \\(h = 6\\) genereert de subgroep \\(1,6\\). Deze subgroepen hebben lengte 2 en 3, beide zijn delers van \\(p-1\\). 
We kunnen dit aan aantonen door Fermats test. Gebasseerd of het feit dat voor elke \\(a\\) geld dat \\(a^{p-1} = 1\\). Dit is eenvoudig aan te tonen. Laat \\(g\\) een generator zijn van \\(Z^{\*}\_{p}\\) en kies \\(x\\) zodat \\(g^{x} = a\\). \\(g\\) is een generator van de volledige groep, er bestaat dus altijd zoon \\(x\\). Maar nu geld dat
<notextile>
$$
a^{p-1} = g^{x(p-1)} = (g^{p-1})^{x} = 1^{x} = 1
$$
</notextile>

### Diffie-Hellman Basis###
Om het origineel DH protocol hebben we een groot priem getal nodig \\(p\\), en een primitief element \\(g\\) die de volledige groep \\(Z^{\*}\_{p}\\) genereerd.
(\\(p,g\\)) zijn publieke constanten. We maken de veronderstelling dat alle entiteiten (inclusief onze aanvaller) kennis hebben van deze waarden.<br>
Het protocol verloopt op de volgende manier:
- Alice kiest een random \\(x \in Z^{\*}\_{p} \\).<br>
  Ze berekent \\(g^{x} \text{ mod } p\\) en verstuurd dit naar Bob.<br>
- Bob kiest een random \\(y \in Z^{\*}\_{p} \\).<br>
  En hij berekent \\(g^{y} \text{ mod } p\\) en stuurd dit naar Alice.<br>
- Het finale resultaat voor beide is \\(k = g^{yx}\\).<br>
<br>
Alice kan dit berekenen door matchsverheffing te doen van \\(g^{x}\\) met de waarde die ze van Bob heeft gekregen.
<notextile>
$$
(g^{y})^{x} = g^{xy}
$$
</notextile>
Bob kan op gelijkaardige manier dezelfde berekening uitvoeren. Maar wat kan de aanvaller doen?
De aanvaller ziet de waarde (\\(g^{x} \text{ mod } p,g^{y} \text{ mod } p\\)), maar niet de waarden (\\(x,y\\)). <br>
Het probleem om \\(g^{xy}\\) te bepalen met kennis van \\(g^{x} \text{ mod }p,g^{y} \text{mod p }\\) noemen we het Diffie-Hellman probleem. <br>
Zolang (\\(g,p\\)) correct zijn gekozen bestaat er geen efficient algoritme om dit te berekenen.