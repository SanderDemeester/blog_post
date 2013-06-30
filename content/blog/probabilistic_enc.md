---
title: "Probabilistic Encryption"
created_at 2013-06-30 13:33:21 +0000
auteur: "Sander Demeester"
img: "/img/1.jpg"
---

Het idee van "probabilistic encryption" is uitgevonden door ["Shafi Goldwasser en Silvio Micali"](http://people.csail.mit.edu/joanne/shafi-pubs.html) en is in theorie het veiligste cryptosysteem uitvonden. De eerste implementaties waren helaas niet praktisch. Dit is "recent" geëvolueerd naar meer praktische implementaties.

Het idee achter probabilistic encryption is om eventuele lekken van informatie te elimineren die voorkomen bij public-key cryptografie. Het is altijd mogelijk om random geencrypteerd bericht te decrypteren met de public-key.

Stel dat Carol een bericht <notextile>$$C = E_{K}(M)$$</notextile> heeft en probeerd het plaintext bericht <notextile>$$M$$</notextile> te achterhalen. Ze kan een random bericht <notextile>$$M'$$</notextile> maken en het encrypteren <notextile>$$C' = E_{K}(M')$$</notextile>, als <notextile>$$C = C'$$</notextile> dan kent Carol origineel bericht <notextile>$$M$$</notextile> door te gokken. Als het fout is kan ze gewoon verder proberen.

