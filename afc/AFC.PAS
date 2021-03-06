program AFC(Input,Output);
uses common,bin,u_text,u_const;

procedure Analize;{ ������ ��ࠬ��஢ ��������� ��ப�.}
  var
     ErrCode,tCount:byte;
     tStr:string;
     _1st_ext,_2nd_ext:string;
     _1st_bool,_2nd_bool:boolean;
     i,Max:byte;
begin
   FirstFile.Path:=ParamStr(1);
   SecondFile.Path:=ParamStr(2);
   if CompareString(FirstFile.Path,SecondFile.Path) then
      ErrorMsg(255,' Both file name must be DIFFERENCES! ');

   with FirstFile do _1st_ext:=GetExt(Path);
   with SecondFile do _2nd_ext:=GetExt(Path);

   i:=0; _1st_bool:=False;
   while (i<=Max_TXT_EXT)and(Not(_1st_bool)) do
     begin
        _1st_bool:=(_1st_ext=TXT_EXT_C[i]);
        Inc(i);
     end;

   i:=0; _2nd_bool:=False;
   while (i<=Max_TXT_EXT)and(Not(_2nd_bool)) do
     begin
        _2nd_bool:=(_2nd_ext=TXT_EXT_C[i]);
        Inc(i);
     end;

  if (_1st_bool)and(_2nd_bool) then Cmp:=TextCmp else Cmp:=BinaryCmp;

  if (FirstFile.Path='')or(Not(FileExists(FirstFile.Path))) then
          begin
            { ������ ����୮� ��� ��ࢮ�� 䠩��.}
             ErrCode:=1;
             ErrorMsg(ErrCode,' First file is non found.');
           end;

   if (SecondFile.Path='')or(Not(FileExists(SecondFile.Path))) then
          begin
             { ������ ����୮� ��� ��ண� 䠩��.}
             ErrCode:=2;
             ErrorMsg(ErrCode,' Second file is non found.');
          end;

   ErrCode:=0;

   { �� 㬮�砭�� ��⠭���������� ०�� �뢮�� ⮫쪮 �� ��࠭.}
   WhereWrite:=ToScreen;
   Max:=ParamCount;

   for tCount:=3 to Max do
      begin
         tStr:=ParamStr(tCount);
         if tStr<>'' then case tStr[2] of
              'P':
                  begin
                     { �뢮� � 䠩� � ������ ᫥���騬 ��᫥ ��ࠬ��� /P .
                       �᫨ ��᫥ ��ࠬ��� �� 㪠���� ��� 䠩��,� �
                       ����⢥ ����� ������ Def_report (�.U_CONST.PAS).}
                     if length(tStr)<3 then OutFile.Path:=Def_report
                               else OutFile.Path:=copy(tStr,3,Length(tStr));
                     if ( OutFile.Path=FirstFile.Path )or
                         ( OutFile.Path=SecondFile.Path )
                     then ErrorMsg(255,' CANNOT WRITE REPORT IN THE ONE OF COMPARE FILES.');
                     WhereWrite:=ToFile;
                     OutInFile:=True;
                  end;

              'R':
                  begin
                     if length(tStr)<3 then OutFile.Path:=Def_report
                               else OutFile.Path:=copy(tStr,3,Length(tStr));
                     WhereWrite:=ToScr_and_File;
                     if ( OutFile.Path=FirstFile.Path )or
                         ( OutFile.Path=SecondFile.Path )
                     then ErrorMsg(255,' CANNOT WRITE REPORT IN THE ONE OF COMPARE FILES.');
                     OutInFile:=True;
                  end;

             'Q': begin
                          if (length(tStr)>2) then ErrorMsg(255,'Wrong command line param')
                          else quiet_mode:=true;
             end;

             'D':
                  begin
                  { /D - �ந������� ������ �⫨稩 � 䠩� � ������
                  ᫥���騬 ��᫥ ��ࠬ���.}
                     if length(tStr)<3 then ErrorMsg(3,cmNameExc);
                     WriteDiff:=True;
                      DiffFile.Path:=copy(tStr,3,Length(tStr));

                     if ( DiffFile.Path=FirstFile.Path )or
                         ( DiffFile.Path=SecondFile.Path ) then
                      ErrorMsg(255,' CANNOT WRITE DIFFERENCES IN THE ONE OF COMPARE FILES.');
                  end;

             'T':   begin
                          if (length(tStr)>2) then ErrorMsg(255,'Wrong command line param')
                                       else  Cmp:=TextCmp;
             { /T ��� /t - ⥪�⮢�� �ࠢ�����.}
             end;


             'B': begin
                          if (length(tStr)>2) then ErrorMsg(255,'Wrong command line param')
                                       else Cmp:=BinaryCmp;
             { /B ��� /b - ����筮� �ࠢ�����.}
             end;

             'S': begin
             { �����஢���� ࠧ��稥 ������ � �ய���� �㪢.}
              { �����஢��� �஡���.}
                          if (tStr='/S')or(tStr='/s') then (SpaceIgnore):=true
                           else if (tStr='/C')or(tStr='/c') then (CaseIgnore):=true
                          else if (tStr='/SMART') then CmpModel:=Smart
                           else ErrorMsg(255,'Wrong command line param');
              end;

             'C': begin
                   if (tStr='/C')or(tStr='/c') then (CaseIgnore):=true
                   else if (tStr='/CLEVER') then CmpModel:=Clever
                   else ErrorMsg(255,'Wrong command line param');
              end;

             'M': begin             { /M ��� /m - ०�� ᮪�饭���� �뢮��.}
                if (length(tStr)>2) then ErrorMsg(255,'Wrong command line param')
                else MinimOutput:=(true)or(MinimOutput);
              end;

             { C�����騥 ��६���� �ᯮ������� ⮫쪮
                  � ०��� ⥪�⮢��� �ࠢ�����.}
             'Z': begin
                if (length(tStr)>2) then ErrorMsg(255,'Wrong command line param')
                else  CleanIgnore:=(tStr='/Z')or(tStr='/z');
              end;

