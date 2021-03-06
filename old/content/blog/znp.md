---
title: "Zero Knowledge Proof"
created_at: 2013-04-02 10:45:51 +0000
auteur: "Sander Demeester"
kind: article
img: "/img/znp.jpg"
contributors:
- "<a href='https://github.com/FelixVanderJeugt'>FelixVDJ</a>"
---
De normale manier voor Alice om iets te bewijzen aan Bob is door het hem te vertellen. Maar dan weet Bob dat iets ook en kan hij het verder vertellen aan andere entiteiten en Alice kan daar niks aan doen. Alice zou op een of andere manier dat "iets" willen bewijzen aan Bob zonder dat "iets" te moeten onthullen.

Om dit idee verder uit te leggen zal ik onderstaande tekst gebruik maken van 2 nieuwe personages, nl: Peggy, die de rol zal vervullen van de "prover", en Victor, die de rol zal spelen van de "verifierer".

Peggy zou een zero-knowledge proof kunnen uitvoeren, dit protocol bewijst aan Victor dat Peggy in het bezit is van een stuk informatie maar heeft Victor geen mogelijkheid om te achterhalen wat deze informatie is. Dit bewijs neem de vorm aan van een interactief protocol waar Victor een aantal vragen stelt aan Peggy. Als Peggy alle vragen correct kan beantwoorden heeft ze kennis van het geheim, zo niet heeft ze een kans van \\(\frac{1}{2}\\) om een vraag juist te beantwoorden, na een n-tal vragen zal Victor overtuigd zijn dat Peggy kennis heeft van het geheim zonder dat hijzelf iets van het geheim weet, dit is natuurlijk om voorwaarde dat de vragen nog de antwoorden iets van informatie bevatten over het geheim zelf.

Laat ons eerst eens kijken naar de definitie van een Zero-Knowledge proof.
Onze interactie tussen de beide partijen moet voldoen aan volgende 3 vereisten.

- Volledigheid:
Als de verklaring waar is, zal Victor (die het protocol volledig en correct heeft gevolgd) overtuigd zijn dat het gepresenteerde feit door Peggy correct is.
-  Correctheid:
Als de verklaring vals is, zal oneerlijke Peggy de eerlijke Victor niet kunnen overtuigen dat het gepresenteerde feit correct is.
- Zero-Knowledge:
Als de verklaring waar is, zal eerlijke Victor niet in het bezit zijn van kennis om het gepresenteerde feit te bewijzen aan een ander persoon. Hij heeft geen kennis van het gepresenteerde feit zelf, behalve dat hij overtuigd is dat Peggy in het bezit is van het feit.

