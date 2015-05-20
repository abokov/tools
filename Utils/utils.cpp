#include <iostream>
#include <string>


void show_about(void) {
 std::cout<<"Usage : utils [-Switches] [params]\n"
     " Switchec are : -GetFileSize filename\n"
     "\t\t  -GetFileTime filename\n"
     "\t\t  -GetDateTime\n"
     "\t\t  -Delay sec\n\n";
};

int getfilesize(const char*);
int getdatetime(void);
int getfiletime(const char*);
int getfiletime(const char*);


int main(int, char* argv []) {
  if (argc<1) {
     show_about();
     return -1;
  };
  int ret_value=0;
  if (strcmpi(argv[1],"-getfilesize")==0) {
     ret_value=getfilesize(argv[2]);
  } else if (strcmpi(argv[1],"-getdatetime")==0) {
     ret_value=getdatetime();
  } else if (strcmpi(argv[1],"-getfiletime")==0) {
     ret_value=getfiletime(argv[1]);
  } else if (strcmpi(argv[1],"-delay")==0) {
     ret_value=getfiletime(argv[1]);
  } else  {
      std::cout<<"\n\n Unsupported switch!\n";
      show_about();
      return -1;

  };
  return ret_value;
};
