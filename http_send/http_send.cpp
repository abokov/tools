#include <check_options.h>
#include <stdio.h>
#include <iostream.h>

#include <windows.h>

#include <common_def.h>
#include <my_istream.h>

#include <Stnd_Lib\conv.h>
#include <Stnd_Lib\utils.h>
#include <Stnd_Lib\My_Ostream.h>


#include "http_req.h"
#include <sys\timeb.h>

class HttpSettingsRecord {
public:
  HttpSettingsRecord(void);
  ~HttpSettingsRecord();

  string host_url; // url
  string host_ip; // ip address
  ulong host_port; // port
  ulong timeout; // in ms
  ulong requests_cnt; // in ms
  bool skip_cout;
  bool log_append;
  bool header_append;
  bool data_append;
  bool save_all;

  ulong repeat_counter;

  string read_header_file; // file with data for Header's data
  string read_post_file; // file with data for POST method

  string write_header_file; // file with server answer
  string write_data_file; // file with server answer

  string log_file; // file with log
};

HttpSettingsRecord::HttpSettingsRecord(void) {
 host_port=80; // port
 repeat_counter=100;
 timeout=0; // in ms
 requests_cnt=1; // in ms
 log_file="http_send.log";
 skip_cout=false;
 log_append=false;
 header_append=false;
 data_append=false;
 save_all=false;

};

HttpSettingsRecord::~HttpSettingsRecord(void) {
};

void usage(void);
// returns false on error, otherwise - true
bool set_options(char *arg,HttpSettingsRecord *setting);
// do it!
bool make_request(HttpSettingsRecord *setting);

bool read_file_to_string(const char*filename,string *string_buf);
bool write_string_to_file(const char*filename,string *string_buf,bool do_append);

void press_any_key(char *message=NULL);

int main(int argc, char *argv[]) {
 if (argc<3) {
   usage();
   return -1;
 };
 cout.flush();
 int i; HttpSettingsRecord settings;
 for (i=1;i<argc;i++) {
    if (set_options(argv[i],&settings)==false) {
       cout<<"\n http_send failed..\n"<<endl;
       press_any_key();
       return -1;
    };                                   
 };
 if (make_request(&settings)==false) {
   cout<<"\nError at request!!"<<endl; 
   press_any_key();
   return -2;
 };
 return 0;
};

