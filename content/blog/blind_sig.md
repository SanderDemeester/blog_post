---
title: "RSA Blind Signature"
created_at: 2013-09-01 09:35:01 +0000
auteur: "Sander Demeester"
kind: article
img: "/img/4.jpg"
---
De notie van "blind signatures" is uitgevonden door David Chaum. <br>
[D. Chaum, "Blind Signatures for Untracable Payments"](http://sce.uhcl.edu/yang/teaching/csci5234WebSecurityFall2011/Chaum-blind-signatures.PDF) <br>
[D. Chaum, "Blind Signature System Patent"](http://www.google.com/patents/US4759063) <br>
Het maakt gebruik van het RSA Algoritme. Voor meer informatie over RSA kan je terug kijken naar een vorige [blog post](/blog/RSA/)

Bob heeft een publieke sleutel \\(e\\), een private sleutel \\(d\\) en een publieke modulus \\(n\\). Alice wilt dat Bob een "blind signature" plaatst op bericht \\(m\\) .

- Alice kiest een random waarde \\(k\\) tussen \\(1\\) en \\(n\\) .
  Ze blindeerd \\(m\\) door de volgende berekening:
<notextile>
	$$
	t = mk^{e} \text{mod } n
	$$
</notextile>
- Bob tekent \\(t\\):
<notextile>
	$$
	t^{d} = (mk^{e})^{d} \text{mod } n
	$$
</notextile>  
- Alice on-blindeerd \\(t^d\\) door de volgende berekening:
<notextile>
	$$
	s = \frac{t^{d}}{k} \text{mod } n
	$$
</notextile>  
- Het resultaat is:
<notextile>
	$$
	s = m^{d} \text{mod } n
	$$		
</notextile>  
Dit is eenvoudig aan te tonen:
<notextile>
	$$
	t^{d} \equiv (mk^{e})^{d} \equiv m^{d}k(\text{mod }n)
	$$		
</notextile>  
Dus:
<notextile>
	$$
	\frac{t^{d}}{k} = \frac{m^{d}k}{k} \equiv m^{d} (\text{mod }n)
	$$		
</notextile>  

Ter illustratie vind je [hier](http://sage.ugent.be/home/pub/59/) een sage voorbeeld.