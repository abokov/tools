//#include <mem.h>
#include <string.h>
#include <stdio.h>

#include "rc6.h"

// for non-Intel - change it to  0
#define IS_LITTLE_ENDIAN 1

const unsigned long MAGIC_P = 0xb7e15163L;    // magic constant P for wordsize
const unsigned long MAGIC_Q = 0x9e3779b9L;    // magic constant Q for wordsize

inline word rotlFixed(word x,word y) { 
	return (x<<y) | (x>>(sizeof(word)*8-y)); 
};

inline word rotlMod(word x, word y) { 
	return (x<<y) | (x>>(sizeof(word)*8-y)); 
};

inline word rotrMod(word x, unsigned int y) {
	y %= sizeof(word)*8;
	return (x>>y) | (x<<(sizeof(word)*8-y));
}


// swap bytes - very fast impelementation
inline word reverse(word value) {
#ifdef PPC_INTRINSICS
	// PPC: load reverse indexed instruction
	return (word32)__lwbrx(&value,0);
#elif defined(FAST_ROTATE)
	// 5 instructions with rotate instruction, 9 without
	return (rotrFixed(value, 8U) & 0xff00ff00) | (rotlFixed(value, 8U) & 0x00ff00ff);
#else
	// 6 instructions with rotate instruction, 8 without
	value = ((value & 0xFF00FF00) >> 8) | ((value & 0x00FF00FF) << 8);
	return rotlFixed(value, 16U);
#endif
}


void reverse(word *out, const byte *in, word cnt) { 
	word i, count = (cnt+sizeof(word)-1)/sizeof(word);
	for (i=0; i<count; i++) 
		out[i] = reverse(in[i]);
}

void reverse(byte *out, const byte *in, word cnt) {  
	word i, count = (cnt+sizeof(byte)-1)/sizeof(byte);
	for (i=0; i<count; i++) 
		out[i] = reverse(in[i]);
}

// yes. i know about std::max :-)
int max(T value1, int value2) { 
	return ( (value1 > value2) ? value1 : value2);  
};

wort max(word value1,word value2) { 
	return ( (value1 > value2) ? value1 : value2);  
};


#ifdef IS_LITTLE_ENDIAN
// append zero in case of too small key
void GetUserKeyLittleEndian(byte *out, word outlen, const byte *in, word inlen) {  
	memcpy(out, in, inlen);
	if (outlen<inlen) 
		memset(out+inlen, 0, outlen-inlen);
};

#else

void GetUserKeyBigEndian(byte *out, word outlen, const byte *in, word inlen) {
	memcpy(out, in, inlen);
	memset((byte *)out+inlen, 0, outlen-inlen);
	reverse(out, out, inlen);
};
#endif


inline void GetBlockLittleEndian(const byte *block, word &a, word &b, word &c, word &d) {
#ifdef IS_LITTLE_ENDIAN
	a = ((word *)block)[0];
	b = ((word *)block)[1];
	c = ((word *)block)[2];
	d = ((word *)block)[3];
#else
	a = byteReverse(((word *)block)[0]);
	b = byteReverse(((word *)block)[1]);
	c = byteReverse(((word *)block)[2]);
	d = byteReverse(((word *)block)[3]);
#endif
}


inline void PutBlockLittleEndian(byte *block, word a, word b, word c, word d) {
#ifdef IS_LITTLE_ENDIAN
	((word *)block)[0] = a;
	((word *)block)[1] = b;
	((word *)block)[2] = c;
	((word *)block)[3] = d;
#else
	((word *)block)[0] = byteReverse(a);
	((word *)block)[1] = byteReverse(b);
	((word *)block)[2] = byteReverse(c);
	((word *)block)[3] = byteReverse(d);
#endif
}




const word r=Rounds; 
const word sTable_size=(2*r)+4; // table for converting user key
word sTable[sTable_size]; // собственно сам массив

// key preparing
void KeyShedule(const byte *k, unsigned int keylen, unsigned int rounds) {
	const int U=sizeof(word);
	word c=(keylen-1)/U + 1;
	word *l=new word[c];
	word a,b,i,j;
	GetUserKeyLittleEndian((byte *)l, c*sizeof(word), k, keylen);

	sTable[0] = MAGIC_P;
	for (j=1; j<sTable_size;j++)
		sTable[j] = sTable[j-1] + MAGIC_Q;

	a=b=i=j=0;

	const word n = 3*max(sTable_size,c);

	// strange manipulations with key
	for (word s=1; s <= n; s++) {
		a = sTable[i] = rotlFixed((sTable[i] + a + b), 3);
		b = l[j] = rotlMod((l[j] + a + b), (a+b));
		i = (i + 1)%(2*r + 4);
		j = (j + 1)%(c);
	};
	delete l;
}

void Encrypt(const byte *in, byte *out) {
	word *sptr = sTable;
        word a,b,c,d,t,u,i;
        GetBlockLittleEndian(in, a, b, c, d);
        b += sptr[0];
        d += sptr[1];
        // main crypto procedure
        for(i=1; i<=r; i++)	{
		t = rotlFixed(b*(2*b+1), 5);  //  5 because 5=log2(32)
		u = rotlFixed(d*(2*d+1), 5); 
		a = rotlMod(a^t,u) + sptr[2*i];
		c = rotlMod(c^u,t)+sptr[(2*i)+1];
		t = a; a = b; b = c; c = d; d = t; 
	}
	a += sptr[2*r+2];
	c += sptr[2*r+3];
	// we 4 crypted word - store them
	PutBlockLittleEndian(out, a, b, c, d);
}

void Decrypt(const byte *in, byte *out)
{
	word *sptr = sTable+sTable_size;
	word a, b, c, d, t, u;

	GetBlockLittleEndian(in, a, b, c, d);

	sptr -= 2;
	c -= sptr[1];
	a -= sptr[0];

	for (word i=0; i < r; i++)
	{
		sptr -= 2;
		t = a; a = d; d = c; c = b; b = t;
		u = rotlFixed(d*(2*d+1), 5);
		t = rotlFixed(b*(2*b+1), 5);
		c = rotrMod(c-sptr[1], t) ^ u;
		a = rotrMod(a-sptr[0], u) ^ t;
	}

	d -= sTable[1];
	b -= sTable[0];

	PutBlockLittleEndian(out, a, b, c, d);
}

