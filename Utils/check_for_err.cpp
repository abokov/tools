#include <fstream>
#include <iostream>
#include <set>


void check_for_err(const char *file);

int main(int argc, char* argv []) {
  if (argc!=2) {
     std::cout<<"Usage : check_for_err text_file \n\n";                          
     return -1;
  };
  check_for_err(argv[1]);

};


void check_for_err(const char *file) {
  std::string out_file=file; out_file.append("_err");
  std::ofstream output(out_file.c_str()); 
                               
  {  std::ifstream file1(file); std::string s;
     while (file1 && ! file1.fail() && ! file1.eof()) {
        std::getline(file1,s);
        do {
            if (s.find("==> http://")!=std::string::npos)
                 break;
            if (s.find("==> ftp://")!=std::string::npos)
                 break;
            if (s.find("==> https://")!=std::string::npos)
                 break;

           output.write(s.c_str(),s.length());
           output.write("\n",1);
        } while(false);
     };
  };  
};
