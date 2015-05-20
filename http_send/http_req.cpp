#include <stdio.h>
#include <stdlib.h>
#include <winsock2.h>

#include "http_req.h"

tHTTP_Request::tHTTP_Request(void) {
};

tHTTP_Request::~tHTTP_Request(void) {
};

unsigned tHTTP_Request::GetHostAddress(const char* host){
    struct hostent *phe;
    char *p;
    phe = gethostbyname( host );
    if(phe==NULL) return 0;
    p = *phe->h_addr_list;
    return *((unsigned*)p);
}


void tHTTP_Request::SplitURL(const string& _url, string& _host, string& _path) {
  const char*  url = _url.c_str();

  const char* host = strstr(url, "//");
  if (host) host+=2;
  else      host=url;

  const char* path = strchr(host, '/');

  if (path) {
    _host.assign(host, path-host);
    _path.assign(path);
  }

  else {
    _host = host;
    _path = "/";
  }

}


bool tHTTP_Request::SendHTTP(
      const char* url,
      const char* ip,
      const unsigned port,
      const string& req_header,
      const string& post_data,
      string& resp_header,
      string& resp_data) {
  // Open socket ---------------------------------------------------------------
  WSADATA       WsaData;
  SOCKADDR_IN   sin;
  SOCKET        sock;
  int err;

  // init WinSocks
  err = WSAStartup (0x0101, &WsaData);
  if(err!=0) return false;

  // create socket
  sock = socket (AF_INET, SOCK_STREAM, 0);
  if (sock == INVALID_SOCKET) return false;
 
  // webserver connection
  sin.sin_family = AF_INET;
  sin.sin_port = htons((unsigned short)port);
  sin.sin_addr.s_addr = GetHostAddress(ip);
  if(connect(sock,(LPSOCKADDR)&sin, sizeof(SOCKADDR_IN))) return false;
 

  // формирование заголовка ----------------------------------------------------
  { 
    string header, local_path, host;
    bool post = !post_data.empty();
                                 
    if (post) header = "POST ";
    else      header = "GET ";
    SplitURL(url, host, local_path);
    header += local_path;
    header += " HTTP/1.0\r\n";
    header += "Host: ";
    header += host;
    header += "\r\n";

    header += req_header;

    send(sock,header.c_str(),header.length(),0);

    if (post) {
      char buf[4096];
      sprintf(buf,
        "Content-Type: application/x-www-form-urlencoded\r\n"
        "Content-length: %d\r\n"
        "\r\n",
        post_data.length()
      );
      send(sock,buf,strlen(buf),0);
      send(sock,post_data.c_str(),post_data.length(),0);
    }

    else send(sock,"\r\n",2,0);

  }


  // прием ответа --------------------------------------------------------------
  { int l;
    char buf[64536];
    //char buf[0x10000]; // буфер побольше)
    while ( (l=recv(sock,buf,sizeof(buf)-1,0)) > 0) {
      buf[l]=0;
      resp_data += buf;
    };
  };

  // ищем начало тела в ответе
  //  const char* body = strstr(resp, "\r\n\r\n"); БАГА !!! iis посылает "\n\n"
  // на самом деле когда html - файл то "\r\n\r\n"
  // а когда isapi то IIS посылает "\n\n"
  unsigned offset;
  {  const char* resp = resp_data.c_str();
     const char *ptr1=strstr(resp,"\r\n\r\n"); // "\r\n\r\n"
     const char *ptr2=strstr(resp,"\n\n"); // "\n\n"

     if (max(ptr1,ptr2)==NULL) {
        offset=0; // фиг его знает - один сплошной ответ без заголовка!!!
     } else {
       if (ptr2==NULL) {
           offset=(ptr1+4)-resp; // сначала "\r\n\r\n"
       } else if (ptr1==NULL) {
           offset=(ptr2+2)-resp; // сначала "\n\n"
       } else if (ptr1>ptr2) {
          offset=(ptr2+2)-resp; // сначала был "\n\n"
        } else {
          offset=(ptr1+4)-resp; // сначала "\r\n\r\n"
        };
     };
  };
  resp_header = resp_data.substr(0,offset);
  resp_data.erase(0,offset);

  
  // завершение ----------------------------------------------------------------

  shutdown(sock,SD_BOTH);
  closesocket(sock);
  WSACleanup();

  return true;
}
