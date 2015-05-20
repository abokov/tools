#include <fstream>
#include <ostream>

#include "..\..\common\utils.h"
#include "..\..\common\fileutil.h"
#include "..\..\common\datetime.h"

char * Section="";

int main(int argc, char* argv []) {
{ HMODULE hModule = GetModuleHandle(NULL);
  MakeIniLogPathes ( hModule );
  SetLogOptions(LOG_AppendTime,"dw");
};

  WORD32 string_count=1000;
  std::ifstream from(argv[1]);
  IniLogUtils::LogClass to(argv[2]); to.set_time_options(false);
  //GetStringCount((char*)argv[1],2048,true,&string_count);
  WORD32 tmp=0;
  while (tmp<string_count) {
     if (from && ! from.fail() && ! from.eof());
     else
       break;
     std::string url;
     std::getline(from,url);
     to<<url<<IniLogUtils::flush;
     tmp++;
  };

FreeIniLogPathes();

  return -1;
};
