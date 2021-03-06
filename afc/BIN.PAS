unit BIN;

{  ����ᥩ �. �����.1996.�����/��᪢�.���.:(095)391-9540. }
{  Alexey Y. Bokow.1996.Russia/Moscow.Phone:(095)391-9540. }

{ ��� ����� ᮤ�ন� ��楤��� �ᯮ��㥬� �� ����筮� �ࠢ����� 䠩���.}
interface

uses common,u_const;

          { ��������� ��������.}

{ �᭮���� ��楤�� ����筮�� �ࠢ�����.}
procedure BinCompare;

{ ��楤�� �ନ஢���� �뢮����� ��ப�.��ப� ᮤ�ন� ���ଠ�� �
  ࠧ�������� ����� �ࠢ�������� 䠩���.}
procedure FormString(Offset:LongInt;Value_1,Value_2:byte;var OutStr:String);

procedure FormHalfString(Offset:LongInt;Value_1:byte;var OutStr:string);

{ ��楤�� �뢮�� ��ப� �� ����������� �����.}
procedure OutHalfBin(Offset:Longint;Value:byte);

{ ��楤�� �뢮�� ��ப� �� ��������� ���⠬.}
procedure OutPutBin(Offset:LongInt;Value_1,Value_2:byte);

{ ��楤�� ����筮�� �ࠢ�����.}
procedure Cmp;



implementation

procedure BinCompare;
  { ��楤�� ����筮�� �ࠢ����� 䠩���.}
begin
   Cmp;
end;



procedure FormString(Offset:LongInt;Value_1,Value_2:byte;var OutStr:String);
  { ��ନ��� �뢮����� ��ப�.��ப� ᮤ�ন�:
    ᬥ饭�� �� ��砫� 䠩��,�����筮�,����筮�,��⭠����筮� �
    ASCII �।�⠢����� ࠧ�������� ���⮢ ���� 䠩���.}

        procedure LittleProc(Value:byte;var fStr:String);
          { �� ��楤�� �믮���� �����஥ �ନ஢���� ������⮢ ��ப�.
            ��� �믮������ ��� ������ ��ப� ��� ࠧ�:
            ��� ᮤ�ন���� ��ࢮ�� � ��ண� 䠩���..}
          var
            tStr:String;
        begin
           fStr:=AddSpace(Ofs_Dec,fStr);
           { ��ନ��� �����筮� �।�⠢�����...}
           ConvertDecToStr(Value,tStr);
           fStr:=fStr+tStr;

           fStr:=AddSpace(Dec_Hex,fStr);
           { ��ନ��� ��⭠����筮� �।�⠢�����...}
           ConvertHexToStr(Value,tStr);
           fStr:=fStr+tStr;

           fStr:=AddSpace(Hex_ASCII,fStr);
           { ��ନ��� ASCII �।�⠢�����.}
           fStr:=fStr+Chr(Value);

           fStr:=AddSpace(ASCII_Bin,fStr);
           { ��ନ��� ����筮� �।�⠢�����...}
           ConvertToBin(Value,tStr);

           fStr:=fStr+tStr;
        end;

  var
    tOutStr:String;
begin
   Str(Offset,tOutStr);
   tOutStr:=AddNul(tOutStr,Size_Len);

   tOutStr:=' '+tOutStr;

   LittleProc(Value_1,tOutStr);
   LittleProc(Value_2,tOutStr);

{   tOutStr:=AddSpace(StrLen,tOutStr);}

   OutStr:=tOutStr;
end;


