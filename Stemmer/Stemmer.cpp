
#include <iostream>
#include <string>


#include "..\..\dllobjs\Lang_dll.h"
#include "..\..\common\ini_log.h"
#include "..\..\common\utils.h"
#include "..\..\common\errdefs.h"

// dummy object for linking with ini_log.cpp
char Section[]= "";

enum LanguageTypes { lang_russian, lang_english };
void usage(void);
void do_action(LanguageTypes lang,LanguageDll *dll_obj);
WORD16 ExtractStems(LanguageDll *dll_obj,char* pWord, char* pBuff, WORD16 SzBuff,Bool *pfSelf);

class MyClass {
public:
/*  int field;
  void get1(void) {
  };
  void get2(void) {
  };
 
  static foo(void) {
  };*/
  virtual void v_foo_1(void) {
  };
  virtual void v_foo_2(void) {
  };
  virtual void v_foo_3(void) {
  };
  
};


int main (int argc, char* argv []) {
 /*1 статическая ф-ция
    3 виртуальных ф-ции
    2 ф-ции-члена (невиртуальных)
    1 поле типа int.*/
  int size_of=sizeof(MyClass);


  LanguageTypes lang;
  switch (argc) {
     case 3:
     if (strcmpi(argv[1],"-l")!=0) {
        usage(); 
        return 1;
     };
     if (strcmpi(argv[2],"ru")==0) {
        lang=lang_russian;
        break;
     }; 
     if (strcmpi(argv[2],"en")==0) {
       lang=lang_english;
       break;
     }; // go to usage section ( because language isn't specified correctly )

     case 0: default:
     usage();
     return 1;
 };
 { HMODULE hModule = GetModuleHandle(NULL);
   MakeIniLogPathes ( hModule );
 };

 try {
    LanguageDll dll_obj; 
    switch (lang) {
       case lang_russian:
       if (dll_obj.LoadDll("LngRus32.dll")==false) {
           IniLogUtils::LogClass log("log_error.log");
           log<<"Can't open LngRus32.dll "<<IniLogUtils::flush;
           return 1;
       };     
       break;

       case lang_english:
       if (dll_obj.LoadDll("LngEng32.dll")==false) {
           IniLogUtils::LogClass log("log_error.log");
           log<<"Can't open LngEng32.dll "<<IniLogUtils::flush;
           return 1;
       };
       break;  
    };
    do_action(lang,&dll_obj);
 } catch (...) {
    IniLogUtils::LogClass log("log_error.log");
    log<<"Unknown exception at main()"<<IniLogUtils::flush;
}; 
 FreeIniLogPathes();
 return 0;
};


void usage(void) {
  const char *About="\nUsage: stemmer.exe -l {ru | en}"
     "\nOptions:\n  -l <lang>   language of source file ('ru' or 'en')."
     "\nExample: stemmer.exe -l en <words.txt  >stems.txt";
  std::cout<<About<<std::endl;
};

void do_action(LanguageTypes lang,LanguageDll *dll_obj) {
 std::string s;
 while (std::cin) {
    if (std::cin.fail() || ( std::cin.eof()==true) )
        break;
    std::getline(std::cin,s);
    {  char buff[nsLanguageDll::MAX_STEMS*(nsLanguageDll::MAX_WORD_LEN)]; 
       Bool fSelf;
       WORD16 cnt=ExtractStems(dll_obj,(char*)s.c_str(), buff, sizeof (buff), &fSelf);
       if (cnt==0) {
         std::cout<<s.c_str()<<"\t"<<s.c_str()<<"\n";
         continue;
       };
       if (cnt==1) {
         std::cout<<s.c_str()<<"\t"<<buff<<"\n";
         continue;
       };
       { char *ptr=buff;
         while (cnt!=0) {
           std::string str=ptr;
           std::cout<<s.c_str()<<"\t"<<str<<"\n";
           ptr+=str.length()+1;
           cnt--;
         }; 
       };
    };
 } // while (std::cin) {
};


WORD16 ExtractStems(LanguageDll *dll_obj,char* pWord, char* pBuff, WORD16 SzBuff,Bool *pfSelf) {
//    INT32 i;
    WORD16 j, k, nNormForms = 0;
    WORD16 SzRest;
    char* pInBuff, *lp1, *lp2, *lp3;

    *pfSelf = FALSE;
    *pBuff = 0;
//    for (i = 0; i < Count; i++)    /// core Seg.fault... 
        //{
        j = 0;
        pInBuff = pBuff;
        while (j++ < nNormForms)
            {
            pInBuff += strlen (pInBuff) + 1;
            }
        SzRest = SzBuff - (WORD16) (pInBuff - pBuff);
        //LanguageModule* module = (LanguageModule*) At (i);
        nNormForms += dll_obj->GetWordStems (pWord, pInBuff, SzRest);
  //      }
    // Set necessary case
    lp1 = pBuff;
    /*for (i = 0; i < nNormForms; i++)
        {
        PrepWordForIdx (lp1, lp1);
        lp1 += strlen (lp1) + 1;
        }*/
    // Clear identical wordforms
    lp1 = pBuff;
    j = 0;
    while (nNormForms >= 2 && j < nNormForms-1)
        {
        lp2 = lp1 + strlen (lp1) + 1;
        for (k = j+1; k < nNormForms; k++)
            {
            if (strcmp (lp1, lp2) == 0)
                {
                // Identical strings! Remove 2nd word
                lp3 = lp2 + strlen (lp2) + 1;
                memmove (lp2, lp3, SzBuff - (lp3 - pBuff));
                nNormForms--;
                k--;
                }
            else
                {
                lp2 += strlen (lp2) + 1;
                }
            }
        j++;
        lp1 += strlen (lp1) + 1;
        }

    // Clear wordforms, identical to pWord
    lp1 = pBuff;
    j = 0;
    while (nNormForms >= 1 && j < nNormForms)
        {
        if (strcmp (lp1, pWord) == 0)
            {
            // One of forms is Identical to original! Remove it
            if (lp1 == pBuff && nNormForms == 1)
                *lp1 = 0;
            else
                {
                lp3 = lp1 + strlen (lp1) + 1;
                memmove (lp1, lp3, SzBuff - (lp3 - pBuff));
                }
            nNormForms--;
            *pfSelf = TRUE;
            }
        else
            {
            lp1 += strlen (lp1) + 1;
            }
        j++;
        }
    return nNormForms;
}



