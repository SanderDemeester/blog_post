---
title: "Advanced Encryption Standard (AES)"
created_at: 2012-01-07 19:59:01 +0000
auteur: "Sander Demeester"
kind: article
img: "/img/aes.gif"
---
Encryption with AES encryption algoritm.
AES werkt met blokken van 16-byte groot, zonder rekening te houden met de key-lengte. AES maakt gebruik van permutaties en een subsitutie-network als interne structuur. Het aantal iteraties dat gebruikt wordt bij het de "key scheduling" hangt af van de key lengte.
<!-- more -->
Als de key een lengte heeft van 128-bit (16 bytes), dan is het aantal iteraties 10. Als de key een lengte heeft van 192 bits (24 byte), dan hebben we 12 iteraties. Als de key een lengte heerft van 256 bits, dan maken we gebruik van 14 iteraties. In het algemeen is het aantal iteraties gelijk aan (key-size in 4-byte woorden)+6. Elke iteratie heeft 16 bytes nodig voor "keying material"
    128 bit key: 160 bytes + extra key permutation 176 bytes
    192 bit key: 192 bytes + extra key permutation 208 bytes
    256 bit key: 224 bytes + extra key permutation 240 bytes

Dus voor een 16 byte input, moet het AES key scheduling algoritme een 176 bytes output genereren. De eerste 16 bytes zijn de input zelf. De andere 160 bytes worden berekend in 4 byte blokken per iteratie. Voor alle blokken van 4 byte geldt dat ze een permutatie zijn het vorige 4 byte woord.

Als voorbeeld kunnen we dus zeggen dat key scheduling bytes 17-20 een permutatie zijn van 13-16. Ofwel bytes 17-20 = bytes 1-4 xor bytes 13-16.

Om de 4 iteraties (bij een 128 bit key) wordt een transformatie toegepast, de vorige 4 bytes worden "ge-xorded". Deze transformatie bestaat uit:

        het roteren van een 4 byte woord.
        de AES sbox gebruiken (subsitutie)
        XOR met een ronde constante

De rotatie:
De 1ste byte wordt overschreven door de 2de byte. De tweede met de derde, de derde met de vierde. En de vierde met de eerste.

De subsitutie:
De subsitutie is het opzoeken van elke byte in de encryptie sbox, en het vervangen met de gevonden byte. De translatie tabel is een 16 bij 16 array. De rij wordt aangeduid met de 4 meest significante bits, de kolom wordt aangeduid met de 4 minst significante bits.
Als voorbeeld, de byte 0x1A is rij 1 met kolom 10. Volgens de specificatie van AES heeft ons dit de "affine transformation over 

<notextile>
$$GF(2^{8})\text{ van } b_{i} + b_{(i+4)\text{%}8} + b_{(i+5)\text{%}8} + b_{(i+6)\text{%}8} + b_{(i+7)\text{%}8} + c_{i}$$
</notextile>

De XOR:
Op het einde wordt de geroteerde, gesubstitueerde waarde gexorderd met onze ronde constante. De 3 minst significante byte van de ronde constante zijn altijd 0. De meest significante byte start altijd met 0x01, deze byte wordt om de 4 iteraties 1 bit naar links geshift. In volgorde wort dit dus: 0x02 in de 8ste iteratie. 0x04 bij de twaalfde iteratie etc.

Het is belangrijk op te merken dat voor een 128-bit key de ronde constante 10 keer moet worden naar links geshift, omdat een 128 bit key 44 iteratie's nodig heeft, maar als je een byte 8 keert shift naar links eindig je met een 0x00 byte. De specificatie eist dat, waneer er overflow optreedt bij een left shift, dat je een XOR moet uitvoeren met de byte 0x1B. Voor de "waarom" verwijst ik naar de specificatie pagina 15.

Voor de 192-bit key scheduler is het zelfde, het verschil is dat de rotatie, subsitutie en ronde constante XOR worden toegepast bij elke 6de iteratie van het "key scheduling algoritme". Voor een 256-bit key is dit elke 8ste iteratie, omdat elke 8ste iteratie "redelijk ver" uit elkaar ligt. Wordt bij elke 4de iteratie de subsitutie gedaan, en bij elke achtste iteratie de rotatie en XOR operatie.

