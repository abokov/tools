#include <stdio.h>
#include <string.h>
void main(int argc, char *argv[])
{ FILE *in,*out;
  char str[256];
  if (argc<2) {
    printf("strIng reverse utils .. by @bokov.
    .. XXX in_file out_file /n");
    return;
  };
  if ((in=fopen(argv[1],"rt"))==NULL) {
    printf("Couldnt open in_file /n");
    return;
  };
  if ((out=fopen(argv[2],"wt"))==NULL) {
    printf("Couldnt open out_file /n");
    return;
  };

  while (fgets(str,sizeof(str),in)!=NULL) {
    strrev(str);
    fputs(str,out);
  };
  fclose(in);
  fclose(out);
 };

