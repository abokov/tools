#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
 char * ptr = getenv("COMPUTERNAME");
 if (ptr==NULL) {
   printf("\n\nERROR IN COMPUTERNMAME environment variable!!!\n");
   printf("\n\nERROR IN COMPUTERNMAME environment variable!!!\n");
   while(ptr==NULL) {
     ptr=NULL;
   };
   return 255;
 };

 char *p=ptr+strlen("indexer");
 if (p==NULL) {
   printf("\n\nWRONG VALUE OF COMPUTERNMAME environment variable : \n%s,",ptr);
   printf("\n\nERROR IN COMPUTERNMAME environment variable!!!\n");
   while(p==NULL) {
     p=NULL;
   };
 };
  
 return atoi(p);
};