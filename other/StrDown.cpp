#include <stdio.h>
#include <string.h>
void main(int argc, char *argv[])
{ FILE *in,*out;
  char buf[120][1000];
  int string_counter,i,j;

  char str[256];
  if (argc<2) {
    printf("strIng down utils .. by @bokov... XXX in_file out_file /n");
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

  string_counter=1;
  memset(buf,0x20,sizeof(buf));
  while (fgets(&buf[string_counter][0],120,in)!=NULL) {
//   while (strlen(buf[string_counter])<120) strcat(buf[string_counter],"0");
   buf[string_counter][strlen(buf[string_counter])-1]=0x0;

   strupr(buf[string_counter]);
   string_counter++;
  };
  fclose(in);
  for (i=0;i<120;i++) {
    for (j=0;j<string_counter;j++) { fputc(buf[j][i],out); fputc(0x20,out); };
    fputc(0xD,out);
    fputc(0xA,out);
  };

  fclose(out);
};

