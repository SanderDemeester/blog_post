---
title: "Rate of a Language and how it relates to Perfect Secrecy"
created_at: 2014-08-24 20:33:21 +0000
auteur: "Sander Demeester"
kind: article
img: "/img/3.jpg"
---

- *Conquer but never triumph*

For a given language, the rate is defined as follows:
<notextile>
$$r = \frac{H(M)}{N}$$
</notextile>
Where $H(M)$ is the amount of information in the message $M$, measured by the entropy. 
$N$ is the length of the message.
As noted be Shannon, the entropy depends on the length of the message. Specificallly he indicated a rate of 2.3 bits/symbol for 8-symbol chunks, but the rate drops to between 1.3 and 1.5 for 16-symbol chunks.

The absolute rate of a language is the maximum number of bits that can be coded in each character, assuming each character sequence is equally likely. If there are $L$ characters n a language, the absolute rate is:
<notextile>
$$R = \log_2 L$$
</notextile>
This is the maximum entropy of the individual characters.
For English, with 26 symbols, the absolute rate is about 4.7 bits/symbol. This is much less than the absolute rate, natural language is highly redundant. This is denoted by $D$
<notextile>
$$D = R - r$$
</notextile>

Given that the rate of English is 1.3, the redundancy is 3.4 bits/symbol. Meaning that each symbol carries 3.4 bits of redundant information. Translate this to bits: each bit in an ASCII text contains 0.84 real information.

Shannon defined a model of what it means for a cryptosystem to be secure. The goal is to determine the key $K$, the plaintext $P$, or both. However, she may be satisfied with some probabilistic information about $P$.

In most real-word cryptanalysis, the cryptanalyst has some probabilistic information about $P$ before she starts.
She knows that the original text contains alot of redundant information, the message may start with a starting beginnen? it can be an IP-packet and so-on.
The purpose of the cryptoanalysis is to modify the probabilities associated with each possible plaintext. Eventually one plaintext will emerge from the pile of possble plaintexsts as certain.

There is such a thing as a cryptosystem that achieves perfect secrecy: a cryptosystem in which is the ciphertext yields no possible information about the plaintext (except possibly its length). Shannon theorized that it is only possible if the number of possible keys is at leat as large as the number of possible messages.

In other words, the key must be at least as large message itself, and no key can be reused. In still other words, the one-time pad is the only cryptosystem that achieves perfect secrecy.