Het is belangrijk om op te merken dat het resultaat van het "key scheduling" algoritme "non-linear" is, maar wel herhaalbaar.    

AES Encryptie:

AES werkt met blokken van 16-byte voor zijn input, onafhankelijk van de key lengte. We zien de input als een 4 bij 4 matrix, dit is natuurlijk de volledig set van hexadecimale tekens. We zullen dit de "AES state mapping initialization" noemen. We zullen tijdens het encryptie-proces permutaties, subsituties  en keying materiaal combineren met deze state om de output te produceren.

We hebben dus de "Input Block ("State")", we doen een xor met de 1ste 16 bytes van de key en krijgen als output "Ronde 1 Input", eee AES key combination.
Dit wordt gedaan voor elke ronde, en bestaat uit 4 stappen:
- Een subsitutie stap.
- Een row-shifting -stap.
- Een column-mixing step.
- Een key-combination stap.

De subsitutie stap voeren we uit op elke byte individueel van de input, en komt van de zelfde matrix die we gebruiken bij het "key scheduling algoritme", nl onze sbox

De rotatie stap voeren we uit op elke rij. De eerste rij roteren we 0 plaatsen. De tweede rij 1 plaats, de derde 2 plaatsen etc.
De "column mixing"-stap. Deze stap is gedefinieerd als een matrixvermenigvuldiging met de matrix: 
<notextile>
$$ \begin{bmatrix}  
02 & 03 & 01 & 01 \\
01 & 02 & 03 & 01 \\
01 & 01 & 02 & 03 \\
03 & 01 & 01 & 02 \\
\end{bmatrix} $$  
</notextile>
AES herdefiniëert de matrix optelling en matrixvermenigvuldiging operaties voor zijn eigen versies van deze bewerkingen.
De matrix optelling operatie in AES is gedefinieerd als een XOR operatie. matrixvermenigvuldiging is meervoudig optellen maar modulo 0x1B bij overflow.

De specificatie noemt deze operaties het inproduct. Wat opnieuw is herdefinitie. Dus, het vermenigvuldigen van 2 bytes is het bepalen van hun inproduct, in AES is dit dus een XOR operatie op 2 bytes die $n$ keer wordt uitgevoerd. N is hier de waarde van is het aantal linker shift operatie en XOR met 0x1B bij overflow neemt.

"Column mixing" stap, het toepassen van AES "inproduct".

AES Decryption:

Alle wat we hebben gedaan tijdens de encryptie fase moeten we nu terug ontdoen. We starten met de ronden van de keys in omgekeerde volgorde, daarna "unmixen" van de kolommen en un-siften van de rijen. Dit wil dus zeggen dat het decryptie proces niet bestaat uit de zelfde volgorde van operaties als bij het encryptie proces.

Wat opvalt is dat we voor het decryptie proces niet opniew kunnen gebruik maken van dezelfde AES sboxen omdat de subsitutie in omgekeerde volgorde moet verlopen. We hebben dus  1 sbox om te encrypteren en 1 om de decrypteren.

Het inverteren houdt in dat we de omgekeerde matrix multiplicatie moeten doen van elke kolom in onze matrix. Dit is niet enkel een multiplicatie maar een multiplicatie en een inversie die we beschouwen als een polynoom over \\(GF(2^{8})\\) en vermenigvuldigd modulo \\(x^{4}+1\\) met een vaste polynoom \\(a^{-1}\\)
 gegeven door 
<notextile>
$$ a^{-1}(x) = \{0b\}x^\{3\} + \{0d\}x^\{2\} + \{09\}x + \{0e\} $$ 
</notextile>
Dit is gelijk met een matrixvermenigvuldiging met de matrix: 

<notextile>
$$ \begin{bmatrix}
0e & 0b & 0d & 09 \\
09 & 0e & 0b & 0d \\
0d & 09 & 0e & 0b \\
0b & 0d & 09 & 0e 
\end{bmatrix} $$  
</notextile>
Dit is natuurlijk met de hergedefiniëert operaties beschreven hierboven.

link naar specificatie: <a href="csrc.nist.gov/publications/fips/fips197/fips-197.pdf">csrc.nist.gov/publications/fips/fips197/fips-197.pdf</a>
