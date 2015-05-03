---
title: "RSA Blind Signature"
created_at: 2013-09-01 09:35:01 +0000
auteur: "Sander Demeester"
kind: article
img: "/img/4.jpg"
---
The original idea for blind signatures was uitgevonden by David Chaum. <br>
[D. Chaum, "Blind Signatures for Untracable Payments"](http://sce.uhcl.edu/yang/teaching/csci5234WebSecurityFall2011/Chaum-blind-signatures.PDF) <br>
[D. Chaum, "Blind Signature System Patent"](http://www.google.com/patents/US4759063) <br>
It uses the RSA Algoritme.
Bob has a public key \\(e\\), and a private key  \\(d\\) and a public modulus\\(n\\). 
Alice wants Bob to place a blind signature on the message \\(m\\) .

- Alice chooses a random values \\(k\\) betwen \\(1\\) and \\(n\\).
  She blinds \\(m\\) by the following calculation:
<notextile>
	$$
	t = mk^{e} \text{mod } n
	$$
</notextile>
- Bob signs \\(t\\):
<notextile>
	$$
	t^{d} = (mk^{e})^{d} \text{mod } n
	$$
</notextile>  
- Alice removes the bliding \\(t^d\\) by the following calculation: 
<notextile>
	$$
	s = \frac{t^{d}}{k} \text{mod } n
	$$
</notextile>  
- The result is:
<notextile>
	$$
	s = m^{d} \text{mod } n
	$$		
</notextile>  
Dit is eenvoudig aan te tonen:
This is demonstrated like this:
<notextile>
	$$
	t^{d} \equiv (mk^{e})^{d} \equiv m^{d}k(\text{mod }n)
	$$		
</notextile>  
So:
<notextile>
	$$
	\frac{t^{d}}{k} = \frac{m^{d}k}{k} \equiv m^{d} (\text{mod }n)
	$$		
</notextile>  

As a [demonstration](http://sage.ugent.be/home/pub/59/)