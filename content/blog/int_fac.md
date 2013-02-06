---
title: "Visualisation of the Integer factorization process"
created_at: 2012-08-09 21:35:01 +0000
auteur: "Sander Demeester"
kind: article
img: "/img/1.jpg"
---
In getallen theorie zijn we vertrouwd met het idee dat elke natuurlijk getal kan worden ontbonden in priemfactoren. 
<!-- more -->
De verzameling van natuurlijke getallen is oneindig wat impliceert dat er oneindig veel priemfactoren zijn met gevolg dat er oneindig veel priem getallen zijn (De ontbinding is uniek voor elke getal op de volgorde na). Als we zouden stellen dat dit niet zo is dan bestaat er een eindig verzameling van priemgetallen $p_{1},p_{2},\cdots,p_{n}$ waarvoor $v= \Pi^{n}_{i=1} p$ met $v+1$ die dus geen priemgetal zou zijn. Dit zou tot gevolg hebben dat $v+1$ echt delers. Noemen we $q$ de kleinste positieve deler van $v+1$. Dan is $q$ een deler en bijgevolg ook een deler van $v$. Bijgevolg is $q$ een deler van $(v+1)-v = 1$. Wat niet kan, dus er zijn <a href="http://en.wikipedia.org/wiki/Largest_known_prime_number">oneindig</a> veel priemgetallen.

Er bestaan <a href="http://en.wikipedia.org/wiki/Integer_factorization#Factoring_algorithms">veel</a> algoritmes om getallen te ontbinden in hun priemfactoren.

Ikzelf heb voor mijn versie (die zeker niet optimaal is) een Direct Search Factorization algoritme gebruikt waar ik steun op de eigenschap:
$$
 \begin{equation}
\frac{n}{\sqrt{n}+1} &lt; \sqrt{n}
\end{equation}
$$
Wat het algoritme doet is, per iteratie kijken of $n$ priem is, ja? stop. In het andere getal bereken $s_{1} = \sqrt{n}$. Daarna wordt getest of $n|p_{i}$, waar $p_{i}$ een priem getal is waarvoor geldt dat $p_{i}\leq \sqrt{n}$. We testen tot we een priemgetal vinden waarvoor $n|p_{i}$, uit bovenstaande eigenschap weten we dat zoon getal bestaat endat we hem gaan vinden in de verzameling van priemgetallen kleiner dan $\sqrt{n}$ als $\sqrt{n}$ niet priem is.

Met mijn beste javascript/css kennis (die niet zo heel erg indrukwekkend zijn) heb ik een <a href="http://bit.ly/visualprimefactor">visualisatie</a> gemaakt, die dit proces als een graaf voorstelt. 
Het resultaat is een graaf $G$, waar de verzameling van toppen $V(G)$ natuurlijke getallen zijn, en de verzameling van ${uv} \in E(G)$ duid aan dat er een priemfactor relatie is tussen die 2 toppen.

Notatie:
$v^{p}_{i} \in V(G)$ is een top uit G waar de sleutel priem is.
$v^{n}_{j} \in V(G)$ is een top uit G waar de sleutel niet priem is.

Een van de dingen die me direct opviel is dat de Euler funtie $\phi(n)$ visueel zichtbaar is, met tot gevolg dat Euler's theorem kan worden uitgedrukt in termen die we gebruiken in grafentheorie.

Voor het paar toppen $$v^{n}_{j},v^{n}_{j+1}$$ 
noemen we
$$
\begin{eqnarray}
A = N_{G}(v^{n}_{j}) \\
B = N_{G}(v^{n}_{j+1})
\end{eqnarray}
$$
waar
$$
N_{G}(v) = {u \in V(G) | vu \in E(G)} \rightarrow deg_{G}(v) = |N_{G}(v)|
$$
$v^{n}_{j}$ en $v^{n}_{j+1}$ zijn relatief priem als $A \cap B = \emptyset$

We defineren Eulers functie als het aantal getallen die relatief priem zijn met $n$, we noteren dit als $\Phi(n)$.
$$
\begin{eqnarray}
\Phi(n) & = P^{e_{1}-1}_{1}(P_{1}-1) P^{e_{2}-1}_{2}(P_{2}-1)P^{e_{2}-1}_{2}\cdots P^{e_{k}-1}_{k}(p_{k}-1) \\
	& = \prod^{k}_{i=1}(P_{i}^{e_{i}-1}(P_{i}-1))
\end{eqnarray}
$$
waar $P^{e_{i}}_{i}$  de bijhorende sleutel waarde is voor elke top $t\in N_{G}(v)|s(v)=n$
Nu het leuke gedeelte. Euler's theorem vertelt ons dat
$$
a^{\Phi(n)} \equiv 1 \mod(n)
$$ 
(waar $a$ en $n$ relatief priem zijn met elkaar).
Wat de orde aanduid voor mijn favoriete groep van getallen, de multiplicatie groep modulo n, dit is de klasse van getallen die congurent zijn relatief priem tot een getal $n$

Het aantal getallen die relatief priem zijn met een getal $m$ kunnen we noteren als volgt:

We noemen $v^{n}_{i}$ de top in $G$ waar de sleutel $m$ is. 
$A_{m} = N_{G}(v^{n}_{i})$ en $\forall v_{i} \in A_{m}$ geldt dat hun sleutel priem is.
$$
A'_{m} = N_{G}(u_{j})|u_{j} \in A_{m}
$$
We kunnen dus nu zeggen dat
$$
\Phi(n) = 
\left\{
  \begin{array}{l l}
    |V(G)| - (|A_{m}| + |A'_{m}|)  & \text{ als } |A'_{m}| > 1 \\
    |V(G)| - (|A_{m}| + |A'_{m}|) + 1 & \text{ als }|A'_{m}| = 1 \\
  \end{array} \right. $$
We noteren de sleutel van $v_{i}$ als $s(v_{i})$. Dus:

$$\forall s(v_{i}) \in V(G) | N_{G}(v_{i}) \cap N_{G}(v_{i+1}) = \emptyset \rightarrow s(v_{i})^{\Phi(s(v_{i+1}))} \equiv 1 \mod s(v_{i+1})$$
<hr>
<li> De code voor de visualisatie kan worden gevonden op <a href="https://gist.github.com/3691347">github</a>
<li> Als ik ergens een fout heb gemaakt, sorry. Laat het mij <a href="twitter.com/SanderDemeester">weten</a>
<iframe src="//www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.sanderdemeester.be%2Fd%2Fnode%2F32&amp;send=false&amp;layout=standard&amp;width=450&amp;show_faces=false&amp;action=like&amp;colorscheme=light&amp;font&amp;height=35&amp;appId=207404839325473" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:450px; height:35px;" allowTransparency="true"></iframe>
