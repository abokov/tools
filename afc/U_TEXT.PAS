unit U_TEXT;

{  ����ᥩ �. �����.1996.�����/��᪢�.���.:(095)391-9540. }
{  Alexey Y. Bokow.1996.Russia/Moscow.Phone:(095)391-9540. }

{ ��� ����� ᮤ�ন� ��楤��� �ᯮ��㥬� �� ⥪�⮢�� �ࠢ�����.}
interface

uses common,u_const;

                { ���������� ��������.}


{ ��楤�� ��⠢��� � ��ப� ⮫쪮 ⥪c⮢� ᨬ����.
  ����⮢묨 ������� ᨬ���� � ASCII ������ �� 20h �� EFh (�����⥫쭮).}
procedure ConvertToText(Var DestString:string);

{ ��楤�� ������� ��ப� � ᮮ⢥��⢨� � ��ࠬ��ࠬ� ��������� ��ப�.
  ���ਬ�� 㡨ࠥ� �� ��ப� ����� ⠡��樨 � ⮬� ��������.}
procedure MinimizeStr(var EString:string);

procedure MinimizeProc(Str_1:string;var Str_2:string);

{ ��楤�� �⥭�� ��ப� �� 䠩��.}
procedure ReadStr(var tFile:FileOfByte;var FileStr:string);

{ �᭮���� ��楤�� ⥪�⮢��� �ࠢ�����.}
procedure TextCompare;


{ �����頥� Value � ���祭�� ᮮ⢥�����饥 ���孥�� ॣ����� ASCII.}
function ConvToUpCase(Value:byte):byte;

{ �����頥� True,�᫨ Value ⥪�⮢� ᨬ��� (� ���� ASCII).}
function InRange(Value:byte):boolean;


implementation


procedure ConvertToText(var DestString:string);
var
  RetString:string;
  StrSegment,StrOffset:word;
  i,Value,StrLength:byte;
begin
   StrSegment:=Seg(DestString);
   StrOffset:=Ofs(DestString);
   RetString:='';
   StrLength:=Peek(StrSegment,StrOffset);
   i:=0;

   for i:=1 to StrLength do
     begin
        Inc(StrOffset);
        Value:=Peek(StrSegment,StrOffset);
        if (Value>=MinASCII)and(Value<=MaxASCII) then RetString:=RetString+chr(Value);
     end;

   DestString:=RetString;
end;



procedure MinimizeStr(var EString:string);
  { ��楤�� ������� ��ப� � ᮮ⢥��⢨� � ��ࠬ��ࠬ� ��������� ��ப�.
    ���ਬ�� 㡨ࠥ� �� ��ப� ����� ⠡��樨 � ⮬� ��������.}
  var
    { Segment:[Offset] - 㪠��⥫� �� ⥪�騩 ᨬ��� � ��ப�.}
    Segment,Offset:word;
    { tStr-��������஢����� ��ப�.}
    tStr:string;
    Length,i,val:byte;
begin
   Segment:=Seg(EString);
   Offset:=Ofs(EString);

   Length:=Peek(Segment,Offset);
   Inc(Offset);

   tStr:='';
   for i:=1 to Length do
     begin
        { val - ⥪�騩 ᨬ��� � ��ப�.}
        val:=Peek(Segment,Offset);
        Inc(Offset);
        if InRange(val) then
          begin
             { E᫨ val - ⥪�⮢� ᨬ���,� �� �ਡ�������
               � ���������㥬�� ��ப�.}
              if CaseIgnore then val:=ConvToUpCase(val);
              tStr:=tStr+chr(Val);
          end;
     end;
   { �����頥� ��������஢����� ��ப�.}
   EString:=tStr;
end;



procedure MinimizeProc(Str_1:string;var Str_2:string);
begin
   Str_2:=Str_1;
   MinimizeStr(Str_2);
end;



procedure ReadStr(var tFile:FileOfByte;var FileStr:string);
{ ��楤�� �⥭�� ��ப� �� 䠩��.}
  label Find_END;

  var
    i:word;
    val,err,count,t:byte;
    tStr,tStr_00:string;
    Find_SEP:boolean;
