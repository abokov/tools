// Set.h, Set templates
#ifndef __SET_INC__
#define __SET_INC__
#include <limits.h>

template<class T> class SetClass{
private:unsigned char set[ (1<<(CHAR_BIT*sizeof(T)-3))-1 ];
// set of byte - 32=256/8
// set of word - 8192=65536/8
public: SetClass(void) { memset(&set,0,(1<<(CHAR_BIT*sizeof(T)-3))-1); };
        SetClass(T*,unsigned int);
        void Include(T t) { set[t>>3] |= (unsigned char )(1 <<(t&7)); };
        void Exclude(T t) { set[t>>3] &= (unsigned char) (~(1 <<(t&7))); };
        unsigned char In(T t) { return ( set[t>>3] & ((unsigned char )(1 <<(t&7))) ); };
};

template<class T> SetClass<T>::SetClass(T*t,unsigned int size)
{ memset(&set,0,(1<<(CHAR_BIT*sizeof(T)-3))-1);
  while (size--) Include(*(t++));
};

#endif