procedure FormHalfString(Offset:LongInt;Value_1:byte;var OutStr:string);
  { ��ନ��� �뢮����� ��ப�.��ப� ᮤ�ন�:
    ᬥ饭�� �� ��砫� 䠩��,�����筮�,����筮�,��⭠����筮� �
    ASCII �।�⠢����� ࠧ�������� ���⮢ ���� 䠩���.}

        procedure LittleProc(Value:byte;var fStr:String);
          { �� ��楤�� �믮���� �����஥ �ନ஢���� ������⮢ ��ப�.
            ��� �믮������ ��� ������ ��ப� ��� ࠧ�:
            ��� ᮤ�ন���� ��ࢮ�� � ��ண� 䠩���..}
          var
            tStr:String;
        begin
           fStr:=AddSpace(Ofs_Dec,fStr);
           { ��ନ��� �����筮� �।�⠢�����...}
           ConvertDecToStr(Value,tStr);
           fStr:=fStr+tStr;

           fStr:=AddSpace(Dec_Hex,fStr);
           { ��ନ��� ��⭠����筮� �।�⠢�����...}
           ConvertHexToStr(Value,tStr);
           fStr:=fStr+tStr;

           fStr:=AddSpace(Hex_ASCII,fStr);
           { ��ନ��� ASCII �।�⠢�����.}
           fStr:=fStr+Chr(Value);

           fStr:=AddSpace(ASCII_Bin,fStr);
           { ��ନ��� ����筮� �।�⠢�����...}
           ConvertToBin(Value,tStr);

           fStr:=fStr+tStr;
        end;

  var
    tOutStr:String;
begin
   Str(Offset,tOutStr);
   tOutStr:=AddNul(tOutStr,Size_Len);

   tOutStr:=' '+tOutStr;

   LittleProc(Value_1,tOutStr);

   OutStr:=tOutStr;

end;



procedure OutHalfBin(Offset:Longint;Value:byte);
{ ��楤�� �뢮�� ��ப� �� ����������� �����.}
  var
    Out:String;
begin
   FormHalfString(Offset,Value,Out);
   AltWriteLn(Out);
end;




procedure OutPutBin(Offset:LongInt;Value_1,Value_2:byte);
  { ��楤�� �뢮�� ��ப� ᮤ�ঠ饩 ���ଠ�� � ࠧ�������� �����.}
  var
    Out:String;
begin
   FormString(Offset,Value_1,Value_2,Out);
   AltWriteLn(Out);
end;



procedure Cmp;
{ �ࠢ����� ���⮢ ������ ���������� ᬥ饭�� �� ��砫� 䠩��.}
  var
    { ������ �������襣� 䠩�� � ⥪��� ������.}
    MinLength,tPos:longInt;
    { ��६����� ࠢ�� True �᫨ �।��騥 ���祭�� ���⠭��� ���⮢ ��������� ࠢ�묨.}
    PrevEqu:boolean;
    { ��६����� ࠢ�� True �᫨ �� ������� ࠧ�������� ���⮢.}
    Equ:boolean;
    { ���祭�� ���⮢ ���⠭��� �� 䠩���.}
    PrevFirstValue,PrevSecondValue,ErrCode,FirstValue,SecondValue:byte;