begin
   tStr:='';
   tStr_00:='';
   i:=0;

   while Not(Eof(tFile)) do
      begin
        { ����� ��ப� �ॢ�蠥� ���ᨬ��쭮 �����⨬��.}
         if i>=255 then goto Find_End;
         Find_SEP:=false;

         ReadByte(tFile,val);

         if (CmpModel=Simple)and(val=CR) then
           begin
              { ������ ᨬ��� - ������ ���⪨.}
              if Not(Eof(tFile)) then
              ReadByte(tFile,val) else goto Find_End;
              if (val=LF) then { ������ ᨬ��� - ��ॢ�� ��ப�.}
                   goto Find_END;
           end;
         t:=0;

         Find_SEP:=( Val=ORD(Sep_1) )or( Val=ORD(Sep_2) );

         if ( Find_SEP )and( Not(CmpModel=Simple) ) then
            begin
   { ������ ᨬ��� ᮮ⢥�����騩 ����� �⢥ত����.}
               tStr:=tStr+chr(val);
               goto Find_END;
            end;

         tStr:=tStr+chr(Val);
         Inc(i);
      end;

Find_END:
   { �����頥� ���⠭��� ��ப�.}
   FileStr:=tStr;
end;




procedure TextCompare;
label The_End;
{ �᭮���� ��楤�� ⥪�⮢��� �ࠢ�����.}
  var
    Equ:boolean;
    MinLength,tPos:LongInt;
    ErrCode:byte;
    FirstStr,SecondStr,tFirstStr,tSecondStr:string;

begin
   if CmpModel=Clever then
     begin
        AltWriteLn(' Sorry...The CLEVER compare model is non ready to using.');
        goto The_End;
     end;

   MinLength:=Min(FirstFile.Size,SecondFile.Size);
   Equ:=True;
   tPos:=1;

   DiffCount:=0;

   while (tPos<=MinLength)and(Not(Eof(FirstFile.Ptr))) do
       begin
          with FirstFile do ReadStr(Ptr,FirstStr);
          with SecondFile do ReadStr(Ptr,SecondStr);
          OutProgress;

          { ���������� ��ப ��� ��c�����饣� �ࠢ�����.}
          MinimizeProc(FirstStr,tFirstStr);
          MinimizeProc(SecondStr,tSecondStr);

          if (CleanIgnore) then
             while (Length(tFirstStr)=0)and(Not(Eof(FirstFile.Ptr))) do
                begin
                   with FirstFile do ReadStr(Ptr,FirstStr);
                   MinimizeProc(FirstStr,tFirstStr);
                end;

          if (CleanIgnore) then
             while (Length(tSecondStr)=0)and(Not(Eof(SecondFile.Ptr))) do
                begin
                   with SecondFile do ReadStr(Ptr,SecondStr);
                   MinimizeProc(SecondStr,tSecondStr);
                end;


          if Not(CompareString(tFirstStr,tSecondStr)) then
             { ��ப� ������� ࠧ���묨.}
              begin
                 ConvertToText(FirstStr);
                 ConvertToText(SecondStr);

                 AltWriteLn('                                   ');
                 AltWriteLn(' Found DIFFERENCES STRING:');
                 AltWriteLn(' File '+FirstFile.Path+' contans:');
                 AltWriteLn(FirstStr);

                 { �뢮� ��������஢����� ��ப�-�᪫��⥫쭮 ��� �⫠���.}
                 if NowDebug then
                   begin
                      AltWriteLn('DEBUG INFO: 1st file string after Minimize:');
                      AltWriteLn(tFirstStr);
                      AltWriteLn(' ');
                   end;



                 AltWriteLn(' File '+SecondFile.Path+' contans:');
                 AltWriteLn(SecondStr);

                 { �뢮� ��������஢����� ��ப�-�᪫��⥫쭮 ��� �⫠���.}
                 if NowDebug then
                   begin
                      AltWriteLn('DEBUG INFO: 2nd file string after Minimize:');
                      AltWriteLn(tSecondStr);
                   end;

                 if Equ then Equ:=false;
              end;
          tPos:=tPos+Length(FirstStr)+2;
       end;

   with FirstFile do
   if  Size>MinLength then
     begin
         AltWriteLn(' First '+Path+' file contans:');
         while Not(Eof(Ptr)) do
          begin
             ReadStr(Ptr,FirstStr);
             MinimizeProc(FirstStr,FirstStr);
             AltWriteLn(FirstStr);
             if WriteDiff then WriteStr(DiffFile.Ptr,FirstStr);
            { �뢮� ��������஢����� ��ப�-�᪫��⥫쭮 ��� �⫠���.}
             if NowDebug then
                   begin
                      AltWriteLn('DEBUG INFO: 1st file string after Minimize:');
                      AltWriteLn(tFirstStr);
                   end;
           end;
     end;



   with SecondFile do
   if Size>MinLength then
     begin
         AltWriteLn(' Second '+Path+' file contans:');
         while Not(Eof(Ptr)) do
           begin
             ReadStr(Ptr,SecondStr);
             MinimizeProc(SecondStr,tSecondStr);
             AltWriteLn(SecondStr);
             if WriteDiff then WriteStr(DiffFile.Ptr,SecondStr);
            { �뢮� ��������஢����� ��ப�-�᪫��⥫쭮 ��� �⫠���.}
             if NowDebug then
                   begin
                      AltWriteLn('DEBUG INFO: 2nd file string after Minimize:');
                      AltWriteLn(tSecondStr);
                   end;
           end;
     end;



   if Equ then AltWriteLn(' No differences encountered.')

          else AltWriteLn(' Found '+DecToStr(DiffCount)+' differences string.');

