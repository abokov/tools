@echo off
rem irulez.org:8080/isapi/form2_isapi.dll?Action=MakeInfoPage
set PARAM=-Urulez.org/isapi/form2_isapi.dll -I192.168.50.246:80
http_send.exe %PARAM% -Xq -C10 -RDdata.html -RHheader.html -Xwa