// do it..
bool make_request(HttpSettingsRecord *setting) {
 bool b,exist;  volatile ulong l; ulong l2;
 volatile timeb start_time,end_time;
 volatile ulong long_start_time,long_end_time;
 ::ftime((timeb*)&start_time);
 long_start_time=((start_time.time & 0xFFFFF )*1000)+start_time.millitm;

 exist=exist_file(setting->log_file.c_str());
 WriteLineFileClass *log;
 if (setting->log_append)
    log=new WriteLineFileClass(setting->log_file.c_str(),&b,WriteByteFileClass::Append);
 else 
    log=new WriteLineFileClass(setting->log_file.c_str(),&b,WriteByteFileClass::Overwrite);

 if (b==false) {
   cout<<"ERROR!!! Can't write log file : '"<<setting->log_file<<"'\n";
   delete log;
   return false;
 };
 if (exist==false) {
   (*log)<<"\n HTTP_SEND log. Build of "__DATE__", "__TIME__"\n\n";
 };
 (*log)<<"\n-------------------------------------------------------------------------\n";
 (*log)<<" Timeout : "<<Dec2Char(setting->timeout);
 (*log)<<" Requests counter : "<<Dec2Char(setting->requests_cnt)<<"\n";
 (*log)<<" URL : "<<setting->host_url.c_str()<<"\n";
 (*log)<<" IP : "<<setting->host_ip.c_str()<<", Port = "<<Dec2Char(setting->host_port)<<"\n";
 (*log)<<" Command line params :\n";
 for (l=0;l<(ulong)_argc;l++)
   (*log)<<"   ["<<Dec2Char(l)<<"]:"<<_argv[l]<<"\n";


 tHTTP_Request* request;
 bool result=true;
 // bool res = request.SendHTTP("http://www.uc.ru/","192.168.50.217",80, "", "", resp_h, data);
 string header,post_data,resp_header,resp_data;

 if (setting->read_header_file.length()!=0) {
    if (read_file_to_string(setting->read_header_file.c_str(),&header)==false)
      result=false;
 };
 if (setting->read_post_file.length()!=0) {
    if (read_file_to_string(setting->read_post_file.c_str(),&post_data)==false)
      result=false;
 };

 if (result==false) {
   (*log)<<" Status : FAILED!!!\n\n";
   delete log;
   return false;
 };

 request=new tHTTP_Request();
 if (setting->requests_cnt>0) {
    volatile ulong one10,max=setting->requests_cnt;
   if ((max>=1000)||(setting->timeout>100))
     one10=max/79;
   else if ((max>=500)||(setting->timeout>50))
     one10=max/49;
   else
     one10=max/33;

   if (one10==0)
       one10=2;
   string s100;
   for (l=0;l<max;l++) {
      resp_header.erase();    resp_data.erase();
      if ((l%one10)==0) cout<<".";
      l2=0;
      do {
        result = request->SendHTTP(
           setting->host_url.c_str(),setting->host_ip.c_str(),setting->host_port,
           header,post_data,resp_header,resp_data);

       if (setting->save_all) {
           s100="\n\n----------------------------------------------------------------------\n"
            "Transaction #";
           s100+=Dec2Char(l);
           s100+="\n data size = "; s100+=Dec2Char((ulong)resp_data.length());
           s100+="\n\n----------------------------------------------------------------------\n";
           if (setting->write_header_file.length()!=0) {
             write_string_to_file(setting->write_header_file.c_str(),&s100,true);
             write_string_to_file(setting->write_header_file.c_str(),&resp_header,true);
           };
           if (setting->write_data_file.length()!=0) {
              write_string_to_file(setting->write_data_file.c_str(),&s100,true);
              write_string_to_file(setting->write_data_file.c_str(),&resp_data,true);
           };
         };

       if (result)
           break;
       else
          Sleep(30);
       l2++;
      } while(l2<setting->repeat_counter);

      if (result==false) {
        cout<<"ERROR!!! At send_http !!!"<<
           "\n host_url = "<<setting->host_url<<
           "\n host_ip = "<<setting->host_ip<<
           "\n host_port = "<<Dec2Char(setting->host_port)<<
           "\n header = "<<header<<
           "\n post_data = "<<post_data<<
           "\n resp_header = "<<resp_header<<
           "\n resp_data = "<<resp_data<<"\n\n";
        break;
      };
      if (setting->timeout!=0)
        make_delay((ushort)setting->timeout);
   };
 };

 if ((result==true)&&(setting->save_all==false)) {
    if (setting->write_header_file.length()==0) {
      if (setting->skip_cout==false)
          cout<<resp_header<<endl;
    } else 
      write_string_to_file(setting->write_header_file.c_str(),&resp_header,
          setting->header_append);


   if (setting->write_data_file.length()==0) {
      if (setting->skip_cout==false)
         cout<<resp_data<<endl;
    } else
      write_string_to_file(setting->write_data_file.c_str(),&resp_data,
          setting->data_append);
 };

 delete request;

 ::ftime((timeb*)&end_time);
 long_end_time=((end_time.time & 0xFFFFF )*1000)+end_time.millitm;
 volatile ulong diff_time_msec=long_end_time-long_start_time; // разница в мсек.
 volatile ulong diff_time_sec=end_time.time-start_time.time;

 (*log)<<" START TIME :\n";
 (*log)<<"\t\t Standart : "<<ctime((const long*)&start_time.time)<<"\n";
 (*log)<<"\t\t Seconds since 1 Jan 1970 : "<<Dec2Char((ulong)start_time.time)<<"."<<
   Dec2Char((ushort)start_time.millitm)<<"\n";
 (*log)<<"\t\t Time in msec : "<<Dec2Char(long_start_time)<<"\n";

 (*log)<<" END TIME :\n";
 (*log)<<"\t\t Standart : "<<ctime((const long *)&end_time.time)<<"\n";
 (*log)<<"\t\t Seconds since 1 Jan 1970 : "<<Dec2Char((ulong)end_time.time)<<"."<<
   Dec2Char((ushort)end_time.millitm)<<"\n";
 (*log)<<"\t\t Time in msec : "<<Dec2Char(long_end_time)<<"\n";

 (*log)<<" TIME ELAPSED ( full, include delay time ) :\n";
 (*log)<<"\t\t In seconds : "<<Dec2Char(diff_time_sec)<<"\n";
 (*log)<<"\t\t In msec : "<<Dec2Char(diff_time_msec)<<"\n";

 volatile ulong delay_time_msec=setting->timeout*setting->requests_cnt;
 volatile ulong delay_time_sec=0;
 if (delay_time_msec!=0)
   delay_time_sec=delay_time_msec/1000;

 volatile ulong pure_time_sec=diff_time_sec-delay_time_sec;
 volatile ulong pure_time_msec=diff_time_msec-delay_time_msec;


 (*log)<<" TIME ELAPSED ( pure, exclude delay time ) :\n";
 (*log)<<"\t\t In seconds : "<<Dec2Char(pure_time_sec)<<"\n";
 (*log)<<"\t\t In msec : "<<Dec2Char(pure_time_msec)<<"\n";

 (*log)<<" PERFOMANCE :\n";
 (*log)<<"\t\t Requests per second : ";
 if (pure_time_sec!=0) {
   (*log)<<Dec2Char((ulong)(setting->requests_cnt/pure_time_sec))<<"\n";
 } else
   (*log)<<" more than "<<Dec2Char(setting->requests_cnt)<<"\n";

 (*log)<<"\t\t Requests per minute : ";
 if (pure_time_sec!=0) {
   (*log)<<Dec2Char((ulong)(setting->requests_cnt*60/pure_time_sec))<<"\n";
 } else
   (*log)<<" more than "<<Dec2Char(setting->requests_cnt)<<"\n";

 (*log)<<"\t\t One request handling time ( msec ) : "<<
    Dec2Char((ulong)(pure_time_msec/setting->requests_cnt))<<"\n";

 if (result) {
   (*log)<<" Status : ok\n";
 } else
   (*log)<<" Status : FAILED!!!\n\n";

 delete log;

 return result;
};

