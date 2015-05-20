#include <mem.h>
#include <stdio.h>

#include "rc6.h"

// ПОСЛЕДОВАТЕЛЬНОСТЬ БАЙТОВ В СЛОВЕ - ЗАВИСИТ ОТ АРХИТЕКТУРЫ 
// у ИНТЕЛ ЭТО 1, В ПРОЧИХ  ( например Motorolla ) - 0
// замечание - в Маках стоят именно Моторолловские чипы
// ВСЕ ЧТО LITTLE_ENDIAN - это для Intel
// ВСЕ ЧТО BIG_ENDIAN - это моторолла и иже с ними...
#define IS_LITTLE_ENDIAN 1

// константы из описания алгоритма RC6
// почему они именно такие надо спрашивать у разработчиков
const unsigned long MAGIC_P = 0xb7e15163L;    // magic constant P for wordsize
const unsigned long MAGIC_Q = 0x9e3779b9L;    // magic constant Q for wordsize



// циклический сдвиг влево 
// inline - это чтобы быстрее было
inline word rotlFixed(word x,word y)
{ return (x<<y) | (x>>(sizeof(word)*8-y)); };

inline word rotlMod(word x, word y)
{ return (x<<y) | (x>>(sizeof(word)*8-y)); };

// то же самое только величина сдвига усекается до размера слова
inline word rotrMod(word x, unsigned int y)
{
	y %= sizeof(word)*8;
	return (x>>y) | (x<<(sizeof(word)*8-y));
}


// просто меняет местами байты в слове :)
// эта реализация позаимствована ( уже не помню у кого )
// Но она быстрее всех прочих и поэтому я решил тут ей воспользоваться
inline word reverse(word value)
{
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


// меняет местами байты в слове для массива слов длинной cnt
void reverse(word *out, const byte *in, word cnt)
{ word count = (cnt+sizeof(word)-1)/sizeof(word);
  word i;
	for (i=0; i<count; i++) out[i] = reverse(in[i]);
}

// То же самое - только изменен тип массива out - это удобнее
// чем каждый раз писать reverse((word*)out,in,cnt) ;)
void reverse(byte *out, const byte *in, word cnt)
{  word i;
	word count = (cnt+sizeof(byte)-1)/sizeof(byte);
	for (i=0; i<count; i++) out[i] = reverse(in[i]);
}

// возвращает максимум из двух значений
int max(int value1, int value2)
{ return ( (value1 > value2) ? value1 : value2);  };
// то же самое - для типа word
int max(word value1,word value2)
{ return ( (value1 > value2) ? value1 : value2);  };



// дополняет ключ нулями ( если он слишком короткий
void GetUserKeyLittleEndian(byte *out, word outlen, const byte *in, word inlen)
{  memcpy(out, in, inlen);
   if (outlen<inlen) memset(out+inlen, 0, outlen-inlen);
/*#ifndef IS_LITTLE_ENDIAN
	byteReverse(out, out, inlen);
#endif*/
};

/*// То же самое - но для всех НЕ интеловских процов - мы ей не пользуемся 
// Но для кто любит MacOS эта функция будет оч полезна...
void GetUserKeyBigEndian(byte *out, word outlen, const byte *in, word inlen)
{
	memcpy(out, in, inlen);
	memset((byte *)out+inlen, 0, outlen-inlen);
//#ifdef IS_LITTLE_ENDIAN
	reverse(out, out, inlen);
//#endif
};
*/


// меняет местами байты для нескольких слов
inline void GetBlockLittleEndian(const byte *block, word &a, word &b, word &c, word &d)
{
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


inline void PutBlockLittleEndian(byte *block, word a, word b, word c, word d)
{
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




// r - число циклов - вообще говоря любое...но мы подстраиваемся под стандарт
const word r=Rounds; 
const word sTable_size=(2*r)+4; // размер той таблицы в которую конвертится
// ключ юзера - как видно она в 2 раза больше по размеру 
word sTable[sTable_size]; // собственно сам массив

// Готовим ключ
void KeyShedule(const byte *k, unsigned int keylen, unsigned int rounds)
{
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

// собственно цикл - взят из описания алгоритма...
// тут происходят страшные вещи с массивом sTable в котором хранится 
// преобразованный ключ юзера 
// как заявляют разработчики -
// все эти преобразования значительно улучшают вероятностные св-ва ключа
   for (word s=1; s <= n; s++) {
		a = sTable[i] = rotlFixed((sTable[i] + a + b), 3);
		b = l[j] = rotlMod((l[j] + a + b), (a+b));
      i = (i + 1)%(2*r + 4);
      j = (j + 1)%(c);
  };
  delete l;
}

void Encrypt(const byte *in, byte *out)
{  word *sptr = sTable;
   word a,b,c,d,t,u,i;
   // берем исходные данные - 4 слова
   GetBlockLittleEndian(in, a, b, c, d);
   b += sptr[0];
   d += sptr[1];
   // и ДАВАЙ ШИФРОВАТЬ!!!! 
   for(i=1; i<=r; i++)	{
		t = rotlFixed(b*(2*b+1), 5);  // почему 5 - кажется 5=log2(32)
		u = rotlFixed(d*(2*d+1), 5);  // см описание RC6
		a = rotlMod(a^t,u) + sptr[2*i];
		c = rotlMod(c^u,t)+sptr[(2*i)+1];
		t = a; a = b; b = c; c = d; d = t; 
	}
	a += sptr[2*r+2];
	c += sptr[2*r+3];
  // все! зашифровали 4 слова - сохраняем их
  PutBlockLittleEndian(out, a, b, c, d);
}

void Decrypt(const byte *in, byte *out)
{
	word *sptr = sTable+sTable_size;
	word a, b, c, d, t, u;

// опять берем 4 слова 
	GetBlockLittleEndian(in, a, b, c, d);

	sptr -= 2;
	c -= sptr[1];
	a -= sptr[0];

// Но на этот раз расшифровываем
	for (word i=0; i < r; i++)
	{
		sptr -= 2;
		t = a; a = d; d = c; c = b; b = t;
		u = rotlFixed(d*(2*d+1), 5);
		t = rotlFixed(b*(2*b+1), 5);
		c = rotrMod(c-sptr[1], t) ^ u;
		a = rotrMod(a-sptr[0], u) ^ t;
	}

//	sptr -= 2;
	d -= sTable[1];
	b -= sTable[0];

// все сделано - можно сохранятся
	PutBlockLittleEndian(out, a, b, c, d);
}