### Basic Zero-Knowledge Protocol
Volgende demonstratie/uitleg van Zero-Knowledge is een vereenvoudigd voorbeeld bedacht door Jean-Jacques Quisquater en Louis Guillou. Het origineel kan gevonden worden op [QUIQUATER Jean-Jacques, GUILLOU Louis, How to Explain Zero-Knowledge Protocols to Your Children](http://www.cs.wisc.edu/~mkowalcz/628.pdf "deze link")

Lezen van bovenstaande paper is aan te raden. Het legt zeer simpel uit hoe een zero-knowledge proof werkt. Maar omdat ik deze tekst kort wil houden zal ik de woorden van Jean-Jacques en Louis Guillou kopiëren en laat ik dit over als oefening voor de lezer. Ik wil mij meer focussen op praktische zero-knowledge protocollen die ik hieronder zal bespreken. 

Neem aan dat Peggy kennis heeft van informatie en dat die informatie de oplossing is voor een NP-hard probleem. Het basis zero-knowledge protocol bestaat uit meerdere rondes.

1. Peggy gebruikt haar informatie en een random nummer om een NP-compleet probleem om te vormen tot een ander NP-compleet probleem, een probleem dat isomorf is met het origineel probleem. Ze gebruikt dan haar informatie en het random nummer om de nieuwe instantie van het probleem op te lossen.
2. Peggy verbindt zich ertoe om deze oplossing als correct te aanvaarden. (eventueel met een bit-commitment scheme).
3. Peggys onthult aan Victor de nieuwe instantie van het probleem. Victor kan met dit nieuw probleem geen informatie verkrijgen over het origineel NP-hard probleem noch kan Victor informatie verkrijgen over de oplossing.
4. Victor vraagt Peggy om
   - Aan hem te bewijzen dat het oude en nieuwe probleem isomorf zijn (maw 2 verschillende oplossingen voor twee gerelateerde problemen).
   - De oplossing te tonen waartoe Peggy zich had verbonden in stap 2. en te bewijzen dat het een oplossing is van het nieuwe probleem.

5. Peggy doet wat haar wordt gevraagd
6. Peggy en Victor herhalen de stappen 1 tem 5 n keer.


Victor zal na afloop niet instaat zijn om bijvoorbeeld een andere entiteit, nl Carol te overhalen dat Peggy kennis heeft van de informatie omdat Victor de kennis van Peggy kan "faken". 

In de volgende sectie bespreek ik 2 voorbeelden:

### Graph Isomorphism
Basis voor dit protocol komt uit 
We noemen 2 grafen isomorfistisch als er een bijectie bestaat tussen de verzamelingen van toppen \\(G\\),\\(H\\)

<notextile>
$$
\begin{equation*}
f : V(G) \rightarrow V(H)
\end{equation*}
$$
</notextile>

zodat elk paar bogen \\({u,v}\\) aangrenzend zijn in \\(G\\) als en alleen als \\(f(u)\\) en \\(f(v)\\) aangrenzend zijn in \\(H\\).
Grafen vinden die isomorf zijn aan elkaar is een NP-compleet probleem.

We aanvaarden dat Peggy kennis heeft van isomorfisme tussen graaf \\(G\_{1}\\) en \\(G\_{2}\\).
Het volgende protocol zal Victor overtuigen van Peggy haar kennis.


1. Peggy random permuteert \\(G\_{1}\\) om een graaf \\(H\\) te produceren. \\(H\\) is isomorf met \\(G\_{1}\\), omdat Peggy kennis heeft van isomorfisme tussen \\(H\\) en \\(G\_{1}\\) heeft ze ook kennis van isomorfisme tussen \\(H\\) en \\(G\_{1}\\). Voor alle andere is isomorfisme vinden tussen \\(G\_{1}\\) en \\(H\\) of tussen \\(G\_{2}\\) en \\(H\\) even moeilijk als het vinden van isomorfisme tussen \\(G\_{1}\\) en \\(G\_{2}\\).
2. Peggy zend H naar Victor.
3. Victor vraagt Peggy om:
  - Te bewijzen dan H en \\(G\_{1}\\) isomorf zijn.
  - Te bewijzen dat H en \\(G\_{2}\\) isomorf zijn.
4. Peggy doet wat haar wordt gevraagd, ofwel
   - Bewijst ze dat \\(H\\) en \\(G\_{1}\\) isomorf zijn, zonder te bewijzen dat \\(H\\) en \\(G\_{2}\\) isomorf zijn.
   - Bewijst ze dat \\(H\\) en \\(G\_{2}\\) isomorf zijn, zonder te bewijzen dat \\(H\\) en \\(G\_{1}\\) isomorf zijn.
5. Peggy en Victor herhalen de stappen 1 tem 4 n keer.

Als Peggy geen kennis heeft van isomorfisme tussen \\(G\_{1}\\) en \\(G\_{2}\\) kan ze geen graaf \\(H\\) produceren die isomorf is met beide. Ze kan enkel een graaf maken die isomorf is met ofwel \\(G\_{1}\\) ofwel \\(G\_{2}\\). Ze heeft dus \\(\frac{1}{2}\\) kans om te gokken. 
Dit protocol heeft Victor ook helemaal geen informatie om zelf instaat te zijn de isomorfe structuur te bepalen. Omdat Peggy elke ronde een nieuwe \\(H\\) maakt kan hij ook geen kennis overdragen van ronde tot ronde.

### "Hamiltonian Cycles"

Een variant van dit protocol werd voorgesteld door .
Peggy heeft kennis van een circulaire, continu pad langs de bogen van een graph that exact door elke top 1 keer passeert. Dit noemen we, zoals we weten, een Hamiltioniaanse cycle. Het vinden van een Hamiltoniaase cycle is terug een NP-compleet probleem.

Peggy wil Victor overtuigen dat ze een Hamiltoniaanse cycle kent van graaf \\(G\\). Victor kent \\(G\\) maar kent niet de cycle. Peggy kan het volgende protocol gebruiken om Victor van het feit te overtuigen.

1. Peggy random permuteert \\(G\\). 
Ze verplaatst de toppen om een nieuwe graaf \\(H\\) te maken. \\(G\\) en \\(H\\) zijn topologisch isomorf, als ze een Hamiltoniaanse cycle kent in \\(G\\) is het voor haar eenvoudig om een Hamiltoniaanse cycle te vinden in \\(H\\). Als ze zelf niet \\(H\\) heeft geproduceerd is het voor haar een moeilijk probleem om isomorfisme te vinden tussen \\(G\\) en \\(H\\).
Daarna encrypteert Peggy \\(H\\) naar \\(H'\\) (dit moet een probabilistische encryptie methode zijn voor elke lijn in \\(H\\), dat is een encrypted 0 of een encrypted 1 voor elke lijn in \\(H\\)).
2. Peggy geeft Victor \\(H'\\).
3. Victor vraagt Peggy om:
  - Te bewijzen dat \\(H'\\) een geencrypteerde isomorfe kopie van \\(G\\) is.
  - Een Hamiltoniaanse cycle tonen in \\(H\\)
4. Peggy doet wat haar gevraagt word.
   - Bewijs dat \\(H'\\) een geencrypteerde isomorfe kopie is van \\(G\\) door de permutaties te tonen en alles de decrypteren, zonder het tonen van de Hamiltoniaanse cycle voor \\(G\\) of \\(H\\)
   - Ze toont een Hamiltoniaanse cycle voor \\(H\\) door enkel de lijnen de decrypteren in \\(H'\\) die overeen stemmen met een Hamiltioniaanse cycle, zonder bewijzen dat \\(G\\) en \\(H\\) topologisch isomorf zijn.
5. Peggy en Victor herhalen stappen 1 temp 4 n keer.


Als Peggy eerlijk is, kan ze elke bewijs in stap 4 aan Victor demonsteren. Als ze geen Hamiltoniaanse cycle kent voor \\(G\\) is het voor haar onmogelijk een geencrypteerde \\(H'\\) te maken die kan voldoen aan beide uitdagingen die Victor haar voorlegt. Het beste wat ze kan doen is ofwel een graaf maken die isomorf is met \\(G\\) of een graaf maken die het zelfde aantal toppen en bogen heeft en een geldige Hamiltoniaanse cycle. Ze heeft opnieuw een kans van \\(\frac{1}{2}\\) om te gokken welk bewijs Victor zal vragen in stap 3. Victor kan het protocol blijven herhalen tot hij overtuigd is van Peggy een Hamiltioniaanse cycle kent voor \\(G\\).

Ik ben niet perfect, het is meer dan mogelijk dat ik ergens een typ fout heb. Als iemand fouten vind laat mij iets weten. 


