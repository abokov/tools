#include <stdio.h>
typedef unsigned int word;
typedef unsigned char byte;
char table[]={
  '�','�','�','�','�',
  '�','�','�','�','�',
  '�','�','�','�','�',
  '�','�','�','�','�',
  '�','�','�','�','�',
  '�','�','�','�','�',
  '�','�',
  '�','�','�','�','�',
  '�','�','�','�','�',
  '�','�','�','�','�',
  '�','�','�','�','�',
  '�','�','�','�','�',
  '�','�','�','�','�',
  '�','�'};

inline bool in(char c,char min,char max)
{ return (c>=min)&&(c<=max); };

const AlphabetSize=32*2;
char get_char(byte c,byte curr_key)
{ return (char)(table[curr_key]+c)%AlphabetSize;
};

void crypt(char *msg,char*output,char *key)
{ char *tmp_key=key;
  while (*msg) {
    if ( in(*msg,'�','�')) *output=get_char( (*msg)-'�',(*tmp_key)-'�');
    else if ( in(*msg,'�','�') ) *output=get_char( (*msg)-'�',(*tmp_key)-'�');
    else *output=*msg;
    msg++;
    output++;
    tmp_key++;
    if ((*tmp_key)==0) tmp_key=key;
  };
 *output=0;
};

/*void crypt(char *msg,char *key,char*output)
{ char *tmp_key=key;
  while (*msg) {
    if ( in(*msg,'�','�') || in(*msg,'�','�') ) *output=get_char( (*msg)+'�',key+'�');
    else *output=*msg;
    msg++;
    output++;
    tmp_key++;
    if ((*tmp_key)==0) *tmp_key=key;
  };
 *output=0;
};
*/
void main(int argc, char *argv[])
{ FILE *in,*out,*key;
  char str[256];
  char str_out[256];
  char str_key[1024];
  if (argc<3) { printf("VIGINER utils .. by @bokov... XXX in_file out_file key_file /n");
    return;
  };
  if ((in=fopen(argv[1],"rt"))==NULL) {  printf("Couldnt open ");printf(argv[1]);
    return;
  };
  if ((out=fopen(argv[2],"wt"))==NULL) { printf("Couldnt open out_file /n"); printf(argv[2]);
    return;
  };
  if ((key=fopen(argv[3],"rt"))==NULL) { printf("Couldnt open key_file /n"); printf(argv[3]);
    return;
  };
  fgets(str_key,sizeof(str_key),key);

  while (fgets(str,sizeof(str),in)!=NULL) {
     crypt(str,str_out,str_key);
     fputs(str_out,out);
     fputs("\n",out);
  };
  fclose(in);
  fclose(out);
  fclose(key);
};

