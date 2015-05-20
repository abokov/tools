#include <fstream>
#include <iostream>
#include <set>

int linecnt(const char *file);

int main(int argc, char* argv []) {
  if (argc!=2) {
     std::cout<<"Usage : linecnt text_file \n\n";                          
     return -1;
  };
  int line=linecnt(argv[1]);
  std::cout<<line<<"\n";
};


int linecnt(const char *file) {
  std::set<std::string> store; int line_cnt=0;
  {  std::ifstream file1(file); std::string s;
     while (file1 && ! file1.fail() && ! file1.eof()) {
        std::getline(file1,s);
        line_cnt++;     
     };
  };  
  return line_cnt;
};