begin
   MinLength:=Min(FirstFile.Size,SecondFile.Size);
   { �᫨ 䠩�� ����� ࠧ����� �����,� 䠩�� ������� ࠧ���묨.}
   Equ:=( FirstFile.Size=SecondFile.Size );
   tPos:=0;

   { DiffCount - ���稪 ࠧ��稩.}
   DiffCount:=0;
   PrevEqu:=True;

   AltWriteLn(ScaleStr);
   Case MinimOutput of

     False:
             while tPos<MinLength do
                begin
     { ����� ������� �뢮�� - �뢮����� �� ࠧ����騥�� �����.}
                   ReadByte(FirstFile.Ptr,FirstValue);
                   ReadByte(SecondFile.Ptr,SecondValue);
                   if Not(CompareByte(FirstValue,SecondValue)) then
                   begin
                       OutPutBin(tPos,FirstValue,SecondValue);
                       if Equ then Equ:=false;
                   end;
                   Inc(tPos);
                end;
      True:


        begin

            { ����� ᮪�饭���� �뢮��:
            �뢮����� ���� � ��᫥���� ࠧ����騥�� �����.}
            ReadByte(FirstFile.Ptr,FirstValue);
            ReadByte(SecondFile.Ptr,SecondValue);

            if Not( CompareByte(FirstValue,SecondValue) ) then
                  begin
            { ����� ��稭����� � ࠧ�������� ���⮢.}
                       AltWriteLn(' FOUND FIRST DIFFERENCES AT POSITION:'+DecToStr(tPos)+'.');
                       OutPutBin(tPos,PrevFirstValue,PrevSecondValue);
                       OutPutBin(tPos+1,FirstValue,SecondValue);
                       PrevEqu:=false;
                       Equ:=false;
                    end;

             while (tPos+1<MinLength) do

                begin
                   ReadByte(FirstFile.Ptr,FirstValue);
                   ReadByte(SecondFile.Ptr,SecondValue);
                   case CompareByte(FirstValue,SecondValue) of
                     False:
                          begin
                          { ������� ���� ࠧ����騥�� �����;�।��騥 �����
                           �뫨 ��������묨.}
                             if PrevEqu then
                                begin
                                   AltWriteLn(' FOUND FIRST DIFFERENCES AT POSITION:'+DecToStr(tPos+1)+'.');
                                   OutPutBin(tPos,PrevFirstValue,PrevSecondValue);
                                   OutPutBin(tPos+1,FirstValue,SecondValue);
                                   PrevEqu:=false;
                                   if Equ then Equ:=false;
                                end;
                          end;
                     True:
                          begin
                              if (PrevFirstValue<>PrevSecondValue)and
                                  (Not(PrevEqu)) then
                                begin
    { ������� ���� ��������� �����;�।��騥 ����� �뫨 ࠧ����騬���.}
                                   AltWriteLn(' THE LAST DIFFERENCES BYTE AT POSITION:'+DecToStr(tPos)+'.');
                                   OutPutBin(tPos,PrevFirstValue,PrevSecondValue);
                                   OutPutBin(tPos+1,FirstValue,SecondValue);
                                   PrevEqu:=true;
                                   if Equ then Equ:=false;
                                 end;
                          end;
                end;
                Inc(tPos);
                PrevFirstValue:=FirstValue;
                PrevSecondValue:=SecondValue;
                OutProgress;
             end;

        end;
   end;

   with FirstFile do
   if FirstFile.Size>MinLength then
     begin
         AltWriteLn(' First file is more big second file ->');
         AltWriteLn(HalfScaleStr);
         with FirstFile do
          while Not(Eof(Ptr)) do
              begin
{ �ࠢ������� 䠩�� ����� ࠧ���� ࠧ����...}
                 ReadByte(Ptr,FirstValue);
                 if WriteDiff then WriteByte(DiffFile.Ptr,FirstValue);
                 OutHalfBin(tPos,FirstValue);
                 Inc(tPos);
              end;
     end;



   with SecondFile do
   if Size>MinLength then
     begin
         AltWriteLn(' Second file is more big first file ->');
         AltWriteLn(HalfScaleStr);
         while Not(Eof(Ptr)) do
              begin
{ �ࠢ������� 䠩�� ����� ࠧ���� ࠧ����...}
                 ReadByte(Ptr,SecondValue);
                 if WriteDiff then  WriteByte(DiffFile.Ptr,SecondValue);
                 OutHalfBin(tPos,SecondValue);
                 Inc(tPos);
              end;
     end;


{ � �����⠭���� ��� ࠧ�������� ���⮢ ���������� ࠧ��� � ࠧ���.}
   DiffCount:=DiffCount+abs(FirstFile.Size-SecondFile.Size);

   if Equ then AltWriteLn('   NO differences encountered.') else
      AltWriteln(' Found '+DecToStr(DiffCount)+' differences bytes.');

end;

end.