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

