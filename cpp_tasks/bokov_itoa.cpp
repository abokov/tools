#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <iostream>
#include <windows.h>

const int ten_table[]={ 
   1,
   10,
   100, 
   1000,  
   10000, 
   100000, 
   1000000, 
   10000000, 
   100000000,
   1000000000
};

void my_itoa_r(char *ptr, int i, char shift) { 
   if (shift == 0) {
/*      if ((i<0) || (i>9)) {
          std::cout<<"Axtung!!!"<<std::endl;
      };*/
      *(ptr+1) = 0;
      *(ptr) = '0'+i;
   } else {
      int val = ten_table[shift];
      int prev_val = 0;
      int cnt = 0;
      do {
          if (i<val)
              break;
          prev_val = val;
          ++cnt;
          val += ten_table[shift];
      } while (cnt<9);
      int mod = i - prev_val;
      /*if ((cnt<0) || (cnt>9)) {
         std::cout<<"Axtung!!!"<<std::endl;
      };*/
      (*ptr) = '0'+cnt;
      my_itoa_r(ptr+1, mod, shift-1);
   };    
};


void my_itoa(char *c, int i) {
   if (i<0) {
      (*c) = '-';
      c++;
      i = -i;      
   };
   if (i<10) {
       my_itoa_r(c, i, 0);
   } else
     for (char cnt = 0; cnt< sizeof(ten_table)/sizeof(int); cnt++) 
         if (i<ten_table[cnt]) {  
              my_itoa_r(c ,i, cnt-1);  
              break;
         };
};

typedef unsigned long ui64;


void main(void) {
  char c[32];
  char c1[32];
  const int MAXINT=999999999;
  //const int MAXINT=999999;
  my_itoa(c1,100);

  my_itoa(c1,352);
  my_itoa(c1,-152);
  
  for (int i=-MAXINT;i<MAXINT;++i) {
       itoa(i,c,10);
       my_itoa(c1,i);
       if (strcmp(c,c1) !=0) {
           std::cout<<" itoa: \'"<<c<<"\', but my_itoa=\'"<<c1<<"\'"<<std::endl;
          return;
       };
  };

 //return;


for (int j=0;j<3;++j) {
  DWORD start = GetTickCount();
  for (int i=-MAXINT;i<MAXINT;++i) {
       itoa(i,c,10);
  };
  ui64 end = GetTickCount();
  ui64 diff = end-start;
  std::cout<<"std::itoa : ="<<diff<<std::endl;


  start = GetTickCount();
  for (int i=-MAXINT;i<MAXINT;++i) {
       my_itoa(c,i);
  };
  end = GetTickCount();
  diff = end-start;
  std::cout<<"my_itoa : ="<<diff<<std::endl;
};

};

/*
test tells that
/www/bokov/www/htdocs/bokov_itoa.cpp 
std::itoa : =381547
my_itoa : =343953
std::itoa : =385219
my_itoa : =343594
std::itoa : =378750
my_itoa : =342921
*/