The_End:

end;





function ConvToUpCase(Value:byte):byte;assembler;
{
  ������஢����� (��� ࠡ��� � ��ਫ��楩) ��楤�� �८�ࠧ������ �㪢.
  �ਣ����쭠� ��楤�� �८�ࠧ������ �㪢 �ਢ����� � �����
  ����� ���,"�ணࠬ��஢���� ���ய����� 8088."- �.���;1988.���.277.
  ��楤�� �८�ࠧ������ ���筮� �㪢� � ॣ���� AL � �ய����.
  ��� ������᪨� �㪢 ��楤�� ࠡ�⠥� � ����஢��� ASCII,
  ��� ��ਫ����-� ����ୠ⨢��� ����஢��� �����,���� ����ୠ⨢���
  ������஢����� ����஢��� �����.
}
label Upper_Eng_Done,Upper_Done,Cmp_2nd_Half,Inv;
asm
  MOV AL,VALUE

  CMP AL,$61        { ��������,�������� �� ����� ���������� ��������.}
  JB  UPPER_ENG_DONE

  CMP AL,$7A
  JA  UPPER_ENG_DONE

  AND AL,01011111b  { ��� ���������� ���� - ��������� ������ ���� � ����.}

  JMP UPPER_DONE

UPPER_ENG_DONE:     { ����� �� �������� ���������� ��������.}

  CMP AL,$A0        { ��������,�������� �� ����� ������� ��������.}
  JB  UPPER_DONE

  CMP AL,$AF
  JA  CMP_2ND_HALF  { ������� �������� ����� ����������� � ASCII �� ������.}

  AND AL,11001111b  { ��������� ������ ���� � ����.}

  JMP UPPER_DONE

CMP_2ND_HALF:

  CMP AL,$E0         { ��������,�������� �� ����� ������� ��������.}
  JB  UPPER_DONE

  CMP AL,$EF
  JA  UPPER_DONE

  AND AL,10001111b  { ��������� ������ � ����� ������� � ����.}
  OR  AL,00010000b  { ��������� ���������� ���� � �������.}

UPPER_DONE:

end;





function InRange(Value:byte):boolean;
  { �����頥� True,�᫨ Chr(Value) ���� ⥪�⮢� ᨬ����� ASCII.}
  var
    Bool:boolean;
begin
   Bool:=(Value>=MinASCII)and(Value<=MaxASCII);
   if (SpaceIgnore)and(Value=Space) then Bool:=False;
   InRange:=Bool;
end;

end.