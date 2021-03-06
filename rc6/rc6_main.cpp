// ��� ��室���� main() 
// ����䥩� � ஬ � ��祥

#include <stdio.h>
#include <mem.h>
#include <time.h>
#include <string.h>
#include "rc6.h"
FILE *src,*output,*key;
bool open_file(char *argv[]);

// ���, ���, ��� - ��� ���� ⠪ � ���뢠�
// � ��饬 ४���७�� ���稪 �ᥢ�� ��砩��� �ᥫ 
inline unsigned long rotate_left(unsigned long x,byte y)
{ return (x<<y) | (x>>(sizeof(unsigned long)*8-y)); };

unsigned long get_random(unsigned long prev) {
// ��१��� �� �஬� ����� 4 ��⮢ 
   return (prev*17+3)^rotate_left(prev,(prev)&0x9); 
};


void main(int argc, char * argv[])
{ bool i_want_to_crypt_it;
  enum { _ecb, _cbc, _cfb, _ofb } mode; // �� �� ०�� ��஢����
  byte UserSrcKey[MaxKeyLength];
 // ����� �� �㤥� ⠪ ��� ��� AES ( ࠧ��� ����� 128 ��⮢ )
  typedef byte AESBlock[16];
  AESBlock buf_in; 
  AESBlock buf_out;
  word i;
  char _c[24];
  byte tmp;

  unsigned long buf2[4];
  unsigned long crypt_buf[4];
  byte *p_crypt_buf=(byte*)crypt_buf;
  word cnt;
  word real_key_len;

  if (argc<6) {
StupidUser: // ��⪠ - �� ��砩 �� �ᮡ� ᮮ�ࠦ��饣� ���짮��⥫�
// ����� � ��⪨ - ���宩 �⨫�,..�� ��� �祭� ���室��...
    printf("\n Usage : RC6 {c|d} {ebc|cbc|cfb|ofb} src_file output_file key_file\n"
      " Options : 'c' - for crypt, 'd' - for decrypt,\n"
      " Mode : 'ecb' - Electoronic Codebook, 'cbc' - Chiper Block Chaining\n"
      "        'cfb' - Chiper Feedback, 'ofb'- Output Feedback\n"
      " Web - http:\\sites.netscape.net\\arxive "
     );
     gets(_c);
     return;
  };
// �� ��� �� �� ��砩 ... � 
  if (strcmpi(argv[1],"c")==0) i_want_to_crypt_it=true;
  else if (strcmpi(argv[1],"d")==0) i_want_to_crypt_it=false;
  else goto StupidUser;

  if (strcmpi(argv[2],"ecb")==0) mode=_ecb;
  else if (strcmpi(argv[2],"cbc")==0) mode=_cbc;
  else if (strcmpi(argv[2],"cfb")==0) mode=_cfb;
  else if (strcmpi(argv[2],"ofb")==0) mode=_ofb;
  else goto StupidUser;

// �� �� - � �த�  �� ��� ���� ����ᠫ 

  if (open_file(argv)==false) return;  // ����୮ ��� 㪠���

  real_key_len=fread(UserSrcKey,1,MaxKeyLength,key);
  if (real_key_len==0) { printf("Wrong key file\n");
     fclose(src); fclose(output);
  };
  fclose(key);
// ��⮢�� ���� - � R�6 �� 楫�� ��楤��
// ��� ����� ��⮬ ���� �� ��室� !!!
  KeyShedule(UserSrcKey,real_key_len); 
  if (mode!=_ecb)
  if (i_want_to_crypt_it) {
   // ᮧ���� ��������� ���樠����樮��� ����� - ��⮬ �ਣ������!
     crypt_buf[0]=time(NULL);
     crypt_buf[1]=get_random(crypt_buf[0]);
     crypt_buf[2]=get_random(crypt_buf[1]);
     crypt_buf[3]=get_random(crypt_buf[2]);
     fwrite(crypt_buf,1,sizeof(crypt_buf),output);
  } else // �⠥� ����������������� ������ �� �����
    if (fread(crypt_buf,1,sizeof(crypt_buf),src)!=sizeof(crypt_buf)) {
      printf(" Couldnt read from input file\n");
      return;
    };

 printf("\n Source file :%s",argv[3]);
 printf("\n Destination file :%s",argv[4]);
 printf("\n Key file :%s",argv[5]);
 if (i_want_to_crypt_it) printf("\n RC6 - encryption, mode : ");
 else printf("\n RC6 - decryption, mode : ");
 switch (mode) {
  case _ecb: printf("Electronic Codebook ( ECB )\n"); break;
  case _cbc: printf("Chiper Block Chaining ( CBC )\n"); break;
  case _cfb: printf("Chiper FeedBack ( CFB )\n"); break;
  case _ofb: printf("Output FeedBack( OFB )\n"); break;
 };

 switch (mode) {
  case _ecb: 
     do { cnt=fread(buf_in,1,sizeof(buf_in),src);
          if (cnt==0) break;
          if (i_want_to_crypt_it) Encrypt(buf_in,buf_in);
          else Decrypt(buf_in,buf_in);
          fwrite(buf_in,1,cnt,output);
        } while (true);
     break;
  case _cbc:
     do { cnt=fread(buf2,1,sizeof(buf2),src);
          if (cnt==0) break;
          if (i_want_to_crypt_it) {
             buf2[0]^=crypt_buf[0];
             buf2[1]^=crypt_buf[1];
             buf2[2]^=crypt_buf[2];
             buf2[3]^=crypt_buf[3];
             Encrypt((byte *)buf2,(byte *)buf2);
          } else {
             Decrypt((byte *)buf2,(byte *)buf2);
             buf2[0]^=crypt_buf[0];
             buf2[1]^=crypt_buf[1];
             buf2[2]^=crypt_buf[2];
             buf2[3]^=crypt_buf[3];
          };
          fwrite(buf2,1,cnt,output);
        } while (true);
       break;
    case _cfb:  
      // ����� ��� - ��� ����஢���� � ����஢���� 
     // �ᯮ������ ���� � � �� ��楤�� Encrypt() � XOR=^
      Encrypt(p_crypt_buf,p_crypt_buf);
      do {
         cnt=fread(buf_in,1,sizeof(buf2),src);
         if (cnt==0) break; // �᫨ ��祣� �� ���⠫� - �� �����
         if (i_want_to_crypt_it)
            for (i=0;i<cnt;i++) {
               buf_out[i]=p_crypt_buf[15]^buf_in[i];
               memcpy(&p_crypt_buf[0],&p_crypt_buf[1],15);
               p_crypt_buf[15]=buf_out[i];
               Encrypt(p_crypt_buf,p_crypt_buf); }
         else
            for (i=0;i<cnt;i++) {
               buf_out[i]=p_crypt_buf[15]^buf_in[i];
               memcpy(&p_crypt_buf[0],&p_crypt_buf[1],15);
//               p_crypt_buf[15]=buf_out[i];
               p_crypt_buf[15]=buf_in[i];
               Encrypt(p_crypt_buf,p_crypt_buf); }
         fwrite(buf_out,1,cnt,output);
      } while (true); // ���� 横� - ���� �� �� ���⠥�
      break;

    case _ofb: 
      // ����� ��� - ��� ����஢���� � ����஢���� 
      // �ᯮ������ ���� � � �� ��楤��
      Encrypt(p_crypt_buf,p_crypt_buf);
      do {
         cnt=fread(buf_in,1,sizeof(buf2),src);
         if (cnt==0) break;
         for (i=0;i<cnt;i++) {
               buf_out[i]=p_crypt_buf[15]^buf_in[i];
               tmp=p_crypt_buf[0];
               memcpy(&p_crypt_buf[0],&p_crypt_buf[1],15);
               p_crypt_buf[15]=tmp;
               Encrypt(p_crypt_buf,p_crypt_buf); }
         fwrite(buf_out,1,cnt,output);
      } while (true);
      break;
    default: printf(".. INTERNAL ERROR\n"); return;
   };


  printf("Done...We'll workin' very well...\n");
  fclose(src); fclose(output);
};


bool open_file(char *argv[])
{ if ((src=fopen(argv[3],"rb"))==NULL) { printf("Could not open file: "); printf(argv[2]); printf("\n");
     return(false);
  };
  if ((output=fopen(argv[4],"wb"))==NULL) { printf("Could not open file: "); printf(argv[3]); printf("\n");
     fclose(src);
     return(false);
  };
  if ((key=fopen(argv[5],"rb"))==NULL) { printf("Could not open file: "); printf(argv[4]); printf("\n");
     fclose(src); fclose(output);
     return(false);
  };
  return(true);
};

