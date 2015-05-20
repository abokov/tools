#include <iostream>
#include <fstream>
#include <string>
#include <time.h>

class Dec2Char {
  char buf[20];
public:
  Dec2Char(unsigned l) {
     ultoa(l,Dec2Char::buf,10);
  };
  operator char * () {
     return buf;
  };
  operator const char * () {
     return buf;
  };
};


int main(void) {
 time_t my_time=time(NULL);
 tm *my_tm=localtime(&my_time);

 std::string s;
 s.append(Dec2Char(my_tm->tm_year+1900));
 s.append("_"); 
 if ((my_tm->tm_mon+1)<10)
   s.append("0"); 
 s.append(Dec2Char(my_tm->tm_mon+1));
 s.append("_"); 
 if (my_tm->tm_mday<10) 
   s.append("0"); 
 s.append(Dec2Char(my_tm->tm_mday));
 std::ofstream file_out(s.c_str());

 return 0;
};