---
tags:
  - symmetric
  - asymmetric
  - algorithms
  - public_key
  - private_key
---
# Symmetric vs asymmetric algorithms
## Symmetric algorithms uses 
- the server uses the same key (single key ) to both sign and verify the token .
- so that single key should be treated as a password (stayed secret)
- ![[Pasted image 20240205222501.png]]
## Asymmetric algorithm
### Private and public keys
- this happens in algorithms like the HS256 they uses a  symmetric key 
- so we can say a very important simple thing ( keys ) are used in confirmation for two process ( sign , verify )
- server uses the private key to make the signature and with the public key i can verify that this JWS is correct ( the public key only verify the signature that is signed from the server via the private key )
- ![[Pasted image 20240205223250.png]]
- as the name suggest the PRIVATE key must be private  , while the public one should be public 
- (as an example) the private key is the qr code of the server on the signature while the public key is the scanner that verifies that qr code
- from the asymmetric algorithms that uses  Private and Public keys  is the  RS2556
