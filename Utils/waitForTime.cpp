#include <time.h>
#include <stdio.h>
#include <iostream>


void wait(const char *hour);

int main(int argc, char* argv []) {
  if (argc!=2) {
     std::cout<<"Usage : waitForTime Hour \n\n";                          
     return -1;
  };
  wait(argv[1]);
};


void wait(const char *str_hour) {
  int hour=atoi(str_hour);
  if (hour!=0) { 
     hour= hour % 24;
  };
  if ((hour<0)||(hour>=24)) {
    std::cout<<"Wrong hour : it must be between 0 and 24 "<<std::endl;
    return;
  };
  tm *tblock;
  time_t timer = time(NULL);
  tblock = localtime(&timer); 
  
  char buf[10]; itoa(hour,buf,10);
  printf("Waiting for %s hour",buf);
  printf("\nWhen it starts local time was: %s", asctime(tblock));

  while(true) {
   timer = time(NULL);
   tblock = localtime(&timer); 
   if (tblock->tm_hour==hour)
      break;
  }; //   while(true) {
};