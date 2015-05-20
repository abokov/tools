#include <fstream>
#include <iostream>


void do_it(const char *src,const char *out);

int main(int argc, char* argv []) {
  if (argc!=3) {
     std::cout<<"Usage : replace_auka src output \n"
          " replace_auka to dstn_file \n\n";
     return -1;
  };
  do_it(argv[1],argv[2]);
};

struct QuotReplaceRecord {
   const char *src_value; // что было
   const char *for_repl;// на что заменять
};
QuotReplaceRecord quot_storage []={
   { "</offer><offer",  "\n</offer>\n<offer" },
};
const QuotStorageSize=sizeof(quot_storage)/sizeof(QuotReplaceRecord);


void replace_string(std::string *s) {
  int i;
  for (i=0;i<QuotStorageSize;i++) {
     do {
        int pos=s->find(quot_storage[i].src_value);
        if (pos!=std::string::npos) {
           std::string s2; s2.assign(s->c_str(),pos);
           s2.append(quot_storage[i].for_repl);
           s2.append(s->c_str()+pos+strlen(quot_storage[i].src_value)); 
           s->assign(s2.c_str());
        } else
            break;
     } while (true);
  }; // for (i=0;i<QuotStorageSize;i++) {
};


void do_it(const char *src,const char *out) {
  std::ofstream output(out); 
  {  std::ifstream file1(src,std::ios::binary); std::string s;
     while (file1 && ! file1.fail() && ! file1.eof()) {
       std::getline(file1,s);
       replace_string(&s);
       output.write(s.c_str(),s.length());
       output.write("\n",1);
     };
  };  
};

