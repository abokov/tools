//  RC6 interface
// KMZI
#ifndef __F_KMZI__
#define __F_KMZI__
const MaxKeyLength=64; 
const Rounds=20;

typedef unsigned char byte;
typedef unsigned int word;         // we'll use it..

void KeyShedule(const byte *k, unsigned int keylen=MaxKeyLength, unsigned int rounds=Rounds);
void Encrypt(const byte *in, byte *out);
void Decrypt(const byte *in, byte *out);

#endif // __F_KMZI__



