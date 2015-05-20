#include <fstream>
#include <iostream>
#include <set>

void String2LowerCase(std::string *s) {
  if (s->length()==0)
    return;
 //---- переводим в lowercase
 char *p=new char[s->length()+1];
 strcpy(p,s->c_str());
 strlwr(p);
 s->assign(p);
 delete [] p;
};


void kill_duplicates(const char *file);

int main(int argc, char* argv []) {
  if (argc!=2) {
     std::cout<<"Usage : kill_duplicated text_file \n\n";                          
     return -1;
  };
  kill_duplicates(argv[1]);

};


void kill_duplicates(const char *file) {
  std::set<std::string> store;
  {  std::ifstream file1(file); std::string s;
     while (file1 && ! file1.fail() && ! file1.eof()) {
        std::getline(file1,s);
        String2LowerCase(&s);
        store.insert(s);
     };
  };  
  std::ofstream  output(file); std::string s;
  std::set<std::string>::iterator iter=store.begin(),end=store.end();
  while (iter!=end) {
    s=*iter;
    s.append("\n");
    output.write(s.c_str(),s.length());
    ++iter;
  };

};
