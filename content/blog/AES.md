---
title: "Advanced Encryption Standard (AES)"
created_at: 2012-01-07 19:59:01 +0000
auteur: "Sander Demeester"
kind: article
img: "/img/aes.gif"
---
AES operates on blocks of 16 byte (128 bit). 
AES uses permutations and a substitution-network as the internal structure, the number of iterations that is used when the "key scheduling" depends upon the key length.
<!-- more -->
If the key has a length of 128 bit (16 bytes) the number of iterations is 10. If the key has a length of 192 bits (24 byte), then we have 12 iterations. If the key length is 256 bits then we use 14 iterations. In general, the number of iterations is equal to (key size in 4 byte words)+6. Each iteration has 16 bytes needed for "keying material"
     128 bit key: 160 bytes + 176 bytes extra key permutation
     192 bit key: 192 bytes + 208 bytes extra key permutation
     256-bit key: 224 bytes + 240 bytes extra key permutation

So for a 16 byte input, the AES key scheduling algorithm is to generate a 176 byte output. The first 16 bytes are the input itself. The other 160 bytes are calculated in 4 byte blocks per iteration. Each of the current 4 byte block is a permutation of the privous 4 byte block.

As an example we can say that the key scheudling bytes 17-20 are a permutation of byte 13-16. Either bytes 17-20 = 1-4 bytes xor bytes 13-16

A transformation sis applied every 4th iterations (for a 128 bit key). The last 4 bytes are xored. Each transformation consists of the following steps:

		Rotation of a 4 byte word
		Using the AES sbox (subsitution)
		XOR with a round constant

The rotation:


The rotation:
The first byte is overwritting with the second byte.
The second byte is overwritting by the third byte, the third with the fourth byte and the last byte with the first byte.


The subsitutation:
The subsitation phase looks up each byte in the AES sbox, and replaces it with the corresponding byte in the sbox. The translation table is a 16 by 16 byte array, the row is identified by the 4 most significant bits.

The column is identified by the 4 least significant bits.

For example, the byte 0x1A would correspond with row 1, column 10.
The AES specification uses an affine transformation over:
<notextile>
$$GF(2^{8})\text{ van } b_{i} + b_{(i+4)\text{%}8} + b_{(i+5)\text{%}8} + b_{(i+6)\text{%}8} + b_{(i+7)\text{%}8} + c_{i}$$
</notextile>

The XOR:
At the end, our value is xored with our round constant. The 3 least significant bytes of the round constant are always 0. The most significant byte always starts with 0x01. This byte is every 4 iterations shifted 1 bit to the left. In order, this takes on values like so: 0x02 in the 8th iteration. 0x04 to the twelfth iteration etc.

It is important to note that for a 128 bit key the round constant will be 10 times shifted to the left. Because a 128 bit key needs 44 iterations. But if you have a byte shifted 8 times to the left, you end up with a 0x00 byte. The specification requires that , when overflow occurs in a left shift, you have to perform an XOR with the byte 0x1B. For the "why" I refer to the specification page 15.

The 192 bit key scheduler works very much in the same way. The difference is that the rotation, substituation and the round constant XOR is applied each 9th iteration.
For a 256 bit key this is each 8th iteration.
 
Because each 8th iteration is a pretty large interval, the subsituation step is applied every 4th iteration.


It is important to note that the result of the key scheduling algorithm is non-linear but repeatable.  

AES Encryption:

AES operates on blocks of 16 bytes for each of his inputs regardless of the key length. We view the input as a 4 x 4 matrix, this is obviously the complete set of hexadecimal characters. 
We'll call this the "AES state mapping initialization". During the encryption we will process this state using permutations, substitutions in combination with keying material to produce the output.


So we have the "Input Block ("State")". We first do a XOR with the first 16 bytes of the key and get as output "Round 1 input". An AES key combination is performed, each of these rounds exists of the following 4 steps:
- A substitution step.
- A row shifting -step.
- A column mixing step.
- A key combination step.

We perform the subsitation step on each individual byte of the input. The subsitution is done using the same matrix from the key scheduling algorithm, namely our sbox.


We perform the rotation step on each row of our state block.
The first row is rotated 0 places. The second row is rotated one place, the third row 2 places and so on.
The column mixing step is defined as a matrix multiplication with the following matrix:
<notextile>
$$ \begin{bmatrix}  
02 & 03 & 01 & 01 \\
01 & 02 & 03 & 01 \\
01 & 01 & 02 & 03 \\
03 & 01 & 01 & 02 \\
\end{bmatrix} $$  
</notextile>
AES redefines the matrix addition and matrix multiplication operations.
The matrix addition operation in AES is defined as an XOR operation. Matrix multiplication is the multiplication mod 0x1B.

The specification calls this the inner product operation. This again is a redefication. Thus, the multiplication of 2 bytes is the determination of their inner product.
So this becomes the XOR operation on 2 bytes performed $n$ bytes. $n$ is the number of left shift operations that are xored with 0x1B.

AES Decryption:

Everything that we have done during the encryption phase must be reversable. We start with the rounds of the keys in reverse order.
We then start "unmixen" of the columns and reshifting of the rows. Unlike DES, it is not possible so simply reuse the same operations to perform decryption.

What is striking is that for decryption we can not reuse the same AES sboxes because the subsitation is in the reverse order. So we have one pair of sboxes to encrypt, and a different set to decrypt.

Inverting means that we need to do the inverse matrix multiplication of each column in our matrix.
This is not only a multiplication, but also an inversion. Consider the following polynomial over 
over \\(GF(2^{8})\\) and multiplied mod \\(x^{4}+1\\) with a polynomial \\(a^{-1}\\)
 gegeven door 
<notextile>
$$ a^{-1}(x) = \{0b\}x^\{3\} + \{0d\}x^\{2\} + \{09\}x + \{0e\} $$ 
</notextile>
This is equivalent to a matrix multiplication with the matrix:

<notextile>
$$ \begin{bmatrix}
0e & 0b & 0d & 09 \\
09 & 0e & 0b & 0d \\
0d & 09 & 0e & 0b \\
0b & 0d & 09 & 0e 
\end{bmatrix} $$  
</notextile>
This is of course with the redefined operations as described above.

Link to the formal specification: <a href="csrc.nist.gov/publications/fips/fips197/fips-197.pdf">csrc.nist.gov/publications/fips/fips197/fips-197.pdf</a>