// returns false on error, otherwise - true
bool set_options(char *arg,HttpSettingsRecord *setting) {
 if (arg==NULL)
   return true;
 if (strlen(arg)<2) {
   cout<<"ERROR!!! Wrong or unknown switch :"<<arg<<endl;
   return false;
 };
 if ((arg[0]!='-')&&(arg[0]!='/')) {
   cout<<"ERROR!!! Wrong prefix - '"<<arg[0]<<"'. Must be - or / !!"<<endl;
   return false;
 };
 switch (arg[1]) {
    case 'u': case 'U':
    setting->host_url=&arg[2];
    break;

    case 'i': case 'I':
    { char *c=strchr(&arg[2],':');
      if (c==NULL) {
          cout<<"ERROR!!! Wrong ip address - '"<<arg<<"'. Address must be like 192.168.0.4:3128 !!!"<<endl;
          return false;
       };
      if (char2dec(c+1,&setting->host_port)==false) {
         cout<<"ERROR!!! Wrong port '"<<c<<"'"<<endl;
         return false;
      };
      *c=0; //ххех)
      setting->host_ip=&arg[2];
    };
    break;

    case 'd': case 'D':
    if (char2dec(&arg[2],&setting->timeout)==false) {
       cout<<"ERROR!!! Wrong timeout '"<<arg<<"'"<<endl;
       return false;
    };
    break;

    case 'c': case 'C':
    if (char2dec(&arg[2],&setting->requests_cnt)==false) {
       cout<<"ERROR!!! Wrong counter '"<<arg<<"'"<<endl;
       return false;
    };
    if (setting->requests_cnt<1) {
       cout<<"ERROR!!! Wrong requests counter value '"<<arg<<"'"<<endl;
       return false;
    };
    break;

    case 'l': case 'L':
    setting->log_file=&arg[2];
    break;

    case 'Y': case 'y':
    if (char2dec(&arg[2],&setting->repeat_counter)==false) {
       cout<<"ERROR!!! Wrong repeat counter '"<<arg<<"'"<<endl;
       return false;
    };
    break;

    case 's': case 'S':
    switch (arg[2]) {
        case 'h': case 'H': setting->read_header_file=&arg[3];
        break;

        case 'p': case 'P': setting->read_post_file=&arg[3];
        break;

        default:
        cout<<"ERROR!!! Wrong or unknown switch :"<<arg<<endl;
        break;
    };
    break;

    case 'x': case 'X':
    if (strcmpi(arg,"-Xq")==0) {
       setting->skip_cout=true;
    } else if (strcmpi(arg,"-Xla")==0) {
       setting->log_append=true;
    } else if (strcmpi(arg,"-Xha")==0) {
       setting->header_append=true;
    } else if (strcmpi(arg,"-Xda")==0) {
       setting->data_append=true;
    } else if (strcmpi(arg,"-Xwa")==0) {
       setting->save_all=true;
    } else {
       cout<<"ERROR!!! Wrong or unknown switch :"<<arg<<endl;
    };
    break;


    case 'r': case 'R':
    switch (arg[2]) {
        case 'h': case 'H': setting->write_header_file=&arg[3];
        break;

        case 'd': case 'D': setting->write_data_file=&arg[3];
        break;

        default:
        cout<<"ERROR!!! Wrong or unknown switch :"<<arg<<endl;
        break;
    };
    break;

    default:
    cout<<"ERROR!!! Wrong or unknown switch :"<<arg<<endl;
    return false;
 };
 return true;
};


