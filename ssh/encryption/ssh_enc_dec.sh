#!/usr/bin/env bash

# source: SSH definitive P41/61

: <<"NOTES"
Public-key, or asymmetric, cryptography replaces the single key 
with a pair of related keys: public and private. They are related 
in a mathematically clever way: 

- data encrypted with one key may be decrypted only with the other
     member of the pair,

- and it is infeasible to derive the private key from the public one.

- You keep your private key, well, private, and give the public key 
    to anyone who wants it, without worrying about disclosure.

- When someone wants to send you a secret message, they encrypt it
    with your public key. Other people may have your public key, 
    but that won’t allow them to decrypt the message; only you can 
    do that with the corresponding private key

Modern data encryption uses both methods (secret-key and public-key),

Suppose you want to send some data securely to your friend Bob Bitflip-
per. Here’s what a modern encryption program does:

1. Generate a random key, called the bulk key, for a fast, secret-key 
    algorithm like 3DES (a.k.a. the bulk cipher).

2. Encrypt the plaintext with the bulk key.

3. Secure the bulk key by encrypting it with Bob Bitflipper’s public 
    key, so only Bob can decrypt it. Since secret keys are small 
    (a few hundred bits long at most), the speed of the public-key 
    algorithm isn’t an issue.

To reverse the operation, Bob’s decryption program first decrypts 
the bulk key, and then uses it to decrypt the ciphertext

SSH uses this technique. User data crossing an SSH connection is 
encrypted using a fast secret-key cipher, the key for which is 
shared between the client and server using public-key methods.


hashing.

What is actually done is to first hash the document, producing 
a small hash value, and then sign that, sending the signed hash 
along instead. A verifier independently computes the hash, then 
decrypts the signature using the appropriate public key, and 
compares them. If they are the same, he concludes (with high 
probability) that the signature is valid, and that the data hasn’t 
changed since the private-key holder signed it.

The Cyclic Redundancy Check (CRC) hash commonly used to detect 
accidental data changes (e.g., in Ethernet frame transmissions) 
is an example of a noncollision-resistant hash. 

It is easy to find CRC-32 hash collisions, and a well-known attack 
on SSH-1 is based on this fact.

Examples of cryptographically strong hash functions are MD5 and SHA-1
NOTES