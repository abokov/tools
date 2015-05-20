#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <conio.h>
char * proceed_line(char *);
void main(int argc, char *argv[])
{ FILE *in,*out;
  char str[256];
  if (argc<2) { printf("TXTCONV utils .. by @bokov... XXX in_file out_file /n");
    return;
  };
  if ((in=fopen(argv[1],"rt"))==NULL) {
    printf("Couldnt open ");printf(argv[1]);
    return;
  };
  if ((out=fopen(argv[2],"wt"))==NULL) {
    printf("Couldnt open out_file /n"); printf(argv[2]);
    return;
  };

  while (fgets(str,sizeof(str),in)!=NULL) {
     str[strlen(str)-1]=0;
     strcpy(str,proceed_line(str));
     fputs(str,out);
     fputs("\n",out);
  };
  fclose(in);
  fclose(out);
};

typedef unsigned int word;
static word value,v2;

word get_random(void) {
   if (v2==0) {value=value*11+1;v2=value;}
   v2>>=1;
   return(value);
};

char buf[256];
char * proceed_line(char *s)
{ char token[128];
  word i;
  static word w;
  for (i=0;i<1000;i++) get_random();
  i=get_random();
  switch (i%4) {
    case 0: strrev(s); // Обратить строку целиком
    return(s);

    default:
    buf[0]=0;
    w=get_random();
    while (s[0]) {
      while (*s==0x20) s++;
      for (i=0;(i<strlen(s))&&(s[i]!=0x20);i++) token[i]=s[i];
      s+=i;
      token[i]=0;
      if (w&1) w>>=1;
      else w>>=2;

      if (w&1) strrev(token);
      strcat(buf,token);
      strcat(buf," ");
    };
    return(buf);
  };
};











