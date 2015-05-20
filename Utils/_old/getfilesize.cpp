#include <windows.h>
#include <stdio.h>
#include <string>
#include <stdlib.h>
#include <iostream>

                                 
// класс конвертации как дрова
// число в строку ( десятичную )
Dec2Char::Dec2Char(long l) {
  ultoa(l,Dec2Char::buf,10);
};


bool get_file_size(char *name,DWORD *file_size) {
  HANDLE hFile = CreateFile(name, 
                     GENERIC_READ,
                     0, 
                     NULL,
                     OPEN_EXISTING, 
                     FILE_ATTRIBUTE_NORMAL, 
                     NULL);
  *file_size=GetFileSize(hFile,NULL);
  CloseHandle(hFile);	
  return true;
};


int main(int, char* argv []) {
  DWORD l;
  if (get_file_size(argv[1],&l)==true) {
     std::cout<<argv[1]<<" : "<<l;
     return (int)l;
  };
  return 0;
};