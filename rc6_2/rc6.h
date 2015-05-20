//  RC6 interface
#ifndef __RC6_INC___
#define __RC6_INC___
const int MaxKeyLength=64; 
const int Rounds=20;

typedef unsigned char byte;
typedef unsigned int word;       

void KeyShedule(const byte *k, unsigned int keylen=MaxKeyLength, unsigned int rounds=Rounds);
void Encrypt(const byte *in, byte *out);
void Decrypt(const byte *in, byte *out);

#endif