{             NowDebug:=(tStr='/DEBUG')or(NowDebug);}
             else ErrorMsg(255,'Wrong command line param');
           end;
       end;
end;

procedure DefaultSet;
{ ��⠭���� �� 㬮�砭��.}
    begin
       Cmp:=BinaryCmp;
       MinimOutput:=False;
       CaseIgnore:=False;
       SpaceIgnore:=False;
       CleanIgnore:=False;
       NowDebug:=False;
end;


  procedure NewCtrlBreakHandler;interrupt;
   { ��ࠡ��稪 ���뢠��� �� ������ Ctrl-Break.}
   begin
      AltWriteLn(' AFC MESSAGE                           ');
      AltWriteLn(' CTRL-BREAK PRESSED! ABNORMAL PROGRAM TERMINATION.');
      AltWriteLn('                                       ');
      Abnormal(255);
   end;






                   { ���� �᭮���� �ணࠬ��.}

label Exit_label;
var
  Bool:boolean;
  NewHandler:pointer;
begin
{ ��⠭�������� ���� ��ࠡ��稪 ���뢠��� �� ������ Ctrl-Break.}
   quiet_mode:=false;
   NewHandler:=Addr(NewCtrlBreakHandler);
   GetVector(CtrlBreak_Int_No,Ctrl_Break_Handler);

   SetVector(CtrlBreak_Int_No,NewHandler);

   AltWriteLn(' ');

   DefaultSet;

   OutFile.Open:=false;
   DiffFile.Open:=false;
   FirstFile.Open:=false;
   SecondFile.Open:=false;

   Bool:=(ParamCount<1)or(ParamStr(1)='/?');
{ ��������� ��ப� ��� ��ࠬ��஢ ��ᬠ�ਢ����� ��� ��ப�
  � ���箬 ��� �뢮�� �����.}
   if (Bool)or(ParamStr(1)='/H')or(ParamStr(1)='/h') then
   begin
      { �᫨ ����室��� �뢥�� ������,� �ࠢ����� 䠩��� �� ��������.}
      OutHelpMsg;
      goto Exit_Label;
   end;

   Analize;

   if WriteDiff then FileReWrite(DiffFile);
   if OutInFile then FileReWrite(OutFile);

   OutAuthorMsg;
{  �뢮� ���ଠ樨 � ⥪��� ����ன���.}
   OutCompareMode;


   FileOpen(FirstFile);
   FileOpen(SecondFile);

{ �뢮� ���ଠ樨 � 䠩���.}
   OutFileInf;

   case  Cmp of
     BinaryCmp:BinCompare;
     TextCmp:TextCompare;
    end;

Exit_Label:

  with DiffFile do if Open then Close(Ptr);
  with OutFile do if Open then Close(Ptr);
  with FirstFile do if Open then Close(Ptr);
  with SecondFile do if Open then Close(Ptr);

{ ���⠭�������� ��ࠡ��稪 ���뢠���.}
  SetVector(CtrlBreak_Int_No,Ctrl_Break_Handler);
end.






