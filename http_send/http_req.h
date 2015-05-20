#ifndef __HTTP_REQ_INC__
#define __HTTP_REQ_INC__ 1

#include <string>

using namespace std;

class tHTTP_Request{
  public:
    tHTTP_Request(void);
    ~tHTTP_Request(void);
    bool SendHTTP (
      const char* url,
      const char* ip,
      const unsigned port,
      const string& req_header, // дополнительные поля заголовка
      const string& post_data,
      string& resp_header,
      string& resp_data
    );

  private: 
    void SplitURL(const string& _url, string& _host, string& _path);
    unsigned GetHostAddress(const char* host);
    long dummy_data1,dummy_data2;
};

#endif
