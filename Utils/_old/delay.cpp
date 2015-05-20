#include <time.h>
void main(void) {
  time_t t=time(NULL);
  while ((time(NULL)-t)<10);
};