void usage(void) {
 cout<<"\n\nHTTP_SEND Build of "__DATE__ ", "__TIME__"\n"
 "usage : http_send [switches]\n"
 " -Uurl : specify server url ( for example -Uhttp://www.uc.ru )\n"
 " -Iip:port : specify server IP address and port ( for example -I192.168.50.217:80 )\n"
 " -Dxxx : delay ( in msec ) between requests, default value is 0 ( no delay )\n"
 " -Ccnt : perform 'cnt' requests to server, default value is 1\n"
 " -SHfile : specify 'file' with header's data ( send to server ) \n"
 " -SPfile : specify 'file' with POST data ( send to server )\n"
 " -RHfile : specify 'file' to write header ( server answer ), default - cout \n"
 " -RDfile : specify 'file' to write data ( server answer ), default - cout\n"
 " -Lfile : specify 'file' to write http_send log ( default - http_send.log )\n"
 " -Ycnt : make cnt request when send-recieve error occur ( default 100 )\n"
 " -Xq : don't write server answer to cout ( valid if -RH or -RD not present )\n"
 " -Xla : append log file ( if exist ), by default - file will be rewrited\n"
 " -Xha : append header file ( if exist ), by default - file will be rewrited\n"
 " -Xda : append data file ( if exist ), by default - file will be rewrited\n"
 " -Xwa : save all transactions ( append header and data files ), def - not save\n"
 "\n";
};


void press_any_key(char *message)
{ char buf[10];
  if (message!=NULL)
     cout<<message<<endl;
  cout<<" Press ENTER to continue.."<<endl;
  cin.read(buf,1);
};

bool read_file_to_string(const char*filename,string *string_buf) {
  MyIstreamClass * file=new MyIstreamClass();
  if (file->open(filename)==false) {
     cout<<"ERROR!! File access error : "<<filename<<endl;
     return false;
  };
  byte *buf=new byte[file->get_file_size()+1];
  file->read_array(buf,file->get_file_size());
  (*string_buf)=(char*)buf;
  delete [] buf;
  delete file;
  return true;
};

bool write_string_to_file(const char*filename,string *string_buf,bool do_append) {
  bool b; WriteLineFileClass * file;
  if (do_append) 
     file=new WriteLineFileClass(filename,&b,WriteByteFileClass::Append);
  else
     file=new WriteLineFileClass(filename,&b,WriteByteFileClass::Overwrite);

  if (b==true) {
    (*file)<<string_buf->c_str();
  } else {
    cout<<"ERROR!!! Can't write to output file : '"<<filename<<"'\n\n";
  };
  delete file;
  return true;
};

