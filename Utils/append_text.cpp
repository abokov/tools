#include <fstream>
#include <iostream>


void append(const char *dstn,const char *src);

int main(int argc, char* argv []) {
  if (argc!=3) {
     std::cout<<"Usage : append_file dstn_file text_file \n"
          " append text_file to dstn_file \n\n";
     return -1;
  };
  append(argv[1],argv[2]);
};


void append(const char *dstn,const char *src) {
  std::ofstream output(dstn,std::ios::app); 
  {  std::ifstream file1(src); std::string s;
     while (file1 && ! file1.fail() && ! file1.eof()) {
       std::getline(file1,s);
       output.write(s.c_str(),s.length());
       output.write("\n",1);
     };
  };  
};

